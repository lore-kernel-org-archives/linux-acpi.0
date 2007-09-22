From: Len Brown <lenb@kernel.org>
Subject: [PATCH 11/32] ACPI: SBS: Simplify data structures in SBS
Date: Fri, 21 Sep 2007 23:46:17 -0400
Message-ID: <1190432807843-git-send-email-lenb@kernel.org>
References: <11904327981905-git-send-email-lenb@kernel.org>
 <11904327991059-git-send-email-lenb@kernel.org>
 <11904328003655-git-send-email-lenb@kernel.org>
 <11904328012791-git-send-email-lenb@kernel.org>
 <11904328011699-git-send-email-lenb@kernel.org>
 <1190432802575-git-send-email-lenb@kernel.org>
 <11904328031107-git-send-email-lenb@kernel.org>
 <11904328041498-git-send-email-lenb@kernel.org>
 <11904328052010-git-send-email-lenb@kernel.org>
 <11904328061489-git-send-email-lenb@kernel.org>
 <119043280633-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:45227 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756708AbXIVDqu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Sep 2007 23:46:50 -0400
In-Reply-To: <119043280633-git-send-email-lenb@kernel.org>
Message-Id: <86b80c709d723d55844097e589f2e58d39857d21.1190432418.git.len.brown@intel.com>
In-Reply-To: <fd1caaed466de2ee100e250b6c755376eda7ba3b.1190432417.git.len.brown@intel.com>
References: <fd1caaed466de2ee100e250b6c755376eda7ba3b.1190432417.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Alexey Starikovskiy <astarikovskiy@suse.de>

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/sbs.c |  282 +++++++++++++++++++++++++---------------------------
 1 files changed, 135 insertions(+), 147 deletions(-)

diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
index 7bb8c62..f35fe63 100644
--- a/drivers/acpi/sbs.c
+++ b/drivers/acpi/sbs.c
@@ -88,10 +88,10 @@ extern void acpi_unlock_battery_dir(struct proc_dir_entry *acpi_battery_dir);
 /* 0 - every time, > 0 - by update_time */
 static unsigned int update_time = 120;
 
-static unsigned int capacity_mode = CAPACITY_UNIT;
+static unsigned int mode = CAPACITY_UNIT;
 
 module_param(update_time, uint, 0644);
-module_param(capacity_mode, uint, 0444);
+module_param(mode, uint, 0444);
 
 static int acpi_sbs_add(struct acpi_device *device);
 static int acpi_sbs_remove(struct acpi_device *device, int type);
@@ -114,59 +114,43 @@ static struct acpi_driver acpi_sbs_driver = {
 		},
 };
 
-struct acpi_ac {
-	int ac_present;
-};
-
-struct acpi_battery_info {
-	int capacity_mode;
-	s16 full_charge_capacity;
-	s16 design_capacity;
-	s16 design_voltage;
-	int vscale;
-	int ipscale;
-	s16 serial_number;
-	char manufacturer_name[ACPI_SBS_BLOCK_MAX + 3];
-	char device_name[ACPI_SBS_BLOCK_MAX + 3];
-	char device_chemistry[ACPI_SBS_BLOCK_MAX + 3];
-};
-
-struct acpi_battery_state {
-	s16 voltage;
-	s16 amperage;
-	s16 remaining_capacity;
-	s16 battery_state;
-};
-
-struct acpi_battery_alarm {
-	s16 remaining_capacity;
-};
-
 struct acpi_battery {
-	int alive;
-	int id;
-	int init_state;
-	int battery_present;
 	struct acpi_sbs *sbs;
-	struct acpi_battery_info info;
-	struct acpi_battery_state state;
-	struct acpi_battery_alarm alarm;
-	struct proc_dir_entry *battery_entry;
+	struct proc_dir_entry *proc_entry;
+	int vscale;
+	int ipscale;
+	char manufacturer_name[ACPI_SBS_BLOCK_MAX];
+	char device_name[ACPI_SBS_BLOCK_MAX];
+	char device_chemistry[ACPI_SBS_BLOCK_MAX];
+	u16 full_charge_capacity;
+	u16 design_capacity;
+	u16 design_voltage;
+	u16 serial_number;
+	u16 voltage_now;
+	s16 current_now;
+	u16 capacity_now;
+	u16 state;
+	u16 alarm_capacity;
+	u16 mode;
+	u8 id;
+	u8 alive:1;
+	u8 init_state:1;
+	u8 present:1;
 };
 
 struct acpi_sbs {
 	struct acpi_device *device;
 	struct acpi_smb_hc *hc;
 	struct mutex mutex;
-	int sbsm_present;
-	int sbsm_batteries_supported;
 	struct proc_dir_entry *ac_entry;
-	struct acpi_ac ac;
 	struct acpi_battery battery[MAX_SBS_BAT];
 	int zombie;
 	struct timer_list update_timer;
 	int run_cnt;
 	int update_proc_flg;
+	u8 batteries_supported;
+	u8 manager_present:1;
+	u8 charger_present:1;
 };
 
 static int acpi_sbs_update_run(struct acpi_sbs *sbs, int id, int data_type);
@@ -231,7 +215,7 @@ static int acpi_battery_get_present(struct acpi_battery *battery)
 	if (!result) {
 		is_present = (state & 0x000f) & (1 << battery->id);
 	}
-	battery->battery_present = is_present;
+	battery->present = is_present;
 
 	return result;
 }
@@ -243,14 +227,14 @@ static int acpi_battery_select(struct acpi_battery *battery)
 	s16 state;
 	int foo;
 
-	if (sbs->sbsm_present) {
+	if (sbs->manager_present) {
 
 		/* Take special care not to knobble other nibbles of
 		 * state (aka selector_state), since
 		 * it causes charging to halt on SBSELs */
 
-		result =
-		    acpi_smbus_read(battery->sbs->hc, SMBUS_READ_WORD, ACPI_SBSM_SMBUS_ADDR, 0x01, (u8 *)&state);
+		result = acpi_smbus_read(battery->sbs->hc, SMBUS_READ_WORD,
+					 ACPI_SBSM_SMBUS_ADDR, 0x01, (u8 *)&state);
 		if (result) {
 			ACPI_EXCEPTION((AE_INFO, AE_ERROR,
 					"acpi_smbus_read() failed"));
@@ -258,8 +242,8 @@ static int acpi_battery_select(struct acpi_battery *battery)
 		}
 
 		foo = (state & 0x0fff) | (1 << (battery->id + 12));
-		result =
-		    acpi_smbus_write(battery->sbs->hc, SMBUS_WRITE_WORD, ACPI_SBSM_SMBUS_ADDR, 0x01, (u8 *)&foo, 2);
+		result = acpi_smbus_write(battery->sbs->hc, SMBUS_WRITE_WORD,
+					  ACPI_SBSM_SMBUS_ADDR, 0x01, (u8 *)&foo, 2);
 		if (result) {
 			ACPI_EXCEPTION((AE_INFO, AE_ERROR,
 					"acpi_smbus_write() failed"));
@@ -283,8 +267,7 @@ static int acpi_sbsm_get_info(struct acpi_sbs *sbs)
 				"acpi_smbus_read() failed"));
 		goto end;
 	}
-	sbs->sbsm_present = 1;
-	sbs->sbsm_batteries_supported = battery_system_info & 0x000f;
+	sbs->manager_present = 1;
 
       end:
 
@@ -304,10 +287,10 @@ static int acpi_battery_get_info(struct acpi_battery *battery)
 				"acpi_smbus_read() failed"));
 		goto end;
 	}
-	battery->info.capacity_mode = (battery_mode & 0x8000) >> 15;
+	battery->mode = (battery_mode & 0x8000) >> 15;
 
 	result = acpi_smbus_read(battery->sbs->hc, SMBUS_READ_WORD, ACPI_SB_SMBUS_ADDR, 0x10,
-				    (u8 *)&battery->info.full_charge_capacity);
+				    (u8 *)&battery->full_charge_capacity);
 	if (result) {
 		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
 				"acpi_smbus_read() failed"));
@@ -315,7 +298,7 @@ static int acpi_battery_get_info(struct acpi_battery *battery)
 	}
 
 	result = acpi_smbus_read(battery->sbs->hc, SMBUS_READ_WORD, ACPI_SB_SMBUS_ADDR, 0x18,
-				    (u8 *)&battery->info.design_capacity);
+				    (u8 *)&battery->design_capacity);
 
 	if (result) {
 		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
@@ -324,7 +307,7 @@ static int acpi_battery_get_info(struct acpi_battery *battery)
 	}
 
 	result = acpi_smbus_read(battery->sbs->hc, SMBUS_READ_WORD, ACPI_SB_SMBUS_ADDR, 0x19,
-				    (u8 *)&battery->info.design_voltage);
+				    (u8 *)&battery->design_voltage);
 	if (result) {
 		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
 				"acpi_smbus_read() failed"));
@@ -341,34 +324,34 @@ static int acpi_battery_get_info(struct acpi_battery *battery)
 
 	switch ((specification_info & 0x0f00) >> 8) {
 	case 1:
-		battery->info.vscale = 10;
+		battery->vscale = 10;
 		break;
 	case 2:
-		battery->info.vscale = 100;
+		battery->vscale = 100;
 		break;
 	case 3:
-		battery->info.vscale = 1000;
+		battery->vscale = 1000;
 		break;
 	default:
-		battery->info.vscale = 1;
+		battery->vscale = 1;
 	}
 
 	switch ((specification_info & 0xf000) >> 12) {
 	case 1:
-		battery->info.ipscale = 10;
+		battery->ipscale = 10;
 		break;
 	case 2:
-		battery->info.ipscale = 100;
+		battery->ipscale = 100;
 		break;
 	case 3:
-		battery->info.ipscale = 1000;
+		battery->ipscale = 1000;
 		break;
 	default:
-		battery->info.ipscale = 1;
+		battery->ipscale = 1;
 	}
 
 	result = acpi_smbus_read(battery->sbs->hc, SMBUS_READ_WORD, ACPI_SB_SMBUS_ADDR, 0x1c,
-				    (u8 *)&battery->info.serial_number);
+				    (u8 *)&battery->serial_number);
 	if (result) {
 		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
 				"acpi_smbus_read() failed"));
@@ -376,7 +359,7 @@ static int acpi_battery_get_info(struct acpi_battery *battery)
 	}
 
 	result = acpi_smbus_read(battery->sbs->hc, SMBUS_READ_BLOCK, ACPI_SB_SMBUS_ADDR, 0x20,
-				   (u8 *)battery->info.manufacturer_name);
+				   (u8 *)battery->manufacturer_name);
 	if (result) {
 		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
 				"acpi_sbs_read_str() failed"));
@@ -384,7 +367,7 @@ static int acpi_battery_get_info(struct acpi_battery *battery)
 	}
 
 	result = acpi_smbus_read(battery->sbs->hc, SMBUS_READ_BLOCK, ACPI_SB_SMBUS_ADDR, 0x21,
-				   (u8 *)battery->info.device_name);
+				   (u8 *)battery->device_name);
 	if (result) {
 		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
 				"acpi_sbs_read_str() failed"));
@@ -392,7 +375,7 @@ static int acpi_battery_get_info(struct acpi_battery *battery)
 	}
 
 	result = acpi_smbus_read(battery->sbs->hc, SMBUS_READ_BLOCK, ACPI_SB_SMBUS_ADDR, 0x22,
-				   (u8 *)battery->info.device_chemistry);
+				   (u8 *)battery->device_chemistry);
 	if (result) {
 		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
 				"acpi_sbs_read_str() failed"));
@@ -408,7 +391,7 @@ static int acpi_battery_get_state(struct acpi_battery *battery)
 	int result = 0;
 
 	result = acpi_smbus_read(battery->sbs->hc, SMBUS_READ_WORD, ACPI_SB_SMBUS_ADDR, 0x09,
-				    (u8 *)&battery->state.voltage);
+				    (u8 *)&battery->voltage_now);
 	if (result) {
 		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
 				"acpi_smbus_read() failed"));
@@ -416,7 +399,7 @@ static int acpi_battery_get_state(struct acpi_battery *battery)
 	}
 
 	result = acpi_smbus_read(battery->sbs->hc, SMBUS_READ_WORD, ACPI_SB_SMBUS_ADDR, 0x0a,
-				    (u8 *)&battery->state.amperage);
+				    (u8 *)&battery->current_now);
 	if (result) {
 		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
 				"acpi_smbus_read() failed"));
@@ -424,7 +407,7 @@ static int acpi_battery_get_state(struct acpi_battery *battery)
 	}
 
 	result = acpi_smbus_read(battery->sbs->hc, SMBUS_READ_WORD, ACPI_SB_SMBUS_ADDR, 0x0f,
-				    (u8 *)&battery->state.remaining_capacity);
+				    (u8 *)&battery->capacity_now);
 	if (result) {
 		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
 				"acpi_smbus_read() failed"));
@@ -432,7 +415,7 @@ static int acpi_battery_get_state(struct acpi_battery *battery)
 	}
 
 	result = acpi_smbus_read(battery->sbs->hc, SMBUS_READ_WORD, ACPI_SB_SMBUS_ADDR, 0x16,
-				    (u8 *)&battery->state.battery_state);
+				    (u8 *)&battery->state);
 	if (result) {
 		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
 				"acpi_smbus_read() failed"));
@@ -448,7 +431,7 @@ static int acpi_battery_get_alarm(struct acpi_battery *battery)
 	int result = 0;
 
 	result = acpi_smbus_read(battery->sbs->hc, SMBUS_READ_WORD, ACPI_SB_SMBUS_ADDR, 0x01,
-				    (u8 *)&battery->alarm.remaining_capacity);
+				    (u8 *)&battery->alarm_capacity);
 	if (result) {
 		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
 				"acpi_smbus_read() failed"));
@@ -497,8 +480,9 @@ static int acpi_battery_set_alarm(struct acpi_battery *battery,
 		}
 	}
 
-	foo = alarm / (battery->info.capacity_mode ? 10 : 1);
-	result = acpi_smbus_write(battery->sbs->hc, SMBUS_READ_WORD, ACPI_SB_SMBUS_ADDR, 0x01, (u8 *)&foo, 2);
+	foo = alarm / (battery->mode ? 10 : 1);
+	result = acpi_smbus_write(battery->sbs->hc, SMBUS_READ_WORD, ACPI_SB_SMBUS_ADDR, 0x01,
+				  (u8 *)&foo, 2);
 	if (result) {
 		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
 				"acpi_smbus_write() failed"));
@@ -515,25 +499,25 @@ static int acpi_battery_set_mode(struct acpi_battery *battery)
 	int result = 0;
 	s16 battery_mode;
 
-	if (capacity_mode == DEF_CAPACITY_UNIT) {
+	if (mode == DEF_CAPACITY_UNIT) {
 		goto end;
 	}
 
 	result = acpi_smbus_read(battery->sbs->hc, SMBUS_READ_WORD,
-				    ACPI_SB_SMBUS_ADDR, 0x03, (u8 *)&battery_mode);
+				 ACPI_SB_SMBUS_ADDR, 0x03, (u8 *)&battery_mode);
 	if (result) {
 		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
 				"acpi_smbus_read() failed"));
 		goto end;
 	}
 
-	if (capacity_mode == MAH_CAPACITY_UNIT) {
+	if (mode == MAH_CAPACITY_UNIT) {
 		battery_mode &= 0x7fff;
 	} else {
 		battery_mode |= 0x8000;
 	}
 	result = acpi_smbus_write(battery->sbs->hc, SMBUS_READ_WORD,
-				     ACPI_SB_SMBUS_ADDR, 0x03, (u8 *)&battery_mode, 2);
+				  ACPI_SB_SMBUS_ADDR, 0x03, (u8 *)&battery_mode, 2);
 	if (result) {
 		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
 				"acpi_smbus_write() failed"));
@@ -541,7 +525,7 @@ static int acpi_battery_set_mode(struct acpi_battery *battery)
 	}
 
 	result = acpi_smbus_read(battery->sbs->hc, SMBUS_READ_WORD,
-				    ACPI_SB_SMBUS_ADDR, 0x03, (u8 *)&battery_mode);
+				 ACPI_SB_SMBUS_ADDR, 0x03, (u8 *)&battery_mode);
 	if (result) {
 		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
 				"acpi_smbus_read() failed"));
@@ -601,7 +585,7 @@ static int acpi_ac_get_present(struct acpi_sbs *sbs)
 	s16 charger_status;
 
 	result = acpi_smbus_read(sbs->hc, SMBUS_READ_WORD, ACPI_SBC_SMBUS_ADDR, 0x13,
-				    (u8 *)&charger_status);
+				 (u8 *)&charger_status);
 
 	if (result) {
 		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
@@ -609,7 +593,7 @@ static int acpi_ac_get_present(struct acpi_sbs *sbs)
 		goto end;
 	}
 
-	sbs->ac.ac_present = (charger_status & 0x8000) >> 15;
+	sbs->charger_present = (charger_status & 0x8000) >> 15;
 
       end:
 
@@ -726,30 +710,30 @@ static int acpi_battery_read_info(struct seq_file *seq, void *offset)
 		}
 	}
 
-	if (battery->battery_present) {
+	if (battery->present) {
 		seq_printf(seq, "present:                 yes\n");
 	} else {
 		seq_printf(seq, "present:                 no\n");
 		goto end;
 	}
 
-	if (battery->info.capacity_mode) {
-		cscale = battery->info.vscale * battery->info.ipscale;
+	if (battery->mode) {
+		cscale = battery->vscale * battery->ipscale;
 	} else {
-		cscale = battery->info.ipscale;
+		cscale = battery->ipscale;
 	}
 	seq_printf(seq, "design capacity:         %i%s\n",
-		   battery->info.design_capacity * cscale,
-		   battery->info.capacity_mode ? "0 mWh" : " mAh");
+		   battery->design_capacity * cscale,
+		   battery->mode ? "0 mWh" : " mAh");
 
 	seq_printf(seq, "last full capacity:      %i%s\n",
-		   battery->info.full_charge_capacity * cscale,
-		   battery->info.capacity_mode ? "0 mWh" : " mAh");
+		   battery->full_charge_capacity * cscale,
+		   battery->mode ? "0 mWh" : " mAh");
 
 	seq_printf(seq, "battery technology:      rechargeable\n");
 
 	seq_printf(seq, "design voltage:          %i mV\n",
-		   battery->info.design_voltage * battery->info.vscale);
+		   battery->design_voltage * battery->vscale);
 
 	seq_printf(seq, "design capacity warning: unknown\n");
 	seq_printf(seq, "design capacity low:     unknown\n");
@@ -757,16 +741,16 @@ static int acpi_battery_read_info(struct seq_file *seq, void *offset)
 	seq_printf(seq, "capacity granularity 2:  unknown\n");
 
 	seq_printf(seq, "model number:            %s\n",
-		   battery->info.device_name);
+		   battery->device_name);
 
 	seq_printf(seq, "serial number:           %i\n",
-		   battery->info.serial_number);
+		   battery->serial_number);
 
 	seq_printf(seq, "battery type:            %s\n",
-		   battery->info.device_chemistry);
+		   battery->device_chemistry);
 
 	seq_printf(seq, "OEM info:                %s\n",
-		   battery->info.manufacturer_name);
+		   battery->manufacturer_name);
 
       end:
 
@@ -804,49 +788,49 @@ static int acpi_battery_read_state(struct seq_file *seq, void *offset)
 		}
 	}
 
-	if (battery->battery_present) {
+	if (battery->present) {
 		seq_printf(seq, "present:                 yes\n");
 	} else {
 		seq_printf(seq, "present:                 no\n");
 		goto end;
 	}
 
-	if (battery->info.capacity_mode) {
-		cscale = battery->info.vscale * battery->info.ipscale;
+	if (battery->mode) {
+		cscale = battery->vscale * battery->ipscale;
 	} else {
-		cscale = battery->info.ipscale;
+		cscale = battery->ipscale;
 	}
 
-	if (battery->state.battery_state & 0x0010) {
+	if (battery->state & 0x0010) {
 		seq_printf(seq, "capacity state:          critical\n");
 	} else {
 		seq_printf(seq, "capacity state:          ok\n");
 	}
 
-	foo = (s16) battery->state.amperage * battery->info.ipscale;
-	if (battery->info.capacity_mode) {
-		foo = foo * battery->info.design_voltage / 1000;
+	foo = (s16) battery->current_now * battery->ipscale;
+	if (battery->mode) {
+		foo = foo * battery->design_voltage / 1000;
 	}
-	if (battery->state.amperage < 0) {
+	if (battery->current_now < 0) {
 		seq_printf(seq, "charging state:          discharging\n");
 		seq_printf(seq, "present rate:            %d %s\n",
-			   -foo, battery->info.capacity_mode ? "mW" : "mA");
-	} else if (battery->state.amperage > 0) {
+			   -foo, battery->mode ? "mW" : "mA");
+	} else if (battery->current_now > 0) {
 		seq_printf(seq, "charging state:          charging\n");
 		seq_printf(seq, "present rate:            %d %s\n",
-			   foo, battery->info.capacity_mode ? "mW" : "mA");
+			   foo, battery->mode ? "mW" : "mA");
 	} else {
 		seq_printf(seq, "charging state:          charged\n");
 		seq_printf(seq, "present rate:            0 %s\n",
-			   battery->info.capacity_mode ? "mW" : "mA");
+			   battery->mode ? "mW" : "mA");
 	}
 
 	seq_printf(seq, "remaining capacity:      %i%s\n",
-		   battery->state.remaining_capacity * cscale,
-		   battery->info.capacity_mode ? "0 mWh" : " mAh");
+		   battery->capacity_now * cscale,
+		   battery->mode ? "0 mWh" : " mAh");
 
 	seq_printf(seq, "present voltage:         %i mV\n",
-		   battery->state.voltage * battery->info.vscale);
+		   battery->voltage_now * battery->vscale);
 
       end:
 
@@ -883,22 +867,22 @@ static int acpi_battery_read_alarm(struct seq_file *seq, void *offset)
 		}
 	}
 
-	if (!battery->battery_present) {
+	if (!battery->present) {
 		seq_printf(seq, "present:                 no\n");
 		goto end;
 	}
 
-	if (battery->info.capacity_mode) {
-		cscale = battery->info.vscale * battery->info.ipscale;
+	if (battery->mode) {
+		cscale = battery->vscale * battery->ipscale;
 	} else {
-		cscale = battery->info.ipscale;
+		cscale = battery->ipscale;
 	}
 
 	seq_printf(seq, "alarm:                   ");
-	if (battery->alarm.remaining_capacity) {
+	if (battery->alarm_capacity) {
 		seq_printf(seq, "%i%s\n",
-			   battery->alarm.remaining_capacity * cscale,
-			   battery->info.capacity_mode ? "0 mWh" : " mAh");
+			   battery->alarm_capacity * cscale,
+			   battery->mode ? "0 mWh" : " mAh");
 	} else {
 		seq_printf(seq, "disabled\n");
 	}
@@ -928,7 +912,7 @@ acpi_battery_write_alarm(struct file *file, const char __user * buffer,
 	if (result)
 		goto end;
 
-	if (!battery->battery_present) {
+	if (!battery->present) {
 		result = -ENODEV;
 		goto end;
 	}
@@ -945,7 +929,7 @@ acpi_battery_write_alarm(struct file *file, const char __user * buffer,
 
 	alarm_string[count] = 0;
 
-	old_alarm = battery->alarm.remaining_capacity;
+	old_alarm = battery->alarm_capacity;
 	new_alarm = simple_strtoul(alarm_string, NULL, 0);
 
 	result = acpi_battery_set_alarm(battery, new_alarm);
@@ -1025,7 +1009,7 @@ static int acpi_ac_read_state(struct seq_file *seq, void *offset)
 	}
 
 	seq_printf(seq, "state:                   %s\n",
-		   sbs->ac.ac_present ? "on-line" : "off-line");
+		   sbs->charger_present ? "on-line" : "off-line");
 
 	sbs_mutex_unlock(sbs);
 
@@ -1080,7 +1064,7 @@ static int acpi_battery_add(struct acpi_sbs *sbs, int id)
 		goto end;
 	}
 
-	is_present = battery->battery_present;
+	is_present = battery->present;
 
 	if (is_present) {
 		result = acpi_battery_init(battery);
@@ -1094,7 +1078,7 @@ static int acpi_battery_add(struct acpi_sbs *sbs, int id)
 
 	sprintf(dir_name, ACPI_BATTERY_DIR_NAME, id);
 
-	result = acpi_sbs_generic_add_fs(&battery->battery_entry,
+	result = acpi_sbs_generic_add_fs(&battery->proc_entry,
 					 acpi_battery_dir,
 					 dir_name,
 					 &acpi_battery_info_fops,
@@ -1109,7 +1093,7 @@ static int acpi_battery_add(struct acpi_sbs *sbs, int id)
 
 	printk(KERN_INFO PREFIX "%s [%s]: Battery Slot [%s] (battery %s)\n",
 	       ACPI_SBS_DEVICE_NAME, acpi_device_bid(sbs->device), dir_name,
-	       sbs->battery->battery_present ? "present" : "absent");
+	       sbs->battery->present ? "present" : "absent");
 
       end:
 	return result;
@@ -1118,8 +1102,8 @@ static int acpi_battery_add(struct acpi_sbs *sbs, int id)
 static void acpi_battery_remove(struct acpi_sbs *sbs, int id)
 {
 
-	if (sbs->battery[id].battery_entry) {
-		acpi_sbs_generic_remove_fs(&(sbs->battery[id].battery_entry),
+	if (sbs->battery[id].proc_entry) {
+		acpi_sbs_generic_remove_fs(&(sbs->battery[id].proc_entry),
 					   acpi_battery_dir);
 	}
 }
@@ -1147,7 +1131,7 @@ static int acpi_ac_add(struct acpi_sbs *sbs)
 
 	printk(KERN_INFO PREFIX "%s [%s]: AC Adapter [%s] (%s)\n",
 	       ACPI_SBS_DEVICE_NAME, acpi_device_bid(sbs->device),
-	       ACPI_AC_DIR_NAME, sbs->ac.ac_present ? "on-line" : "off-line");
+	       ACPI_AC_DIR_NAME, sbs->charger_present ? "on-line" : "off-line");
 
       end:
 
@@ -1172,9 +1156,9 @@ static int acpi_sbs_update_run(struct acpi_sbs *sbs, int id, int data_type)
 	struct acpi_battery *battery;
 	int result = 0, cnt;
 	int old_ac_present = -1;
-	int old_battery_present = -1;
+	int old_present = -1;
 	int new_ac_present = -1;
-	int new_battery_present = -1;
+	int new_present = -1;
 	int id_min = 0, id_max = MAX_SBS_BAT - 1;
 	char dir_name[32];
 	int do_battery_init = 0, do_ac_init = 0;
@@ -1199,7 +1183,11 @@ static int acpi_sbs_update_run(struct acpi_sbs *sbs, int id, int data_type)
 
 	sbs->run_cnt++;
 
-	old_ac_present = sbs->ac.ac_present;
+	if (!update_battery) {
+		goto end;
+	}
+
+	old_ac_present = sbs->charger_present;
 
 	result = acpi_ac_get_present(sbs);
 	if (result) {
@@ -1207,7 +1195,7 @@ static int acpi_sbs_update_run(struct acpi_sbs *sbs, int id, int data_type)
 				"acpi_ac_get_present() failed"));
 	}
 
-	new_ac_present = sbs->ac.ac_present;
+	new_ac_present = sbs->charger_present;
 
 	do_ac_init = (old_ac_present != new_ac_present);
 	if (sbs->run_cnt == 1 && data_type == DATA_TYPE_COMMON) {
@@ -1244,9 +1232,9 @@ static int acpi_sbs_update_run(struct acpi_sbs *sbs, int id, int data_type)
 			continue;
 		}
 
-		old_remaining_capacity = battery->state.remaining_capacity;
+		old_remaining_capacity = battery->capacity_now;
 
-		old_battery_present = battery->battery_present;
+		old_present = battery->present;
 
 		result = acpi_battery_select(battery);
 		if (result) {
@@ -1260,11 +1248,11 @@ static int acpi_sbs_update_run(struct acpi_sbs *sbs, int id, int data_type)
 					"acpi_battery_get_present() failed"));
 		}
 
-		new_battery_present = battery->battery_present;
+		new_present = battery->present;
 
-		do_battery_init = ((old_battery_present != new_battery_present)
-				   && new_battery_present);
-		if (!new_battery_present)
+		do_battery_init = ((old_present != new_present)
+				   && new_present);
+		if (!new_present)
 			goto event;
 		if (do_ac_init || do_battery_init) {
 			result = acpi_battery_init(battery);
@@ -1280,7 +1268,7 @@ static int acpi_sbs_update_run(struct acpi_sbs *sbs, int id, int data_type)
 
 		if ((data_type == DATA_TYPE_COMMON
 		     || data_type == DATA_TYPE_INFO)
-		    && new_battery_present) {
+		    && new_present) {
 			result = acpi_battery_get_info(battery);
 			if (result) {
 				ACPI_EXCEPTION((AE_INFO, AE_ERROR,
@@ -1296,7 +1284,7 @@ static int acpi_sbs_update_run(struct acpi_sbs *sbs, int id, int data_type)
 
 		if ((data_type == DATA_TYPE_COMMON
 		     || data_type == DATA_TYPE_STATE)
-		    && new_battery_present) {
+		    && new_present) {
 			result = acpi_battery_get_state(battery);
 			if (result) {
 				ACPI_EXCEPTION((AE_INFO, AE_ERROR,
@@ -1312,7 +1300,7 @@ static int acpi_sbs_update_run(struct acpi_sbs *sbs, int id, int data_type)
 
 		if ((data_type == DATA_TYPE_COMMON
 		     || data_type == DATA_TYPE_ALARM)
-		    && new_battery_present) {
+		    && new_present) {
 			result = acpi_battery_get_alarm(battery);
 			if (result) {
 				ACPI_EXCEPTION((AE_INFO, AE_ERROR,
@@ -1329,17 +1317,17 @@ static int acpi_sbs_update_run(struct acpi_sbs *sbs, int id, int data_type)
 
 	      event:
 
-		if (old_battery_present != new_battery_present || do_ac_init ||
+		if (old_present != new_present || do_ac_init ||
 		    old_remaining_capacity !=
-		    battery->state.remaining_capacity) {
+		    battery->capacity_now) {
 			sprintf(dir_name, ACPI_BATTERY_DIR_NAME, id);
 			result = acpi_bus_generate_proc_event4(ACPI_BATTERY_CLASS,
 							 dir_name,
 							 ACPI_SBS_BATTERY_NOTIFY_STATUS,
-							 new_battery_present);
+							 new_present);
 			acpi_bus_generate_netlink_event(ACPI_BATTERY_CLASS, dir_name,
 							ACPI_SBS_BATTERY_NOTIFY_STATUS,
-							new_battery_present);
+							new_present);
 			if (result) {
 				ACPI_EXCEPTION((AE_INFO, AE_ERROR,
 						"acpi_bus_generate_proc_event4() "
@@ -1426,7 +1414,7 @@ static int acpi_sbs_add(struct acpi_device *device)
 
 	acpi_sbsm_get_info(sbs);
 
-	if (!sbs->sbsm_present) {
+	if (!sbs->manager_present) {
 		result = acpi_battery_add(sbs, 0);
 		if (result) {
 			ACPI_EXCEPTION((AE_INFO, AE_ERROR,
@@ -1435,7 +1423,7 @@ static int acpi_sbs_add(struct acpi_device *device)
 		}
 	} else {
 		for (id = 0; id < MAX_SBS_BAT; id++) {
-			if ((sbs->sbsm_batteries_supported & (1 << id))) {
+			if ((sbs->batteries_supported & (1 << id))) {
 				result = acpi_battery_add(sbs, id);
 				if (result) {
 					ACPI_EXCEPTION((AE_INFO, AE_ERROR,
@@ -1535,11 +1523,11 @@ static int __init acpi_sbs_init(void)
 	if (acpi_disabled)
 		return -ENODEV;
 
-	if (capacity_mode != DEF_CAPACITY_UNIT
-	    && capacity_mode != MAH_CAPACITY_UNIT
-	    && capacity_mode != MWH_CAPACITY_UNIT) {
+	if (mode != DEF_CAPACITY_UNIT
+	    && mode != MAH_CAPACITY_UNIT
+	    && mode != MWH_CAPACITY_UNIT) {
 		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
-				"invalid capacity_mode = %d", capacity_mode));
+				"invalid mode = %d", mode));
 		return -EINVAL;
 	}
 
-- 
1.5.3.1.27.g57543
