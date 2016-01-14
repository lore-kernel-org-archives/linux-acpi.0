From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 2/4] acpi_video: Fix using an uninitialized mutex / list_head in acpi_video_handles_brightness_key_presses()
Date: Thu, 14 Jan 2016 09:41:46 +0100
Message-ID: <1452760908-15965-2-git-send-email-hdegoede@redhat.com>
References: <1452760908-15965-1-git-send-email-hdegoede@redhat.com>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1452760908-15965-1-git-send-email-hdegoede@redhat.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: platform-driver-x86@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, Adrien Schildknecht <adrien+dev@schischi.me>, Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
List-Id: linux-acpi@vger.kernel.org

If acpi_video_handles_brightness_key_presses() was called before
acpi_video_register(), it would use the video_list mutex / list_head
uninitialized.

This patch fixes this by using DEFINE_MUTEX / LIST_HEAD when declaring
these, instead of initializing them runtime from acpi_video_register().

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/acpi_video.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index d95aaa5..408b014 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -92,8 +92,8 @@ module_param(only_lcd, bool, 0444);
 
 static int register_count;
 static DEFINE_MUTEX(register_count_mutex);
-static struct mutex video_list_lock;
-static struct list_head video_bus_head;
+static DEFINE_MUTEX(video_list_lock);
+static LIST_HEAD(video_bus_head);
 static int acpi_video_bus_add(struct acpi_device *device);
 static int acpi_video_bus_remove(struct acpi_device *device);
 static void acpi_video_bus_notify(struct acpi_device *device, u32 event);
@@ -2067,9 +2067,6 @@ int acpi_video_register(void)
 		goto leave;
 	}
 
-	mutex_init(&video_list_lock);
-	INIT_LIST_HEAD(&video_bus_head);
-
 	dmi_check_system(video_dmi_table);
 
 	ret = acpi_bus_register_driver(&acpi_video_bus);
-- 
2.5.0
