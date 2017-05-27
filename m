From: Darren Hart <dvhart@infradead.org>
Subject: [PATCH 06/16] platform/x86: wmi: Fix error handling when creating devices
Date: Fri, 26 May 2017 22:31:20 -0700
Message-ID: <99f96cee64db588a3846332162aaccb11aa8641b.1495862272.git.dvhart@infradead.org>
References: <cover.1495862272.git.dvhart@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1495862272.git.dvhart@infradead.org>
In-Reply-To: <cover.1495862272.git.dvhart@infradead.org>
References: <cover.1495862272.git.dvhart@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: platform-driver-x86@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Andy Lutomirski <luto@amacapital.net>, Mario Limonciello <mario_limonciello@dell.com>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Rafael Wysocki <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Darren Hart <dvhart@infradead.org>
List-Id: linux-acpi@vger.kernel.org

From: Andy Lutomirski <luto@kernel.org>

We have two memory leaks. If guid_already_parsed returned true, we leak
the wmi_block. If wmi_create_device failed, we leak the device.

Simplify the logic and fix both of them.

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
 drivers/platform/x86/wmi.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index f06b7c0..31c317f 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -757,6 +757,15 @@ static int parse_wdg(struct device *wmi_bus_dev, struct acpi_device *device)
 		if (debug_dump_wdg)
 			wmi_dump_wdg(&gblock[i]);
 
+		/*
+		 * Some WMI devices, like those for nVidia hooks, have a
+		 * duplicate GUID. It's not clear what we should do in this
+		 * case yet, so for now, we'll just ignore the duplicate
+		 * for device creation.
+		 */
+		if (guid_already_parsed(device, gblock[i].guid))
+			continue;
+
 		wblock = kzalloc(sizeof(struct wmi_block), GFP_KERNEL);
 		if (!wblock)
 			return -ENOMEM;
@@ -764,19 +773,12 @@ static int parse_wdg(struct device *wmi_bus_dev, struct acpi_device *device)
 		wblock->acpi_device = device;
 		wblock->gblock = gblock[i];
 
-		/*
-		  Some WMI devices, like those for nVidia hooks, have a
-		  duplicate GUID. It's not clear what we should do in this
-		  case yet, so for now, we'll just ignore the duplicate
-		  for device creation.
-		*/
-		if (!guid_already_parsed(device, gblock[i].guid)) {
-			retval = wmi_create_device(wmi_bus_dev, &gblock[i],
-						   wblock, device);
-			if (retval) {
-				wmi_free_devices(device);
-				goto out_free_pointer;
-			}
+		retval = wmi_create_device(wmi_bus_dev, &gblock[i],
+					   wblock, device);
+		if (retval) {
+			put_device(&wblock->dev.dev);
+			wmi_free_devices(device);
+			goto out_free_pointer;
 		}
 
 		list_add_tail(&wblock->list, &wmi_block_list);
-- 
2.9.4
