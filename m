From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: [PATCH 12/12] ACPI: SBS: Add ACPI_PROCFS around procfs handling code.
Date: Thu, 16 Aug 2007 18:04:17 +0400
Message-ID: <20070816140417.19441.60209.stgit@z61m>
References: <20070816140322.19441.63139.stgit@z61m>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from [81.5.104.13] ([81.5.104.13]:40427 "EHLO z61m"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1760342AbXHPOew (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 16 Aug 2007 10:34:52 -0400
In-Reply-To: <20070816140322.19441.63139.stgit@z61m>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, linux-acpi@vger.kernel.org
Cc: astarikovskiy@suse.de

Make procfs support optional under ACPI_PROCFS

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
---

 drivers/acpi/sbs.c |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
index 87bee1e..7db85a9 100644
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
@@ -91,7 +93,9 @@ struct acpi_battery {
 	struct power_supply bat;
 #endif
 	struct acpi_sbs *sbs;
+#ifdef CONFIG_ACPI_PROCFS
 	struct proc_dir_entry *proc_entry;
+#endif
 	unsigned long update_time;
 	char name[8];
 	char manufacturer_name[ACPI_SBS_BLOCK_MAX];
@@ -125,7 +129,9 @@ struct acpi_sbs {
 	struct acpi_device *device;
 	struct acpi_smb_hc *hc;
 	struct mutex lock;
+#ifdef CONFIG_ACPI_PROCFS
 	struct proc_dir_entry *charger_entry;
+#endif
 	struct acpi_battery battery[MAX_SBS_BAT];
 	u8 batteries_supported:4;
 	u8 manager_present:1;
@@ -389,6 +395,8 @@ static int acpi_battery_get_state(struct acpi_battery *battery)
 	return result;
 }
 
+#ifdef CONFIG_ACPI_PROCFS
+
 static int acpi_battery_get_alarm(struct acpi_battery *battery)
 {
 	return acpi_smbus_read(battery->sbs->hc, SMBUS_READ_WORD,
@@ -424,6 +432,7 @@ static int acpi_battery_set_alarm(struct acpi_battery *battery)
       end:
 	return ret;
 }
+#endif
 
 static int acpi_ac_get_present(struct acpi_sbs *sbs)
 {
@@ -759,10 +768,12 @@ static int acpi_battery_add(struct acpi_sbs *sbs, int id)
 		return result;
 
 	sprintf(battery->name, ACPI_BATTERY_DIR_NAME, id);
+#ifdef CONFIG_ACPI_PROCFS
 	acpi_sbs_add_fs(&battery->proc_entry, acpi_battery_dir,
 			battery->name, &acpi_battery_info_fops,
 			&acpi_battery_state_fops, &acpi_battery_alarm_fops,
 			battery);
+#endif
 #ifdef ENABLE_POWER_SUPPLY
 	battery->bat.name = battery->name;
 	battery->bat.type = POWER_SUPPLY_TYPE_BATTERY;
@@ -790,10 +801,12 @@ static void acpi_battery_remove(struct acpi_sbs *sbs, int id)
 	if (sbs->battery[id].bat.dev)
 		power_supply_unregister(&sbs->battery[id].bat);
 #endif
+#ifdef CONFIG_ACPI_PROCFS
 	if (sbs->battery[id].proc_entry) {
 		acpi_sbs_remove_fs(&(sbs->battery[id].proc_entry),
 				   acpi_battery_dir);
 	}
+#endif
 }
 
 static int acpi_charger_add(struct acpi_sbs *sbs)
@@ -803,11 +816,13 @@ static int acpi_charger_add(struct acpi_sbs *sbs)
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
 #ifdef ENABLE_POWER_SUPPLY
 	sbs->charger.name = "sbs-charger";
 	sbs->charger.type = POWER_SUPPLY_TYPE_MAINS;
@@ -829,8 +844,10 @@ static void acpi_charger_remove(struct acpi_sbs *sbs)
 	if (sbs->charger.dev)
 		power_supply_unregister(&sbs->charger);
 #endif
+#ifdef CONFIG_ACPI_PROCFS
 	if (sbs->charger_entry)
 		acpi_sbs_remove_fs(&sbs->charger_entry, acpi_ac_dir);
+#endif
 }
 
 void acpi_sbs_callback(void *context)
@@ -933,6 +950,7 @@ static int acpi_sbs_remove(struct acpi_device *device, int type)
 
 static void acpi_sbs_rmdirs(void)
 {
+#ifdef CONFIG_ACPI_PROCFS
 	if (acpi_ac_dir) {
 		acpi_unlock_ac_dir(acpi_ac_dir);
 		acpi_ac_dir = NULL;
@@ -941,6 +959,7 @@ static void acpi_sbs_rmdirs(void)
 		acpi_unlock_battery_dir(acpi_battery_dir);
 		acpi_battery_dir = NULL;
 	}
+#endif
 }
 
 static int acpi_sbs_resume(struct acpi_device *device)
@@ -970,6 +989,7 @@ static int __init acpi_sbs_init(void)
 
 	if (acpi_disabled)
 		return -ENODEV;
+#ifdef CONFIG_ACPI_PROCFS
 	acpi_ac_dir = acpi_lock_ac_dir();
 	if (!acpi_ac_dir)
 		return -ENODEV;
@@ -978,6 +998,7 @@ static int __init acpi_sbs_init(void)
 		acpi_sbs_rmdirs();
 		return -ENODEV;
 	}
+#endif
 	result = acpi_bus_register_driver(&acpi_sbs_driver);
 	if (result < 0) {
 		acpi_sbs_rmdirs();

