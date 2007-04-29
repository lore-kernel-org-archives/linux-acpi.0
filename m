From: Len Brown <len.brown@intel.com>
Subject: [PATCH 022/105] ACPI: sbs: Common interface with CM battery
Date: Sun, 29 Apr 2007 00:50:22 -0400
Message-ID: <1177822324973-git-send-email-len.brown@intel.com>
References: <11778223052751-git-send-email-len.brown@intel.com>
 <11778223068-git-send-email-len.brown@intel.com>
 <11778223072296-git-send-email-len.brown@intel.com>
 <11778223083747-git-send-email-len.brown@intel.com>
 <11778223081771-git-send-email-len.brown@intel.com>
 <1177822309524-git-send-email-len.brown@intel.com>
 <1177822310688-git-send-email-len.brown@intel.com>
 <11778223112050-git-send-email-len.brown@intel.com>
 <11778223122850-git-send-email-len.brown@intel.com>
 <11778223131932-git-send-email-len.brown@intel.com>
 <11778223143898-git-send-email-len.brown@intel.com>
 <11778223151972-git-send-email-len.brown@intel.com>
 <11778223152006-git-send-email-len.brown@intel.com>
 <11778223161614-git-send-email-len.brown@intel.com>
 <11778223173663-git-send-email-len.brown@intel.com>
 <11778223183783-git-send-email-len.brown@intel.com>
 <11778223192706-git-send-email-len.brown@intel.com>
 <11778223201940-git-send-email-len.brown@intel.com>
 <11778223212414-git-send-email-len.brown@intel.com>
 <11778223211710-git-send-email-len.brown@intel.com>
 <11778223222525-git-send-email-len.brown@intel.com>
 <11778223233885-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:58359 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754608AbXD2EwG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 29 Apr 2007 00:52:06 -0400
In-Reply-To: <11778223233885-git-send-email-len.brown@intel.com>
Message-Id: <722062334b972c31a3b83dbf7e9b5a58bb2707dd.1177822058.git.len.brown@intel.com>
In-Reply-To: <ac122bb64b0d51f0512185d3522a75f3f3a80bc9.1177822058.git.len.brown@intel.com>
References: <ac122bb64b0d51f0512185d3522a75f3f3a80bc9.1177822058.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Vladimir Lebedev <vladimir.p.lebedev@intel.com>, Len Brown <len.brown@intel.com>

From: Vladimir Lebedev <vladimir.p.lebedev@intel.com>

The SBS driver has tne features as CM battery:
SBS update_time variable has tne same definition as CM battery 'update_time' variable.

Signed-off-by: Vladimir Lebedev <vladimir.p.lebedev@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/sbs.c |  577 +++++++++++++++++++++++++++++-----------------------
 1 files changed, 319 insertions(+), 258 deletions(-)

diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
index 3956645..c1bae10 100644
--- a/drivers/acpi/sbs.c
+++ b/drivers/acpi/sbs.c
@@ -31,6 +31,7 @@
 #include <asm/uaccess.h>
 #include <linux/acpi.h>
 #include <linux/timer.h>
+#include <linux/jiffies.h>
 #include <linux/delay.h>
 
 #define ACPI_SBS_COMPONENT		0x00080000
@@ -109,29 +110,19 @@ extern void acpi_unlock_battery_dir(struct proc_dir_entry *acpi_battery_dir);
 #define ACPI_SBS_WORD_DATA		1
 #define ACPI_SBS_BLOCK_DATA		2
 
-static struct semaphore sbs_sem;
+#define	UPDATE_DELAY	10
 
-#define	UPDATE_MODE		QUEUE_UPDATE_MODE
-/* REQUEST_UPDATE_MODE  QUEUE_UPDATE_MODE */
-#define	UPDATE_INFO_MODE	0
-#define	UPDATE_TIME		60
-#define	UPDATE_TIME2		0
+/* 0 - every time, > 0 - by update_time */
+static unsigned int update_time = 120;
 
-static int capacity_mode = CAPACITY_UNIT;
-static int update_mode = UPDATE_MODE;
-static int update_info_mode = UPDATE_INFO_MODE;
-static int update_time = UPDATE_TIME;
-static int update_time2 = UPDATE_TIME2;
+static unsigned int capacity_mode = CAPACITY_UNIT;
 
-module_param(capacity_mode, int, 0);
-module_param(update_mode, int, 0);
-module_param(update_info_mode, int, 0);
-module_param(update_time, int, 0);
-module_param(update_time2, int, 0);
+module_param(update_time, uint, 0644);
+module_param(capacity_mode, uint, 0444);
 
 static int acpi_sbs_add(struct acpi_device *device);
 static int acpi_sbs_remove(struct acpi_device *device, int type);
-static void acpi_sbs_update_queue(void *data);
+static int acpi_sbs_resume(struct acpi_device *device);
 
 static struct acpi_driver acpi_sbs_driver = {
 	.name = "sbs",
@@ -140,9 +131,14 @@ static struct acpi_driver acpi_sbs_driver = {
 	.ops = {
 		.add = acpi_sbs_add,
 		.remove = acpi_sbs_remove,
+		.resume = acpi_sbs_resume,
 		},
 };
 
+struct acpi_ac {
+	int ac_present;
+};
+
 struct acpi_battery_info {
 	int capacity_mode;
 	s16 full_charge_capacity;
@@ -160,9 +156,7 @@ struct acpi_battery_state {
 	s16 voltage;
 	s16 amperage;
 	s16 remaining_capacity;
-	s16 average_time_to_empty;
-	s16 average_time_to_full;
-	s16 battery_status;
+	s16 battery_state;
 };
 
 struct acpi_battery_alarm {
@@ -171,9 +165,9 @@ struct acpi_battery_alarm {
 
 struct acpi_battery {
 	int alive;
-	int battery_present;
 	int id;
 	int init_state;
+	int battery_present;
 	struct acpi_sbs *sbs;
 	struct acpi_battery_info info;
 	struct acpi_battery_state state;
@@ -185,18 +179,22 @@ struct acpi_sbs {
 	acpi_handle handle;
 	int base;
 	struct acpi_device *device;
+	struct acpi_ec_smbus *smbus;
+	struct mutex mutex;
 	int sbsm_present;
 	int sbsm_batteries_supported;
-	int ac_present;
 	struct proc_dir_entry *ac_entry;
+	struct acpi_ac ac;
 	struct acpi_battery battery[MAX_SBS_BAT];
-	int update_info_mode;
 	int zombie;
-	int update_time;
-	int update_time2;
 	struct timer_list update_timer;
+	int run_cnt;
+	int update_proc_flg;
 };
 
+static int acpi_sbs_update_run(struct acpi_sbs *sbs, int id, int data_type);
+static void acpi_sbs_update_time(void *data);
+
 union sbs_rw_data {
 	u16 word;
 	u8 block[ACPI_SBS_BLOCK_MAX + 2];
@@ -205,8 +203,6 @@ union sbs_rw_data {
 static int acpi_ec_sbs_access(struct acpi_sbs *sbs, u16 addr,
 			      char read_write, u8 command, int size,
 			      union sbs_rw_data *data);
-static void acpi_update_delay(struct acpi_sbs *sbs);
-static int acpi_sbs_update_run(struct acpi_sbs *sbs, int data_type);
 
 /* --------------------------------------------------------------------------
                                SMBus Communication
@@ -383,11 +379,49 @@ acpi_sbs_write_word(struct acpi_sbs *sbs, int addr, int func, int word)
 	return result;
 }
 
+static int sbs_zombie(struct acpi_sbs *sbs)
+{
+	return (sbs->zombie);
+}
+
+static int sbs_mutex_lock(struct acpi_sbs *sbs)
+{
+	if (sbs_zombie(sbs)) {
+		return -ENODEV;
+	}
+	mutex_lock(&sbs->mutex);
+	return 0;
+}
+
+static void sbs_mutex_unlock(struct acpi_sbs *sbs)
+{
+	mutex_unlock(&sbs->mutex);
+}
+
 /* --------------------------------------------------------------------------
                             Smart Battery System Management
    -------------------------------------------------------------------------- */
 
-/* Smart Battery */
+static int acpi_check_update_proc(struct acpi_sbs *sbs)
+{
+	acpi_status status = AE_OK;
+
+	if (update_time == 0) {
+		sbs->update_proc_flg = 0;
+		return 0;
+	}
+	if (sbs->update_proc_flg == 0) {
+		status = acpi_os_execute(OSL_GPE_HANDLER,
+					 acpi_sbs_update_time, sbs);
+		if (status != AE_OK) {
+			ACPI_EXCEPTION((AE_INFO, status,
+					"acpi_os_execute() failed"));
+			return 1;
+		}
+		sbs->update_proc_flg = 1;
+	}
+	return 0;
+}
 
 static int acpi_sbs_generate_event(struct acpi_device *device,
 				   int event, int state, char *bid, char *class)
@@ -430,16 +464,6 @@ static int acpi_battery_get_present(struct acpi_battery *battery)
 	return result;
 }
 
-static int acpi_battery_is_present(struct acpi_battery *battery)
-{
-	return (battery->battery_present);
-}
-
-static int acpi_ac_is_present(struct acpi_sbs *sbs)
-{
-	return (sbs->ac_present);
-}
-
 static int acpi_battery_select(struct acpi_battery *battery)
 {
 	struct acpi_sbs *sbs = battery->sbs;
@@ -447,7 +471,7 @@ static int acpi_battery_select(struct acpi_battery *battery)
 	s16 state;
 	int foo;
 
-	if (battery->sbs->sbsm_present) {
+	if (sbs->sbsm_present) {
 
 		/* Take special care not to knobble other nibbles of
 		 * state (aka selector_state), since
@@ -523,6 +547,8 @@ static int acpi_battery_get_info(struct acpi_battery *battery)
 				    &battery->info.design_capacity);
 
 	if (result) {
+		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
+				"acpi_sbs_read_word() failed"));
 		goto end;
 	}
 
@@ -573,6 +599,8 @@ static int acpi_battery_get_info(struct acpi_battery *battery)
 	result = acpi_sbs_read_word(sbs, ACPI_SB_SMBUS_ADDR, 0x1c,
 				    &battery->info.serial_number);
 	if (result) {
+		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
+				"acpi_sbs_read_word() failed"));
 		goto end;
 	}
 
@@ -604,22 +632,11 @@ static int acpi_battery_get_info(struct acpi_battery *battery)
 	return result;
 }
 
-static void acpi_update_delay(struct acpi_sbs *sbs)
-{
-	if (sbs->zombie) {
-		return;
-	}
-	if (sbs->update_time2 > 0) {
-		msleep(sbs->update_time2 * 1000);
-	}
-}
-
 static int acpi_battery_get_state(struct acpi_battery *battery)
 {
 	struct acpi_sbs *sbs = battery->sbs;
 	int result = 0;
 
-	acpi_update_delay(battery->sbs);
 	result = acpi_sbs_read_word(sbs, ACPI_SB_SMBUS_ADDR, 0x09,
 				    &battery->state.voltage);
 	if (result) {
@@ -628,7 +645,6 @@ static int acpi_battery_get_state(struct acpi_battery *battery)
 		goto end;
 	}
 
-	acpi_update_delay(battery->sbs);
 	result = acpi_sbs_read_word(sbs, ACPI_SB_SMBUS_ADDR, 0x0a,
 				    &battery->state.amperage);
 	if (result) {
@@ -637,7 +653,6 @@ static int acpi_battery_get_state(struct acpi_battery *battery)
 		goto end;
 	}
 
-	acpi_update_delay(battery->sbs);
 	result = acpi_sbs_read_word(sbs, ACPI_SB_SMBUS_ADDR, 0x0f,
 				    &battery->state.remaining_capacity);
 	if (result) {
@@ -646,35 +661,14 @@ static int acpi_battery_get_state(struct acpi_battery *battery)
 		goto end;
 	}
 
-	acpi_update_delay(battery->sbs);
-	result = acpi_sbs_read_word(sbs, ACPI_SB_SMBUS_ADDR, 0x12,
-				    &battery->state.average_time_to_empty);
-	if (result) {
-		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
-				"acpi_sbs_read_word() failed"));
-		goto end;
-	}
-
-	acpi_update_delay(battery->sbs);
-	result = acpi_sbs_read_word(sbs, ACPI_SB_SMBUS_ADDR, 0x13,
-				    &battery->state.average_time_to_full);
-	if (result) {
-		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
-				"acpi_sbs_read_word() failed"));
-		goto end;
-	}
-
-	acpi_update_delay(battery->sbs);
 	result = acpi_sbs_read_word(sbs, ACPI_SB_SMBUS_ADDR, 0x16,
-				    &battery->state.battery_status);
+				    &battery->state.battery_state);
 	if (result) {
 		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
 				"acpi_sbs_read_word() failed"));
 		goto end;
 	}
 
-	acpi_update_delay(battery->sbs);
-
       end:
 	return result;
 }
@@ -692,8 +686,6 @@ static int acpi_battery_get_alarm(struct acpi_battery *battery)
 		goto end;
 	}
 
-	acpi_update_delay(battery->sbs);
-
       end:
 
 	return result;
@@ -751,6 +743,7 @@ static int acpi_battery_set_alarm(struct acpi_battery *battery,
 
 static int acpi_battery_set_mode(struct acpi_battery *battery)
 {
+	struct acpi_sbs *sbs = battery->sbs;
 	int result = 0;
 	s16 battery_mode;
 
@@ -758,7 +751,7 @@ static int acpi_battery_set_mode(struct acpi_battery *battery)
 		goto end;
 	}
 
-	result = acpi_sbs_read_word(battery->sbs,
+	result = acpi_sbs_read_word(sbs,
 				    ACPI_SB_SMBUS_ADDR, 0x03, &battery_mode);
 	if (result) {
 		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
@@ -771,7 +764,7 @@ static int acpi_battery_set_mode(struct acpi_battery *battery)
 	} else {
 		battery_mode |= 0x8000;
 	}
-	result = acpi_sbs_write_word(battery->sbs,
+	result = acpi_sbs_write_word(sbs,
 				     ACPI_SB_SMBUS_ADDR, 0x03, battery_mode);
 	if (result) {
 		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
@@ -779,7 +772,7 @@ static int acpi_battery_set_mode(struct acpi_battery *battery)
 		goto end;
 	}
 
-	result = acpi_sbs_read_word(battery->sbs,
+	result = acpi_sbs_read_word(sbs,
 				    ACPI_SB_SMBUS_ADDR, 0x03, &battery_mode);
 	if (result) {
 		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
@@ -798,7 +791,7 @@ static int acpi_battery_init(struct acpi_battery *battery)
 	result = acpi_battery_select(battery);
 	if (result) {
 		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
-				"acpi_battery_init() failed"));
+				"acpi_battery_select() failed"));
 		goto end;
 	}
 
@@ -848,7 +841,7 @@ static int acpi_ac_get_present(struct acpi_sbs *sbs)
 		goto end;
 	}
 
-	sbs->ac_present = (charger_status & 0x8000) >> 15;
+	sbs->ac.ac_present = (charger_status & 0x8000) >> 15;
 
       end:
 
@@ -945,24 +938,27 @@ static struct proc_dir_entry *acpi_battery_dir = NULL;
 static int acpi_battery_read_info(struct seq_file *seq, void *offset)
 {
 	struct acpi_battery *battery = seq->private;
+	struct acpi_sbs *sbs = battery->sbs;
 	int cscale;
 	int result = 0;
 
-	if (battery->sbs->zombie) {
+	if (sbs_mutex_lock(sbs)) {
 		return -ENODEV;
 	}
 
-	down(&sbs_sem);
+	result = acpi_check_update_proc(sbs);
+	if (result)
+		goto end;
 
-	if (update_mode == REQUEST_UPDATE_MODE) {
-		result = acpi_sbs_update_run(battery->sbs, DATA_TYPE_INFO);
+	if (update_time == 0) {
+		result = acpi_sbs_update_run(sbs, battery->id, DATA_TYPE_INFO);
 		if (result) {
 			ACPI_EXCEPTION((AE_INFO, AE_ERROR,
 					"acpi_sbs_update_run() failed"));
 		}
 	}
 
-	if (acpi_battery_is_present(battery)) {
+	if (battery->battery_present) {
 		seq_printf(seq, "present:                 yes\n");
 	} else {
 		seq_printf(seq, "present:                 no\n");
@@ -974,13 +970,13 @@ static int acpi_battery_read_info(struct seq_file *seq, void *offset)
 	} else {
 		cscale = battery->info.ipscale;
 	}
-	seq_printf(seq, "design capacity:         %i%s",
+	seq_printf(seq, "design capacity:         %i%s\n",
 		   battery->info.design_capacity * cscale,
-		   battery->info.capacity_mode ? "0 mWh\n" : " mAh\n");
+		   battery->info.capacity_mode ? "0 mWh" : " mAh");
 
-	seq_printf(seq, "last full capacity:      %i%s",
+	seq_printf(seq, "last full capacity:      %i%s\n",
 		   battery->info.full_charge_capacity * cscale,
-		   battery->info.capacity_mode ? "0 mWh\n" : " mAh\n");
+		   battery->info.capacity_mode ? "0 mWh" : " mAh");
 
 	seq_printf(seq, "battery technology:      rechargeable\n");
 
@@ -1006,7 +1002,7 @@ static int acpi_battery_read_info(struct seq_file *seq, void *offset)
 
       end:
 
-	up(&sbs_sem);
+	sbs_mutex_unlock(sbs);
 
 	return result;
 }
@@ -1018,26 +1014,29 @@ static int acpi_battery_info_open_fs(struct inode *inode, struct file *file)
 
 static int acpi_battery_read_state(struct seq_file *seq, void *offset)
 {
-	struct acpi_battery *battery = (struct acpi_battery *)seq->private;
+	struct acpi_battery *battery = seq->private;
+	struct acpi_sbs *sbs = battery->sbs;
 	int result = 0;
 	int cscale;
 	int foo;
 
-	if (battery->sbs->zombie) {
+	if (sbs_mutex_lock(sbs)) {
 		return -ENODEV;
 	}
 
-	down(&sbs_sem);
+	result = acpi_check_update_proc(sbs);
+	if (result)
+		goto end;
 
-	if (update_mode == REQUEST_UPDATE_MODE) {
-		result = acpi_sbs_update_run(battery->sbs, DATA_TYPE_STATE);
+	if (update_time == 0) {
+		result = acpi_sbs_update_run(sbs, battery->id, DATA_TYPE_STATE);
 		if (result) {
 			ACPI_EXCEPTION((AE_INFO, AE_ERROR,
 					"acpi_sbs_update_run() failed"));
 		}
 	}
 
-	if (acpi_battery_is_present(battery)) {
+	if (battery->battery_present) {
 		seq_printf(seq, "present:                 yes\n");
 	} else {
 		seq_printf(seq, "present:                 no\n");
@@ -1050,7 +1049,7 @@ static int acpi_battery_read_state(struct seq_file *seq, void *offset)
 		cscale = battery->info.ipscale;
 	}
 
-	if (battery->state.battery_status & 0x0010) {
+	if (battery->state.battery_state & 0x0010) {
 		seq_printf(seq, "capacity state:          critical\n");
 	} else {
 		seq_printf(seq, "capacity state:          ok\n");
@@ -1074,16 +1073,16 @@ static int acpi_battery_read_state(struct seq_file *seq, void *offset)
 			   battery->info.capacity_mode ? "mW" : "mA");
 	}
 
-	seq_printf(seq, "remaining capacity:      %i%s",
+	seq_printf(seq, "remaining capacity:      %i%s\n",
 		   battery->state.remaining_capacity * cscale,
-		   battery->info.capacity_mode ? "0 mWh\n" : " mAh\n");
+		   battery->info.capacity_mode ? "0 mWh" : " mAh");
 
 	seq_printf(seq, "present voltage:         %i mV\n",
 		   battery->state.voltage * battery->info.vscale);
 
       end:
 
-	up(&sbs_sem);
+	sbs_mutex_unlock(sbs);
 
 	return result;
 }
@@ -1096,24 +1095,27 @@ static int acpi_battery_state_open_fs(struct inode *inode, struct file *file)
 static int acpi_battery_read_alarm(struct seq_file *seq, void *offset)
 {
 	struct acpi_battery *battery = seq->private;
+	struct acpi_sbs *sbs = battery->sbs;
 	int result = 0;
 	int cscale;
 
-	if (battery->sbs->zombie) {
+	if (sbs_mutex_lock(sbs)) {
 		return -ENODEV;
 	}
 
-	down(&sbs_sem);
+	result = acpi_check_update_proc(sbs);
+	if (result)
+		goto end;
 
-	if (update_mode == REQUEST_UPDATE_MODE) {
-		result = acpi_sbs_update_run(battery->sbs, DATA_TYPE_ALARM);
+	if (update_time == 0) {
+		result = acpi_sbs_update_run(sbs, battery->id, DATA_TYPE_ALARM);
 		if (result) {
 			ACPI_EXCEPTION((AE_INFO, AE_ERROR,
 					"acpi_sbs_update_run() failed"));
 		}
 	}
 
-	if (!acpi_battery_is_present(battery)) {
+	if (!battery->battery_present) {
 		seq_printf(seq, "present:                 no\n");
 		goto end;
 	}
@@ -1126,16 +1128,16 @@ static int acpi_battery_read_alarm(struct seq_file *seq, void *offset)
 
 	seq_printf(seq, "alarm:                   ");
 	if (battery->alarm.remaining_capacity) {
-		seq_printf(seq, "%i%s",
+		seq_printf(seq, "%i%s\n",
 			   battery->alarm.remaining_capacity * cscale,
-			   battery->info.capacity_mode ? "0 mWh\n" : " mAh\n");
+			   battery->info.capacity_mode ? "0 mWh" : " mAh");
 	} else {
 		seq_printf(seq, "disabled\n");
 	}
 
       end:
 
-	up(&sbs_sem);
+	sbs_mutex_unlock(sbs);
 
 	return result;
 }
@@ -1146,16 +1148,19 @@ acpi_battery_write_alarm(struct file *file, const char __user * buffer,
 {
 	struct seq_file *seq = file->private_data;
 	struct acpi_battery *battery = seq->private;
+	struct acpi_sbs *sbs = battery->sbs;
 	char alarm_string[12] = { '\0' };
 	int result, old_alarm, new_alarm;
 
-	if (battery->sbs->zombie) {
+	if (sbs_mutex_lock(sbs)) {
 		return -ENODEV;
 	}
 
-	down(&sbs_sem);
+	result = acpi_check_update_proc(sbs);
+	if (result)
+		goto end;
 
-	if (!acpi_battery_is_present(battery)) {
+	if (!battery->battery_present) {
 		result = -ENODEV;
 		goto end;
 	}
@@ -1191,7 +1196,7 @@ acpi_battery_write_alarm(struct file *file, const char __user * buffer,
 	}
 
       end:
-	up(&sbs_sem);
+	sbs_mutex_unlock(sbs);
 
 	if (result) {
 		return result;
@@ -1239,14 +1244,12 @@ static int acpi_ac_read_state(struct seq_file *seq, void *offset)
 	struct acpi_sbs *sbs = seq->private;
 	int result;
 
-	if (sbs->zombie) {
+	if (sbs_mutex_lock(sbs)) {
 		return -ENODEV;
 	}
 
-	down(&sbs_sem);
-
-	if (update_mode == REQUEST_UPDATE_MODE) {
-		result = acpi_sbs_update_run(sbs, DATA_TYPE_AC_STATE);
+	if (update_time == 0) {
+		result = acpi_sbs_update_run(sbs, -1, DATA_TYPE_AC_STATE);
 		if (result) {
 			ACPI_EXCEPTION((AE_INFO, AE_ERROR,
 					"acpi_sbs_update_run() failed"));
@@ -1254,9 +1257,9 @@ static int acpi_ac_read_state(struct seq_file *seq, void *offset)
 	}
 
 	seq_printf(seq, "state:                   %s\n",
-		   sbs->ac_present ? "on-line" : "off-line");
+		   sbs->ac.ac_present ? "on-line" : "off-line");
 
-	up(&sbs_sem);
+	sbs_mutex_unlock(sbs);
 
 	return 0;
 }
@@ -1309,7 +1312,7 @@ static int acpi_battery_add(struct acpi_sbs *sbs, int id)
 		goto end;
 	}
 
-	is_present = acpi_battery_is_present(battery);
+	is_present = battery->battery_present;
 
 	if (is_present) {
 		result = acpi_battery_init(battery);
@@ -1336,6 +1339,10 @@ static int acpi_battery_add(struct acpi_sbs *sbs, int id)
 	}
 	battery->alive = 1;
 
+	printk(KERN_INFO PREFIX "%s [%s]: Battery Slot [%s] (battery %s)\n",
+	       ACPI_SBS_DEVICE_NAME, acpi_device_bid(sbs->device), dir_name,
+	       sbs->battery->battery_present ? "present" : "absent");
+
       end:
 	return result;
 }
@@ -1370,6 +1377,10 @@ static int acpi_ac_add(struct acpi_sbs *sbs)
 		goto end;
 	}
 
+	printk(KERN_INFO PREFIX "%s [%s]: AC Adapter [%s] (%s)\n",
+	       ACPI_SBS_DEVICE_NAME, acpi_device_bid(sbs->device),
+	       ACPI_AC_DIR_NAME, sbs->ac.ac_present ? "on-line" : "off-line");
+
       end:
 
 	return result;
@@ -1383,29 +1394,48 @@ static void acpi_ac_remove(struct acpi_sbs *sbs)
 	}
 }
 
-static void acpi_sbs_update_queue_run(unsigned long data)
+static void acpi_sbs_update_time_run(unsigned long data)
 {
-	acpi_os_execute(OSL_GPE_HANDLER, acpi_sbs_update_queue, (void *)data);
+	acpi_os_execute(OSL_GPE_HANDLER, acpi_sbs_update_time, (void *)data);
 }
 
-static int acpi_sbs_update_run(struct acpi_sbs *sbs, int data_type)
+static int acpi_sbs_update_run(struct acpi_sbs *sbs, int id, int data_type)
 {
 	struct acpi_battery *battery;
-	int result = 0;
-	int old_ac_present;
-	int old_battery_present;
-	int new_ac_present;
-	int new_battery_present;
-	int id;
+	int result = 0, cnt;
+	int old_ac_present = -1;
+	int old_battery_present = -1;
+	int new_ac_present = -1;
+	int new_battery_present = -1;
+	int id_min = 0, id_max = MAX_SBS_BAT - 1;
 	char dir_name[32];
-	int do_battery_init, do_ac_init;
-	s16 old_remaining_capacity;
+	int do_battery_init = 0, do_ac_init = 0;
+	int old_remaining_capacity = 0;
+	int update_ac = 1, update_battery = 1;
+	int up_tm = update_time;
+
+	if (sbs_zombie(sbs)) {
+		goto end;
+	}
 
-	if (sbs->zombie) {
+	if (id >= 0) {
+		id_min = id_max = id;
+	}
+
+	if (data_type == DATA_TYPE_COMMON && up_tm > 0) {
+		cnt = up_tm / (up_tm > UPDATE_DELAY ? UPDATE_DELAY : up_tm);
+		if (sbs->run_cnt % cnt != 0) {
+			update_battery = 0;
+		}
+	}
+
+	sbs->run_cnt++;
+
+	if (!update_ac && !update_battery) {
 		goto end;
 	}
 
-	old_ac_present = acpi_ac_is_present(sbs);
+	old_ac_present = sbs->ac.ac_present;
 
 	result = acpi_ac_get_present(sbs);
 	if (result) {
@@ -1413,15 +1443,36 @@ static int acpi_sbs_update_run(struct acpi_sbs *sbs, int data_type)
 				"acpi_ac_get_present() failed"));
 	}
 
-	new_ac_present = acpi_ac_is_present(sbs);
+	new_ac_present = sbs->ac.ac_present;
 
 	do_ac_init = (old_ac_present != new_ac_present);
+	if (sbs->run_cnt == 1 && data_type == DATA_TYPE_COMMON) {
+		do_ac_init = 1;
+	}
 
-	if (data_type == DATA_TYPE_AC_STATE) {
+	if (do_ac_init) {
+		result = acpi_sbs_generate_event(sbs->device,
+						 ACPI_SBS_AC_NOTIFY_STATUS,
+						 new_ac_present,
+						 ACPI_AC_DIR_NAME,
+						 ACPI_AC_CLASS);
+		if (result) {
+			ACPI_EXCEPTION((AE_INFO, AE_ERROR,
+					"acpi_sbs_generate_event() failed"));
+		}
+	}
+
+	if (data_type == DATA_TYPE_COMMON) {
+		if (!do_ac_init && !update_battery) {
+			goto end;
+		}
+	}
+
+	if (data_type == DATA_TYPE_AC_STATE && !do_ac_init) {
 		goto end;
 	}
 
-	for (id = 0; id < MAX_SBS_BAT; id++) {
+	for (id = id_min; id <= id_max; id++) {
 		battery = &sbs->battery[id];
 		if (battery->alive == 0) {
 			continue;
@@ -1429,41 +1480,27 @@ static int acpi_sbs_update_run(struct acpi_sbs *sbs, int data_type)
 
 		old_remaining_capacity = battery->state.remaining_capacity;
 
-		old_battery_present = acpi_battery_is_present(battery);
+		old_battery_present = battery->battery_present;
 
 		result = acpi_battery_select(battery);
 		if (result) {
 			ACPI_EXCEPTION((AE_INFO, AE_ERROR,
 					"acpi_battery_select() failed"));
 		}
-		if (sbs->zombie) {
-			goto end;
-		}
 
 		result = acpi_battery_get_present(battery);
 		if (result) {
 			ACPI_EXCEPTION((AE_INFO, AE_ERROR,
 					"acpi_battery_get_present() failed"));
 		}
-		if (sbs->zombie) {
-			goto end;
-		}
 
-		new_battery_present = acpi_battery_is_present(battery);
+		new_battery_present = battery->battery_present;
 
 		do_battery_init = ((old_battery_present != new_battery_present)
 				   && new_battery_present);
-
-		if (sbs->zombie) {
-			goto end;
-		}
-		if (do_ac_init || do_battery_init ||
-		    update_info_mode || sbs->update_info_mode) {
-			if (sbs->update_info_mode) {
-				sbs->update_info_mode = 0;
-			} else {
-				sbs->update_info_mode = 1;
-			}
+		if (!new_battery_present)
+			goto event;
+		if (do_ac_init || do_battery_init) {
 			result = acpi_battery_init(battery);
 			if (result) {
 				ACPI_EXCEPTION((AE_INFO, AE_ERROR,
@@ -1471,52 +1508,64 @@ static int acpi_sbs_update_run(struct acpi_sbs *sbs, int data_type)
 						"failed"));
 			}
 		}
-		if (data_type == DATA_TYPE_INFO) {
-			continue;
-		}
-
-		if (sbs->zombie) {
+		if (sbs_zombie(sbs)) {
 			goto end;
 		}
-		if (new_battery_present) {
-			result = acpi_battery_get_alarm(battery);
+
+		if ((data_type == DATA_TYPE_COMMON
+		     || data_type == DATA_TYPE_INFO)
+		    && new_battery_present) {
+			result = acpi_battery_get_info(battery);
 			if (result) {
 				ACPI_EXCEPTION((AE_INFO, AE_ERROR,
-						"acpi_battery_get_alarm() "
-						"failed"));
-			}
-			if (data_type == DATA_TYPE_ALARM) {
-				continue;
+						"acpi_battery_get_info() failed"));
 			}
+		}
+		if (data_type == DATA_TYPE_INFO) {
+			continue;
+		}
+		if (sbs_zombie(sbs)) {
+			goto end;
+		}
 
+		if ((data_type == DATA_TYPE_COMMON
+		     || data_type == DATA_TYPE_STATE)
+		    && new_battery_present) {
 			result = acpi_battery_get_state(battery);
 			if (result) {
 				ACPI_EXCEPTION((AE_INFO, AE_ERROR,
-						"acpi_battery_get_state() "
-						"failed"));
+						"acpi_battery_get_state() failed"));
 			}
 		}
-		if (sbs->zombie) {
-			goto end;
+		if (data_type == DATA_TYPE_STATE) {
+			goto event;
 		}
-		if (data_type != DATA_TYPE_COMMON) {
-			continue;
+		if (sbs_zombie(sbs)) {
+			goto end;
 		}
 
-		if (old_battery_present != new_battery_present) {
-			sprintf(dir_name, ACPI_BATTERY_DIR_NAME, id);
-			result = acpi_sbs_generate_event(sbs->device,
-							 ACPI_SBS_BATTERY_NOTIFY_STATUS,
-							 new_battery_present,
-							 dir_name,
-							 ACPI_BATTERY_CLASS);
+		if ((data_type == DATA_TYPE_COMMON
+		     || data_type == DATA_TYPE_ALARM)
+		    && new_battery_present) {
+			result = acpi_battery_get_alarm(battery);
 			if (result) {
 				ACPI_EXCEPTION((AE_INFO, AE_ERROR,
-						"acpi_sbs_generate_event() "
+						"acpi_battery_get_alarm() "
 						"failed"));
 			}
 		}
-		if (old_remaining_capacity != battery->state.remaining_capacity) {
+		if (data_type == DATA_TYPE_ALARM) {
+			continue;
+		}
+		if (sbs_zombie(sbs)) {
+			goto end;
+		}
+
+	      event:
+
+		if (old_battery_present != new_battery_present || do_ac_init ||
+		    old_remaining_capacity !=
+		    battery->state.remaining_capacity) {
 			sprintf(dir_name, ACPI_BATTERY_DIR_NAME, id);
 			result = acpi_sbs_generate_event(sbs->device,
 							 ACPI_SBS_BATTERY_NOTIFY_STATUS,
@@ -1525,71 +1574,62 @@ static int acpi_sbs_update_run(struct acpi_sbs *sbs, int data_type)
 							 ACPI_BATTERY_CLASS);
 			if (result) {
 				ACPI_EXCEPTION((AE_INFO, AE_ERROR,
-						"acpi_sbs_generate_event() failed"));
+						"acpi_sbs_generate_event() "
+						"failed"));
 			}
 		}
-
-	}
-	if (sbs->zombie) {
-		goto end;
-	}
-	if (data_type != DATA_TYPE_COMMON) {
-		goto end;
-	}
-
-	if (old_ac_present != new_ac_present) {
-		result = acpi_sbs_generate_event(sbs->device,
-						 ACPI_SBS_AC_NOTIFY_STATUS,
-						 new_ac_present,
-						 ACPI_AC_DIR_NAME,
-						 ACPI_AC_CLASS);
-		if (result) {
-			ACPI_EXCEPTION((AE_INFO, AE_ERROR,
-					"acpi_sbs_generate_event() failed"));
-		}
 	}
 
       end:
+
 	return result;
 }
 
-static void acpi_sbs_update_queue(void *data)
+static void acpi_sbs_update_time(void *data)
 {
 	struct acpi_sbs *sbs = data;
 	unsigned long delay = -1;
 	int result;
+	unsigned int up_tm = update_time;
 
-	if (sbs->zombie) {
-		goto end;
-	}
+	if (sbs_mutex_lock(sbs))
+		return;
 
-	result = acpi_sbs_update_run(sbs, DATA_TYPE_COMMON);
+	result = acpi_sbs_update_run(sbs, -1, DATA_TYPE_COMMON);
 	if (result) {
 		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
 				"acpi_sbs_update_run() failed"));
 	}
 
-	if (sbs->zombie) {
+	if (sbs_zombie(sbs)) {
 		goto end;
 	}
 
-	if (update_mode == REQUEST_UPDATE_MODE) {
-		goto end;
+	if (!up_tm) {
+		if (timer_pending(&sbs->update_timer))
+			del_timer(&sbs->update_timer);
+	} else {
+		delay = (up_tm > UPDATE_DELAY ? UPDATE_DELAY : up_tm);
+		delay = jiffies + HZ * delay;
+		if (timer_pending(&sbs->update_timer)) {
+			mod_timer(&sbs->update_timer, delay);
+		} else {
+			sbs->update_timer.data = (unsigned long)data;
+			sbs->update_timer.function = acpi_sbs_update_time_run;
+			sbs->update_timer.expires = delay;
+			add_timer(&sbs->update_timer);
+		}
 	}
 
-	delay = jiffies + HZ * update_time;
-	sbs->update_timer.data = (unsigned long)data;
-	sbs->update_timer.function = acpi_sbs_update_queue_run;
-	sbs->update_timer.expires = delay;
-	add_timer(&sbs->update_timer);
       end:
-	;
+
+	sbs_mutex_unlock(sbs);
 }
 
 static int acpi_sbs_add(struct acpi_device *device)
 {
 	struct acpi_sbs *sbs = NULL;
-	int result;
+	int result = 0, remove_result = 0;
 	unsigned long sbs_obj;
 	int id;
 	acpi_status status = AE_OK;
@@ -1604,33 +1644,34 @@ static int acpi_sbs_add(struct acpi_device *device)
 
 	sbs = kzalloc(sizeof(struct acpi_sbs), GFP_KERNEL);
 	if (!sbs) {
-		ACPI_EXCEPTION((AE_INFO, AE_ERROR, "kmalloc() failed"));
-		return -ENOMEM;
+		ACPI_EXCEPTION((AE_INFO, AE_ERROR, "kzalloc() failed"));
+		result = -ENOMEM;
+		goto end;
 	}
-	sbs->base = (val & 0xff00ull) >> 8;
 
+	mutex_init(&sbs->mutex);
+
+	sbs_mutex_lock(sbs);
+
+	sbs->base = (val & 0xff00ull) >> 8;
 	sbs->device = device;
 
 	strcpy(acpi_device_name(device), ACPI_SBS_DEVICE_NAME);
 	strcpy(acpi_device_class(device), ACPI_SBS_CLASS);
 	acpi_driver_data(device) = sbs;
 
-	sbs->update_time = 0;
-	sbs->update_time2 = 0;
-
 	result = acpi_ac_add(sbs);
 	if (result) {
 		ACPI_EXCEPTION((AE_INFO, AE_ERROR, "acpi_ac_add() failed"));
 		goto end;
 	}
-	result = acpi_evaluate_integer(device->handle, "_SBS", NULL, &sbs_obj);
-	if (ACPI_FAILURE(result)) {
-		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
+	status = acpi_evaluate_integer(device->handle, "_SBS", NULL, &sbs_obj);
+	if (status) {
+		ACPI_EXCEPTION((AE_INFO, status,
 				"acpi_evaluate_integer() failed"));
 		result = -EIO;
 		goto end;
 	}
-
 	if (sbs_obj > 0) {
 		result = acpi_sbsm_get_info(sbs);
 		if (result) {
@@ -1640,6 +1681,7 @@ static int acpi_sbs_add(struct acpi_device *device)
 		}
 		sbs->sbsm_present = 1;
 	}
+
 	if (sbs->sbsm_present == 0) {
 		result = acpi_battery_add(sbs, 0);
 		if (result) {
@@ -1653,8 +1695,7 @@ static int acpi_sbs_add(struct acpi_device *device)
 				result = acpi_battery_add(sbs, id);
 				if (result) {
 					ACPI_EXCEPTION((AE_INFO, AE_ERROR,
-							"acpi_battery_add() "
-							"failed"));
+							"acpi_battery_add() failed"));
 					goto end;
 				}
 			}
@@ -1664,29 +1705,26 @@ static int acpi_sbs_add(struct acpi_device *device)
 	sbs->handle = device->handle;
 
 	init_timer(&sbs->update_timer);
-	if (update_mode == QUEUE_UPDATE_MODE) {
-		status = acpi_os_execute(OSL_GPE_HANDLER,
-					 acpi_sbs_update_queue, sbs);
-		if (status != AE_OK) {
-			ACPI_EXCEPTION((AE_INFO, AE_ERROR,
-					"acpi_os_execute() failed"));
-		}
-	}
-	sbs->update_time = update_time;
-	sbs->update_time2 = update_time2;
-
-	printk(KERN_INFO PREFIX "%s [%s]\n",
-	       acpi_device_name(device), acpi_device_bid(device));
+	result = acpi_check_update_proc(sbs);
+	if (result)
+		goto end;
 
       end:
+
+	sbs_mutex_unlock(sbs);
+
 	if (result) {
-		acpi_sbs_remove(device, 0);
+		remove_result = acpi_sbs_remove(device, 0);
+		if (remove_result) {
+			ACPI_EXCEPTION((AE_INFO, AE_ERROR,
+					"acpi_sbs_remove() failed"));
+		}
 	}
 
 	return result;
 }
 
-int acpi_sbs_remove(struct acpi_device *device, int type)
+static int acpi_sbs_remove(struct acpi_device *device, int type)
 {
 	struct acpi_sbs *sbs;
 	int id;
@@ -1695,15 +1733,14 @@ int acpi_sbs_remove(struct acpi_device *device, int type)
 		return -EINVAL;
 	}
 
-	sbs = (struct acpi_sbs *)acpi_driver_data(device);
-
+	sbs = acpi_driver_data(device);
 	if (!sbs) {
 		return -EINVAL;
 	}
 
+	sbs_mutex_lock(sbs);
+
 	sbs->zombie = 1;
-	sbs->update_time = 0;
-	sbs->update_time2 = 0;
 	del_timer_sync(&sbs->update_timer);
 	acpi_os_wait_events_complete(NULL);
 	del_timer_sync(&sbs->update_timer);
@@ -1714,13 +1751,41 @@ int acpi_sbs_remove(struct acpi_device *device, int type)
 
 	acpi_ac_remove(sbs);
 
-	acpi_driver_data(device) = NULL;
+	sbs_mutex_unlock(sbs);
+
+	mutex_destroy(&sbs->mutex);
 
 	kfree(sbs);
 
 	return 0;
 }
 
+static void acpi_sbs_rmdirs(void)
+{
+	if (acpi_ac_dir) {
+		acpi_unlock_ac_dir(acpi_ac_dir);
+		acpi_ac_dir = NULL;
+	}
+	if (acpi_battery_dir) {
+		acpi_unlock_battery_dir(acpi_battery_dir);
+		acpi_battery_dir = NULL;
+	}
+}
+
+static int acpi_sbs_resume(struct acpi_device *device)
+{
+	struct acpi_sbs *sbs;
+
+	if (!device)
+		return -EINVAL;
+
+	sbs = device->driver_data;
+
+	sbs->run_cnt = 0;
+
+	return 0;
+}
+
 static int __init acpi_sbs_init(void)
 {
 	int result = 0;
@@ -1728,12 +1793,10 @@ static int __init acpi_sbs_init(void)
 	if (acpi_disabled)
 		return -ENODEV;
 
-	init_MUTEX(&sbs_sem);
-
 	if (capacity_mode != DEF_CAPACITY_UNIT
 	    && capacity_mode != MAH_CAPACITY_UNIT
 	    && capacity_mode != MWH_CAPACITY_UNIT) {
-		ACPI_EXCEPTION((AE_INFO, AE_ERROR, "acpi_sbs_init: "
+		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
 				"invalid capacity_mode = %d", capacity_mode));
 		return -EINVAL;
 	}
@@ -1749,6 +1812,7 @@ static int __init acpi_sbs_init(void)
 	if (!acpi_battery_dir) {
 		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
 				"acpi_lock_battery_dir() failed"));
+		acpi_sbs_rmdirs();
 		return -ENODEV;
 	}
 
@@ -1756,6 +1820,7 @@ static int __init acpi_sbs_init(void)
 	if (result < 0) {
 		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
 				"acpi_bus_register_driver() failed"));
+		acpi_sbs_rmdirs();
 		return -ENODEV;
 	}
 
@@ -1764,13 +1829,9 @@ static int __init acpi_sbs_init(void)
 
 static void __exit acpi_sbs_exit(void)
 {
-
 	acpi_bus_unregister_driver(&acpi_sbs_driver);
 
-	acpi_unlock_ac_dir(acpi_ac_dir);
-	acpi_ac_dir = NULL;
-	acpi_unlock_battery_dir(acpi_battery_dir);
-	acpi_battery_dir = NULL;
+	acpi_sbs_rmdirs();
 
 	return;
 }
-- 
1.5.2.rc0.34.gda94
