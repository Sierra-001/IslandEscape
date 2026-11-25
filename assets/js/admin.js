$(document).ready(function () {
    console.log('Admin panel initialized.');
    
    $('.btn-delete').on('click', function (e) {
        if (!confirm('Are you sure you want to delete this record? This action cannot be undone.')) {
            e.preventDefault();
            return false;
        }
        return true;
    });
    
    $('.toggle-status').on('click', function (e) {
        e.preventDefault();
        var url = $(this).data('url');
        var id = $(this).data('id');
        var status = $(this).data('status');
        
        if (confirm('Are you sure you want to change the status?')) {
            // AJAX call would go here
            // $.post(url, { id: id, status: status }, function(response) {
            //     location.reload();
            // });
        }
    });
    
    // ===== DataTable initialization (if needed) =====
    // $('.datatable').DataTable();
    
    // ===== Chart initialization (if needed) =====
    // Example: Chart.js or other chart library
});