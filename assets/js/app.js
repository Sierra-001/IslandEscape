$(document).ready(function () {
    console.log('Island Escape Adventures initialized.');

    var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
    var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
        return new bootstrap.Tooltip(tooltipTriggerEl);
    });

    var popoverTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="popover"]'));
    var popoverList = popoverTriggerList.map(function (popoverTriggerEl) {
        return new bootstrap.Popover(popoverTriggerEl);
    });

    setTimeout(function () {
        $('.alert-dismissible').alert('close');
    }, 5000);

    $('.confirm-delete').on('click', function (e) {
        if (!confirm('Are you sure you want to delete this item? This action cannot be undone.')) {
            e.preventDefault();
            return false;
        }
        return true;
    });

    $('.needs-validation').on('submit', function (e) {
        if (!this.checkValidity()) {
            e.preventDefault();
            e.stopPropagation();
        }
        $(this).addClass('was-validated');
    });

    $('.search-box input').on('keypress', function (e) {
        if (e.which === 13) {
            $(this).closest('form').submit();
        }
    });

    $('#back-to-top').on('click', function (e) {
        e.preventDefault();
        $('html, body').animate({ scrollTop: 0 }, 'slow');
    });

    $(window).on('scroll', function () {
        if ($(this).scrollTop() > 300) {
            $('#back-to-top').fadeIn();
        } else {
            $('#back-to-top').fadeOut();
        }
    });

    setTimeout(function () {
        $('.alert').fadeOut('slow', function () {
            $(this).remove();
        });
    }, 5000);
});

function showLoading(elementId) {
    var el = document.getElementById(elementId);
    if (el) {
        el.innerHTML = '<div class="text-center"><div class="spinner-border text-primary" role="status"><span class="visually-hidden">Loading...</span></div></div>';
    }
}

function hideLoading(elementId, content) {
    var el = document.getElementById(elementId);
    if (el && content) {
        el.innerHTML = content;
    }
}

function isValidEmail(email) {
    var pattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
    return pattern.test(email);
}

function isValidPhone(phone) {
    var pattern = /^[\d\s\-+()]{8,20}$/;
    return pattern.test(phone);
}

function showValidationError(inputId, message) {
    var input = document.getElementById(inputId);
    if (input) {
        input.classList.add('is-invalid');
        var feedback = input.nextElementSibling;
        if (feedback && feedback.classList.contains('invalid-feedback')) {
            feedback.textContent = message;
        }
    }
}

function clearValidationError(inputId) {
    var input = document.getElementById(inputId);
    if (input) {
        input.classList.remove('is-invalid');
        var feedback = input.nextElementSibling;
        if (feedback && feedback.classList.contains('invalid-feedback')) {
            feedback.textContent = '';
        }
    }
}
