/**
 * Admin Search Functionality
 */

document.addEventListener('DOMContentLoaded', function() {
    // Clear search form when clicking clear button
    const clearSearchButtons = document.querySelectorAll('.clear-search');
    clearSearchButtons.forEach(button => {
        button.addEventListener('click', function(e) {
            e.preventDefault();
            const form = this.closest('form');
            const inputs = form.querySelectorAll('input[type="text"], input[type="date"]');
            inputs.forEach(input => {
                input.value = '';
            });
            form.submit();
        });
    });
    
    // Handle date inputs in trip search
    const startDateInput = document.querySelector('input[name="startDate"]');
    const endDateInput = document.querySelector('input[name="endDate"]');
    
    if (startDateInput && endDateInput) {
        // Remove auto-submit class to prevent automatic submission
        startDateInput.classList.remove('auto-submit');
        endDateInput.classList.remove('auto-submit');
        
        // Store the initial values
        const initialStartDate = startDateInput.value;
        const initialEndDate = endDateInput.value;
        
        // Add change event listeners without auto-submit
        startDateInput.addEventListener('change', function() {
            // Do not auto-submit when changing date
            // Let user click the filter button manually
        });
        
        endDateInput.addEventListener('change', function() {
            // Do not auto-submit when changing date
            // Let user click the filter button manually
        });
    }
    
    // Add keyboard shortcut (Ctrl+F) to focus on search input
    document.addEventListener('keydown', function(e) {
        if (e.ctrlKey && e.key === 'f') {
            e.preventDefault();
            const searchInput = document.querySelector('.search-input');
            if (searchInput) {
                searchInput.focus();
            }
        }
    });
});

// Function to toggle advanced search options
function toggleAdvancedSearch() {
    const advancedOptions = document.getElementById('advancedSearchOptions');
    if (advancedOptions) {
        advancedOptions.classList.toggle('d-none');
        const toggleButton = document.getElementById('toggleAdvancedSearch');
        if (toggleButton) {
            const isVisible = !advancedOptions.classList.contains('d-none');
            toggleButton.innerHTML = isVisible ? 
                '<i class="bi bi-chevron-up"></i> Ẩn tìm kiếm nâng cao' : 
                '<i class="bi bi-chevron-down"></i> Hiển thị tìm kiếm nâng cao';
        }
    }
} 