From: Len Brown <lenb@kernel.org>
Subject: [PATCH 31/37] ACPI: SBS: Add ACPI_PROCFS around procfs handling code.
Date: Wed, 10 Oct 2007 01:06:38 -0400
Message-ID: <1191992804-14965-32-git-send-email-lenb@kernel.org>
References: <1191992804-14965-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:7214 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751224AbXJJFHK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 10 Oct 2007 01:07:10 -0400
In-Reply-To: <1191992804-14965-1-git-send-email-lenb@kernel.org>
Message-Id: <66e4b72bfa7347fd1017b9b82dce77a410f2e4a1.1191992584.git.len.brown@intel.com>
In-Reply-To: <fd1caaed466de2ee100e250b6c755376eda7ba3b.1191992584.git.len.brown@intel.com>
References: <fd1caaed466de2ee100e250b6c755376eda7ba3b.1191992584.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Alexey Starikovskiy <astarikovskiy@suse.de>

Make procfs support optional under ACPI_PROCFS

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/sbs.c |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
index c4f9641..aae65e8 100644
--- a/drivers/acpi/sbs.c
+++ b/drivers/acpi/sbs.c
@@ -29,9 +29,11 @@
 #include <linux/moduleparam.h>
 #include <linux/kernel.h>
 
+#ifdef CONFIG_ACPI_PROCFS
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #include <asm/uaccess.h>
+#endif
 
 #include <linux/acpi.h>
 #include <linux/timer.h>
@@ -86,7 +88,9 @@ MODULE_DEVICE_TABLE(acpi, sbs_device_ids);
 struct acpi_battery {
 	struct power_supply bat;
 	struct acpi_sbs *sbs;
+#ifdef CONFIG_ACPI_PROCFS
 	struct proc_dir_entry *proc_entry;
+#endif
 	unsigned long update_time;
 	char name[8];
 	char manufacturer_name[ACPI_SBS_BLOCK_MAX];
@@ -118,7 +122,9 @@ struct acpi_sbs {
 	struct acpi_device *device;
 	struct acpi_smb_hc *hc;
 	struct mutex lock;
+#ifdef CONFIG_ACPI_PROCFS
 	struct proc_dir_entry *charger_entry;
+#endif
 	struct acpi_battery battery[MAX_SBS_BAT];
 	u8 batteries_supported:4;
 	u8 manager_present:1;
@@ -380,6 +386,8 @@ static int acpi_battery_get_state(struct acpi_battery *battery)
 	return result;
 }
 
+#ifdef CONFIG_ACPI_PROCFS
+
 static int acpi_battery_get_alarm(struct acpi_battery *battery)
 {
 	return acpi_smbus_read(battery->sbs->hc, SMBUS_READ_WORD,
@@ -416,6 +424,8 @@ static int acpi_battery_set_alarm(struct acpi_battery *battery)
 	return ret;
 }
 
+#endif
+
 static int acpi_ac_get_present(struct acpi_sbs *sbs)
 {
 	int result;
@@ -432,6 +442,7 @@ static int acpi_ac_get_present(struct acpi_sbs *sbs)
                               FS Interface (/proc/acpi)
    -------------------------------------------------------------------------- */
 
+#ifdef CONFIG_ACPI_PROCFS
 /* Generic Routines */
 static int
 acpi_sbs_add_fs(struct proc_dir_entry **dir,
@@ -705,6 +716,8 @@ static struct file_operations acpi_ac_state_fops = {
 	.owner = THIS_MODULE,
 };
 
+#endif
+
 /* --------------------------------------------------------------------------
                                  Driver Interface
    -------------------------------------------------------------------------- */
@@ -750,10 +763,12 @@ static int acpi_battery_add(struct acpi_sbs *sbs, int id)
 		return result;
 
 	sprintf(battery->name, ACPI_BATTERY_DIR_NAME, id);
+#ifdef CONFIG_ACPI_PROCFS
 	acpi_sbs_add_fs(&battery->proc_entry, acpi_battery_dir,
 			battery->name, &acpi_battery_info_fops,
 			&acpi_battery_state_fops, &acpi_battery_alarm_fops,
 			battery);
+#endif
 	battery->bat.name = battery->name;
 	battery->bat.type = POWER_SUPPLY_TYPE_BATTERY;
 	if (!acpi_battery_mode(battery)) {
@@ -777,10 +792,12 @@ static void acpi_battery_remove(struct acpi_sbs *sbs, int id)
 {
 	if (sbs->battery[id].bat.dev)
 		power_supply_unregister(&sbs->battery[id].bat);
+#ifdef CONFIG_ACPI_PROCFS
 	if (sbs->battery[id].proc_entry) {
 		acpi_sbs_remove_fs(&(sbs->battery[id].proc_entry),
 				   acpi_battery_dir);
 	}
+#endif
 }
 
 static int acpi_charger_add(struct acpi_sbs *sbs)
@@ -790,11 +807,13 @@ static int acpi_charger_add(struct acpi_sbs *sbs)
 	result = acpi_ac_get_present(sbs);
 	if (result)
 		goto end;
+#ifdef CONFIG_ACPI_PROCFS
 	result = acpi_sbs_add_fs(&sbs->charger_entry, acpi_ac_dir,
 				 ACPI_AC_DIR_NAME, NULL,
 				 &acpi_ac_state_fops, NULL, sbs);
 	if (result)
 		goto end;
+#endif
 	sbs->charger.name = "sbs-charger";
 	sbs->charger.type = POWER_SUPPLY_TYPE_MAINS;
 	sbs->charger.properties = sbs_ac_props;
@@ -812,8 +831,10 @@ static void acpi_charger_remove(struct acpi_sbs *sbs)
 {
 	if (sbs->charger.dev)
 		power_supply_unregister(&sbs->charger);
+#ifdef CONFIG_ACPI_PROCFS
 	if (sbs->charger_entry)
 		acpi_sbs_remove_fs(&sbs->charger_entry, acpi_ac_dir);
+#endif
 }
 
 void acpi_sbs_callback(void *context)
@@ -916,6 +937,7 @@ static int acpi_sbs_remove(struct acpi_device *device, int type)
 
 static void acpi_sbs_rmdirs(void)
 {
+#ifdef CONFIG_ACPI_PROCFS
 	if (acpi_ac_dir) {
 		acpi_unlock_ac_dir(acpi_ac_dir);
 		acpi_ac_dir = NULL;
@@ -924,6 +946,7 @@ static void acpi_sbs_rmdirs(void)
 		acpi_unlock_battery_dir(acpi_battery_dir);
 		acpi_battery_dir = NULL;
 	}
+#endif
 }
 
 static int acpi_sbs_resume(struct acpi_device *device)
@@ -953,6 +976,7 @@ static int __init acpi_sbs_init(void)
 
 	if (acpi_disabled)
 		return -ENODEV;
+#ifdef CONFIG_ACPI_PROCFS
 	acpi_ac_dir = acpi_lock_ac_dir();
 	if (!acpi_ac_dir)
 		return -ENODEV;
@@ -961,6 +985,7 @@ static int __init acpi_sbs_init(void)
 		acpi_sbs_rmdirs();
 		return -ENODEV;
 	}
+#endif
 	result = acpi_bus_register_driver(&acpi_sbs_driver);
 	if (result < 0) {
 		acpi_sbs_rmdirs();
-- 
1.5.3.4.206.g58ba4
