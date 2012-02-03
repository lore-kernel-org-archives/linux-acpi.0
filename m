From: Matthew Garrett <mjg@redhat.com>
Subject: [PATCH 1/3] ACPI: Provide config option to disable BIOS brightness changes on power events
Date: Fri,  3 Feb 2012 10:18:11 -0500
Message-ID: <1328282293-16551-1-git-send-email-mjg@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Matthew Garrett <mjg@redhat.com>, linux-acpi@vger.kernel.org, lenb@kernel.org
List-Id: linux-acpi@vger.kernel.org

The default ACPI behaviour is to instruct the BIOS to automatically change
brightness on power events. This may be undesirable for distributions who
manage brightness in userspace. Provide a config option that disables this
behaviour and leaves brightness control up to the OS.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
Cc: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org
---
 drivers/acpi/Kconfig |    8 ++++++++
 drivers/acpi/video.c |    9 ++++++++-
 2 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 7556913..5354290 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -163,6 +163,14 @@ config ACPI_VIDEO
 	  To compile this driver as a module, choose M here:
 	  the module will be called video.
 
+config ACPI_VIDEO_DISABLE_BIOS_POWER_BRIGHTNESS
+        bool "Disable BIOS brightness changes on power events"
+        depends on ACPI_VIDEO
+        default n
+        help
+	  Many laptops will automatically change brightness on AC/battery
+	  status changes. Choose Y here to disable this.
+
 config ACPI_FAN
 	tristate "Fan"
 	select THERMAL
diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index eaef02a..4b42938 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -86,6 +86,13 @@ module_param(allow_duplicates, bool, 0644);
 static bool use_bios_initial_backlight = 1;
 module_param(use_bios_initial_backlight, bool, 0644);
 
+#ifdef CONFIG_ACPI_VIDEO_DISABLE_BIOS_POWER_BRIGHTNESS
+static bool disable_bios_power_change = true;
+#else
+static bool disable_bios_power_change;
+#endif
+module_param(disable_bios_power_change, bool, 0644);
+
 static int register_count = 0;
 static int acpi_video_bus_add(struct acpi_device *device);
 static int acpi_video_bus_remove(struct acpi_device *device, int type);
@@ -1421,7 +1428,7 @@ static int acpi_video_bus_put_devices(struct acpi_video_bus *video)
 
 static int acpi_video_bus_start_devices(struct acpi_video_bus *video)
 {
-	return acpi_video_bus_DOS(video, 0, 0);
+	return acpi_video_bus_DOS(video, 0, disable_bios_power_change);
 }
 
 static int acpi_video_bus_stop_devices(struct acpi_video_bus *video)
-- 
1.7.7.6
