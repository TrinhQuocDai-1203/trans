package com.example.controllers;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.model.Bus;
import com.example.model.PickupPoint;
import com.example.model.Trip;
import com.example.model.User;
import com.example.model.Ticket;
import com.example.services.BusService;
import com.example.services.PickupPointService;
import com.example.services.TripService;
import com.example.services.UserService;
import com.example.services.TicketService;

@Controller
@RequestMapping("/admin")
public class AdminController {
    
    private final UserService userService;
    private final TripService tripService;
    private final BusService busService;
    private final PickupPointService pickupPointService;
    private final TicketService ticketService;
    
    @Autowired
    public AdminController(UserService userService, TripService tripService, BusService busService, 
                          PickupPointService pickupPointService, TicketService ticketService) {
        this.userService = userService;
        this.tripService = tripService;
        this.busService = busService;
        this.pickupPointService = pickupPointService;
        this.ticketService = ticketService;
    }
    
    @InitBinder
    public void initBinder(WebDataBinder binder) {
        // Định dạng cho input datetime-local (yyyy-MM-dd'T'HH:mm)
        SimpleDateFormat dateTimeFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
        dateTimeFormat.setLenient(false);
        
        // Định dạng cho input date (yyyy-MM-dd)
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        dateFormat.setLenient(false);
        
        // Sử dụng CustomDateEditor cho nhiều định dạng
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateTimeFormat, true) {
            @Override
            public void setAsText(String text) {
                if (text == null || text.isEmpty()) {
                    setValue(null);
                    return;
                }
                
                try {
                    // Thử với định dạng datetime-local
                    setValue(dateTimeFormat.parse(text));
                } catch (ParseException e1) {
                    try {
                        // Thử với định dạng date
                        setValue(dateFormat.parse(text));
                    } catch (ParseException e2) {
                        throw new IllegalArgumentException("Không thể chuyển đổi định dạng ngày: " + text);
                    }
                }
            }
        });
    }

    @GetMapping("/")
    public String adminDashboard(HttpSession session, Model model) {
        // Thêm dữ liệu thống kê cho UI
        Date today = new Date();
        Long tripsToday = tripService.countTripsByDate(today);
        List<Trip> todayTrips = tripService.getTripsByDate(today);
        List<User> drivers = userService.getUsersByRole(User.Role.DRIVER);
        List<Bus> buses = busService.getAllBuses();
        
        model.addAttribute("tripsToday", tripsToday);
        model.addAttribute("todayTrips", todayTrips);
        model.addAttribute("driversCount", drivers.size());
        model.addAttribute("busesCount", buses.size());
        
        return "admin/index";
    }
    
    @GetMapping("/users")
    public String manageUsers(Model model) {
        List<User> users = userService.getAllUsers();
        model.addAttribute("users", users);
        return "admin/users";
    }
    
    @GetMapping("/reports")
    public String viewReports(
            @RequestParam(required = false) @DateTimeFormat(pattern="yyyy-MM-dd") Date startDate,
            @RequestParam(required = false) @DateTimeFormat(pattern="yyyy-MM-dd") Date endDate,
            Model model) {
        
        // Đặt khoảng thời gian mặc định nếu không cung cấp
        if (startDate == null) {
            Calendar cal = Calendar.getInstance();
            cal.add(Calendar.DAY_OF_MONTH, -30); // Mặc định là 30 ngày trước
            startDate = cal.getTime();
        }
        
        if (endDate == null) {
            endDate = new Date(); // Mặc định là ngày hiện tại
        }
        
        // Lấy tất cả chuyến đi trong khoảng thời gian
        List<Trip> trips = tripService.getTripsByDateRange(startDate, endDate);
        
        // Tính toán thống kê
        long totalTrips = trips.size();
        long completedTrips = trips.stream()
                .filter(trip -> "COMPLETED".equals(trip.getStatus()))
                .count();
        long cancelledTrips = trips.stream()
                .filter(trip -> "CANCELLED".equals(trip.getStatus()))
                .count();
        
        // Thống kê tài xế
        List<Map<String, Object>> driverStats = new ArrayList<>();
        Map<User, List<Trip>> tripsByDriver = trips.stream()
                .filter(trip -> trip.getPrimaryDriver() != null)
                .collect(Collectors.groupingBy(Trip::getPrimaryDriver));
        
        for (Map.Entry<User, List<Trip>> entry : tripsByDriver.entrySet()) {
            User driver = entry.getKey();
            List<Trip> driverTrips = entry.getValue();
            
            long driverCompletedTrips = driverTrips.stream()
                    .filter(trip -> "COMPLETED".equals(trip.getStatus()))
                    .count();
            
            double completionRate = driverTrips.isEmpty() ? 0 : 
                    (double) driverCompletedTrips / driverTrips.size() * 100;
            
            Map<String, Object> stat = new HashMap<>();
            stat.put("driverName", driver.getFullName());
            stat.put("phoneNumber", driver.getNumberPhone());
            stat.put("totalTrips", driverTrips.size());
            stat.put("completionRate", Math.round(completionRate));
            
            driverStats.add(stat);
        }
        
        // Đường đi phổ biến
        Map<String, Long> routeCounts = new HashMap<>();
        for (Trip trip : trips) {
            String route = trip.getDepartureLocation() + " → " + trip.getDestinationLocation();
            routeCounts.put(route, routeCounts.getOrDefault(route, 0L) + 1);
        }
        
        List<Map<String, Object>> popularRoutes = new ArrayList<>();
        routeCounts.entrySet().stream()
                .sorted(Map.Entry.<String, Long>comparingByValue().reversed())
                .limit(10) // Top 10 đường đi
                .forEach(entry -> {
                    String[] locations = entry.getKey().split(" → ");
                    Map<String, Object> route = new HashMap<>();
                    route.put("departureLocation", locations[0]);
                    route.put("destinationLocation", locations[1]);
                    route.put("tripCount", entry.getValue());
                    popularRoutes.add(route);
                });
        
        // Thêm dữ liệu vào model
        model.addAttribute("startDate", startDate);
        model.addAttribute("endDate", endDate);
        model.addAttribute("totalTrips", totalTrips);
        model.addAttribute("completedTrips", completedTrips);
        model.addAttribute("cancelledTrips", cancelledTrips);
        model.addAttribute("driverStats", driverStats);
        model.addAttribute("popularRoutes", popularRoutes);
        
        return "admin/reports";
    }
    
    // Quản lý chuyến đi
    @GetMapping("/trips")
    public String manageTrips(Model model) {
        // Lấy danh sách chuyến đi với các chuyến khởi hành ngày hôm nay lên đầu
        List<Trip> trips = tripService.getAllTripsOrderedByDepartureDate();
        
        // Thêm thông tin về ngày hiện tại
        Date currentDate = new Date();
        model.addAttribute("currentDate", currentDate);
        
        model.addAttribute("trips", trips);
        return "admin/trips";
    }
    
    @GetMapping("/trips/add")
    public String showAddTripForm(Model model) {
        Trip trip = new Trip();
        List<User> drivers = userService.getUsersByRole(User.Role.DRIVER);
        List<Bus> buses = busService.getAllBuses();
        List<PickupPoint> pickupPoints = pickupPointService.getAllPickupPoints();
        
        model.addAttribute("trip", trip);
        model.addAttribute("drivers", drivers);
        model.addAttribute("buses", buses);
        model.addAttribute("pickupPoints", pickupPoints);
        
        return "admin/trip-form";
    }
    
    @PostMapping("/trips/save")
    public String saveTrip(@ModelAttribute Trip trip, 
                          @RequestParam("primaryDriverId") Long primaryDriverId,
                          @RequestParam(value = "secondaryDriverId", required = false) Long secondaryDriverId,
                          @RequestParam("busId") Long busId,
                          @RequestParam("departureLocation") Long departureLocation,
                          @RequestParam("destinationLocation") Long destinationLocation,
                          RedirectAttributes redirectAttributes) {
        try {
            User primaryDriver = userService.getUserById(primaryDriverId);
            trip.setPrimaryDriver(primaryDriver);
            
            if (secondaryDriverId != null) {
                User secondaryDriver = userService.getUserById(secondaryDriverId);
                trip.setSecondaryDriver(secondaryDriver);
            }
            
            Bus bus = busService.getBusById(busId);
            trip.setBus(bus);
            trip.setAvailableSeats(bus.getCapacity());
            
            // Đặt điểm khởi hành và điểm đến
            PickupPoint departurePoint = pickupPointService.getPickupPointById(departureLocation);
            PickupPoint destinationPoint = pickupPointService.getPickupPointById(destinationLocation);
            trip.setDeparturePoint(departurePoint);
            trip.setDestinationPoint(destinationPoint);
            
            // Đặt các trường chuỗi vị trí
            trip.setDepartureLocation(departurePoint.getName() + " (" + departurePoint.getCity() + ")");
            trip.setDestinationLocation(destinationPoint.getName() + " (" + destinationPoint.getCity() + ")");
            
            // Lưu chuyến đi
            tripService.saveTrip(trip);
            
            redirectAttributes.addFlashAttribute("message", "Chuyến đi đã được lưu thành công!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/admin/trips";
    }
    
    @GetMapping("/trips/edit/{id}")
    public String showEditTripForm(@PathVariable Long id, Model model) {
        Trip trip = tripService.getTripById(id);
        List<User> drivers = userService.getUsersByRole(User.Role.DRIVER);
        List<Bus> buses = busService.getAllBuses();
        List<PickupPoint> pickupPoints = pickupPointService.getAllPickupPoints();
        
        model.addAttribute("trip", trip);
        model.addAttribute("drivers", drivers);
        model.addAttribute("buses", buses);
        model.addAttribute("pickupPoints", pickupPoints);
        
        return "admin/trip-form";
    }
    
    @GetMapping("/trips/delete/{id}")
    public String deleteTrip(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        tripService.deleteTrip(id);
        redirectAttributes.addFlashAttribute("message", "Chuyến đi đã được xóa thành công!");
        return "redirect:/admin/trips";
    }
    
    @GetMapping("/trips/by-date")
    public String getTripsByDate(@RequestParam @DateTimeFormat(pattern="yyyy-MM-dd") Date date, Model model) {
        List<Trip> trips = tripService.getTripsByDate(date);
        model.addAttribute("trips", trips);
        model.addAttribute("selectedDate", date);
        return "admin/trips";
    }
    
    // Quản lý xe
    @GetMapping("/buses")
    public String manageBuses(Model model) {
        List<Bus> buses = busService.getAllBuses();
        model.addAttribute("buses", buses);
        return "admin/buses";
    }
    
    @GetMapping("/buses/add")
    public String showAddBusForm(Model model) {
        model.addAttribute("bus", new Bus());
        return "admin/bus-form";
    }
    
    @PostMapping("/buses/save")
    public String saveBus(@ModelAttribute Bus bus, RedirectAttributes redirectAttributes) {
        busService.saveBus(bus);
        redirectAttributes.addFlashAttribute("message", "Xe đã được lưu thành công!");
        return "redirect:/admin/buses";
    }
    
    @GetMapping("/buses/edit/{id}")
    public String showEditBusForm(@PathVariable Long id, Model model) {
        Bus bus = busService.getBusById(id);
        model.addAttribute("bus", bus);
        return "admin/bus-form";
    }
    
    @GetMapping("/buses/delete/{id}")
    public String deleteBus(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        busService.deleteBus(id);
        redirectAttributes.addFlashAttribute("message", "Xe đã được xóa thành công!");
        return "redirect:/admin/buses";
    }
    
    // Driver Management
    @GetMapping("/drivers")
    public String manageDrivers(Model model) {
        List<User> drivers = userService.getUsersByRole(User.Role.DRIVER);
        model.addAttribute("drivers", drivers);
        return "admin/drivers";
    }
    
    @GetMapping("/drivers/add")
    public String showAddDriverForm(Model model) {
        model.addAttribute("user", new User());
        return "admin/driver-form";
    }
    
    @PostMapping("/drivers/save")
    public String saveDriver(@ModelAttribute User user, RedirectAttributes redirectAttributes) {
        user.setRole(User.Role.DRIVER);
        userService.saveUser(user);
        redirectAttributes.addFlashAttribute("message", "Tài xế đã được lưu thành công!");
        return "redirect:/admin/drivers";
    }
    
    @GetMapping("/drivers/edit/{id}")
    public String showEditDriverForm(@PathVariable Long id, Model model) {
        User driver = userService.getUserById(id);
        model.addAttribute("user", driver);
        return "admin/driver-form";
    }
    
    // Tìm kiếm tài xế
    @GetMapping("/drivers/search")
    public String searchDrivers(@RequestParam(required = false) String name, Model model) {
        List<User> drivers;
        if (name != null && !name.trim().isEmpty()) {
            drivers = userService.searchDriversByName(name);
        } else {
            drivers = userService.getUsersByRole(User.Role.DRIVER);
        }
        model.addAttribute("drivers", drivers);
        model.addAttribute("searchName", name);
        return "admin/drivers";
    }
    
    // Tìm kiếm xe
    @GetMapping("/buses/search")
    public String searchBuses(@RequestParam(required = false) String licensePlate, Model model) {
        List<Bus> buses;
        if (licensePlate != null && !licensePlate.trim().isEmpty()) {
            buses = busService.searchBusesByLicensePlate(licensePlate);
        } else {
            buses = busService.getAllBuses();
        }
        model.addAttribute("buses", buses);
        model.addAttribute("searchLicensePlate", licensePlate);
        return "admin/buses";
    }
    
    // Quản lý điểm đón
    @GetMapping("/pickup-points")
    public String managePickupPoints(Model model) {
        List<PickupPoint> pickupPoints = pickupPointService.getAllPickupPoints();
        model.addAttribute("pickupPoints", pickupPoints);
        return "admin/pickup-points";
    }
    
    @GetMapping("/pickup-points/add")
    public String showAddPickupPointForm(Model model) {
        model.addAttribute("pickupPoint", new PickupPoint());
        return "admin/pickup-point-form";
    }
    
    @PostMapping("/pickup-points/save")
    public String savePickupPoint(@ModelAttribute PickupPoint pickupPoint, RedirectAttributes redirectAttributes) {
        pickupPointService.savePickupPoint(pickupPoint);
        redirectAttributes.addFlashAttribute("message", "Điểm đón đã được lưu thành công!");
        return "redirect:/admin/pickup-points";
    }
    
    @GetMapping("/pickup-points/edit/{id}")
    public String showEditPickupPointForm(@PathVariable Long id, Model model) {
        PickupPoint pickupPoint = pickupPointService.getPickupPointById(id);
        model.addAttribute("pickupPoint", pickupPoint);
        return "admin/pickup-point-form";
    }
    
    @GetMapping("/pickup-points/delete/{id}")
    public String deletePickupPoint(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        pickupPointService.deletePickupPoint(id);
        redirectAttributes.addFlashAttribute("message", "Điểm đón đã được xóa thành công!");
        return "redirect:/admin/pickup-points";
    }
    
    // Tìm kiếm điểm đón
    @GetMapping("/pickup-points/search")
    public String searchPickupPoints(
            @RequestParam(required = false) String keyword, 
            Model model) {
        List<PickupPoint> pickupPoints;
        if (keyword != null && !keyword.trim().isEmpty()) {
            pickupPoints = pickupPointService.searchPickupPoints(keyword);
        } else {
            pickupPoints = pickupPointService.getAllPickupPoints();
        }
        model.addAttribute("pickupPoints", pickupPoints);
        model.addAttribute("searchKeyword", keyword);
        return "admin/pickup-points";
    }
    
    // Tìm kiếm chuyến đi theo khoảng thời gian
    @GetMapping("/trips/search")
    public String searchTripsByDateRange(
            @RequestParam(required = false) @DateTimeFormat(pattern="yyyy-MM-dd") Date startDate,
            @RequestParam(required = false) @DateTimeFormat(pattern="yyyy-MM-dd") Date endDate,
            Model model) {
        
        // Đặt khoảng thời gian mặc định nếu không cung cấp
        if (startDate == null) {
            Calendar cal = Calendar.getInstance();
            cal.add(Calendar.DAY_OF_MONTH, -7); // Mặc định là 7 ngày trước
            startDate = cal.getTime();
        }
        
        if (endDate == null) {
            endDate = new Date(); // Mặc định là ngày hiện tại
        }
        
        List<Trip> trips = tripService.getTripsByDateRange(startDate, endDate);
        
        // Sắp xếp để các chuyến đi trong ngày hiện tại lên đầu
        Date currentDate = new Date();
        final Date today = currentDate;
        
        trips.sort((trip1, trip2) -> {
            boolean isTrip1Today = isSameDay(trip1.getDepartureTime(), today);
            boolean isTrip2Today = isSameDay(trip2.getDepartureTime(), today);
            
            if (isTrip1Today && !isTrip2Today) {
                return -1;
            } else if (!isTrip1Today && isTrip2Today) {
                return 1;
            } else {
                return trip1.getDepartureTime().compareTo(trip2.getDepartureTime());
            }
        });
        
        model.addAttribute("trips", trips);
        model.addAttribute("startDate", startDate);
        model.addAttribute("endDate", endDate);
        model.addAttribute("currentDate", currentDate);
        return "admin/trips";
    }
    
    // Helper method to check if two dates are on the same day
    private boolean isSameDay(Date date1, Date date2) {
        if (date1 == null || date2 == null) {
            return false;
        }
        Calendar cal1 = Calendar.getInstance();
        cal1.setTime(date1);
        Calendar cal2 = Calendar.getInstance();
        cal2.setTime(date2);
        return cal1.get(Calendar.YEAR) == cal2.get(Calendar.YEAR) &&
               cal1.get(Calendar.MONTH) == cal2.get(Calendar.MONTH) &&
               cal1.get(Calendar.DAY_OF_MONTH) == cal2.get(Calendar.DAY_OF_MONTH);
    }
    
    // Add ticket management endpoints
    @GetMapping("/tickets")
    public String manageTickets(
            @RequestParam(required = false) String status,
            @RequestParam(required = false) @DateTimeFormat(pattern="yyyy-MM-dd") Date date,
            Model model) {
        
        List<Ticket> tickets;
        
        if (date != null) {
            // Nếu có ngày, lấy vé theo ngày và sắp xếp vé chưa duyệt lên trên
            tickets = ticketService.getTicketsByDate(date);
            model.addAttribute("selectedDate", date);
            
            // Lọc thêm theo trạng thái nếu có
            if (status != null && !status.isEmpty()) {
                final String statusFilter = status;
                tickets = tickets.stream()
                    .filter(ticket -> statusFilter.equals(ticket.getStatus()))
                    .collect(Collectors.toList());
                model.addAttribute("selectedStatus", status);
            }
        } else if (status != null && !status.isEmpty()) {
            // Nếu chỉ có trạng thái, không có ngày
            tickets = ticketService.getTicketsByStatus(status);
            model.addAttribute("selectedStatus", status);
        } else {
            // Mặc định lấy vé của ngày hiện tại và sắp xếp vé chưa duyệt lên trên
            tickets = ticketService.getTicketsByDate(new Date());
            model.addAttribute("selectedDate", new Date());
        }
        
        model.addAttribute("tickets", tickets);
        return "admin/tickets";
    }

    @GetMapping("/tickets/confirm/{id}")
    public String confirmTicket(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        ticketService.updateTicketStatus(id, "CONFIRMED");
        redirectAttributes.addFlashAttribute("successMessage", "Vé đã được xác nhận thành công!");
        return "redirect:/admin/tickets";
    }

    @GetMapping("/tickets/cancel/{id}")
    public String cancelTicket(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        // Sử dụng phương thức cancelTicket để hủy vé và trả lại ghế
        ticketService.cancelTicket(id);
        redirectAttributes.addFlashAttribute("successMessage", "Vé đã được hủy và ghế đã được trả lại thành công!");
        return "redirect:/admin/tickets";
    }
    
    @GetMapping("/tickets/search")
    public String searchTickets(
            @RequestParam(required = false) String customerName,
            @RequestParam(required = false) String phoneNumber,
            @RequestParam(required = false) String status,
            @RequestParam(required = false) @DateTimeFormat(pattern="yyyy-MM-dd") Date bookingDate,
            Model model) {
        
        List<Ticket> tickets;
        
        // Tìm kiếm theo tên, số điện thoại và/hoặc ngày
        if ((customerName != null && !customerName.trim().isEmpty()) || 
            (phoneNumber != null && !phoneNumber.trim().isEmpty()) ||
            (bookingDate != null)) {
            
            tickets = ticketService.searchTickets(customerName, phoneNumber, bookingDate);
            
            // Lọc thêm theo trạng thái nếu có
            if (status != null && !status.trim().isEmpty()) {
                final String statusFilter = status;
                tickets = tickets.stream()
                    .filter(ticket -> statusFilter.equals(ticket.getStatus()))
                    .collect(Collectors.toList());
                model.addAttribute("selectedStatus", status);
            }
            
            model.addAttribute("customerName", customerName);
            model.addAttribute("phoneNumber", phoneNumber);
            if (bookingDate != null) {
                model.addAttribute("selectedDate", bookingDate);
            }
        } 
        // Chỉ lọc theo trạng thái
        else if (status != null && !status.trim().isEmpty()) {
            tickets = ticketService.getTicketsByStatus(status);
            model.addAttribute("selectedStatus", status);
        } 
        // Không có điều kiện tìm kiếm, lấy vé của ngày hiện tại
        else {
            tickets = ticketService.getTicketsByDate(new Date());
            model.addAttribute("selectedDate", new Date());
        }
        
        model.addAttribute("tickets", tickets);
        return "admin/tickets";
    }
}