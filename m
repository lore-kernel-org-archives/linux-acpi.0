From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: [RFT PATCH 1/2] tc1100-wmi: Convert wireless to use rfkill
Date: Fri, 10 Oct 2008 19:00:04 +0100
Message-ID: <20081010180004.12879.4588.stgit@localhost>
References: <20081010175958.12879.26768.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bb-87-81-255-5.ukonline.co.uk ([87.81.255.5]:43409 "EHLO
	pegasus." rhost-flags-OK-OK-FAIL-FAIL) by vger.kernel.org with ESMTP
	id S1755842AbYJJSAM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 10 Oct 2008 14:00:12 -0400
In-Reply-To: <20081010175958.12879.26768.stgit@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org

Removal of the old sysfs file will be left for a future patch.

Also, I don't own the hardware, so this patch is compile tested only
(though mostly based on the working acer-wmi code).

While we're at it, fix the broken Kconfig description.

Signed-off-by: Carlos Corbacho <carlos@strangeworlds.co.uk>
---

 drivers/misc/Kconfig      |    5 ++-
 drivers/misc/tc1100-wmi.c |   76 ++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 78 insertions(+), 3 deletions(-)


diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index cce9202..1caa81b 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -208,12 +208,13 @@ config FUJITSU_LAPTOP_DEBUG
 config TC1100_WMI
 	tristate "HP Compaq TC1100 Tablet WMI Extras (EXPERIMENTAL)"
 	depends on X86 && !X86_64
+	depends on RFKILL
 	depends on EXPERIMENTAL
 	depends on ACPI
 	select ACPI_WMI
 	---help---
-	  This is a driver for the WMI extensions (wireless and bluetooth power
-	  control) of the HP Compaq TC1100 tablet.
+	  This is a driver for the WMI extensions (wireless power control and
+	  jogdial mode) of the HP Compaq TC1100 tablet.
 
 config HP_WMI
        tristate "HP WMI extras"
diff --git a/drivers/misc/tc1100-wmi.c b/drivers/misc/tc1100-wmi.c
index f25e4c9..ed49269 100644
--- a/drivers/misc/tc1100-wmi.c
+++ b/drivers/misc/tc1100-wmi.c
@@ -1,7 +1,7 @@
 /*
  *  HP Compaq TC1100 Tablet WMI Extras Driver
  *
- *  Copyright (C) 2007 Carlos Corbacho <carlos@strangeworlds.co.uk>
+ *  Copyright (C) 2007-2008 Carlos Corbacho <carlos@strangeworlds.co.uk>
  *  Copyright (C) 2004 Jamey Hicks <jamey.hicks@hp.com>
  *  Copyright (C) 2001, 2002 Andy Grover <andrew.grover@intel.com>
  *  Copyright (C) 2001, 2002 Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>
@@ -28,7 +28,9 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/rfkill.h>
 #include <linux/types.h>
+#include <linux/workqueue.h>
 #include <acpi/acpi.h>
 #include <acpi/actypes.h>
 #include <acpi/acpi_bus.h>
@@ -73,6 +75,8 @@ struct tc1100_data {
 
 static struct tc1100_data suspend_data;
 
+static struct rfkill *wireless_rfkill;
+
 /* --------------------------------------------------------------------------
 				Device Management
    -------------------------------------------------------------------------- */
@@ -151,6 +155,71 @@ static int set_state(u32 *in, u8 instance)
 }
 
 /* --------------------------------------------------------------------------
+				Rfkill
+   -------------------------------------------------------------------------- */
+
+static void tc1100_rfkill_update(struct work_struct *ignored);
+static DECLARE_DELAYED_WORK(tc1100_rfkill_work, tc1100_rfkill_update);
+static void tc1100_rfkill_update(struct work_struct *ignored)
+{
+	u32 state;
+	int status;
+
+	status = get_state(&state, TC1100_INSTANCE_WIRELESS);
+	if (!status)
+		rfkill_force_state(wireless_rfkill, state ?
+			RFKILL_STATE_UNBLOCKED : RFKILL_STATE_SOFT_BLOCKED);
+
+	schedule_delayed_work(&tc1100_rfkill_work, round_jiffies_relative(HZ));
+}
+
+static int tc1100_rfkill_set(void *data, enum rfkill_state new_state)
+{
+	u32 state;
+	int status;
+
+	state = (u32) (new_state == RFKILL_STATE_UNBLOCKED);
+	status = set_state(&state, TC1100_INSTANCE_WIRELESS);
+	if (status)
+		return -ENODEV;
+	return 0;
+}
+
+static int tc1100_rfkill_init(struct device *dev)
+{
+	int err;
+	u32 state;
+
+	wireless_rfkill = rfkill_allocate(dev, RFKILL_TYPE_WLAN);
+	if (!wireless_rfkill)
+		return -ENOMEM;
+	wireless_rfkill->name = "tc1100-wireless";
+	get_state(&state, TC1100_INSTANCE_WIRELESS);
+	wireless_rfkill->state = state ? RFKILL_STATE_UNBLOCKED :
+		RFKILL_STATE_SOFT_BLOCKED;
+	wireless_rfkill->toggle_radio = tc1100_rfkill_set;
+	wireless_rfkill->user_claim_unsupported = 1;
+
+	err = rfkill_register(wireless_rfkill);
+	if (err) {
+		kfree(wireless_rfkill->data);
+		rfkill_free(wireless_rfkill);
+		return err;
+	}
+
+	schedule_delayed_work(&tc1100_rfkill_work, round_jiffies_relative(HZ));
+
+	return 0;
+}
+
+static void tc1100_rfkill_exit(void)
+{
+	cancel_delayed_work_sync(&tc1100_rfkill_work);
+	rfkill_unregister(wireless_rfkill);
+	return;
+}
+
+/* --------------------------------------------------------------------------
 				FS Interface (/sys)
    -------------------------------------------------------------------------- */
 
@@ -218,6 +287,10 @@ static int tc1100_probe(struct platform_device *device)
 {
 	int result = 0;
 
+	result = tc1100_rfkill_init(&device->dev);
+	if (result)
+		return result;
+
 	result = add_fs();
 	return result;
 }
@@ -225,6 +298,7 @@ static int tc1100_probe(struct platform_device *device)
 
 static int tc1100_remove(struct platform_device *device)
 {
+	tc1100_rfkill_exit();
 	remove_fs();
 	return 0;
 }

