From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: [PATCHv2 4/4] ACPI: Remove unneccesary acpi_disabled checks in acpi
 drivers
Date: Tue, 15 Sep 2009 11:11:09 +0100
Message-ID: <4AAF683D.6050609@tuffmail.co.uk>
References: <1252944569-29799-1-git-send-email-alan-jenkins@tuffmail.co.uk> <1252944569-29799-5-git-send-email-alan-jenkins@tuffmail.co.uk> <200909141346.31381.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f206.google.com ([209.85.219.206]:60116 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752521AbZIOKLJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Sep 2009 06:11:09 -0400
Received: by mail-ew0-f206.google.com with SMTP id 2so298757ewy.17
        for <linux-acpi@vger.kernel.org>; Tue, 15 Sep 2009 03:11:12 -0700 (PDT)
In-Reply-To: <200909141346.31381.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Bjorn Helgaas <bjorn.helgaas@hp.com>

acpi_bus_register_driver() already checks acpi_disabled, so acpi bus
drivers don't need to.  Pass on the return value when it fails
instead of assuming ENODEV.

Also remove registration failure messages from a few drivers; they
serve no obvious purpose and most drivers do without them.

Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Reviewed-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

---
v2: 
 - Remove printk("registration failed").

 - Some module_init functions can now be reduced to a single line:

	return acpi_bus_driver_register(&acpi_drv);


 drivers/acpi/ac.c                       |    5 +----
 drivers/acpi/acpi_memhotplug.c          |    2 +-
 drivers/acpi/battery.c                  |    2 --
 drivers/acpi/container.c                |    4 ++--
 drivers/acpi/ec.c                       |    2 +-
 drivers/acpi/fan.c                      |    2 +-
 drivers/acpi/pci_link.c                 |   11 ++++++-----
 drivers/acpi/power.c                    |    2 +-
 drivers/acpi/sbs.c                      |    4 +---
 drivers/acpi/sbshc.c                    |    7 +------
 drivers/acpi/thermal.c                  |    2 +-
 drivers/acpi/video.c                    |    2 +-
 drivers/hwmon/asus_atk0110.c            |    8 +-------
 drivers/hwmon/hp_accel.c                |    3 ---
 drivers/input/misc/atlas_btns.c         |   13 +------------
 drivers/platform/x86/asus-laptop.c      |    3 ---
 drivers/platform/x86/asus_acpi.c        |    3 ---
 drivers/platform/x86/eeepc-laptop.c     |    2 --
 drivers/platform/x86/panasonic-laptop.c |   14 +-------------
 drivers/platform/x86/wmi.c              |    3 ---
 20 files changed, 20 insertions(+), 74 deletions(-)

diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
index 7725bda..142744a 100644
--- a/drivers/acpi/ac.c
+++ b/drivers/acpi/ac.c
@@ -338,9 +338,6 @@ static int __init acpi_ac_init(void)
 {
 	int result;
 
-	if (acpi_disabled)
-		return -ENODEV;
-
 #ifdef CONFIG_ACPI_PROCFS_POWER
 	acpi_ac_dir = acpi_lock_ac_dir();
 	if (!acpi_ac_dir)
@@ -352,7 +349,7 @@ static int __init acpi_ac_init(void)
 #ifdef CONFIG_ACPI_PROCFS_POWER
 		acpi_unlock_ac_dir(acpi_ac_dir);
 #endif
-		return -ENODEV;
+		return result;
 	}
 
 	return 0;
diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
index 71085b9..30a4600 100644
--- a/drivers/acpi/acpi_memhotplug.c
+++ b/drivers/acpi/acpi_memhotplug.c
@@ -526,7 +526,7 @@ static int __init acpi_memory_device_init(void)
 	result = acpi_bus_register_driver(&acpi_memory_device_driver);
 
 	if (result < 0)
-		return -ENODEV;
+		return result;
 
 	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
 				     ACPI_UINT32_MAX,
diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 90e39d9..f451dc0 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -907,8 +907,6 @@ static struct acpi_driver acpi_battery_driver = {
 
 static void __init acpi_battery_init_async(void *unused, async_cookie_t cookie)
 {
-	if (acpi_disabled)
-		return;
 #ifdef CONFIG_ACPI_PROCFS_POWER
 	acpi_battery_dir = acpi_lock_battery_dir();
 	if (!acpi_battery_dir)
diff --git a/drivers/acpi/container.c b/drivers/acpi/container.c
index 30c4700..c54b69b 100644
--- a/drivers/acpi/container.c
+++ b/drivers/acpi/container.c
@@ -245,7 +245,7 @@ static int __init acpi_container_init(void)
 
 	result = acpi_bus_register_driver(&acpi_container_driver);
 	if (result < 0) {
-		return (result);
+		return result;
 	}
 
 	/* register notify handler to every container device */
@@ -254,7 +254,7 @@ static int __init acpi_container_init(void)
 			    ACPI_UINT32_MAX,
 			    container_walk_namespace_cb, &action, NULL);
 
-	return (0);
+	return 0;
 }
 
 static void __exit acpi_container_exit(void)
diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 5e93ae3..26c58a3 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1010,7 +1010,7 @@ int __init acpi_ec_init(void)
 	result = acpi_bus_register_driver(&acpi_ec_driver);
 	if (result < 0) {
 		remove_proc_entry(ACPI_EC_CLASS, acpi_root_dir);
-		return -ENODEV;
+		return result;
 	}
 
 	return result;
diff --git a/drivers/acpi/fan.c b/drivers/acpi/fan.c
index d40e214..947556e 100644
--- a/drivers/acpi/fan.c
+++ b/drivers/acpi/fan.c
@@ -345,7 +345,7 @@ static int __init acpi_fan_init(void)
 	result = acpi_bus_register_driver(&acpi_fan_driver);
 	if (result < 0) {
 		remove_proc_entry(ACPI_FAN_CLASS, acpi_root_dir);
-		return -ENODEV;
+		return result;
 	}
 
 	return 0;
diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index 394ae89..4a1e22a 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -769,9 +769,7 @@ static int irqrouter_resume(struct sys_device *dev)
 
 static int acpi_pci_link_remove(struct acpi_device *device, int type)
 {
-	struct acpi_pci_link *link;
-
-	link = acpi_driver_data(device);
+	struct acpi_pci_link *link = acpi_driver_data(device);
 
 	mutex_lock(&acpi_link_lock);
 	list_del(&link->list);
@@ -900,6 +898,8 @@ device_initcall(irqrouter_init_sysfs);
 
 static int __init acpi_pci_link_init(void)
 {
+	int result;
+
 	if (acpi_noirq)
 		return 0;
 
@@ -911,8 +911,9 @@ static int __init acpi_pci_link_init(void)
 			acpi_irq_balance = 0;
 	}
 
-	if (acpi_bus_register_driver(&acpi_pci_link_driver) < 0)
-		return -ENODEV;
+	result = acpi_bus_register_driver(&acpi_pci_link_driver);
+	if (result < 0)
+		return result;
 
 	return 0;
 }
diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
index 2c3d844..3cd8d45 100644
--- a/drivers/acpi/power.c
+++ b/drivers/acpi/power.c
@@ -747,7 +747,7 @@ int __init acpi_power_init(void)
 	result = acpi_bus_register_driver(&acpi_power_driver);
 	if (result < 0) {
 		remove_proc_entry(ACPI_POWER_CLASS, acpi_root_dir);
-		return -ENODEV;
+		return result;
 	}
 
 	return 0;
diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
index 25a2f6a..4f83688 100644
--- a/drivers/acpi/sbs.c
+++ b/drivers/acpi/sbs.c
@@ -1013,8 +1013,6 @@ static int __init acpi_sbs_init(void)
 {
 	int result = 0;
 
-	if (acpi_disabled)
-		return -ENODEV;
 #ifdef CONFIG_ACPI_PROCFS_POWER
 	acpi_ac_dir = acpi_lock_ac_dir();
 	if (!acpi_ac_dir)
@@ -1028,7 +1026,7 @@ static int __init acpi_sbs_init(void)
 	result = acpi_bus_register_driver(&acpi_sbs_driver);
 	if (result < 0) {
 		acpi_sbs_rmdirs();
-		return -ENODEV;
+		return result;
 	}
 	return 0;
 }
diff --git a/drivers/acpi/sbshc.c b/drivers/acpi/sbshc.c
index 9e06e9c..c07cabd 100644
--- a/drivers/acpi/sbshc.c
+++ b/drivers/acpi/sbshc.c
@@ -302,12 +302,7 @@ static int acpi_smbus_hc_remove(struct acpi_device *device, int type)
 
 static int __init acpi_smb_hc_init(void)
 {
-	int result;
-
-	result = acpi_bus_register_driver(&acpi_smb_hc_driver);
-	if (result < 0)
-		return -ENODEV;
-	return 0;
+	return acpi_bus_register_driver(&acpi_smb_hc_driver);
 }
 
 static void __exit acpi_smb_hc_exit(void)
diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index fca61a1..767e57d 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -1534,7 +1534,7 @@ static int __init acpi_thermal_init(void)
 	result = acpi_bus_register_driver(&acpi_thermal_driver);
 	if (result < 0) {
 		remove_proc_entry(ACPI_THERMAL_CLASS, acpi_root_dir);
-		return -ENODEV;
+		return result;
 	}
 
 	return 0;
diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 576a600..0433df3 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -2398,7 +2398,7 @@ int acpi_video_register(void)
 	result = acpi_bus_register_driver(&acpi_video_bus);
 	if (result < 0) {
 		remove_proc_entry(ACPI_VIDEO_CLASS, acpi_root_dir);
-		return -ENODEV;
+		return result;
 	}
 
 	/*
diff --git a/drivers/hwmon/asus_atk0110.c b/drivers/hwmon/asus_atk0110.c
index 7fc7625..95c744d 100644
--- a/drivers/hwmon/asus_atk0110.c
+++ b/drivers/hwmon/asus_atk0110.c
@@ -993,13 +993,7 @@ static int atk_remove(struct acpi_device *device, int type)
 
 static int __init atk0110_init(void)
 {
-	int ret;
-
-	ret = acpi_bus_register_driver(&atk_driver);
-	if (ret)
-		pr_info("atk: acpi_bus_register_driver failed: %d\n", ret);
-
-	return ret;
+	return acpi_bus_register_driver(&atk_driver);
 }
 
 static void __exit atk0110_exit(void)
diff --git a/drivers/hwmon/hp_accel.c b/drivers/hwmon/hp_accel.c
index c8d3c88..38f8959 100644
--- a/drivers/hwmon/hp_accel.c
+++ b/drivers/hwmon/hp_accel.c
@@ -357,9 +357,6 @@ static int __init lis3lv02d_init_module(void)
 {
 	int ret;
 
-	if (acpi_disabled)
-		return -ENODEV;
-
 	ret = acpi_bus_register_driver(&lis3lv02d_driver);
 	if (ret < 0)
 		return ret;
diff --git a/drivers/input/misc/atlas_btns.c b/drivers/input/misc/atlas_btns.c
index 1b87191..0b7641a 100644
--- a/drivers/input/misc/atlas_btns.c
+++ b/drivers/input/misc/atlas_btns.c
@@ -154,18 +154,7 @@ static struct acpi_driver atlas_acpi_driver = {
 
 static int __init atlas_acpi_init(void)
 {
-	int result;
-
-	if (acpi_disabled)
-		return -ENODEV;
-
-	result = acpi_bus_register_driver(&atlas_acpi_driver);
-	if (result < 0) {
-		printk(KERN_ERR "Atlas ACPI: Unable to register driver\n");
-		return -ENODEV;
-	}
-
-	return 0;
+	return acpi_bus_register_driver(&atlas_acpi_driver);
 }
 
 static void __exit atlas_acpi_exit(void)
diff --git a/drivers/platform/x86/asus-laptop.c b/drivers/platform/x86/asus-laptop.c
index 8af43e9..4234edb 100644
--- a/drivers/platform/x86/asus-laptop.c
+++ b/drivers/platform/x86/asus-laptop.c
@@ -1438,9 +1438,6 @@ static int __init asus_laptop_init(void)
 {
 	int result;
 
-	if (acpi_disabled)
-		return -ENODEV;
-
 	result = acpi_bus_register_driver(&asus_hotk_driver);
 	if (result < 0)
 		return result;
diff --git a/drivers/platform/x86/asus_acpi.c b/drivers/platform/x86/asus_acpi.c
index 25a7d57..502692b 100644
--- a/drivers/platform/x86/asus_acpi.c
+++ b/drivers/platform/x86/asus_acpi.c
@@ -1416,9 +1416,6 @@ static int __init asus_acpi_init(void)
 {
 	int result;
 
-	if (acpi_disabled)
-		return -ENODEV;
-
 	asus_proc_dir = proc_mkdir(PROC_ASUS, acpi_root_dir);
 	if (!asus_proc_dir) {
 		printk(KERN_ERR "Asus ACPI: Unable to create /proc entry\n");
diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index e7f14a4..eba3772 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -1291,8 +1291,6 @@ static int __init eeepc_laptop_init(void)
 {
 	int result;
 
-	if (acpi_disabled)
-		return -ENODEV;
 	result = acpi_bus_register_driver(&eeepc_hotk_driver);
 	if (result < 0)
 		return result;
diff --git a/drivers/platform/x86/panasonic-laptop.c b/drivers/platform/x86/panasonic-laptop.c
index 953b60c..cd6fbdb 100644
--- a/drivers/platform/x86/panasonic-laptop.c
+++ b/drivers/platform/x86/panasonic-laptop.c
@@ -678,19 +678,7 @@ out_hotkey:
 
 static int __init acpi_pcc_init(void)
 {
-	int result = 0;
-
-	if (acpi_disabled)
-		return -ENODEV;
-
-	result = acpi_bus_register_driver(&acpi_pcc_driver);
-	if (result < 0) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Error registering hotkey driver\n"));
-		return -ENODEV;
-	}
-
-	return 0;
+	return acpi_bus_register_driver(&acpi_pcc_driver);
 }
 
 static int acpi_pcc_hotkey_remove(struct acpi_device *device, int type)
diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 177f8d7..d889f51 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -702,9 +702,6 @@ static int __init acpi_wmi_init(void)
 
 	INIT_LIST_HEAD(&wmi_blocks.list);
 
-	if (acpi_disabled)
-		return -ENODEV;
-
 	result = acpi_bus_register_driver(&acpi_wmi_driver);
 
 	if (result < 0) {
-- 
1.6.3.2



