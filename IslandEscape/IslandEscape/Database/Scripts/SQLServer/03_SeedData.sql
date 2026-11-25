/*
Name:   Tonta Jonathan
Date:   28/06/2026
Title:  Island Escape Adventures
*/
-- Seed Data - Categories and Settings

USE [IslandEscapeDB]
GO

-- Insert default settings
INSERT INTO [dbo].[Settings] (SettingKey, SettingValue, Description)
VALUES
    ('SiteName', 'Island Escape Adventures', 'Website name'),
    ('SiteEmail', 'info@islandescape.mu', 'Contact email'),
    ('Currency', 'MUR', 'Default currency'),
    ('TaxRate', '15', 'Tax percentage'),
    ('BookingPrefix', 'IE', 'Booking number prefix')
GO

-- Insert default categories
INSERT INTO [dbo].[Categories] (Name, Description, Icon, DisplayOrder, IsActive)
VALUES
    ('Luxury Hotels', 'Premium hotel accommodations with world-class amenities', 'fa-hotel', 1, 1),
    ('Beach Resorts', 'Stunning beachfront resorts with ocean views', 'fa-umbrella-beach', 2, 1),
    ('Adventure Activities', 'Exciting adventures and water sports', 'fa-hiking', 3, 1),
    ('Island Excursions', 'Guided tours exploring Mauritius attractions', 'fa-ship', 4, 1),
    ('Airport Transfers', 'Comfortable and reliable transport services', 'fa-car', 5, 1),
    ('Dining Experiences', 'Fine dining and local cuisine experiences', 'fa-utensils', 6, 1)
GO

-- Insert Sample Packages:
-- Luxury Hotels (CategoryID = 1)
INSERT INTO [dbo].[Packages] (CategoryID, Name, Description, Price, DiscountedPrice, Duration, Location, MaxPersons, ImageURL, IsFeatured, IsActive)
VALUES
(1, 'Belle Mare Plage Resort', 'Experience ultimate luxury at Belle Mare Plage. This 5-star resort offers pristine white beaches, world-class amenities, and exceptional service.', 45000.00, 38000.00, '7 Nights', 'Belle Mare', 2, 'belle-mare-plage.jpg', 1, 1),
(1, 'Le Morne Mountain View Resort', 'Nestled at the foot of the iconic Le Morne Mountain, this resort offers breathtaking views and unparalleled luxury.', 52000.00, NULL, '5 Nights', 'Le Morne', 2, 'le-morne-resort.jpg', 0, 1),
(1, 'Trou aux Biches Resort', 'A tropical paradise with crystal-clear waters and luxury overwater bungalows. Perfect for honeymooners.', 48000.00, 42000.00, '7 Nights', 'Trou aux Biches', 2, 'trou-aux-biches.jpg', 0, 1),
(1, 'Grand Baie Luxury Hotel', 'Located in the vibrant Grand Baie area, this hotel offers modern luxury with easy access to shopping and nightlife.', 35000.00, NULL, '5 Nights', 'Grand Baie', 2, 'grand-baie-hotel.jpg', 0, 1),
(1, 'Flic en Flac Beach Resort', 'Enjoy stunning sunsets and water activities at this beautiful beachfront resort on the west coast.', 40000.00, 36000.00, '6 Nights', 'Flic en Flac', 2, 'flic-en-flac.jpg', 0, 1);

-- Beach Resorts (CategoryID = 2)
INSERT INTO [dbo].[Packages] (CategoryID, Name, Description, Price, DiscountedPrice, Duration, Location, MaxPersons, ImageURL, IsFeatured, IsActive)
VALUES
(2, 'Blue Bay Beach Resort', 'A stunning beachfront resort with direct access to the Blue Bay Marine Park. Perfect for snorkeling and diving enthusiasts.', 32000.00, 28000.00, '5 Nights', 'Blue Bay', 2, 'blue-bay-resort.jpg', 1, 1),
(2, 'Mont Choisy Beach Club', 'Experience the charm of the north coast at this beautiful beach club with panoramic ocean views.', 28000.00, NULL, '4 Nights', 'Mont Choisy', 2, 'mont-choisy.jpg', 0, 1),
(2, 'Palmar Beach Resort', 'A tranquil escape on the east coast with pristine white sands and turquoise waters.', 30000.00, 26000.00, '5 Nights', 'Palmar', 2, 'palmar-beach.jpg', 0, 1),
(2, 'Pereybere Beach Hotel', 'Located in the picturesque Pereybere area, this hotel offers a perfect blend of relaxation and adventure.', 27000.00, NULL, '4 Nights', 'Pereybere', 2, 'pereybere-hotel.jpg', 0, 1),
(2, 'Riviere Noire Ocean View', 'Stunning ocean views and world-class fishing opportunities at this west coast resort.', 34000.00, 30000.00, '6 Nights', 'Riviere Noire', 2, 'riviere-noire.jpg', 0, 1);

-- Adventure Activities (CategoryID = 3)
INSERT INTO [dbo].[Packages] (CategoryID, Name, Description, Price, DiscountedPrice, Duration, Location, MaxPersons, ImageURL, IsFeatured, IsActive)
VALUES
(3, 'Catamaran Cruise Adventure', 'Full-day catamaran cruise with snorkeling, BBQ lunch, and dolphin watching. Perfect for families and groups.', 8500.00, 7500.00, '1 Day', 'West Coast', 10, 'catamaran-cruise.jpg', 1, 1),
(3, 'Scuba Diving Experience', 'Discover the underwater wonders of Mauritius with a certified diving instructor. Includes all equipment.', 6500.00, NULL, 'Half Day', 'Flic en Flac', 4, 'scuba-diving.jpg', 0, 1),
(3, 'Quad Biking Safari', 'Explore the rugged landscapes of Mauritius on an exciting quad biking safari through nature trails.', 4500.00, 3800.00, '3 Hours', 'Casela', 2, 'quad-biking.jpg', 0, 1);

-- Island Excursions (CategoryID = 4)
INSERT INTO [dbo].[Packages] (CategoryID, Name, Description, Price, DiscountedPrice, Duration, Location, MaxPersons, ImageURL, IsFeatured, IsActive)
VALUES
(4, 'Port Louis Market Tour', 'Discover the vibrant markets and cultural heritage of Port Louis, the capital city of Mauritius.', 3500.00, NULL, 'Half Day', 'Port Louis', 10, 'port-louis-market.jpg', 0, 1),
(4, 'Casela Park Adventure', 'Full-day exploration of Casela World of Adventures with safari, zip lines, and animal encounters.', 7500.00, 6500.00, '1 Day', 'Casela', 8, 'casela-park.jpg', 1, 1),
(4, 'South Coast Discovery', 'Explore the stunning south coast with visits to Rochester Falls, Gris Gris, and local villages.', 5000.00, 4500.00, '1 Day', 'South Coast', 8, 'south-coast.jpg', 0, 1);

-- Airport Transfers (CategoryID = 5)
INSERT INTO [dbo].[Packages] (CategoryID, Name, Description, Price, DiscountedPrice, Duration, Location, MaxPersons, ImageURL, IsFeatured, IsActive)
VALUES
(5, 'Private Airport Transfer', 'Luxury private transfer from SSR International Airport to any hotel or resort in Mauritius.', 2500.00, 2000.00, '1 Way', 'All Regions', 4, 'airport-transfer.jpg', 0, 1),
(5, 'Shared Shuttle Service', 'Economical shared shuttle service from the airport to major hotel zones.', 1200.00, NULL, '1 Way', 'All Regions', 8, 'shared-shuttle.jpg', 0, 1);

-- Dining Experiences (CategoryID = 6)
INSERT INTO [dbo].[Packages] (CategoryID, Name, Description, Price, DiscountedPrice, Duration, Location, MaxPersons, ImageURL, IsFeatured, IsActive)
VALUES
(6, 'Sunset Beach Dinner', 'Romantic 3-course dinner on the beach with stunning sunset views. Includes complimentary drinks.', 4500.00, 3800.00, '2 Hours', 'Flic en Flac', 2, 'sunset-dinner.jpg', 0, 1),
(6, 'Mauritian Cooking Class', 'Learn to cook authentic Mauritian cuisine with a local chef and enjoy the meal you prepare.', 3500.00, NULL, '3 Hours', 'Grand Baie', 6, 'cooking-class.jpg', 0, 1);
