<?php
declare(strict_types=1);

return [
    // Public
    ''                       => 'app/pages/Public/Home.php',
    'packages'               => 'app/pages/Public/Packages.php',
    'package'                => 'app/pages/Public/PackageDetails.php',
    'cart'                   => 'app/pages/Public/Cart.php',
    'login'                  => 'app/pages/Public/Login.php',
    'register'               => 'app/pages/Public/Register.php',
    'forgot-password'        => 'app/pages/Public/ForgotPassword.php',
    'reset-password'         => 'app/pages/Public/ResetPassword.php',
    'logout'                 => 'app/pages/Public/Logout.php',
    'about'                  => 'app/pages/Public/About.php',
    'contact'                => 'app/pages/Public/Contact.php',

    // Secure (requireAuth)
    'checkout'               => 'app/pages/Secure/Checkout.php',
    'order-confirmation'     => 'app/pages/Secure/BookingConfirmation.php',
    'purchase-history'       => 'app/pages/Secure/PurchaseHistory.php',
    'profile'                => 'app/pages/Secure/Profile.php',
    'change-password'        => 'app/pages/Secure/ChangePassword.php',
    'my-queries'             => 'app/pages/Secure/MyQueries.php',

    // Admin (requireAdmin)
    'admin'                  => 'app/pages/Admin/Dashboard.php',
    'admin/packages'         => 'app/pages/Admin/ManagePackages.php',
    'admin/packages/add'     => 'app/pages/Admin/AddPackage.php',
    'admin/users'            => 'app/pages/Admin/ManageUsers.php',
    'admin/bookings'         => 'app/pages/Admin/ManageBookings.php',
    'admin/queries'          => 'app/pages/Admin/ManageQueries.php',
    'admin/reports'          => 'app/pages/Admin/Reports.php',
];