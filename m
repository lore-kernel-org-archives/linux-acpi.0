From: Len Brown <lenb@kernel.org>
Subject: [PATCH 10/32] ACPI: SBS: Split host controller (ACPI0001) from SBS driver (ACPI0002)
Date: Fri, 21 Sep 2007 23:46:16 -0400
Message-ID: <119043280633-git-send-email-lenb@kernel.org>
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
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:2443 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754300AbXIVDqs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Sep 2007 23:46:48 -0400
In-Reply-To: <11904328061489-git-send-email-lenb@kernel.org>
Message-Id: <f0ebb0c2228ebb95b1dc400bcc05d6fe873e2b3f.1190432418.git.len.brown@intel.com>
In-Reply-To: <fd1caaed466de2ee100e250b6c755376eda7ba3b.1190432417.git.len.brown@intel.com>
References: <fd1caaed466de2ee100e250b6c755376eda7ba3b.1190432417.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Alexey Starikovskiy <astarikovskiy@suse.de>

Replace poll-based host controller driver with the notify-based one.
Split it out of sbs.c.
Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/Makefile |    1 +
 drivers/acpi/sbs.c    |  374 ++++++++++---------------------------------------
 drivers/acpi/sbshc.c  |  309 ++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/sbshc.h  |   27 ++++
 4 files changed, 412 insertions(+), 299 deletions(-)
 create mode 100644 drivers/acpi/sbshc.c
 create mode 100644 drivers/acpi/sbshc.h

diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index d4336f1..54e3ab0 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -60,3 +60,4 @@ obj-$(CONFIG_ACPI_TOSHIBA)	+= toshiba_acpi.o
 obj-$(CONFIG_ACPI_HOTPLUG_MEMORY)	+= acpi_memhotplug.o
 obj-y				+= cm_sbs.o
 obj-$(CONFIG_ACPI_SBS)		+= sbs.o
+obj-$(CONFIG_ACPI_SBS)		+= sbshc.o
diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
index 33ba4bf..7bb8c62 100644
--- a/drivers/acpi/sbs.c
+++ b/drivers/acpi/sbs.c
@@ -34,6 +34,8 @@
 #include <linux/jiffies.h>
 #include <linux/delay.h>
 
+#include "sbshc.h"
+
 #define ACPI_SBS_COMPONENT		0x00080000
 #define ACPI_SBS_CLASS			"sbs"
 #define ACPI_AC_CLASS			"ac_adapter"
@@ -59,28 +61,6 @@ MODULE_AUTHOR("Rich Townsend");
 MODULE_DESCRIPTION("Smart Battery System ACPI interface driver");
 MODULE_LICENSE("GPL");
 
-#define	xmsleep(t)	msleep(t)
-
-#define ACPI_EC_SMB_PRTCL	0x00	/* protocol, PEC */
-
-#define ACPI_EC_SMB_STS		0x01	/* status */
-#define ACPI_EC_SMB_ADDR	0x02	/* address */
-#define ACPI_EC_SMB_CMD		0x03	/* command */
-#define ACPI_EC_SMB_DATA	0x04	/* 32 data registers */
-#define ACPI_EC_SMB_BCNT	0x24	/* number of data bytes */
-
-#define ACPI_EC_SMB_STS_DONE	0x80
-#define ACPI_EC_SMB_STS_STATUS	0x1f
-
-#define ACPI_EC_SMB_PRTCL_WRITE		0x00
-#define ACPI_EC_SMB_PRTCL_READ		0x01
-#define ACPI_EC_SMB_PRTCL_WORD_DATA	0x08
-#define ACPI_EC_SMB_PRTCL_BLOCK_DATA	0x0a
-
-#define ACPI_EC_SMB_TRANSACTION_SLEEP	1
-#define ACPI_EC_SMB_ACCESS_SLEEP1	1
-#define ACPI_EC_SMB_ACCESS_SLEEP2	10
-
 #define	DEF_CAPACITY_UNIT	3
 #define	MAH_CAPACITY_UNIT	1
 #define	MWH_CAPACITY_UNIT	2
@@ -103,12 +83,6 @@ extern void acpi_unlock_battery_dir(struct proc_dir_entry *acpi_battery_dir);
 #define	MAX_SBS_BAT			4
 #define ACPI_SBS_BLOCK_MAX		32
 
-#define ACPI_SBS_SMBUS_READ		1
-#define ACPI_SBS_SMBUS_WRITE		2
-
-#define ACPI_SBS_WORD_DATA		1
-#define ACPI_SBS_BLOCK_DATA		2
-
 #define	UPDATE_DELAY	10
 
 /* 0 - every time, > 0 - by update_time */
@@ -124,8 +98,7 @@ static int acpi_sbs_remove(struct acpi_device *device, int type);
 static int acpi_sbs_resume(struct acpi_device *device);
 
 static const struct acpi_device_id sbs_device_ids[] = {
-	{"ACPI0001", 0},
-	{"ACPI0005", 0},
+	{"ACPI0002", 0},
 	{"", 0},
 };
 MODULE_DEVICE_TABLE(acpi, sbs_device_ids);
@@ -182,8 +155,8 @@ struct acpi_battery {
 };
 
 struct acpi_sbs {
-	int base;
 	struct acpi_device *device;
+	struct acpi_smb_hc *hc;
 	struct mutex mutex;
 	int sbsm_present;
 	int sbsm_batteries_supported;
@@ -199,190 +172,6 @@ struct acpi_sbs {
 static int acpi_sbs_update_run(struct acpi_sbs *sbs, int id, int data_type);
 static void acpi_sbs_update_time(void *data);
 
-union sbs_rw_data {
-	u16 word;
-	u8 block[ACPI_SBS_BLOCK_MAX + 2];
-};
-
-static int acpi_ec_sbs_access(struct acpi_sbs *sbs, u16 addr,
-			      char read_write, u8 command, int size,
-			      union sbs_rw_data *data);
-
-/* --------------------------------------------------------------------------
-                               SMBus Communication
-   -------------------------------------------------------------------------- */
-
-static int acpi_ec_sbs_read(struct acpi_sbs *sbs, u8 address, u8 * data)
-{
-	u8 val;
-	int err;
-
-	err = ec_read(sbs->base + address, &val);
-	if (!err) {
-		*data = val;
-	}
-	xmsleep(ACPI_EC_SMB_TRANSACTION_SLEEP);
-	return (err);
-}
-
-static int acpi_ec_sbs_write(struct acpi_sbs *sbs, u8 address, u8 data)
-{
-	int err;
-
-	err = ec_write(sbs->base + address, data);
-	return (err);
-}
-
-static int
-acpi_ec_sbs_access(struct acpi_sbs *sbs, u16 addr,
-		   char read_write, u8 command, int size,
-		   union sbs_rw_data *data)
-{
-	unsigned char protocol, len = 0, temp[2] = { 0, 0 };
-	int i;
-
-	if (read_write == ACPI_SBS_SMBUS_READ) {
-		protocol = ACPI_EC_SMB_PRTCL_READ;
-	} else {
-		protocol = ACPI_EC_SMB_PRTCL_WRITE;
-	}
-
-	switch (size) {
-
-	case ACPI_SBS_WORD_DATA:
-		acpi_ec_sbs_write(sbs, ACPI_EC_SMB_CMD, command);
-		if (read_write == ACPI_SBS_SMBUS_WRITE) {
-			acpi_ec_sbs_write(sbs, ACPI_EC_SMB_DATA, data->word);
-			acpi_ec_sbs_write(sbs, ACPI_EC_SMB_DATA + 1,
-					  data->word >> 8);
-		}
-		protocol |= ACPI_EC_SMB_PRTCL_WORD_DATA;
-		break;
-	case ACPI_SBS_BLOCK_DATA:
-		acpi_ec_sbs_write(sbs, ACPI_EC_SMB_CMD, command);
-		if (read_write == ACPI_SBS_SMBUS_WRITE) {
-			len = min_t(u8, data->block[0], 32);
-			acpi_ec_sbs_write(sbs, ACPI_EC_SMB_BCNT, len);
-			for (i = 0; i < len; i++)
-				acpi_ec_sbs_write(sbs, ACPI_EC_SMB_DATA + i,
-						  data->block[i + 1]);
-		}
-		protocol |= ACPI_EC_SMB_PRTCL_BLOCK_DATA;
-		break;
-	default:
-		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
-				"unsupported transaction %d", size));
-		return (-1);
-	}
-
-	acpi_ec_sbs_write(sbs, ACPI_EC_SMB_ADDR, addr << 1);
-	acpi_ec_sbs_write(sbs, ACPI_EC_SMB_PRTCL, protocol);
-
-	acpi_ec_sbs_read(sbs, ACPI_EC_SMB_STS, temp);
-
-	if (~temp[0] & ACPI_EC_SMB_STS_DONE) {
-		xmsleep(ACPI_EC_SMB_ACCESS_SLEEP1);
-		acpi_ec_sbs_read(sbs, ACPI_EC_SMB_STS, temp);
-	}
-	if (~temp[0] & ACPI_EC_SMB_STS_DONE) {
-		xmsleep(ACPI_EC_SMB_ACCESS_SLEEP2);
-		acpi_ec_sbs_read(sbs, ACPI_EC_SMB_STS, temp);
-	}
-	if ((~temp[0] & ACPI_EC_SMB_STS_DONE)
-	    || (temp[0] & ACPI_EC_SMB_STS_STATUS)) {
-		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
-				"transaction %d error", size));
-		return (-1);
-	}
-
-	if (read_write == ACPI_SBS_SMBUS_WRITE) {
-		return (0);
-	}
-
-	switch (size) {
-
-	case ACPI_SBS_WORD_DATA:
-		acpi_ec_sbs_read(sbs, ACPI_EC_SMB_DATA, temp);
-		acpi_ec_sbs_read(sbs, ACPI_EC_SMB_DATA + 1, temp + 1);
-		data->word = (temp[1] << 8) | temp[0];
-		break;
-
-	case ACPI_SBS_BLOCK_DATA:
-		len = 0;
-		acpi_ec_sbs_read(sbs, ACPI_EC_SMB_BCNT, &len);
-		len = min_t(u8, len, 32);
-		for (i = 0; i < len; i++)
-			acpi_ec_sbs_read(sbs, ACPI_EC_SMB_DATA + i,
-					 data->block + i + 1);
-		data->block[0] = len;
-		break;
-	default:
-		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
-				"unsupported transaction %d", size));
-		return (-1);
-	}
-
-	return (0);
-}
-
-static int
-acpi_sbs_read_word(struct acpi_sbs *sbs, int addr, int func, u16 * word)
-{
-	union sbs_rw_data data;
-	int result = 0;
-
-	result = acpi_ec_sbs_access(sbs, addr,
-				    ACPI_SBS_SMBUS_READ, func,
-				    ACPI_SBS_WORD_DATA, &data);
-	if (result) {
-		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
-				"acpi_ec_sbs_access() failed"));
-	} else {
-		*word = data.word;
-	}
-
-	return result;
-}
-
-static int
-acpi_sbs_read_str(struct acpi_sbs *sbs, int addr, int func, char *str)
-{
-	union sbs_rw_data data;
-	int result = 0;
-
-	result = acpi_ec_sbs_access(sbs, addr,
-				    ACPI_SBS_SMBUS_READ, func,
-				    ACPI_SBS_BLOCK_DATA, &data);
-	if (result) {
-		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
-				"acpi_ec_sbs_access() failed"));
-	} else {
-		strncpy(str, (const char *)data.block + 1, data.block[0]);
-		str[data.block[0]] = 0;
-	}
-
-	return result;
-}
-
-static int
-acpi_sbs_write_word(struct acpi_sbs *sbs, int addr, int func, int word)
-{
-	union sbs_rw_data data;
-	int result = 0;
-
-	data.word = word;
-
-	result = acpi_ec_sbs_access(sbs, addr,
-				    ACPI_SBS_SMBUS_WRITE, func,
-				    ACPI_SBS_WORD_DATA, &data);
-	if (result) {
-		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
-				"acpi_ec_sbs_access() failed"));
-	}
-
-	return result;
-}
-
 static int sbs_zombie(struct acpi_sbs *sbs)
 {
 	return (sbs->zombie);
@@ -433,11 +222,11 @@ static int acpi_battery_get_present(struct acpi_battery *battery)
 	int result = 0;
 	int is_present = 0;
 
-	result = acpi_sbs_read_word(battery->sbs,
-				    ACPI_SBSM_SMBUS_ADDR, 0x01, &state);
+	result = acpi_smbus_read(battery->sbs->hc, SMBUS_READ_WORD,
+				    ACPI_SBSM_SMBUS_ADDR, 0x01, (u8 *)&state);
 	if (result) {
 		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
-				"acpi_sbs_read_word() failed"));
+				"acpi_smbus_read() failed"));
 	}
 	if (!result) {
 		is_present = (state & 0x000f) & (1 << battery->id);
@@ -461,19 +250,19 @@ static int acpi_battery_select(struct acpi_battery *battery)
 		 * it causes charging to halt on SBSELs */
 
 		result =
-		    acpi_sbs_read_word(sbs, ACPI_SBSM_SMBUS_ADDR, 0x01, &state);
+		    acpi_smbus_read(battery->sbs->hc, SMBUS_READ_WORD, ACPI_SBSM_SMBUS_ADDR, 0x01, (u8 *)&state);
 		if (result) {
 			ACPI_EXCEPTION((AE_INFO, AE_ERROR,
-					"acpi_sbs_read_word() failed"));
+					"acpi_smbus_read() failed"));
 			goto end;
 		}
 
 		foo = (state & 0x0fff) | (1 << (battery->id + 12));
 		result =
-		    acpi_sbs_write_word(sbs, ACPI_SBSM_SMBUS_ADDR, 0x01, foo);
+		    acpi_smbus_write(battery->sbs->hc, SMBUS_WRITE_WORD, ACPI_SBSM_SMBUS_ADDR, 0x01, (u8 *)&foo, 2);
 		if (result) {
 			ACPI_EXCEPTION((AE_INFO, AE_ERROR,
-					"acpi_sbs_write_word() failed"));
+					"acpi_smbus_write() failed"));
 			goto end;
 		}
 	}
@@ -487,11 +276,11 @@ static int acpi_sbsm_get_info(struct acpi_sbs *sbs)
 	int result = 0;
 	s16 battery_system_info;
 
-	result = acpi_sbs_read_word(sbs, ACPI_SBSM_SMBUS_ADDR, 0x04,
-				    &battery_system_info);
+	result = acpi_smbus_read(sbs->hc, SMBUS_READ_WORD, ACPI_SBSM_SMBUS_ADDR, 0x04,
+				    (u8 *)&battery_system_info);
 	if (result) {
 		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
-				"acpi_sbs_read_word() failed"));
+				"acpi_smbus_read() failed"));
 		goto end;
 	}
 	sbs->sbsm_present = 1;
@@ -504,50 +293,49 @@ static int acpi_sbsm_get_info(struct acpi_sbs *sbs)
 
 static int acpi_battery_get_info(struct acpi_battery *battery)
 {
-	struct acpi_sbs *sbs = battery->sbs;
 	int result = 0;
 	s16 battery_mode;
 	s16 specification_info;
 
-	result = acpi_sbs_read_word(sbs, ACPI_SB_SMBUS_ADDR, 0x03,
-				    &battery_mode);
+	result = acpi_smbus_read(battery->sbs->hc, SMBUS_READ_WORD, ACPI_SB_SMBUS_ADDR, 0x03,
+				    (u8 *)&battery_mode);
 	if (result) {
 		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
-				"acpi_sbs_read_word() failed"));
+				"acpi_smbus_read() failed"));
 		goto end;
 	}
 	battery->info.capacity_mode = (battery_mode & 0x8000) >> 15;
 
-	result = acpi_sbs_read_word(sbs, ACPI_SB_SMBUS_ADDR, 0x10,
-				    &battery->info.full_charge_capacity);
+	result = acpi_smbus_read(battery->sbs->hc, SMBUS_READ_WORD, ACPI_SB_SMBUS_ADDR, 0x10,
+				    (u8 *)&battery->info.full_charge_capacity);
 	if (result) {
 		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
-				"acpi_sbs_read_word() failed"));
+				"acpi_smbus_read() failed"));
 		goto end;
 	}
 
-	result = acpi_sbs_read_word(sbs, ACPI_SB_SMBUS_ADDR, 0x18,
-				    &battery->info.design_capacity);
+	result = acpi_smbus_read(battery->sbs->hc, SMBUS_READ_WORD, ACPI_SB_SMBUS_ADDR, 0x18,
+				    (u8 *)&battery->info.design_capacity);
 
 	if (result) {
 		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
-				"acpi_sbs_read_word() failed"));
+				"acpi_smbus_read() failed"));
 		goto end;
 	}
 
-	result = acpi_sbs_read_word(sbs, ACPI_SB_SMBUS_ADDR, 0x19,
-				    &battery->info.design_voltage);
+	result = acpi_smbus_read(battery->sbs->hc, SMBUS_READ_WORD, ACPI_SB_SMBUS_ADDR, 0x19,
+				    (u8 *)&battery->info.design_voltage);
 	if (result) {
 		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
-				"acpi_sbs_read_word() failed"));
+				"acpi_smbus_read() failed"));
 		goto end;
 	}
 
-	result = acpi_sbs_read_word(sbs, ACPI_SB_SMBUS_ADDR, 0x1a,
-				    &specification_info);
+	result = acpi_smbus_read(battery->sbs->hc, SMBUS_READ_WORD, ACPI_SB_SMBUS_ADDR, 0x1a,
+				    (u8 *)&specification_info);
 	if (result) {
 		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
-				"acpi_sbs_read_word() failed"));
+				"acpi_smbus_read() failed"));
 		goto end;
 	}
 
@@ -579,32 +367,32 @@ static int acpi_battery_get_info(struct acpi_battery *battery)
 		battery->info.ipscale = 1;
 	}
 
-	result = acpi_sbs_read_word(sbs, ACPI_SB_SMBUS_ADDR, 0x1c,
-				    &battery->info.serial_number);
+	result = acpi_smbus_read(battery->sbs->hc, SMBUS_READ_WORD, ACPI_SB_SMBUS_ADDR, 0x1c,
+				    (u8 *)&battery->info.serial_number);
 	if (result) {
 		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
-				"acpi_sbs_read_word() failed"));
+				"acpi_smbus_read() failed"));
 		goto end;
 	}
 
-	result = acpi_sbs_read_str(sbs, ACPI_SB_SMBUS_ADDR, 0x20,
-				   battery->info.manufacturer_name);
+	result = acpi_smbus_read(battery->sbs->hc, SMBUS_READ_BLOCK, ACPI_SB_SMBUS_ADDR, 0x20,
+				   (u8 *)battery->info.manufacturer_name);
 	if (result) {
 		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
 				"acpi_sbs_read_str() failed"));
 		goto end;
 	}
 
-	result = acpi_sbs_read_str(sbs, ACPI_SB_SMBUS_ADDR, 0x21,
-				   battery->info.device_name);
+	result = acpi_smbus_read(battery->sbs->hc, SMBUS_READ_BLOCK, ACPI_SB_SMBUS_ADDR, 0x21,
+				   (u8 *)battery->info.device_name);
 	if (result) {
 		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
 				"acpi_sbs_read_str() failed"));
 		goto end;
 	}
 
-	result = acpi_sbs_read_str(sbs, ACPI_SB_SMBUS_ADDR, 0x22,
-				   battery->info.device_chemistry);
+	result = acpi_smbus_read(battery->sbs->hc, SMBUS_READ_BLOCK, ACPI_SB_SMBUS_ADDR, 0x22,
+				   (u8 *)battery->info.device_chemistry);
 	if (result) {
 		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
 				"acpi_sbs_read_str() failed"));
@@ -617,38 +405,37 @@ static int acpi_battery_get_info(struct acpi_battery *battery)
 
 static int acpi_battery_get_state(struct acpi_battery *battery)
 {
-	struct acpi_sbs *sbs = battery->sbs;
 	int result = 0;
 
-	result = acpi_sbs_read_word(sbs, ACPI_SB_SMBUS_ADDR, 0x09,
-				    &battery->state.voltage);
+	result = acpi_smbus_read(battery->sbs->hc, SMBUS_READ_WORD, ACPI_SB_SMBUS_ADDR, 0x09,
+				    (u8 *)&battery->state.voltage);
 	if (result) {
 		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
-				"acpi_sbs_read_word() failed"));
+				"acpi_smbus_read() failed"));
 		goto end;
 	}
 
-	result = acpi_sbs_read_word(sbs, ACPI_SB_SMBUS_ADDR, 0x0a,
-				    &battery->state.amperage);
+	result = acpi_smbus_read(battery->sbs->hc, SMBUS_READ_WORD, ACPI_SB_SMBUS_ADDR, 0x0a,
+				    (u8 *)&battery->state.amperage);
 	if (result) {
 		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
-				"acpi_sbs_read_word() failed"));
+				"acpi_smbus_read() failed"));
 		goto end;
 	}
 
-	result = acpi_sbs_read_word(sbs, ACPI_SB_SMBUS_ADDR, 0x0f,
-				    &battery->state.remaining_capacity);
+	result = acpi_smbus_read(battery->sbs->hc, SMBUS_READ_WORD, ACPI_SB_SMBUS_ADDR, 0x0f,
+				    (u8 *)&battery->state.remaining_capacity);
 	if (result) {
 		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
-				"acpi_sbs_read_word() failed"));
+				"acpi_smbus_read() failed"));
 		goto end;
 	}
 
-	result = acpi_sbs_read_word(sbs, ACPI_SB_SMBUS_ADDR, 0x16,
-				    &battery->state.battery_state);
+	result = acpi_smbus_read(battery->sbs->hc, SMBUS_READ_WORD, ACPI_SB_SMBUS_ADDR, 0x16,
+				    (u8 *)&battery->state.battery_state);
 	if (result) {
 		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
-				"acpi_sbs_read_word() failed"));
+				"acpi_smbus_read() failed"));
 		goto end;
 	}
 
@@ -658,14 +445,13 @@ static int acpi_battery_get_state(struct acpi_battery *battery)
 
 static int acpi_battery_get_alarm(struct acpi_battery *battery)
 {
-	struct acpi_sbs *sbs = battery->sbs;
 	int result = 0;
 
-	result = acpi_sbs_read_word(sbs, ACPI_SB_SMBUS_ADDR, 0x01,
-				    &battery->alarm.remaining_capacity);
+	result = acpi_smbus_read(battery->sbs->hc, SMBUS_READ_WORD, ACPI_SB_SMBUS_ADDR, 0x01,
+				    (u8 *)&battery->alarm.remaining_capacity);
 	if (result) {
 		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
-				"acpi_sbs_read_word() failed"));
+				"acpi_smbus_read() failed"));
 		goto end;
 	}
 
@@ -677,7 +463,6 @@ static int acpi_battery_get_alarm(struct acpi_battery *battery)
 static int acpi_battery_set_alarm(struct acpi_battery *battery,
 				  unsigned long alarm)
 {
-	struct acpi_sbs *sbs = battery->sbs;
 	int result = 0;
 	s16 battery_mode;
 	int foo;
@@ -693,29 +478,30 @@ static int acpi_battery_set_alarm(struct acpi_battery *battery,
 
 	if (alarm > 0) {
 		result =
-		    acpi_sbs_read_word(sbs, ACPI_SB_SMBUS_ADDR, 0x03,
-				       &battery_mode);
+		    acpi_smbus_read(battery->sbs->hc, SMBUS_READ_WORD, ACPI_SB_SMBUS_ADDR, 0x03,
+				       (u8 *)&battery_mode);
 		if (result) {
 			ACPI_EXCEPTION((AE_INFO, AE_ERROR,
-					"acpi_sbs_read_word() failed"));
+					"acpi_smbus_read() failed"));
 			goto end;
 		}
 
+		battery_mode &= 0xbfff;
 		result =
-		    acpi_sbs_write_word(sbs, ACPI_SB_SMBUS_ADDR, 0x01,
-					battery_mode & 0xbfff);
+		    acpi_smbus_write(battery->sbs->hc, SMBUS_READ_WORD, ACPI_SB_SMBUS_ADDR, 0x01,
+					(u8 *)&battery_mode, 2);
 		if (result) {
 			ACPI_EXCEPTION((AE_INFO, AE_ERROR,
-					"acpi_sbs_write_word() failed"));
+					"acpi_smbus_write() failed"));
 			goto end;
 		}
 	}
 
 	foo = alarm / (battery->info.capacity_mode ? 10 : 1);
-	result = acpi_sbs_write_word(sbs, ACPI_SB_SMBUS_ADDR, 0x01, foo);
+	result = acpi_smbus_write(battery->sbs->hc, SMBUS_READ_WORD, ACPI_SB_SMBUS_ADDR, 0x01, (u8 *)&foo, 2);
 	if (result) {
 		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
-				"acpi_sbs_write_word() failed"));
+				"acpi_smbus_write() failed"));
 		goto end;
 	}
 
@@ -726,7 +512,6 @@ static int acpi_battery_set_alarm(struct acpi_battery *battery,
 
 static int acpi_battery_set_mode(struct acpi_battery *battery)
 {
-	struct acpi_sbs *sbs = battery->sbs;
 	int result = 0;
 	s16 battery_mode;
 
@@ -734,11 +519,11 @@ static int acpi_battery_set_mode(struct acpi_battery *battery)
 		goto end;
 	}
 
-	result = acpi_sbs_read_word(sbs,
-				    ACPI_SB_SMBUS_ADDR, 0x03, &battery_mode);
+	result = acpi_smbus_read(battery->sbs->hc, SMBUS_READ_WORD,
+				    ACPI_SB_SMBUS_ADDR, 0x03, (u8 *)&battery_mode);
 	if (result) {
 		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
-				"acpi_sbs_read_word() failed"));
+				"acpi_smbus_read() failed"));
 		goto end;
 	}
 
@@ -747,19 +532,19 @@ static int acpi_battery_set_mode(struct acpi_battery *battery)
 	} else {
 		battery_mode |= 0x8000;
 	}
-	result = acpi_sbs_write_word(sbs,
-				     ACPI_SB_SMBUS_ADDR, 0x03, battery_mode);
+	result = acpi_smbus_write(battery->sbs->hc, SMBUS_READ_WORD,
+				     ACPI_SB_SMBUS_ADDR, 0x03, (u8 *)&battery_mode, 2);
 	if (result) {
 		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
-				"acpi_sbs_write_word() failed"));
+				"acpi_smbus_write() failed"));
 		goto end;
 	}
 
-	result = acpi_sbs_read_word(sbs,
-				    ACPI_SB_SMBUS_ADDR, 0x03, &battery_mode);
+	result = acpi_smbus_read(battery->sbs->hc, SMBUS_READ_WORD,
+				    ACPI_SB_SMBUS_ADDR, 0x03, (u8 *)&battery_mode);
 	if (result) {
 		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
-				"acpi_sbs_read_word() failed"));
+				"acpi_smbus_read() failed"));
 		goto end;
 	}
 
@@ -815,12 +600,12 @@ static int acpi_ac_get_present(struct acpi_sbs *sbs)
 	int result = 0;
 	s16 charger_status;
 
-	result = acpi_sbs_read_word(sbs, ACPI_SBC_SMBUS_ADDR, 0x13,
-				    &charger_status);
+	result = acpi_smbus_read(sbs->hc, SMBUS_READ_WORD, ACPI_SBC_SMBUS_ADDR, 0x13,
+				    (u8 *)&charger_status);
 
 	if (result) {
 		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
-				"acpi_sbs_read_word() failed"));
+				"acpi_smbus_read() failed"));
 		goto end;
 	}
 
@@ -1614,15 +1399,6 @@ static int acpi_sbs_add(struct acpi_device *device)
 	struct acpi_sbs *sbs = NULL;
 	int result = 0, remove_result = 0;
 	int id;
-	acpi_status status = AE_OK;
-	unsigned long val;
-
-	status =
-	    acpi_evaluate_integer(device->handle, "_EC", NULL, &val);
-	if (ACPI_FAILURE(status)) {
-		ACPI_EXCEPTION((AE_INFO, AE_ERROR, "Error obtaining _EC"));
-		return -EIO;
-	}
 
 	sbs = kzalloc(sizeof(struct acpi_sbs), GFP_KERNEL);
 	if (!sbs) {
@@ -1635,8 +1411,8 @@ static int acpi_sbs_add(struct acpi_device *device)
 
 	sbs_mutex_lock(sbs);
 
-	sbs->base = 0xff & (val >> 8);
 	sbs->device = device;
+	sbs->hc = acpi_driver_data(device->parent);
 
 	strcpy(acpi_device_name(device), ACPI_SBS_DEVICE_NAME);
 	strcpy(acpi_device_class(device), ACPI_SBS_CLASS);
diff --git a/drivers/acpi/sbshc.c b/drivers/acpi/sbshc.c
new file mode 100644
index 0000000..046d7c3
--- /dev/null
+++ b/drivers/acpi/sbshc.c
@@ -0,0 +1,309 @@
+/*
+ * SMBus driver for ACPI Embedded Controller (v0.1)
+ *
+ * Copyright (c) 2007 Alexey Starikovskiy
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation version 2.
+ */
+
+#include <acpi/acpi_bus.h>
+#include <acpi/acpi_drivers.h>
+#include <acpi/actypes.h>
+#include <linux/wait.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include "sbshc.h"
+
+#define ACPI_SMB_HC_CLASS	"smbus_host_controller"
+#define ACPI_SMB_HC_DEVICE_NAME	"ACPI SMBus HC"
+
+struct acpi_smb_hc {
+	struct acpi_ec *ec;
+	struct mutex lock;
+	wait_queue_head_t wait;
+	u8 offset;
+	u8 query_bit;
+	smbus_alarm_callback callback;
+	void *context;
+};
+
+static int acpi_smbus_hc_add(struct acpi_device *device);
+static int acpi_smbus_hc_remove(struct acpi_device *device, int type);
+
+static const struct acpi_device_id sbs_device_ids[] = {
+	{"ACPI0001", 0},
+	{"ACPI0005", 0},
+	{"", 0},
+};
+
+MODULE_DEVICE_TABLE(acpi, sbs_device_ids);
+
+static struct acpi_driver acpi_smb_hc_driver = {
+	.name = "smbus_hc",
+	.class = ACPI_SMB_HC_CLASS,
+	.ids = sbs_device_ids,
+	.ops = {
+		.add = acpi_smbus_hc_add,
+		.remove = acpi_smbus_hc_remove,
+		},
+};
+
+union acpi_smb_status {
+	u8 raw;
+	struct {
+		u8 status:5;
+		u8 reserved:1;
+		u8 alarm:1;
+		u8 done:1;
+	} fields;
+};
+
+enum acpi_smb_status_codes {
+	SMBUS_OK = 0,
+	SMBUS_UNKNOWN_FAILURE = 0x07,
+	SMBUS_DEVICE_ADDRESS_NACK = 0x10,
+	SMBUS_DEVICE_ERROR = 0x11,
+	SMBUS_DEVICE_COMMAND_ACCESS_DENIED = 0x12,
+	SMBUS_UNKNOWN_ERROR = 0x13,
+	SMBUS_DEVICE_ACCESS_DENIED = 0x17,
+	SMBUS_TIMEOUT = 0x18,
+	SMBUS_HOST_UNSUPPORTED_PROTOCOL = 0x19,
+	SMBUS_BUSY = 0x1a,
+	SMBUS_PEC_ERROR = 0x1f,
+};
+
+enum acpi_smb_offset {
+	ACPI_SMB_PROTOCOL = 0,	/* protocol, PEC */
+	ACPI_SMB_STATUS = 1,	/* status */
+	ACPI_SMB_ADDRESS = 2,	/* address */
+	ACPI_SMB_COMMAND = 3,	/* command */
+	ACPI_SMB_DATA = 4,	/* 32 data registers */
+	ACPI_SMB_BLOCK_COUNT = 0x24,	/* number of data bytes */
+	ACPI_SMB_ALARM_ADDRESS = 0x25,	/* alarm address */
+	ACPI_SMB_ALARM_DATA = 0x26,	/* 2 bytes alarm data */
+};
+
+static inline int smb_hc_read(struct acpi_smb_hc *hc, u8 address, u8 *data)
+{
+	return ec_read(hc->offset + address, data);
+}
+
+static inline int smb_hc_write(struct acpi_smb_hc *hc, u8 address, u8 data)
+{
+	return ec_write(hc->offset + address, data);
+}
+
+static inline int smb_check_done(struct acpi_smb_hc *hc)
+{
+	union acpi_smb_status status = {.raw = 0};
+	smb_hc_read(hc, ACPI_SMB_STATUS, &status.raw);
+	return status.fields.done && (status.fields.status == SMBUS_OK);
+}
+
+static int wait_transaction_complete(struct acpi_smb_hc *hc, int timeout)
+{
+	if (wait_event_timeout(hc->wait, smb_check_done(hc),
+			       msecs_to_jiffies(timeout)))
+		return 0;
+	else
+		return -ETIME;
+}
+
+int acpi_smbus_transaction(struct acpi_smb_hc *hc, u8 protocol, u8 address,
+		    u8 command, u8 *data, u8 length)
+{
+	int ret = -EFAULT, i;
+	u8 temp, sz = 0;
+
+	mutex_lock(&hc->lock);
+	if (smb_hc_read(hc, ACPI_SMB_PROTOCOL, &temp))
+		goto end;
+	if (temp) {
+		ret = -EBUSY;
+		goto end;
+	}
+	smb_hc_write(hc, ACPI_SMB_COMMAND, command);
+	smb_hc_write(hc, ACPI_SMB_COMMAND, command);
+	if (!(protocol & 0x01)) {
+		smb_hc_write(hc, ACPI_SMB_BLOCK_COUNT, length);
+		for (i = 0; i < length; ++i)
+			smb_hc_write(hc, ACPI_SMB_DATA + i, data[i]);
+	}
+	smb_hc_write(hc, ACPI_SMB_ADDRESS, address << 1);
+	smb_hc_write(hc, ACPI_SMB_PROTOCOL, protocol);
+	/*
+	 * Wait for completion. Save the status code, data size,
+	 * and data into the return package (if required by the protocol).
+	 */
+	ret = wait_transaction_complete(hc, 1000);
+	if (ret || !(protocol & 0x01))
+		goto end;
+	switch (protocol) {
+	case SMBUS_RECEIVE_BYTE:
+	case SMBUS_READ_BYTE:
+		sz = 1;
+		break;
+	case SMBUS_READ_WORD:
+		sz = 2;
+		break;
+	case SMBUS_READ_BLOCK:
+		if (smb_hc_read(hc, ACPI_SMB_BLOCK_COUNT, &sz)) {
+			ret = -EFAULT;
+			goto end;
+		}
+		sz &= 0x1f;
+		break;
+	}
+	for (i = 0; i < sz; ++i)
+		smb_hc_read(hc, ACPI_SMB_DATA + i, &data[i]);
+      end:
+	mutex_unlock(&hc->lock);
+	return ret;
+}
+
+int acpi_smbus_read(struct acpi_smb_hc *hc, u8 protocol, u8 address,
+		    u8 command, u8 *data)
+{
+	return acpi_smbus_transaction(hc, protocol, address, command, data, 0);
+}
+
+EXPORT_SYMBOL_GPL(acpi_smbus_read);
+
+int acpi_smbus_write(struct acpi_smb_hc *hc, u8 protocol, u8 address,
+		     u8 command, u8 *data, u8 length)
+{
+	return acpi_smbus_transaction(hc, protocol, address, command, data, length);
+}
+
+EXPORT_SYMBOL_GPL(acpi_smbus_write);
+
+int acpi_smbus_register_callback(struct acpi_smb_hc *hc,
+			         smbus_alarm_callback callback, void *context)
+{
+	mutex_lock(&hc->lock);
+	hc->callback = callback;
+	hc->context = context;
+	mutex_unlock(&hc->lock);
+	return 0;
+}
+
+EXPORT_SYMBOL_GPL(acpi_smbus_register_callback);
+
+int acpi_smbus_unregister_callback(struct acpi_smb_hc *hc)
+{
+	mutex_lock(&hc->lock);
+	hc->callback = NULL;
+	hc->context = NULL;
+	mutex_unlock(&hc->lock);
+	return 0;
+}
+
+EXPORT_SYMBOL_GPL(acpi_smbus_unregister_callback);
+
+static void acpi_smbus_callback(void *context)
+{
+	struct acpi_smb_hc *hc = context;
+
+	if (hc->callback)
+		hc->callback(hc->context);
+}
+
+static int smbus_alarm(void *context)
+{
+	struct acpi_smb_hc *hc = context;
+	union acpi_smb_status status;
+	if (smb_hc_read(hc, ACPI_SMB_STATUS, &status.raw))
+		return 0;
+	/* Check if it is only a completion notify */
+	if (status.fields.done)
+		wake_up(&hc->wait);
+	if (!status.fields.alarm)
+		return 0;
+	mutex_lock(&hc->lock);
+	smb_hc_write(hc, ACPI_SMB_STATUS, status.raw);
+	if (hc->callback)
+		acpi_os_execute(OSL_GPE_HANDLER, acpi_smbus_callback, hc);
+	mutex_unlock(&hc->lock);
+	return 0;
+}
+
+typedef int (*acpi_ec_query_func) (void *data);
+
+extern int acpi_ec_add_query_handler(struct acpi_ec *ec, u8 query_bit,
+			      acpi_handle handle, acpi_ec_query_func func,
+			      void *data);
+
+static int acpi_smbus_hc_add(struct acpi_device *device)
+{
+	int status;
+	unsigned long val;
+	struct acpi_smb_hc *hc;
+
+	if (!device)
+		return -EINVAL;
+
+	status = acpi_evaluate_integer(device->handle, "_EC", NULL, &val);
+	if (ACPI_FAILURE(status)) {
+		printk(KERN_ERR PREFIX "error obtaining _EC.\n");
+		return -EIO;
+	}
+
+	strcpy(acpi_device_name(device), ACPI_SMB_HC_DEVICE_NAME);
+	strcpy(acpi_device_class(device), ACPI_SMB_HC_CLASS);
+
+	hc = kzalloc(sizeof(struct acpi_smb_hc), GFP_KERNEL);
+	if (!hc)
+		return -ENOMEM;
+	mutex_init(&hc->lock);
+	init_waitqueue_head(&hc->wait);
+
+	hc->ec = acpi_driver_data(device->parent);
+	hc->offset = (val >> 8) & 0xff;
+	hc->query_bit = val & 0xff;
+	acpi_driver_data(device) = hc;
+
+	acpi_ec_add_query_handler(hc->ec, hc->query_bit, NULL, smbus_alarm, hc);
+	printk(KERN_INFO PREFIX "SBS HC: EC = 0x%p, offset = 0x%0x, query_bit = 0x%0x\n",
+		hc->ec, hc->offset, hc->query_bit);
+
+	return 0;
+}
+
+extern void acpi_ec_remove_query_handler(struct acpi_ec *ec, u8 query_bit);
+
+static int acpi_smbus_hc_remove(struct acpi_device *device, int type)
+{
+	struct acpi_smb_hc *hc;
+
+	if (!device)
+		return -EINVAL;
+
+	hc = acpi_driver_data(device);
+	acpi_ec_remove_query_handler(hc->ec, hc->query_bit);
+	kfree(hc);
+	return 0;
+}
+
+static int __init acpi_smb_hc_init(void)
+{
+	int result;
+
+	result = acpi_bus_register_driver(&acpi_smb_hc_driver);
+	if (result < 0)
+		return -ENODEV;
+	return 0;
+}
+
+static void __exit acpi_smb_hc_exit(void)
+{
+	acpi_bus_unregister_driver(&acpi_smb_hc_driver);
+}
+
+module_init(acpi_smb_hc_init);
+module_exit(acpi_smb_hc_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Alexey Starikovskiy");
+MODULE_DESCRIPTION("ACPI SMBus HC driver");
diff --git a/drivers/acpi/sbshc.h b/drivers/acpi/sbshc.h
new file mode 100644
index 0000000..3bda349
--- /dev/null
+++ b/drivers/acpi/sbshc.h
@@ -0,0 +1,27 @@
+struct acpi_smb_hc;
+enum acpi_smb_protocol {
+	SMBUS_WRITE_QUICK = 2,
+	SMBUS_READ_QUICK = 3,
+	SMBUS_SEND_BYTE = 4,
+	SMBUS_RECEIVE_BYTE = 5,
+	SMBUS_WRITE_BYTE = 6,
+	SMBUS_READ_BYTE = 7,
+	SMBUS_WRITE_WORD  = 8,
+	SMBUS_READ_WORD  = 9,
+	SMBUS_WRITE_BLOCK = 0xa,
+	SMBUS_READ_BLOCK = 0xb,
+	SMBUS_PROCESS_CALL = 0xc,
+	SMBUS_BLOCK_PROCESS_CALL = 0xd,
+};
+
+static const u8 SMBUS_PEC = 0x80;
+
+typedef void (*smbus_alarm_callback)(void *context);
+
+extern int acpi_smbus_read(struct acpi_smb_hc *hc, u8 protocol, u8 address,
+	       u8 command, u8 * data);
+extern int acpi_smbus_write(struct acpi_smb_hc *hc, u8 protocol, u8 slave_address,
+		u8 command, u8 * data, u8 length);
+extern int acpi_smbus_register_callback(struct acpi_smb_hc *hc,
+			         smbus_alarm_callback callback, void *context);
+extern int acpi_smbus_unregister_callback(struct acpi_smb_hc *hc);
-- 
1.5.3.1.27.g57543
