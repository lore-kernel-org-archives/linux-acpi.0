From: Len Brown <len.brown@intel.com>
Subject: [PATCH 018/105] ACPI: sbs: use EC rather than I2C
Date: Sun, 29 Apr 2007 00:50:18 -0400
Message-ID: <11778223212414-git-send-email-len.brown@intel.com>
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
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:58359 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754604AbXD2EwC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 29 Apr 2007 00:52:02 -0400
In-Reply-To: <11778223201940-git-send-email-len.brown@intel.com>
Message-Id: <6d15702cc07503b74494dc4f1ddb15f354987b14.1177822058.git.len.brown@intel.com>
In-Reply-To: <ac122bb64b0d51f0512185d3522a75f3f3a80bc9.1177822058.git.len.brown@intel.com>
References: <ac122bb64b0d51f0512185d3522a75f3f3a80bc9.1177822058.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Vladimir Lebedev <vladimir.p.lebedev@intel.com>, Len Brown <len.brown@intel.com>

From: Vladimir Lebedev <vladimir.p.lebedev@intel.com>

SBS is based on EC function(ec_read/ec_write).
Not needed using of I2C structures/functions ... is removed.
SBS does not depend on I2C now.

Signed-off-by: Vladimir Lebedev <vladimir.p.lebedev@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/sbs.c |  565 ++++++++++++++++++++++++++--------------------------
 1 files changed, 287 insertions(+), 278 deletions(-)

diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
index 59640d9..eab5c68 100644
--- a/drivers/acpi/sbs.c
+++ b/drivers/acpi/sbs.c
@@ -30,30 +30,9 @@
 #include <linux/seq_file.h>
 #include <asm/uaccess.h>
 #include <linux/acpi.h>
-#include <linux/i2c.h>
+#include <linux/timer.h>
 #include <linux/delay.h>
 
-#include "i2c_ec.h"
-
-#define	DEF_CAPACITY_UNIT	3
-#define	MAH_CAPACITY_UNIT	1
-#define	MWH_CAPACITY_UNIT	2
-#define	CAPACITY_UNIT		DEF_CAPACITY_UNIT
-
-#define	REQUEST_UPDATE_MODE	1
-#define	QUEUE_UPDATE_MODE	2
-
-#define	DATA_TYPE_COMMON	0
-#define	DATA_TYPE_INFO		1
-#define	DATA_TYPE_STATE		2
-#define	DATA_TYPE_ALARM		3
-#define	DATA_TYPE_AC_STATE	4
-
-extern struct proc_dir_entry *acpi_lock_ac_dir(void);
-extern struct proc_dir_entry *acpi_lock_battery_dir(void);
-extern void acpi_unlock_ac_dir(struct proc_dir_entry *acpi_ac_dir);
-extern void acpi_unlock_battery_dir(struct proc_dir_entry *acpi_battery_dir);
-
 #define ACPI_SBS_COMPONENT		0x00080000
 #define ACPI_SBS_CLASS			"sbs"
 #define ACPI_AC_CLASS			"ac_adapter"
@@ -74,15 +53,62 @@ extern void acpi_unlock_battery_dir(struct proc_dir_entry *acpi_battery_dir);
 
 #define _COMPONENT			ACPI_SBS_COMPONENT
 
-#define	MAX_SBS_BAT			4
-#define	MAX_SMBUS_ERR			1
-
 ACPI_MODULE_NAME("sbs");
 
 MODULE_AUTHOR("Rich Townsend");
 MODULE_DESCRIPTION("Smart Battery System ACPI interface driver");
 MODULE_LICENSE("GPL");
 
+#define	xmsleep(t)	msleep(t)
+
+#define ACPI_EC_SMB_PRTCL	0x00	/* protocol, PEC */
+
+#define ACPI_EC_SMB_STS		0x01	/* status */
+#define ACPI_EC_SMB_ADDR	0x02	/* address */
+#define ACPI_EC_SMB_CMD		0x03	/* command */
+#define ACPI_EC_SMB_DATA	0x04	/* 32 data registers */
+#define ACPI_EC_SMB_BCNT	0x24	/* number of data bytes */
+
+#define ACPI_EC_SMB_STS_DONE	0x80
+#define ACPI_EC_SMB_STS_STATUS	0x1f
+
+#define ACPI_EC_SMB_PRTCL_WRITE		0x00
+#define ACPI_EC_SMB_PRTCL_READ		0x01
+#define ACPI_EC_SMB_PRTCL_WORD_DATA	0x08
+#define ACPI_EC_SMB_PRTCL_BLOCK_DATA	0x0a
+
+#define ACPI_EC_SMB_TRANSACTION_SLEEP	1
+#define ACPI_EC_SMB_ACCESS_SLEEP1	1
+#define ACPI_EC_SMB_ACCESS_SLEEP2	10
+
+#define	DEF_CAPACITY_UNIT	3
+#define	MAH_CAPACITY_UNIT	1
+#define	MWH_CAPACITY_UNIT	2
+#define	CAPACITY_UNIT		DEF_CAPACITY_UNIT
+
+#define	REQUEST_UPDATE_MODE	1
+#define	QUEUE_UPDATE_MODE	2
+
+#define	DATA_TYPE_COMMON	0
+#define	DATA_TYPE_INFO		1
+#define	DATA_TYPE_STATE		2
+#define	DATA_TYPE_ALARM		3
+#define	DATA_TYPE_AC_STATE	4
+
+extern struct proc_dir_entry *acpi_lock_ac_dir(void);
+extern struct proc_dir_entry *acpi_lock_battery_dir(void);
+extern void acpi_unlock_ac_dir(struct proc_dir_entry *acpi_ac_dir);
+extern void acpi_unlock_battery_dir(struct proc_dir_entry *acpi_battery_dir);
+
+#define	MAX_SBS_BAT			4
+#define ACPI_SBS_BLOCK_MAX		32
+
+#define ACPI_SBS_SMBUS_READ		1
+#define ACPI_SBS_SMBUS_WRITE		2
+
+#define ACPI_SBS_WORD_DATA		1
+#define ACPI_SBS_BLOCK_DATA		2
+
 static struct semaphore sbs_sem;
 
 #define	UPDATE_MODE		QUEUE_UPDATE_MODE
@@ -105,7 +131,6 @@ module_param(update_time2, int, 0);
 
 static int acpi_sbs_add(struct acpi_device *device);
 static int acpi_sbs_remove(struct acpi_device *device, int type);
-static void acpi_battery_smbus_err_handler(struct acpi_ec_smbus *smbus);
 static void acpi_sbs_update_queue(void *data);
 
 static struct acpi_driver acpi_sbs_driver = {
@@ -126,9 +151,9 @@ struct acpi_battery_info {
 	int vscale;
 	int ipscale;
 	s16 serial_number;
-	char manufacturer_name[I2C_SMBUS_BLOCK_MAX + 3];
-	char device_name[I2C_SMBUS_BLOCK_MAX + 3];
-	char device_chemistry[I2C_SMBUS_BLOCK_MAX + 3];
+	char manufacturer_name[ACPI_SBS_BLOCK_MAX + 3];
+	char device_name[ACPI_SBS_BLOCK_MAX + 3];
+	char device_chemistry[ACPI_SBS_BLOCK_MAX + 3];
 };
 
 struct acpi_battery_state {
@@ -158,8 +183,8 @@ struct acpi_battery {
 
 struct acpi_sbs {
 	acpi_handle handle;
+	int base;
 	struct acpi_device *device;
-	struct acpi_ec_smbus *smbus;
 	int sbsm_present;
 	int sbsm_batteries_supported;
 	int ac_present;
@@ -172,6 +197,14 @@ struct acpi_sbs {
 	struct timer_list update_timer;
 };
 
+union sbs_rw_data {
+	u16 word;
+	u8 block[ACPI_SBS_BLOCK_MAX + 2];
+};
+
+static int acpi_ec_sbs_access(struct acpi_sbs *sbs, u16 addr,
+			      char read_write, u8 command, int size,
+			      union sbs_rw_data *data);
 static void acpi_update_delay(struct acpi_sbs *sbs);
 static int acpi_sbs_update_run(struct acpi_sbs *sbs, int data_type);
 
@@ -179,155 +212,172 @@ static int acpi_sbs_update_run(struct acpi_sbs *sbs, int data_type);
                                SMBus Communication
    -------------------------------------------------------------------------- */
 
-static void acpi_battery_smbus_err_handler(struct acpi_ec_smbus *smbus)
+static int acpi_ec_sbs_read(struct acpi_sbs *sbs, u8 address, u8 * data)
 {
-	union i2c_smbus_data data;
-	int result = 0;
-	char *err_str;
-	int err_number;
+	u8 val;
+	int err;
 
-	data.word = 0;
+	err = ec_read(sbs->base + address, &val);
+	if (!err) {
+		*data = val;
+	}
+	xmsleep(ACPI_EC_SMB_TRANSACTION_SLEEP);
+	return (err);
+}
 
-	result = smbus->adapter.algo->
-	    smbus_xfer(&smbus->adapter,
-		       ACPI_SB_SMBUS_ADDR,
-		       0, I2C_SMBUS_READ, 0x16, I2C_SMBUS_BLOCK_DATA, &data);
+static int acpi_ec_sbs_write(struct acpi_sbs *sbs, u8 address, u8 data)
+{
+	int err;
 
-	err_number = (data.word & 0x000f);
+	err = ec_write(sbs->base + address, data);
+	return (err);
+}
 
-	switch (data.word & 0x000f) {
-	case 0x0000:
-		err_str = "unexpected bus error";
-		break;
-	case 0x0001:
-		err_str = "busy";
-		break;
-	case 0x0002:
-		err_str = "reserved command";
-		break;
-	case 0x0003:
-		err_str = "unsupported command";
-		break;
-	case 0x0004:
-		err_str = "access denied";
+static int
+acpi_ec_sbs_access(struct acpi_sbs *sbs, u16 addr,
+		   char read_write, u8 command, int size,
+		   union sbs_rw_data *data)
+{
+	unsigned char protocol, len = 0, temp[2] = { 0, 0 };
+	int i;
+
+	if (read_write == ACPI_SBS_SMBUS_READ) {
+		protocol = ACPI_EC_SMB_PRTCL_READ;
+	} else {
+		protocol = ACPI_EC_SMB_PRTCL_WRITE;
+	}
+
+	switch (size) {
+
+	case ACPI_SBS_WORD_DATA:
+		acpi_ec_sbs_write(sbs, ACPI_EC_SMB_CMD, command);
+		if (read_write == ACPI_SBS_SMBUS_WRITE) {
+			acpi_ec_sbs_write(sbs, ACPI_EC_SMB_DATA, data->word);
+			acpi_ec_sbs_write(sbs, ACPI_EC_SMB_DATA + 1,
+					  data->word >> 8);
+		}
+		protocol |= ACPI_EC_SMB_PRTCL_WORD_DATA;
 		break;
-	case 0x0005:
-		err_str = "overflow/underflow";
+	case ACPI_SBS_BLOCK_DATA:
+		acpi_ec_sbs_write(sbs, ACPI_EC_SMB_CMD, command);
+		if (read_write == ACPI_SBS_SMBUS_WRITE) {
+			len = min_t(u8, data->block[0], 32);
+			acpi_ec_sbs_write(sbs, ACPI_EC_SMB_BCNT, len);
+			for (i = 0; i < len; i++)
+				acpi_ec_sbs_write(sbs, ACPI_EC_SMB_DATA + i,
+						  data->block[i + 1]);
+		}
+		protocol |= ACPI_EC_SMB_PRTCL_BLOCK_DATA;
 		break;
-	case 0x0006:
-		err_str = "bad size";
+	default:
+		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
+				"unsupported transaction %d\n", size));
+		return (-1);
+	}
+
+	acpi_ec_sbs_write(sbs, ACPI_EC_SMB_ADDR, addr << 1);
+	acpi_ec_sbs_write(sbs, ACPI_EC_SMB_PRTCL, protocol);
+
+	acpi_ec_sbs_read(sbs, ACPI_EC_SMB_STS, temp);
+
+	if (~temp[0] & ACPI_EC_SMB_STS_DONE) {
+		xmsleep(ACPI_EC_SMB_ACCESS_SLEEP1);
+		acpi_ec_sbs_read(sbs, ACPI_EC_SMB_STS, temp);
+	}
+	if (~temp[0] & ACPI_EC_SMB_STS_DONE) {
+		xmsleep(ACPI_EC_SMB_ACCESS_SLEEP2);
+		acpi_ec_sbs_read(sbs, ACPI_EC_SMB_STS, temp);
+	}
+	if ((~temp[0] & ACPI_EC_SMB_STS_DONE)
+	    || (temp[0] & ACPI_EC_SMB_STS_STATUS)) {
+		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
+				"transaction %d error\n", size));
+		return (-1);
+	}
+
+	if (read_write == ACPI_SBS_SMBUS_WRITE) {
+		return (0);
+	}
+
+	switch (size) {
+
+	case ACPI_SBS_WORD_DATA:
+		acpi_ec_sbs_read(sbs, ACPI_EC_SMB_DATA, temp);
+		acpi_ec_sbs_read(sbs, ACPI_EC_SMB_DATA + 1, temp + 1);
+		data->word = (temp[1] << 8) | temp[0];
 		break;
-	case 0x0007:
-		err_str = "unknown error";
+
+	case ACPI_SBS_BLOCK_DATA:
+		len = 0;
+		acpi_ec_sbs_read(sbs, ACPI_EC_SMB_BCNT, &len);
+		len = min_t(u8, len, 32);
+		for (i = 0; i < len; i++)
+			acpi_ec_sbs_read(sbs, ACPI_EC_SMB_DATA + i,
+					 data->block + i + 1);
+		data->block[0] = len;
 		break;
 	default:
-		err_str = "unrecognized error";
+		ACPI_EXCEPTION((AE_INFO, AE_ERROR,
+				"unsupported transaction %d\n", size));
+		return (-1);
 	}
-	ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-			  "%s: ret %i, err %i\n", err_str, result, err_number));
+
+	return (0);
 }
 
 static int
-acpi_sbs_smbus_read_word(struct acpi_ec_smbus *smbus, int addr, int func,
-			 u16 * word,
-			 void (*err_handler) (struct acpi_ec_smbus * smbus))
+acpi_sbs_read_word(struct acpi_sbs *sbs, int addr, int func, u16 * word)
 {
-	union i2c_smbus_data data;
+	union sbs_rw_data data;
 	int result = 0;
-	int i;
 
-	if (err_handler == NULL) {
-		err_handler = acpi_battery_smbus_err_handler;
-	}
-
-	for (i = 0; i < MAX_SMBUS_ERR; i++) {
-		result =
-		    smbus->adapter.algo->smbus_xfer(&smbus->adapter, addr, 0,
-						    I2C_SMBUS_READ, func,
-						    I2C_SMBUS_WORD_DATA, &data);
-		if (result) {
-			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-					  "try %i: smbus->adapter.algo->smbus_xfer() failed\n",
-					  i));
-			if (err_handler) {
-				err_handler(smbus);
-			}
-		} else {
-			*word = data.word;
-			break;
-		}
+	result = acpi_ec_sbs_access(sbs, addr,
+				    ACPI_SBS_SMBUS_READ, func,
+				    ACPI_SBS_WORD_DATA, &data);
+	if (result) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+				  "acpi_ec_sbs_access() failed\n"));
+	} else {
+		*word = data.word;
 	}
 
 	return result;
 }
 
 static int
-acpi_sbs_smbus_read_str(struct acpi_ec_smbus *smbus, int addr, int func,
-			char *str,
-			void (*err_handler) (struct acpi_ec_smbus * smbus))
+acpi_sbs_read_str(struct acpi_sbs *sbs, int addr, int func, char *str)
 {
-	union i2c_smbus_data data;
+	union sbs_rw_data data;
 	int result = 0;
-	int i;
-
-	if (err_handler == NULL) {
-		err_handler = acpi_battery_smbus_err_handler;
-	}
 
-	for (i = 0; i < MAX_SMBUS_ERR; i++) {
-		result =
-		    smbus->adapter.algo->smbus_xfer(&smbus->adapter, addr, 0,
-						    I2C_SMBUS_READ, func,
-						    I2C_SMBUS_BLOCK_DATA,
-						    &data);
-		if (result) {
-			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-					  "try %i: smbus->adapter.algo->smbus_xfer() failed\n",
-					  i));
-			if (err_handler) {
-				err_handler(smbus);
-			}
-		} else {
-			strncpy(str, (const char *)data.block + 1,
-				data.block[0]);
-			str[data.block[0]] = 0;
-			break;
-		}
+	result = acpi_ec_sbs_access(sbs, addr,
+				    ACPI_SBS_SMBUS_READ, func,
+				    ACPI_SBS_BLOCK_DATA, &data);
+	if (result) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+				  "acpi_ec_sbs_access() failed\n"));
+	} else {
+		strncpy(str, (const char *)data.block + 1, data.block[0]);
+		str[data.block[0]] = 0;
 	}
 
 	return result;
 }
 
 static int
-acpi_sbs_smbus_write_word(struct acpi_ec_smbus *smbus, int addr, int func,
-			  int word,
-			  void (*err_handler) (struct acpi_ec_smbus * smbus))
+acpi_sbs_write_word(struct acpi_sbs *sbs, int addr, int func, int word)
 {
-	union i2c_smbus_data data;
+	union sbs_rw_data data;
 	int result = 0;
-	int i;
-
-	if (err_handler == NULL) {
-		err_handler = acpi_battery_smbus_err_handler;
-	}
 
 	data.word = word;
 
-	for (i = 0; i < MAX_SMBUS_ERR; i++) {
-		result =
-		    smbus->adapter.algo->smbus_xfer(&smbus->adapter, addr, 0,
-						    I2C_SMBUS_WRITE, func,
-						    I2C_SMBUS_WORD_DATA, &data);
-		if (result) {
-			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-					  "try %i: smbus->adapter.algo"
-					  "->smbus_xfer() failed\n", i));
-			if (err_handler) {
-				err_handler(smbus);
-			}
-		} else {
-			break;
-		}
+	result = acpi_ec_sbs_access(sbs, addr,
+				    ACPI_SBS_SMBUS_WRITE, func,
+				    ACPI_SBS_WORD_DATA, &data);
+	if (result) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+				  "acpi_ec_sbs_access() failed\n"));
 	}
 
 	return result;
@@ -366,12 +416,11 @@ static int acpi_battery_get_present(struct acpi_battery *battery)
 	int result = 0;
 	int is_present = 0;
 
-	result = acpi_sbs_smbus_read_word(battery->sbs->smbus,
-					  ACPI_SBSM_SMBUS_ADDR, 0x01,
-					  &state, NULL);
+	result = acpi_sbs_read_word(battery->sbs,
+				    ACPI_SBSM_SMBUS_ADDR, 0x01, &state);
 	if (result) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "acpi_sbs_smbus_read_word() failed"));
+				  "acpi_sbs_read_word() failed"));
 	}
 	if (!result) {
 		is_present = (state & 0x000f) & (1 << battery->id);
@@ -393,7 +442,7 @@ static int acpi_ac_is_present(struct acpi_sbs *sbs)
 
 static int acpi_battery_select(struct acpi_battery *battery)
 {
-	struct acpi_ec_smbus *smbus = battery->sbs->smbus;
+	struct acpi_sbs *sbs = battery->sbs;
 	int result = 0;
 	s16 state;
 	int foo;
@@ -405,21 +454,19 @@ static int acpi_battery_select(struct acpi_battery *battery)
 		 * it causes charging to halt on SBSELs */
 
 		result =
-		    acpi_sbs_smbus_read_word(smbus, ACPI_SBSM_SMBUS_ADDR, 0x01,
-					     &state, NULL);
+		    acpi_sbs_read_word(sbs, ACPI_SBSM_SMBUS_ADDR, 0x01, &state);
 		if (result) {
 			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-					  "acpi_sbs_smbus_read_word() failed\n"));
+					  "acpi_sbs_read_word() failed\n"));
 			goto end;
 		}
 
 		foo = (state & 0x0fff) | (1 << (battery->id + 12));
 		result =
-		    acpi_sbs_smbus_write_word(smbus, ACPI_SBSM_SMBUS_ADDR, 0x01,
-					      foo, NULL);
+		    acpi_sbs_write_word(sbs, ACPI_SBSM_SMBUS_ADDR, 0x01, foo);
 		if (result) {
 			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-					  "acpi_sbs_smbus_write_word() failed\n"));
+					  "acpi_sbs_write_word() failed\n"));
 			goto end;
 		}
 	}
@@ -430,15 +477,14 @@ static int acpi_battery_select(struct acpi_battery *battery)
 
 static int acpi_sbsm_get_info(struct acpi_sbs *sbs)
 {
-	struct acpi_ec_smbus *smbus = sbs->smbus;
 	int result = 0;
 	s16 battery_system_info;
 
-	result = acpi_sbs_smbus_read_word(smbus, ACPI_SBSM_SMBUS_ADDR, 0x04,
-					  &battery_system_info, NULL);
+	result = acpi_sbs_read_word(sbs, ACPI_SBSM_SMBUS_ADDR, 0x04,
+				    &battery_system_info);
 	if (result) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "acpi_sbs_smbus_read_word() failed\n"));
+				  "acpi_sbs_read_word() failed\n"));
 		goto end;
 	}
 
@@ -451,53 +497,48 @@ static int acpi_sbsm_get_info(struct acpi_sbs *sbs)
 
 static int acpi_battery_get_info(struct acpi_battery *battery)
 {
-	struct acpi_ec_smbus *smbus = battery->sbs->smbus;
+	struct acpi_sbs *sbs = battery->sbs;
 	int result = 0;
 	s16 battery_mode;
 	s16 specification_info;
 
-	result = acpi_sbs_smbus_read_word(smbus, ACPI_SB_SMBUS_ADDR, 0x03,
-					  &battery_mode,
-					  &acpi_battery_smbus_err_handler);
+	result = acpi_sbs_read_word(sbs, ACPI_SB_SMBUS_ADDR, 0x03,
+				    &battery_mode);
 	if (result) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "acpi_sbs_smbus_read_word() failed\n"));
+				  "acpi_sbs_read_word() failed\n"));
 		goto end;
 	}
 	battery->info.capacity_mode = (battery_mode & 0x8000) >> 15;
 
-	result = acpi_sbs_smbus_read_word(smbus, ACPI_SB_SMBUS_ADDR, 0x10,
-					  &battery->info.full_charge_capacity,
-					  &acpi_battery_smbus_err_handler);
+	result = acpi_sbs_read_word(sbs, ACPI_SB_SMBUS_ADDR, 0x10,
+				    &battery->info.full_charge_capacity);
 	if (result) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "acpi_sbs_smbus_read_word() failed\n"));
+				  "acpi_sbs_read_word() failed\n"));
 		goto end;
 	}
 
-	result = acpi_sbs_smbus_read_word(smbus, ACPI_SB_SMBUS_ADDR, 0x18,
-					  &battery->info.design_capacity,
-					  &acpi_battery_smbus_err_handler);
+	result = acpi_sbs_read_word(sbs, ACPI_SB_SMBUS_ADDR, 0x18,
+				    &battery->info.design_capacity);
 
 	if (result) {
 		goto end;
 	}
 
-	result = acpi_sbs_smbus_read_word(smbus, ACPI_SB_SMBUS_ADDR, 0x19,
-					  &battery->info.design_voltage,
-					  &acpi_battery_smbus_err_handler);
+	result = acpi_sbs_read_word(sbs, ACPI_SB_SMBUS_ADDR, 0x19,
+				    &battery->info.design_voltage);
 	if (result) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "acpi_sbs_smbus_read_word() failed\n"));
+				  "acpi_sbs_read_word() failed\n"));
 		goto end;
 	}
 
-	result = acpi_sbs_smbus_read_word(smbus, ACPI_SB_SMBUS_ADDR, 0x1a,
-					  &specification_info,
-					  &acpi_battery_smbus_err_handler);
+	result = acpi_sbs_read_word(sbs, ACPI_SB_SMBUS_ADDR, 0x1a,
+				    &specification_info);
 	if (result) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "acpi_sbs_smbus_read_word() failed\n"));
+				  "acpi_sbs_read_word() failed\n"));
 		goto end;
 	}
 
@@ -529,37 +570,33 @@ static int acpi_battery_get_info(struct acpi_battery *battery)
 		battery->info.ipscale = 1;
 	}
 
-	result = acpi_sbs_smbus_read_word(smbus, ACPI_SB_SMBUS_ADDR, 0x1c,
-					  &battery->info.serial_number,
-					  &acpi_battery_smbus_err_handler);
+	result = acpi_sbs_read_word(sbs, ACPI_SB_SMBUS_ADDR, 0x1c,
+				    &battery->info.serial_number);
 	if (result) {
 		goto end;
 	}
 
-	result = acpi_sbs_smbus_read_str(smbus, ACPI_SB_SMBUS_ADDR, 0x20,
-					 battery->info.manufacturer_name,
-					 &acpi_battery_smbus_err_handler);
+	result = acpi_sbs_read_str(sbs, ACPI_SB_SMBUS_ADDR, 0x20,
+				   battery->info.manufacturer_name);
 	if (result) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "acpi_sbs_smbus_read_str() failed\n"));
+				  "acpi_sbs_read_str() failed\n"));
 		goto end;
 	}
 
-	result = acpi_sbs_smbus_read_str(smbus, ACPI_SB_SMBUS_ADDR, 0x21,
-					 battery->info.device_name,
-					 &acpi_battery_smbus_err_handler);
+	result = acpi_sbs_read_str(sbs, ACPI_SB_SMBUS_ADDR, 0x21,
+				   battery->info.device_name);
 	if (result) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "acpi_sbs_smbus_read_str() failed\n"));
+				  "acpi_sbs_read_str() failed\n"));
 		goto end;
 	}
 
-	result = acpi_sbs_smbus_read_str(smbus, ACPI_SB_SMBUS_ADDR, 0x22,
-					 battery->info.device_chemistry,
-					 &acpi_battery_smbus_err_handler);
+	result = acpi_sbs_read_str(sbs, ACPI_SB_SMBUS_ADDR, 0x22,
+				   battery->info.device_chemistry);
 	if (result) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "acpi_sbs_smbus_read_str() failed\n"));
+				  "acpi_sbs_read_str() failed\n"));
 		goto end;
 	}
 
@@ -579,66 +616,60 @@ static void acpi_update_delay(struct acpi_sbs *sbs)
 
 static int acpi_battery_get_state(struct acpi_battery *battery)
 {
-	struct acpi_ec_smbus *smbus = battery->sbs->smbus;
+	struct acpi_sbs *sbs = battery->sbs;
 	int result = 0;
 
 	acpi_update_delay(battery->sbs);
-	result = acpi_sbs_smbus_read_word(smbus, ACPI_SB_SMBUS_ADDR, 0x09,
-					  &battery->state.voltage,
-					  &acpi_battery_smbus_err_handler);
+	result = acpi_sbs_read_word(sbs, ACPI_SB_SMBUS_ADDR, 0x09,
+				    &battery->state.voltage);
 	if (result) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "acpi_sbs_smbus_read_word() failed\n"));
+				  "acpi_sbs_read_word() failed\n"));
 		goto end;
 	}
 
 	acpi_update_delay(battery->sbs);
-	result = acpi_sbs_smbus_read_word(smbus, ACPI_SB_SMBUS_ADDR, 0x0a,
-					  &battery->state.amperage,
-					  &acpi_battery_smbus_err_handler);
+	result = acpi_sbs_read_word(sbs, ACPI_SB_SMBUS_ADDR, 0x0a,
+				    &battery->state.amperage);
 	if (result) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "acpi_sbs_smbus_read_word() failed\n"));
+				  "acpi_sbs_read_word() failed\n"));
 		goto end;
 	}
 
 	acpi_update_delay(battery->sbs);
-	result = acpi_sbs_smbus_read_word(smbus, ACPI_SB_SMBUS_ADDR, 0x0f,
-					  &battery->state.remaining_capacity,
-					  &acpi_battery_smbus_err_handler);
+	result = acpi_sbs_read_word(sbs, ACPI_SB_SMBUS_ADDR, 0x0f,
+				    &battery->state.remaining_capacity);
 	if (result) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "acpi_sbs_smbus_read_word() failed\n"));
+				  "acpi_sbs_read_word() failed\n"));
 		goto end;
 	}
 
 	acpi_update_delay(battery->sbs);
-	result = acpi_sbs_smbus_read_word(smbus, ACPI_SB_SMBUS_ADDR, 0x12,
-					  &battery->state.average_time_to_empty,
-					  &acpi_battery_smbus_err_handler);
+	result = acpi_sbs_read_word(sbs, ACPI_SB_SMBUS_ADDR, 0x12,
+				    &battery->state.average_time_to_empty);
 	if (result) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "acpi_sbs_smbus_read_word() failed\n"));
+				  "acpi_sbs_read_word() failed\n"));
 		goto end;
 	}
 
 	acpi_update_delay(battery->sbs);
-	result = acpi_sbs_smbus_read_word(smbus, ACPI_SB_SMBUS_ADDR, 0x13,
-					  &battery->state.average_time_to_full,
-					  &acpi_battery_smbus_err_handler);
+	result = acpi_sbs_read_word(sbs, ACPI_SB_SMBUS_ADDR, 0x13,
+				    &battery->state.average_time_to_full);
 	if (result) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "acpi_sbs_smbus_read_word() failed\n"));
+				  "acpi_sbs_read_word() failed\n"));
 		goto end;
 	}
 
 	acpi_update_delay(battery->sbs);
-	result = acpi_sbs_smbus_read_word(smbus, ACPI_SB_SMBUS_ADDR, 0x16,
-					  &battery->state.battery_status,
-					  &acpi_battery_smbus_err_handler);
+	result = acpi_sbs_read_word(sbs, ACPI_SB_SMBUS_ADDR, 0x16,
+				    &battery->state.battery_status);
 	if (result) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "acpi_sbs_smbus_read_word() failed\n"));
+				  "acpi_sbs_read_word() failed\n"));
 		goto end;
 	}
 
@@ -650,15 +681,14 @@ static int acpi_battery_get_state(struct acpi_battery *battery)
 
 static int acpi_battery_get_alarm(struct acpi_battery *battery)
 {
-	struct acpi_ec_smbus *smbus = battery->sbs->smbus;
+	struct acpi_sbs *sbs = battery->sbs;
 	int result = 0;
 
-	result = acpi_sbs_smbus_read_word(smbus, ACPI_SB_SMBUS_ADDR, 0x01,
-					  &battery->alarm.remaining_capacity,
-					  &acpi_battery_smbus_err_handler);
+	result = acpi_sbs_read_word(sbs, ACPI_SB_SMBUS_ADDR, 0x01,
+				    &battery->alarm.remaining_capacity);
 	if (result) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "acpi_sbs_smbus_read_word() failed\n"));
+				  "acpi_sbs_read_word() failed\n"));
 		goto end;
 	}
 
@@ -672,7 +702,7 @@ static int acpi_battery_get_alarm(struct acpi_battery *battery)
 static int acpi_battery_set_alarm(struct acpi_battery *battery,
 				  unsigned long alarm)
 {
-	struct acpi_ec_smbus *smbus = battery->sbs->smbus;
+	struct acpi_sbs *sbs = battery->sbs;
 	int result = 0;
 	s16 battery_mode;
 	int foo;
@@ -688,33 +718,29 @@ static int acpi_battery_set_alarm(struct acpi_battery *battery,
 
 	if (alarm > 0) {
 		result =
-		    acpi_sbs_smbus_read_word(smbus, ACPI_SB_SMBUS_ADDR, 0x03,
-					     &battery_mode,
-					     &acpi_battery_smbus_err_handler);
+		    acpi_sbs_read_word(sbs, ACPI_SB_SMBUS_ADDR, 0x03,
+				       &battery_mode);
 		if (result) {
 			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-					  "acpi_sbs_smbus_read_word() failed\n"));
+					  "acpi_sbs_read_word() failed\n"));
 			goto end;
 		}
 
 		result =
-		    acpi_sbs_smbus_write_word(smbus, ACPI_SB_SMBUS_ADDR, 0x01,
-					      battery_mode & 0xbfff,
-					      &acpi_battery_smbus_err_handler);
+		    acpi_sbs_write_word(sbs, ACPI_SB_SMBUS_ADDR, 0x01,
+					battery_mode & 0xbfff);
 		if (result) {
 			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-					  "acpi_sbs_smbus_write_word() failed\n"));
+					  "acpi_sbs_write_word() failed\n"));
 			goto end;
 		}
 	}
 
 	foo = alarm / (battery->info.capacity_mode ? 10 : 1);
-	result = acpi_sbs_smbus_write_word(smbus, ACPI_SB_SMBUS_ADDR, 0x01,
-					   foo,
-					   &acpi_battery_smbus_err_handler);
+	result = acpi_sbs_write_word(sbs, ACPI_SB_SMBUS_ADDR, 0x01, foo);
 	if (result) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "acpi_sbs_smbus_write_word() failed\n"));
+				  "acpi_sbs_write_word() failed\n"));
 		goto end;
 	}
 
@@ -732,12 +758,11 @@ static int acpi_battery_set_mode(struct acpi_battery *battery)
 		goto end;
 	}
 
-	result = acpi_sbs_smbus_read_word(battery->sbs->smbus,
-					  ACPI_SB_SMBUS_ADDR, 0x03,
-					  &battery_mode, NULL);
+	result = acpi_sbs_read_word(battery->sbs,
+				    ACPI_SB_SMBUS_ADDR, 0x03, &battery_mode);
 	if (result) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "acpi_sbs_smbus_read_word() failed\n"));
+				  "acpi_sbs_read_word() failed\n"));
 		goto end;
 	}
 
@@ -746,21 +771,19 @@ static int acpi_battery_set_mode(struct acpi_battery *battery)
 	} else {
 		battery_mode |= 0x8000;
 	}
-	result = acpi_sbs_smbus_write_word(battery->sbs->smbus,
-					   ACPI_SB_SMBUS_ADDR, 0x03,
-					   battery_mode, NULL);
+	result = acpi_sbs_write_word(battery->sbs,
+				     ACPI_SB_SMBUS_ADDR, 0x03, battery_mode);
 	if (result) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "acpi_sbs_smbus_write_word() failed\n"));
+				  "acpi_sbs_write_word() failed\n"));
 		goto end;
 	}
 
-	result = acpi_sbs_smbus_read_word(battery->sbs->smbus,
-					  ACPI_SB_SMBUS_ADDR, 0x03,
-					  &battery_mode, NULL);
+	result = acpi_sbs_read_word(battery->sbs,
+				    ACPI_SB_SMBUS_ADDR, 0x03, &battery_mode);
 	if (result) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "acpi_sbs_smbus_read_word() failed\n"));
+				  "acpi_sbs_read_word() failed\n"));
 		goto end;
 	}
 
@@ -813,16 +836,15 @@ static int acpi_battery_init(struct acpi_battery *battery)
 
 static int acpi_ac_get_present(struct acpi_sbs *sbs)
 {
-	struct acpi_ec_smbus *smbus = sbs->smbus;
 	int result = 0;
 	s16 charger_status;
 
-	result = acpi_sbs_smbus_read_word(smbus, ACPI_SBC_SMBUS_ADDR, 0x13,
-					  &charger_status, NULL);
+	result = acpi_sbs_read_word(sbs, ACPI_SBC_SMBUS_ADDR, 0x13,
+				    &charger_status);
 
 	if (result) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "acpi_sbs_smbus_read_word() failed\n"));
+				  "acpi_sbs_read_word() failed\n"));
 		goto end;
 	}
 
@@ -1567,38 +1589,27 @@ static void acpi_sbs_update_queue(void *data)
 static int acpi_sbs_add(struct acpi_device *device)
 {
 	struct acpi_sbs *sbs = NULL;
-	struct acpi_ec_hc *ec_hc = NULL;
-	int result, remove_result = 0;
+	int result;
 	unsigned long sbs_obj;
-	int id, cnt;
+	int id;
 	acpi_status status = AE_OK;
+	unsigned long val;
+
+	status =
+	    acpi_evaluate_integer(device->parent->handle, "_EC", NULL, &val);
+	if (ACPI_FAILURE(status)) {
+		ACPI_DEBUG_PRINT((ACPI_DB_WARN, "Error obtaining _EC\n"));
+		return -EIO;
+	}
 
 	sbs = kzalloc(sizeof(struct acpi_sbs), GFP_KERNEL);
 	if (!sbs) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "kmalloc() failed\n"));
 		return -ENOMEM;
 	}
-
-	cnt = 0;
-	while (cnt < 10) {
-		cnt++;
-		ec_hc = acpi_get_ec_hc(device);
-		if (ec_hc) {
-			break;
-		}
-		msleep(1000);
-	}
-
-	if (!ec_hc) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "acpi_get_ec_hc() failed: "
-				  "NO driver found for EC HC SMBus\n"));
-		result = -ENODEV;
-		goto end;
-	}
+	sbs->base = (val & 0xff00ull) >> 8;
 
 	sbs->device = device;
-	sbs->smbus = ec_hc->smbus;
 
 	strcpy(acpi_device_name(device), ACPI_SBS_DEVICE_NAME);
 	strcpy(acpi_device_class(device), ACPI_SBS_CLASS);
@@ -1669,11 +1680,7 @@ static int acpi_sbs_add(struct acpi_device *device)
 
       end:
 	if (result) {
-		remove_result = acpi_sbs_remove(device, 0);
-		if (remove_result) {
-			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-					  "acpi_sbs_remove() failed\n"));
-		}
+		acpi_sbs_remove(device, 0);
 	}
 
 	return result;
@@ -1707,6 +1714,8 @@ int acpi_sbs_remove(struct acpi_device *device, int type)
 
 	acpi_ac_remove(sbs);
 
+	acpi_driver_data(device) = NULL;
+
 	kfree(sbs);
 
 	return 0;
-- 
1.5.2.rc0.34.gda94
