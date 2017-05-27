From: Darren Hart <dvhart@infradead.org>
Subject: [PATCH 09/16] platform/x86: wmi: Instantiate all devices before adding them
Date: Fri, 26 May 2017 22:31:23 -0700
Message-ID: <a25645295f6aaf80407ff851baa14ec039c885aa.1495862272.git.dvhart@infradead.org>
References: <cover.1495862272.git.dvhart@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <cover.1495862272.git.dvhart@infradead.org>
In-Reply-To: <cover.1495862272.git.dvhart@infradead.org>
References: <cover.1495862272.git.dvhart@infradead.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: platform-driver-x86@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Andy Lutomirski <luto@amacapital.net>, Mario Limonciello <mario_limonciello@dell.com>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Rafael Wysocki <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Darren Hart <dvhart@infradead.org>
List-Id: linux-acpi@vger.kernel.org

From: Andy Lutomirski <luto@kernel.org>

At some point, we will want sub-drivers to get references to other
devices on the same WMI bus. This change is needed to avoid races.

This ends up simplifying the setup code and fixing some leaks, too.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Mario Limonciello <mario_limonciello@dell.com>
Cc: Pali Rohár <pali.rohar@gmail.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linux-kernel@vger.kernel.org
Cc: platform-driver-x86@vger.kernel.org
Cc: linux-acpi@vger.kernel.org
Signed-off-by: Darren Hart (VMware) <dvhart@infradead.org>
---
 drivers/platform/x86/wmi.c | 49 +++++++++++++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 18 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 651693a..bfc0a3f 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -796,7 +796,7 @@ static struct device_type wmi_type_data = {
 	.release = wmi_dev_release,
 };
 
-static int wmi_create_device(struct device *wmi_bus_dev,
+static void wmi_create_device(struct device *wmi_bus_dev,
 			     const struct guid_block *gblock,
 			     struct wmi_block *wblock,
 			     struct acpi_device *device)
@@ -852,7 +852,7 @@ static int wmi_create_device(struct device *wmi_bus_dev,
 
 	}
 
-	return device_register(&wblock->dev.dev);
+	device_initialize(&wblock->dev.dev);
 }
 
 static void wmi_free_devices(struct acpi_device *device)
@@ -863,10 +863,14 @@ static void wmi_free_devices(struct acpi_device *device)
 	list_for_each_entry_safe(wblock, next, &wmi_block_list, list) {
 		if (wblock->acpi_device == device) {
 			list_del(&wblock->list);
-			if (wblock->dev.dev.bus)
-				device_unregister(&wblock->dev.dev);
-			else
+			if (wblock->dev.dev.bus) {
+				/* Device was initialized. */
+				device_del(&wblock->dev.dev);
+				put_device(&wblock->dev.dev);
+			} else {
+				/* device_initialize was not called. */
 				kfree(wblock);
+			}
 		}
 	}
 }
@@ -901,9 +905,9 @@ static int parse_wdg(struct device *wmi_bus_dev, struct acpi_device *device)
 	struct acpi_buffer out = {ACPI_ALLOCATE_BUFFER, NULL};
 	union acpi_object *obj;
 	const struct guid_block *gblock;
-	struct wmi_block *wblock;
+	struct wmi_block *wblock, *next;
 	acpi_status status;
-	int retval;
+	int retval = 0;
 	u32 i, total;
 
 	status = acpi_evaluate_object(device->handle, "_WDG", NULL, &out);
@@ -936,19 +940,15 @@ static int parse_wdg(struct device *wmi_bus_dev, struct acpi_device *device)
 			continue;
 
 		wblock = kzalloc(sizeof(struct wmi_block), GFP_KERNEL);
-		if (!wblock)
-			return -ENOMEM;
+		if (!wblock) {
+			retval = -ENOMEM;
+			break;
+		}
 
 		wblock->acpi_device = device;
 		wblock->gblock = gblock[i];
 
-		retval = wmi_create_device(wmi_bus_dev, &gblock[i],
-					   wblock, device);
-		if (retval) {
-			put_device(&wblock->dev.dev);
-			wmi_free_devices(device);
-			goto out_free_pointer;
-		}
+		wmi_create_device(wmi_bus_dev, &gblock[i], wblock, device);
 
 		list_add_tail(&wblock->list, &wmi_block_list);
 
@@ -958,11 +958,24 @@ static int parse_wdg(struct device *wmi_bus_dev, struct acpi_device *device)
 		}
 	}
 
-	retval = 0;
-
 out_free_pointer:
 	kfree(out.pointer);
 
+	/*
+	 * Now that all of the devices are created, add them to the
+	 * device tree and probe subdrivers.
+	 */
+	list_for_each_entry_safe(wblock, next, &wmi_block_list, list) {
+		if (wblock->acpi_device == device) {
+			if (device_add(&wblock->dev.dev) != 0) {
+				dev_err(wmi_bus_dev,
+					"failed to register %pULL\n",
+					wblock->gblock.guid);
+				list_del(&wblock->list);
+			}
+		}
+	}
+
 	return retval;
 }
 
-- 
2.9.4
