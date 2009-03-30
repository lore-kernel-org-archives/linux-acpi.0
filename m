From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 04/10] ACPI: thermal: use .notify method instead of installing
	handler directly
Date: Mon, 30 Mar 2009 11:48:29 -0600
Message-ID: <20090330174829.20905.39529.stgit@bob.kio>
References: <20090330174646.20905.18465.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0014.houston.hp.com ([15.201.24.17]:2770 "EHLO
	g4t0014.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752147AbZC3Rsa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 30 Mar 2009 13:48:30 -0400
In-Reply-To: <20090330174646.20905.18465.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Tony Vroon <tony@linx.net>, Alex Chiang <achiang@hp.com>, linux-acpi@vger.kernel.org, Carlos Corbacho <carlos@strangeworlds.co.uk>, Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, Zhao Yakui <yakui.zhao@intel.com>, Mattia Dongili <malattia@linux.it>, Harald Welte <laforge@gnumonks.org>, Venki Pallipadi <venkatesh.pallipadi@intel.com>, Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, Matthew Garrett <mjg@redhat.com>

This patch adds a .notify() method.  The presence of .notify() causes
Linux/ACPI to manage event handlers and notify handlers on our behalf,
so we don't have to install and remove them ourselves.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
CC: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/thermal.c |   27 ++++-----------------------
 1 files changed, 4 insertions(+), 23 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 99e6f1f..3a7b0c7 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -98,6 +98,7 @@ MODULE_PARM_DESC(psv, "Disable or override all passive trip points.");
 static int acpi_thermal_add(struct acpi_device *device);
 static int acpi_thermal_remove(struct acpi_device *device, int type);
 static int acpi_thermal_resume(struct acpi_device *device);
+static void acpi_thermal_notify(struct acpi_device *device, u32 event);
 static int acpi_thermal_state_open_fs(struct inode *inode, struct file *file);
 static int acpi_thermal_temp_open_fs(struct inode *inode, struct file *file);
 static int acpi_thermal_trip_open_fs(struct inode *inode, struct file *file);
@@ -123,6 +124,7 @@ static struct acpi_driver acpi_thermal_driver = {
 		.add = acpi_thermal_add,
 		.remove = acpi_thermal_remove,
 		.resume = acpi_thermal_resume,
+		.notify = acpi_thermal_notify,
 		},
 };
 
@@ -1579,17 +1581,14 @@ static int acpi_thermal_remove_fs(struct acpi_device *device)
                                  Driver Interface
    -------------------------------------------------------------------------- */
 
-static void acpi_thermal_notify(acpi_handle handle, u32 event, void *data)
+static void acpi_thermal_notify(struct acpi_device *device, u32 event)
 {
-	struct acpi_thermal *tz = data;
-	struct acpi_device *device = NULL;
+	struct acpi_thermal *tz = acpi_driver_data(device);
 
 
 	if (!tz)
 		return;
 
-	device = tz->device;
-
 	switch (event) {
 	case ACPI_THERMAL_NOTIFY_TEMPERATURE:
 		acpi_thermal_check(tz);
@@ -1613,8 +1612,6 @@ static void acpi_thermal_notify(acpi_handle handle, u32 event, void *data)
 				  "Unsupported event [0x%x]\n", event));
 		break;
 	}
-
-	return;
 }
 
 static int acpi_thermal_get_info(struct acpi_thermal *tz)
@@ -1652,7 +1649,6 @@ static int acpi_thermal_get_info(struct acpi_thermal *tz)
 static int acpi_thermal_add(struct acpi_device *device)
 {
 	int result = 0;
-	acpi_status status = AE_OK;
 	struct acpi_thermal *tz = NULL;
 
 
@@ -1689,21 +1685,11 @@ static int acpi_thermal_add(struct acpi_device *device)
 
 	acpi_thermal_check(tz);
 
-	status = acpi_install_notify_handler(device->handle,
-					     ACPI_DEVICE_NOTIFY,
-					     acpi_thermal_notify, tz);
-	if (ACPI_FAILURE(status)) {
-		result = -ENODEV;
-		goto remove_fs;
-	}
-
 	printk(KERN_INFO PREFIX "%s [%s] (%ld C)\n",
 	       acpi_device_name(device), acpi_device_bid(device),
 	       KELVIN_TO_CELSIUS(tz->temperature));
 	goto end;
 
-remove_fs:
-	acpi_thermal_remove_fs(device);
 unregister_thermal_zone:
 	thermal_zone_device_unregister(tz->thermal_zone);
 free_memory:
@@ -1714,7 +1700,6 @@ end:
 
 static int acpi_thermal_remove(struct acpi_device *device, int type)
 {
-	acpi_status status = AE_OK;
 	struct acpi_thermal *tz = NULL;
 
 
@@ -1732,10 +1717,6 @@ static int acpi_thermal_remove(struct acpi_device *device, int type)
 	/* deferred task may reinsert timer */
 	del_timer_sync(&(tz->timer));
 
-	status = acpi_remove_notify_handler(device->handle,
-					    ACPI_DEVICE_NOTIFY,
-					    acpi_thermal_notify);
-
 	/* Terminate policy */
 	if (tz->trips.passive.flags.valid && tz->trips.passive.flags.enabled) {
 		tz->trips.passive.flags.enabled = 0;

