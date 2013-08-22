From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH (revert)] Revert "ACPI / video: Always call acpi_video_init_brightness() on init"
Date: Fri, 23 Aug 2013 00:54:42 +0200
Message-ID: <1403634.a5R4CNkWRc@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Matthew Garrett <mjg59@srcf.ucam.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, Jani Nikula <jani.nikula@linux.intel.com>, Trevor Bortins <enabfluw@gmail.com>
List-Id: linux-acpi@vger.kernel.org

commit 168cf0eca45b86014b8c2a17fcb0673ab1af809b
Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Date:   Thu Aug 22 23:31:38 2013 +0200

    Revert "ACPI / video: Always call acpi_video_init_brightness() on init"
    
    Revert commit c04c697 (ACPI / video: Always call acpi_video_init_brightness()
    on init), because it breaks eDP backlight at 1920x1080 on Acer Aspire S3
    for Trevor Bortins.
    
    References: https://bugs.freedesktop.org/show_bug.cgi?id=68355
    Reported-and-bisected-by: Trevor Bortins <enabfluw@gmail.com>
    Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index e1284b8..3270d3c 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -908,9 +908,6 @@ static void acpi_video_device_find_cap(struct acpi_video_device *device)
 		device->cap._DDC = 1;
 	}
 
-	if (acpi_video_init_brightness(device))
-		return;
-
 	if (acpi_video_backlight_support()) {
 		struct backlight_properties props;
 		struct pci_dev *pdev;
@@ -920,6 +917,9 @@ static void acpi_video_device_find_cap(struct acpi_video_device *device)
 		static int count = 0;
 		char *name;
 
+		result = acpi_video_init_brightness(device);
+		if (result)
+			return;
 		name = kasprintf(GFP_KERNEL, "acpi_video%d", count);
 		if (!name)
 			return;
@@ -979,11 +979,6 @@ static void acpi_video_device_find_cap(struct acpi_video_device *device)
 		if (result)
 			printk(KERN_ERR PREFIX "Create sysfs link\n");
 
-	} else {
-		/* Remove the brightness object. */
-		kfree(device->brightness->levels);
-		kfree(device->brightness);
-		device->brightness = NULL;
 	}
 }
 
