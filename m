From: Len Brown <len.brown@intel.com>
Subject: [PATCH 021/105] ACPI: sbs: Debug messages correction/improvement
Date: Sun, 29 Apr 2007 00:50:21 -0400
Message-ID: <11778223233885-git-send-email-len.brown@intel.com>
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
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:29561 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754607AbXD2EwF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 29 Apr 2007 00:52:05 -0400
In-Reply-To: <11778223222525-git-send-email-len.brown@intel.com>
Message-Id: <6845118b3b7a9cc2ba14dc665370217bc3ba8057.1177822058.git.len.brown@intel.com>
In-Reply-To: <ac122bb64b0d51f0512185d3522a75f3f3a80bc9.1177822058.git.len.brown@intel.com>
References: <ac122bb64b0d51f0512185d3522a75f3f3a80bc9.1177822058.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Vladimir Lebedev <vladimir.p.lebedev@intel.com>, Len Brown <len.brown@intel.com>

From: Vladimir Lebedev <vladimir.p.lebedev@intel.com>

Debug messages correction/improvement:
Use ACPI_EXCEPTION instead of ACPI_DEBUG_PRINT.

Signed-off-by: Vladimir Lebedev <vladimir.p.lebedev@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/sbs.c |  299 ++++++++++++++++++++++++++--------------------------
 1 files changed, 149 insertions(+), 150 deletions(-)

diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
index eab5c68..3956645 100644
--- a/drivers/acpi/sbs.c
+++ b/drivers/acpi/sbs.c
@@ -271,7 +271,7 @@ acpi_ec_sbs_access(struct acpi_sbs *sbs, u16 addr,
 		break;
 	default:
 		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
-				"unsupported transaction %d\n", size));
+				"unsupported transaction %d", size));
 		return (-1);
 	}
 
@@ -291,7 +291,7 @@ acpi_ec_sbs_access(struct acpi_sbs *sbs, u16 addr,
 	if ((~temp[0] & ACPI_EC_SMB_STS_DONE)
 	    || (temp[0] & ACPI_EC_SMB_STS_STATUS)) {
 		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
-				"transaction %d error\n", size));
+				"transaction %d error", size));
 		return (-1);
 	}
 
@@ -318,7 +318,7 @@ acpi_ec_sbs_access(struct acpi_sbs *sbs, u16 addr,
 		break;
 	default:
 		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
-				"unsupported transaction %d\n", size));
+				"unsupported transaction %d", size));
 		return (-1);
 	}
 
@@ -335,8 +335,8 @@ acpi_sbs_read_word(struct acpi_sbs *sbs, int addr, int func, u16 * word)
 				    ACPI_SBS_SMBUS_READ, func,
 				    ACPI_SBS_WORD_DATA, &data);
 	if (result) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "acpi_ec_sbs_access() failed\n"));
+		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
+				"acpi_ec_sbs_access() failed"));
 	} else {
 		*word = data.word;
 	}
@@ -354,8 +354,8 @@ acpi_sbs_read_str(struct acpi_sbs *sbs, int addr, int func, char *str)
 				    ACPI_SBS_SMBUS_READ, func,
 				    ACPI_SBS_BLOCK_DATA, &data);
 	if (result) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "acpi_ec_sbs_access() failed\n"));
+		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
+				"acpi_ec_sbs_access() failed"));
 	} else {
 		strncpy(str, (const char *)data.block + 1, data.block[0]);
 		str[data.block[0]] = 0;
@@ -376,8 +376,8 @@ acpi_sbs_write_word(struct acpi_sbs *sbs, int addr, int func, int word)
 				    ACPI_SBS_SMBUS_WRITE, func,
 				    ACPI_SBS_WORD_DATA, &data);
 	if (result) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "acpi_ec_sbs_access() failed\n"));
+		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
+				"acpi_ec_sbs_access() failed"));
 	}
 
 	return result;
@@ -419,8 +419,8 @@ static int acpi_battery_get_present(struct acpi_battery *battery)
 	result = acpi_sbs_read_word(battery->sbs,
 				    ACPI_SBSM_SMBUS_ADDR, 0x01, &state);
 	if (result) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "acpi_sbs_read_word() failed"));
+		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
+				"acpi_sbs_read_word() failed"));
 	}
 	if (!result) {
 		is_present = (state & 0x000f) & (1 << battery->id);
@@ -456,8 +456,8 @@ static int acpi_battery_select(struct acpi_battery *battery)
 		result =
 		    acpi_sbs_read_word(sbs, ACPI_SBSM_SMBUS_ADDR, 0x01, &state);
 		if (result) {
-			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-					  "acpi_sbs_read_word() failed\n"));
+			ACPI_EXCEPTION((AE_INFO, AE_ERROR,
+					"acpi_sbs_read_word() failed"));
 			goto end;
 		}
 
@@ -465,8 +465,8 @@ static int acpi_battery_select(struct acpi_battery *battery)
 		result =
 		    acpi_sbs_write_word(sbs, ACPI_SBSM_SMBUS_ADDR, 0x01, foo);
 		if (result) {
-			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-					  "acpi_sbs_write_word() failed\n"));
+			ACPI_EXCEPTION((AE_INFO, AE_ERROR,
+					"acpi_sbs_write_word() failed"));
 			goto end;
 		}
 	}
@@ -483,8 +483,8 @@ static int acpi_sbsm_get_info(struct acpi_sbs *sbs)
 	result = acpi_sbs_read_word(sbs, ACPI_SBSM_SMBUS_ADDR, 0x04,
 				    &battery_system_info);
 	if (result) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "acpi_sbs_read_word() failed\n"));
+		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
+				"acpi_sbs_read_word() failed"));
 		goto end;
 	}
 
@@ -505,8 +505,8 @@ static int acpi_battery_get_info(struct acpi_battery *battery)
 	result = acpi_sbs_read_word(sbs, ACPI_SB_SMBUS_ADDR, 0x03,
 				    &battery_mode);
 	if (result) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "acpi_sbs_read_word() failed\n"));
+		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
+				"acpi_sbs_read_word() failed"));
 		goto end;
 	}
 	battery->info.capacity_mode = (battery_mode & 0x8000) >> 15;
@@ -514,8 +514,8 @@ static int acpi_battery_get_info(struct acpi_battery *battery)
 	result = acpi_sbs_read_word(sbs, ACPI_SB_SMBUS_ADDR, 0x10,
 				    &battery->info.full_charge_capacity);
 	if (result) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "acpi_sbs_read_word() failed\n"));
+		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
+				"acpi_sbs_read_word() failed"));
 		goto end;
 	}
 
@@ -529,16 +529,16 @@ static int acpi_battery_get_info(struct acpi_battery *battery)
 	result = acpi_sbs_read_word(sbs, ACPI_SB_SMBUS_ADDR, 0x19,
 				    &battery->info.design_voltage);
 	if (result) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "acpi_sbs_read_word() failed\n"));
+		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
+				"acpi_sbs_read_word() failed"));
 		goto end;
 	}
 
 	result = acpi_sbs_read_word(sbs, ACPI_SB_SMBUS_ADDR, 0x1a,
 				    &specification_info);
 	if (result) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "acpi_sbs_read_word() failed\n"));
+		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
+				"acpi_sbs_read_word() failed"));
 		goto end;
 	}
 
@@ -579,24 +579,24 @@ static int acpi_battery_get_info(struct acpi_battery *battery)
 	result = acpi_sbs_read_str(sbs, ACPI_SB_SMBUS_ADDR, 0x20,
 				   battery->info.manufacturer_name);
 	if (result) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "acpi_sbs_read_str() failed\n"));
+		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
+				"acpi_sbs_read_str() failed"));
 		goto end;
 	}
 
 	result = acpi_sbs_read_str(sbs, ACPI_SB_SMBUS_ADDR, 0x21,
 				   battery->info.device_name);
 	if (result) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "acpi_sbs_read_str() failed\n"));
+		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
+				"acpi_sbs_read_str() failed"));
 		goto end;
 	}
 
 	result = acpi_sbs_read_str(sbs, ACPI_SB_SMBUS_ADDR, 0x22,
 				   battery->info.device_chemistry);
 	if (result) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "acpi_sbs_read_str() failed\n"));
+		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
+				"acpi_sbs_read_str() failed"));
 		goto end;
 	}
 
@@ -623,8 +623,8 @@ static int acpi_battery_get_state(struct acpi_battery *battery)
 	result = acpi_sbs_read_word(sbs, ACPI_SB_SMBUS_ADDR, 0x09,
 				    &battery->state.voltage);
 	if (result) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "acpi_sbs_read_word() failed\n"));
+		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
+				"acpi_sbs_read_word() failed"));
 		goto end;
 	}
 
@@ -632,8 +632,8 @@ static int acpi_battery_get_state(struct acpi_battery *battery)
 	result = acpi_sbs_read_word(sbs, ACPI_SB_SMBUS_ADDR, 0x0a,
 				    &battery->state.amperage);
 	if (result) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "acpi_sbs_read_word() failed\n"));
+		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
+				"acpi_sbs_read_word() failed"));
 		goto end;
 	}
 
@@ -641,8 +641,8 @@ static int acpi_battery_get_state(struct acpi_battery *battery)
 	result = acpi_sbs_read_word(sbs, ACPI_SB_SMBUS_ADDR, 0x0f,
 				    &battery->state.remaining_capacity);
 	if (result) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "acpi_sbs_read_word() failed\n"));
+		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
+				"acpi_sbs_read_word() failed"));
 		goto end;
 	}
 
@@ -650,8 +650,8 @@ static int acpi_battery_get_state(struct acpi_battery *battery)
 	result = acpi_sbs_read_word(sbs, ACPI_SB_SMBUS_ADDR, 0x12,
 				    &battery->state.average_time_to_empty);
 	if (result) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "acpi_sbs_read_word() failed\n"));
+		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
+				"acpi_sbs_read_word() failed"));
 		goto end;
 	}
 
@@ -659,8 +659,8 @@ static int acpi_battery_get_state(struct acpi_battery *battery)
 	result = acpi_sbs_read_word(sbs, ACPI_SB_SMBUS_ADDR, 0x13,
 				    &battery->state.average_time_to_full);
 	if (result) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "acpi_sbs_read_word() failed\n"));
+		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
+				"acpi_sbs_read_word() failed"));
 		goto end;
 	}
 
@@ -668,8 +668,8 @@ static int acpi_battery_get_state(struct acpi_battery *battery)
 	result = acpi_sbs_read_word(sbs, ACPI_SB_SMBUS_ADDR, 0x16,
 				    &battery->state.battery_status);
 	if (result) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "acpi_sbs_read_word() failed\n"));
+		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
+				"acpi_sbs_read_word() failed"));
 		goto end;
 	}
 
@@ -687,8 +687,8 @@ static int acpi_battery_get_alarm(struct acpi_battery *battery)
 	result = acpi_sbs_read_word(sbs, ACPI_SB_SMBUS_ADDR, 0x01,
 				    &battery->alarm.remaining_capacity);
 	if (result) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "acpi_sbs_read_word() failed\n"));
+		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
+				"acpi_sbs_read_word() failed"));
 		goto end;
 	}
 
@@ -709,8 +709,8 @@ static int acpi_battery_set_alarm(struct acpi_battery *battery,
 
 	result = acpi_battery_select(battery);
 	if (result) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "acpi_battery_select() failed\n"));
+		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
+				"acpi_battery_select() failed"));
 		goto end;
 	}
 
@@ -721,8 +721,8 @@ static int acpi_battery_set_alarm(struct acpi_battery *battery,
 		    acpi_sbs_read_word(sbs, ACPI_SB_SMBUS_ADDR, 0x03,
 				       &battery_mode);
 		if (result) {
-			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-					  "acpi_sbs_read_word() failed\n"));
+			ACPI_EXCEPTION((AE_INFO, AE_ERROR,
+					"acpi_sbs_read_word() failed"));
 			goto end;
 		}
 
@@ -730,8 +730,8 @@ static int acpi_battery_set_alarm(struct acpi_battery *battery,
 		    acpi_sbs_write_word(sbs, ACPI_SB_SMBUS_ADDR, 0x01,
 					battery_mode & 0xbfff);
 		if (result) {
-			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-					  "acpi_sbs_write_word() failed\n"));
+			ACPI_EXCEPTION((AE_INFO, AE_ERROR,
+					"acpi_sbs_write_word() failed"));
 			goto end;
 		}
 	}
@@ -739,8 +739,8 @@ static int acpi_battery_set_alarm(struct acpi_battery *battery,
 	foo = alarm / (battery->info.capacity_mode ? 10 : 1);
 	result = acpi_sbs_write_word(sbs, ACPI_SB_SMBUS_ADDR, 0x01, foo);
 	if (result) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "acpi_sbs_write_word() failed\n"));
+		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
+				"acpi_sbs_write_word() failed"));
 		goto end;
 	}
 
@@ -761,8 +761,8 @@ static int acpi_battery_set_mode(struct acpi_battery *battery)
 	result = acpi_sbs_read_word(battery->sbs,
 				    ACPI_SB_SMBUS_ADDR, 0x03, &battery_mode);
 	if (result) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "acpi_sbs_read_word() failed\n"));
+		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
+				"acpi_sbs_read_word() failed"));
 		goto end;
 	}
 
@@ -774,16 +774,16 @@ static int acpi_battery_set_mode(struct acpi_battery *battery)
 	result = acpi_sbs_write_word(battery->sbs,
 				     ACPI_SB_SMBUS_ADDR, 0x03, battery_mode);
 	if (result) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "acpi_sbs_write_word() failed\n"));
+		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
+				"acpi_sbs_write_word() failed"));
 		goto end;
 	}
 
 	result = acpi_sbs_read_word(battery->sbs,
 				    ACPI_SB_SMBUS_ADDR, 0x03, &battery_mode);
 	if (result) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "acpi_sbs_read_word() failed\n"));
+		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
+				"acpi_sbs_read_word() failed"));
 		goto end;
 	}
 
@@ -797,36 +797,36 @@ static int acpi_battery_init(struct acpi_battery *battery)
 
 	result = acpi_battery_select(battery);
 	if (result) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "acpi_battery_init() failed\n"));
+		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
+				"acpi_battery_init() failed"));
 		goto end;
 	}
 
 	result = acpi_battery_set_mode(battery);
 	if (result) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "acpi_battery_set_mode() failed\n"));
+		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
+				"acpi_battery_set_mode() failed"));
 		goto end;
 	}
 
 	result = acpi_battery_get_info(battery);
 	if (result) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "acpi_battery_get_info() failed\n"));
+		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
+				"acpi_battery_get_info() failed"));
 		goto end;
 	}
 
 	result = acpi_battery_get_state(battery);
 	if (result) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "acpi_battery_get_state() failed\n"));
+		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
+				"acpi_battery_get_state() failed"));
 		goto end;
 	}
 
 	result = acpi_battery_get_alarm(battery);
 	if (result) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "acpi_battery_get_alarm() failed\n"));
+		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
+				"acpi_battery_get_alarm() failed"));
 		goto end;
 	}
 
@@ -843,8 +843,8 @@ static int acpi_ac_get_present(struct acpi_sbs *sbs)
 				    &charger_status);
 
 	if (result) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "acpi_sbs_read_word() failed\n"));
+		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
+				"acpi_sbs_read_word() failed"));
 		goto end;
 	}
 
@@ -874,8 +874,8 @@ acpi_sbs_generic_add_fs(struct proc_dir_entry **dir,
 	if (!*dir) {
 		*dir = proc_mkdir(dir_name, parent_dir);
 		if (!*dir) {
-			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-					  "proc_mkdir() failed\n"));
+			ACPI_EXCEPTION((AE_INFO, AE_ERROR,
+					"proc_mkdir() failed"));
 			return -ENODEV;
 		}
 		(*dir)->owner = THIS_MODULE;
@@ -885,8 +885,8 @@ acpi_sbs_generic_add_fs(struct proc_dir_entry **dir,
 	if (info_fops) {
 		entry = create_proc_entry(ACPI_SBS_FILE_INFO, S_IRUGO, *dir);
 		if (!entry) {
-			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-					  "create_proc_entry() failed\n"));
+			ACPI_EXCEPTION((AE_INFO, AE_ERROR,
+					"create_proc_entry() failed"));
 		} else {
 			entry->proc_fops = info_fops;
 			entry->data = data;
@@ -898,8 +898,8 @@ acpi_sbs_generic_add_fs(struct proc_dir_entry **dir,
 	if (state_fops) {
 		entry = create_proc_entry(ACPI_SBS_FILE_STATE, S_IRUGO, *dir);
 		if (!entry) {
-			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-					  "create_proc_entry() failed\n"));
+			ACPI_EXCEPTION((AE_INFO, AE_ERROR,
+					"create_proc_entry() failed"));
 		} else {
 			entry->proc_fops = state_fops;
 			entry->data = data;
@@ -911,8 +911,8 @@ acpi_sbs_generic_add_fs(struct proc_dir_entry **dir,
 	if (alarm_fops) {
 		entry = create_proc_entry(ACPI_SBS_FILE_ALARM, S_IRUGO, *dir);
 		if (!entry) {
-			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-					  "create_proc_entry() failed\n"));
+			ACPI_EXCEPTION((AE_INFO, AE_ERROR,
+					"create_proc_entry() failed"));
 		} else {
 			entry->proc_fops = alarm_fops;
 			entry->data = data;
@@ -957,8 +957,8 @@ static int acpi_battery_read_info(struct seq_file *seq, void *offset)
 	if (update_mode == REQUEST_UPDATE_MODE) {
 		result = acpi_sbs_update_run(battery->sbs, DATA_TYPE_INFO);
 		if (result) {
-			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-					  "acpi_sbs_update_run() failed\n"));
+			ACPI_EXCEPTION((AE_INFO, AE_ERROR,
+					"acpi_sbs_update_run() failed"));
 		}
 	}
 
@@ -1032,8 +1032,8 @@ static int acpi_battery_read_state(struct seq_file *seq, void *offset)
 	if (update_mode == REQUEST_UPDATE_MODE) {
 		result = acpi_sbs_update_run(battery->sbs, DATA_TYPE_STATE);
 		if (result) {
-			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-					  "acpi_sbs_update_run() failed\n"));
+			ACPI_EXCEPTION((AE_INFO, AE_ERROR,
+					"acpi_sbs_update_run() failed"));
 		}
 	}
 
@@ -1108,8 +1108,8 @@ static int acpi_battery_read_alarm(struct seq_file *seq, void *offset)
 	if (update_mode == REQUEST_UPDATE_MODE) {
 		result = acpi_sbs_update_run(battery->sbs, DATA_TYPE_ALARM);
 		if (result) {
-			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-					  "acpi_sbs_update_run() failed\n"));
+			ACPI_EXCEPTION((AE_INFO, AE_ERROR,
+					"acpi_sbs_update_run() failed"));
 		}
 	}
 
@@ -1177,15 +1177,15 @@ acpi_battery_write_alarm(struct file *file, const char __user * buffer,
 
 	result = acpi_battery_set_alarm(battery, new_alarm);
 	if (result) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "acpi_battery_set_alarm() failed\n"));
+		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
+				"acpi_battery_set_alarm() failed"));
 		acpi_battery_set_alarm(battery, old_alarm);
 		goto end;
 	}
 	result = acpi_battery_get_alarm(battery);
 	if (result) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "acpi_battery_get_alarm() failed\n"));
+		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
+				"acpi_battery_get_alarm() failed"));
 		acpi_battery_set_alarm(battery, old_alarm);
 		goto end;
 	}
@@ -1248,8 +1248,8 @@ static int acpi_ac_read_state(struct seq_file *seq, void *offset)
 	if (update_mode == REQUEST_UPDATE_MODE) {
 		result = acpi_sbs_update_run(sbs, DATA_TYPE_AC_STATE);
 		if (result) {
-			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-					  "acpi_sbs_update_run() failed\n"));
+			ACPI_EXCEPTION((AE_INFO, AE_ERROR,
+					"acpi_sbs_update_run() failed"));
 		}
 	}
 
@@ -1297,15 +1297,15 @@ static int acpi_battery_add(struct acpi_sbs *sbs, int id)
 
 	result = acpi_battery_select(battery);
 	if (result) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "acpi_battery_select() failed\n"));
+		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
+				"acpi_battery_select() failed"));
 		goto end;
 	}
 
 	result = acpi_battery_get_present(battery);
 	if (result) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "acpi_battery_get_present() failed\n"));
+		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
+				"acpi_battery_get_present() failed"));
 		goto end;
 	}
 
@@ -1314,8 +1314,8 @@ static int acpi_battery_add(struct acpi_sbs *sbs, int id)
 	if (is_present) {
 		result = acpi_battery_init(battery);
 		if (result) {
-			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-					  "acpi_battery_init() failed\n"));
+			ACPI_EXCEPTION((AE_INFO, AE_ERROR,
+					"acpi_battery_init() failed"));
 			goto end;
 		}
 		battery->init_state = 1;
@@ -1330,8 +1330,8 @@ static int acpi_battery_add(struct acpi_sbs *sbs, int id)
 					 &acpi_battery_state_fops,
 					 &acpi_battery_alarm_fops, battery);
 	if (result) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "acpi_sbs_generic_add_fs() failed\n"));
+		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
+				"acpi_sbs_generic_add_fs() failed"));
 		goto end;
 	}
 	battery->alive = 1;
@@ -1355,8 +1355,8 @@ static int acpi_ac_add(struct acpi_sbs *sbs)
 
 	result = acpi_ac_get_present(sbs);
 	if (result) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "acpi_ac_get_present() failed\n"));
+		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
+				"acpi_ac_get_present() failed"));
 		goto end;
 	}
 
@@ -1365,8 +1365,8 @@ static int acpi_ac_add(struct acpi_sbs *sbs)
 					 ACPI_AC_DIR_NAME,
 					 NULL, &acpi_ac_state_fops, NULL, sbs);
 	if (result) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "acpi_sbs_generic_add_fs() failed\n"));
+		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
+				"acpi_sbs_generic_add_fs() failed"));
 		goto end;
 	}
 
@@ -1409,8 +1409,8 @@ static int acpi_sbs_update_run(struct acpi_sbs *sbs, int data_type)
 
 	result = acpi_ac_get_present(sbs);
 	if (result) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "acpi_ac_get_present() failed\n"));
+		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
+				"acpi_ac_get_present() failed"));
 	}
 
 	new_ac_present = acpi_ac_is_present(sbs);
@@ -1433,8 +1433,8 @@ static int acpi_sbs_update_run(struct acpi_sbs *sbs, int data_type)
 
 		result = acpi_battery_select(battery);
 		if (result) {
-			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-					  "acpi_battery_select() failed\n"));
+			ACPI_EXCEPTION((AE_INFO, AE_ERROR,
+					"acpi_battery_select() failed"));
 		}
 		if (sbs->zombie) {
 			goto end;
@@ -1442,8 +1442,8 @@ static int acpi_sbs_update_run(struct acpi_sbs *sbs, int data_type)
 
 		result = acpi_battery_get_present(battery);
 		if (result) {
-			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-					  "acpi_battery_get_present() failed\n"));
+			ACPI_EXCEPTION((AE_INFO, AE_ERROR,
+					"acpi_battery_get_present() failed"));
 		}
 		if (sbs->zombie) {
 			goto end;
@@ -1466,9 +1466,9 @@ static int acpi_sbs_update_run(struct acpi_sbs *sbs, int data_type)
 			}
 			result = acpi_battery_init(battery);
 			if (result) {
-				ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-						  "acpi_battery_init() "
-						  "failed\n"));
+				ACPI_EXCEPTION((AE_INFO, AE_ERROR,
+						"acpi_battery_init() "
+						"failed"));
 			}
 		}
 		if (data_type == DATA_TYPE_INFO) {
@@ -1481,9 +1481,9 @@ static int acpi_sbs_update_run(struct acpi_sbs *sbs, int data_type)
 		if (new_battery_present) {
 			result = acpi_battery_get_alarm(battery);
 			if (result) {
-				ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-						  "acpi_battery_get_alarm() "
-						  "failed\n"));
+				ACPI_EXCEPTION((AE_INFO, AE_ERROR,
+						"acpi_battery_get_alarm() "
+						"failed"));
 			}
 			if (data_type == DATA_TYPE_ALARM) {
 				continue;
@@ -1491,9 +1491,9 @@ static int acpi_sbs_update_run(struct acpi_sbs *sbs, int data_type)
 
 			result = acpi_battery_get_state(battery);
 			if (result) {
-				ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-						  "acpi_battery_get_state() "
-						  "failed\n"));
+				ACPI_EXCEPTION((AE_INFO, AE_ERROR,
+						"acpi_battery_get_state() "
+						"failed"));
 			}
 		}
 		if (sbs->zombie) {
@@ -1511,9 +1511,9 @@ static int acpi_sbs_update_run(struct acpi_sbs *sbs, int data_type)
 							 dir_name,
 							 ACPI_BATTERY_CLASS);
 			if (result) {
-				ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-						  "acpi_sbs_generate_event() "
-						  "failed\n"));
+				ACPI_EXCEPTION((AE_INFO, AE_ERROR,
+						"acpi_sbs_generate_event() "
+						"failed"));
 			}
 		}
 		if (old_remaining_capacity != battery->state.remaining_capacity) {
@@ -1524,8 +1524,8 @@ static int acpi_sbs_update_run(struct acpi_sbs *sbs, int data_type)
 							 dir_name,
 							 ACPI_BATTERY_CLASS);
 			if (result) {
-				ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-						  "acpi_sbs_generate_event() failed\n"));
+				ACPI_EXCEPTION((AE_INFO, AE_ERROR,
+						"acpi_sbs_generate_event() failed"));
 			}
 		}
 
@@ -1544,8 +1544,8 @@ static int acpi_sbs_update_run(struct acpi_sbs *sbs, int data_type)
 						 ACPI_AC_DIR_NAME,
 						 ACPI_AC_CLASS);
 		if (result) {
-			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-					  "acpi_sbs_generate_event() failed\n"));
+			ACPI_EXCEPTION((AE_INFO, AE_ERROR,
+					"acpi_sbs_generate_event() failed"));
 		}
 	}
 
@@ -1565,8 +1565,8 @@ static void acpi_sbs_update_queue(void *data)
 
 	result = acpi_sbs_update_run(sbs, DATA_TYPE_COMMON);
 	if (result) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "acpi_sbs_update_run() failed\n"));
+		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
+				"acpi_sbs_update_run() failed"));
 	}
 
 	if (sbs->zombie) {
@@ -1598,13 +1598,13 @@ static int acpi_sbs_add(struct acpi_device *device)
 	status =
 	    acpi_evaluate_integer(device->parent->handle, "_EC", NULL, &val);
 	if (ACPI_FAILURE(status)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_WARN, "Error obtaining _EC\n"));
+		ACPI_EXCEPTION((AE_INFO, AE_ERROR, "Error obtaining _EC"));
 		return -EIO;
 	}
 
 	sbs = kzalloc(sizeof(struct acpi_sbs), GFP_KERNEL);
 	if (!sbs) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "kmalloc() failed\n"));
+		ACPI_EXCEPTION((AE_INFO, AE_ERROR, "kmalloc() failed"));
 		return -ENOMEM;
 	}
 	sbs->base = (val & 0xff00ull) >> 8;
@@ -1620,13 +1620,13 @@ static int acpi_sbs_add(struct acpi_device *device)
 
 	result = acpi_ac_add(sbs);
 	if (result) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "acpi_ac_add() failed\n"));
+		ACPI_EXCEPTION((AE_INFO, AE_ERROR, "acpi_ac_add() failed"));
 		goto end;
 	}
 	result = acpi_evaluate_integer(device->handle, "_SBS", NULL, &sbs_obj);
 	if (ACPI_FAILURE(result)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "acpi_evaluate_integer() failed\n"));
+		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
+				"acpi_evaluate_integer() failed"));
 		result = -EIO;
 		goto end;
 	}
@@ -1634,8 +1634,8 @@ static int acpi_sbs_add(struct acpi_device *device)
 	if (sbs_obj > 0) {
 		result = acpi_sbsm_get_info(sbs);
 		if (result) {
-			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-					  "acpi_sbsm_get_info() failed\n"));
+			ACPI_EXCEPTION((AE_INFO, AE_ERROR,
+					"acpi_sbsm_get_info() failed"));
 			goto end;
 		}
 		sbs->sbsm_present = 1;
@@ -1643,8 +1643,8 @@ static int acpi_sbs_add(struct acpi_device *device)
 	if (sbs->sbsm_present == 0) {
 		result = acpi_battery_add(sbs, 0);
 		if (result) {
-			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-					  "acpi_battery_add() failed\n"));
+			ACPI_EXCEPTION((AE_INFO, AE_ERROR,
+					"acpi_battery_add() failed"));
 			goto end;
 		}
 	} else {
@@ -1652,9 +1652,9 @@ static int acpi_sbs_add(struct acpi_device *device)
 			if ((sbs->sbsm_batteries_supported & (1 << id))) {
 				result = acpi_battery_add(sbs, id);
 				if (result) {
-					ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-							  "acpi_battery_add() "
-							  "failed\n"));
+					ACPI_EXCEPTION((AE_INFO, AE_ERROR,
+							"acpi_battery_add() "
+							"failed"));
 					goto end;
 				}
 			}
@@ -1668,8 +1668,8 @@ static int acpi_sbs_add(struct acpi_device *device)
 		status = acpi_os_execute(OSL_GPE_HANDLER,
 					 acpi_sbs_update_queue, sbs);
 		if (status != AE_OK) {
-			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-					  "acpi_os_execute() failed\n"));
+			ACPI_EXCEPTION((AE_INFO, AE_ERROR,
+					"acpi_os_execute() failed"));
 		}
 	}
 	sbs->update_time = update_time;
@@ -1733,30 +1733,29 @@ static int __init acpi_sbs_init(void)
 	if (capacity_mode != DEF_CAPACITY_UNIT
 	    && capacity_mode != MAH_CAPACITY_UNIT
 	    && capacity_mode != MWH_CAPACITY_UNIT) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "acpi_sbs_init: "
-				  "invalid capacity_mode = %d\n",
-				  capacity_mode));
+		ACPI_EXCEPTION((AE_INFO, AE_ERROR, "acpi_sbs_init: "
+				"invalid capacity_mode = %d", capacity_mode));
 		return -EINVAL;
 	}
 
 	acpi_ac_dir = acpi_lock_ac_dir();
 	if (!acpi_ac_dir) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "acpi_lock_ac_dir() failed\n"));
+		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
+				"acpi_lock_ac_dir() failed"));
 		return -ENODEV;
 	}
 
 	acpi_battery_dir = acpi_lock_battery_dir();
 	if (!acpi_battery_dir) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "acpi_lock_battery_dir() failed\n"));
+		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
+				"acpi_lock_battery_dir() failed"));
 		return -ENODEV;
 	}
 
 	result = acpi_bus_register_driver(&acpi_sbs_driver);
 	if (result < 0) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "acpi_bus_register_driver() failed\n"));
+		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
+				"acpi_bus_register_driver() failed"));
 		return -ENODEV;
 	}
 
-- 
1.5.2.rc0.34.gda94
