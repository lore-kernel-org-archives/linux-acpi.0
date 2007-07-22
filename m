From: Len Brown <len.brown@intel.com>
Subject: [PATCH 57/77] ACPI: thinkpad-acpi: store ThinkPad model information
Date: Sun, 22 Jul 2007 05:14:42 -0400
Message-ID: <11850957621605-git-send-email-len.brown@intel.com>
References: <11850957022956-git-send-email-len.brown@intel.com>
 <11850957033938-git-send-email-len.brown@intel.com>
 <11850957043270-git-send-email-len.brown@intel.com>
 <11850957053842-git-send-email-len.brown@intel.com>
 <11850957062754-git-send-email-len.brown@intel.com>
 <11850957073494-git-send-email-len.brown@intel.com>
 <1185095708928-git-send-email-len.brown@intel.com>
 <11850957093360-git-send-email-len.brown@intel.com>
 <11850957102641-git-send-email-len.brown@intel.com>
 <11850957111797-git-send-email-len.brown@intel.com>
 <11850957123807-git-send-email-len.brown@intel.com>
 <11850957131802-git-send-email-len.brown@intel.com>
 <1185095714699-git-send-email-len.brown@intel.com>
 <1185095715506-git-send-email-len.brown@intel.com>
 <11850957162801-git-send-email-len.brown@intel.com>
 <11850957173842-git-send-email-len.brown@intel.com>
 <11850957181201-git-send-email-len.brown@intel.com>
 <11850957192175-git-send-email-len.brown@intel.com>
 <1185095721166-git-send-email-len.brown@intel.com>
 <1185095721760-git-send-email-len.brown@intel.com>
 <11850957232745-git-send-email-len.brown@intel.com>
 <11850957242656-git-send-email-len.brown@intel.com>
 <11850957252722-git-send-email-len.brown@intel.com>
 <11850957262869-git-send-email-len.brown@intel.com>
 <11850957272369-git-send-email-len.brown@intel.com>
 <11850957282082-git-send-email-len.brown@intel.com>
 <11850957292555-git-send-email-len.brown@intel.com>
 <11850957302782-git-send-email-len.brown@intel.com>
 <11850957311269-git-send-email-len.brown@intel.com>
 <11850957323059-git-send-email-len.brown@intel.com>
 <11850957332171-git-send-email-len.brown@intel.com>
 <11850957342584-git-send-email-len.brown@intel.com>
 <11850957362476-git-send-email-len.brown@intel.com>
 <11850957361736-git-send-email-len.brown@intel.com>
 <1185095737422-git-send-email-len.brown@intel.com>
 <11850957384004-git-send-email-len.brown@intel.com>
 <1185095739370-git-send-email-len.brown@intel.com>
 <11850957403722-git-send-email-len.brown@intel.com>
 <11850957413607-git-send-email-len.brown@intel.com>
 <11850957432095-git-send-email-len.brown@intel.com>
 <11850957443711-git-send-email-len.brown@intel.com>
 <11850957451942-git-send-email-len.brown@intel.com>
 <11850957462109-git-send-email-len.brown@intel.com>
 <11850957471828-git-send-email-len.brown@intel.com>
 <11850957482671-git-send-email-len.brown@intel.com>
 <11850957491254-git-send-email-len.brown@intel.com>
 <11850957503243-git-send-email-len.brown@intel.com>
 <1185095751279-git-send-email-len.brown@intel.com>
 <11850957522609-git-send-email-len.brown@intel.com>
 <11850957531914-git-send-email-len.brown@intel.com>
 <11850957541879-git-send-email-len.brown@intel.com>
 <11850957552824-git-send-email-len.brown@intel.com>
 <11850957561003-git-send-email-len.brown@intel.com>
 <11850957571080-git-send-email-len.brown@intel.com>
 <11850957591101-git-send-email-len.brown@intel.com>
 <11850957601664-git-send-email-len.brown@intel.com>
 <1185095761326-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:43305 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764252AbXGVJQD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 22 Jul 2007 05:16:03 -0400
In-Reply-To: <1185095761326-git-send-email-len.brown@intel.com>
Message-Id: <d5a2f2f1d68e2da538ac28540cddd9ccc733b001.1185095456.git.len.brown@intel.com>
In-Reply-To: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
References: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Keep note of ThinkPad model, BIOS and EC firmware information, and log it
on startup.  Makes for far more readable code in places, too.

This patch also adds Lenovo's PCI ID to the pci ids table.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/thinkpad_acpi.c |   98 ++++++++++++++++++++++++++++++------------
 drivers/misc/thinkpad_acpi.h |   17 ++++++-
 include/linux/pci_ids.h      |    2 +
 3 files changed, 87 insertions(+), 30 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 44aa8c9..99500af 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -717,9 +717,19 @@ static int __init thinkpad_acpi_driver_init(struct ibm_init_struct *iibm)
 	printk(IBM_INFO "%s v%s\n", IBM_DESC, IBM_VERSION);
 	printk(IBM_INFO "%s\n", IBM_URL);
 
-	if (ibm_thinkpad_ec_found)
-		printk(IBM_INFO "ThinkPad EC firmware %s\n",
-		       ibm_thinkpad_ec_found);
+	printk(IBM_INFO "ThinkPad BIOS %s, EC %s\n",
+		(thinkpad_id.bios_version_str) ?
+			thinkpad_id.bios_version_str : "unknown",
+		(thinkpad_id.ec_version_str) ?
+			thinkpad_id.ec_version_str : "unknown");
+
+	if (thinkpad_id.vendor && thinkpad_id.model_str)
+		printk(IBM_INFO "%s %s\n",
+			(thinkpad_id.vendor == PCI_VENDOR_ID_IBM) ?
+				"IBM" : ((thinkpad_id.vendor ==
+						PCI_VENDOR_ID_LENOVO) ?
+					"Lenovo" : "Unknown vendor"),
+			thinkpad_id.model_str);
 
 	return 0;
 }
@@ -2648,7 +2658,7 @@ static int __init thermal_init(struct ibm_init_struct *iibm)
 
 	acpi_tmp7 = acpi_evalf(ec_handle, NULL, "TMP7", "qv");
 
-	if (ibm_thinkpad_ec_found && experimental) {
+	if (thinkpad_id.ec_model && experimental) {
 		/*
 		 * Direct EC access mode: sensors at registers
 		 * 0x78-0x7F, 0xC0-0xC7.  Registers return 0x00 for
@@ -3532,20 +3542,19 @@ static int __init fan_init(struct ibm_init_struct *iibm)
 			 * Enable for TP-1Y (T43), TP-78 (R51e),
 			 * TP-76 (R52), TP-70 (T43, R52), which are known
 			 * to be buggy. */
-			if (fan_control_initial_status == 0x07 &&
-			    ibm_thinkpad_ec_found &&
-			    ((ibm_thinkpad_ec_found[0] == '1' &&
-			      ibm_thinkpad_ec_found[1] == 'Y') ||
-			     (ibm_thinkpad_ec_found[0] == '7' &&
-			      (ibm_thinkpad_ec_found[1] == '6' ||
-			       ibm_thinkpad_ec_found[1] == '8' ||
-			       ibm_thinkpad_ec_found[1] == '0'))
-			    )) {
-				printk(IBM_NOTICE
-				       "fan_init: initial fan status is "
-				       "unknown, assuming it is in auto "
-				       "mode\n");
-				tp_features.fan_ctrl_status_undef = 1;
+			if (fan_control_initial_status == 0x07) {
+				switch (thinkpad_id.ec_model) {
+				case 0x5931: /* TP-1Y */
+				case 0x3837: /* TP-78 */
+				case 0x3637: /* TP-76 */
+				case 0x3037: /* TP-70 */
+					printk(IBM_NOTICE
+					       "fan_init: initial fan status is "
+					       "unknown, assuming it is in auto "
+					       "mode\n");
+					tp_features.fan_ctrl_status_undef = 1;
+					;;
+				}
 			}
 		} else {
 			printk(IBM_ERR
@@ -4279,13 +4288,30 @@ static void ibm_exit(struct ibm_struct *ibm)
 
 /* Probing */
 
-static char *ibm_thinkpad_ec_found;
-
-static char* __init check_dmi_for_ec(void)
+static void __init get_thinkpad_model_data(struct thinkpad_id_data *tp)
 {
 	struct dmi_device *dev = NULL;
 	char ec_fw_string[18];
 
+	if (!tp)
+		return;
+
+	memset(tp, 0, sizeof(*tp));
+
+	if (dmi_name_in_vendors("IBM"))
+		tp->vendor = PCI_VENDOR_ID_IBM;
+	else if (dmi_name_in_vendors("LENOVO"))
+		tp->vendor = PCI_VENDOR_ID_LENOVO;
+	else
+		return;
+
+	tp->bios_version_str = kstrdup(dmi_get_system_info(DMI_BIOS_VERSION),
+					GFP_KERNEL);
+	if (!tp->bios_version_str)
+		return;
+	tp->bios_model = tp->bios_version_str[0]
+			 | (tp->bios_version_str[1] << 8);
+
 	/*
 	 * ThinkPad T23 or newer, A31 or newer, R50e or newer,
 	 * X32 or newer, all Z series;  Some models must have an
@@ -4299,10 +4325,20 @@ static char* __init check_dmi_for_ec(void)
 			   ec_fw_string) == 1) {
 			ec_fw_string[sizeof(ec_fw_string) - 1] = 0;
 			ec_fw_string[strcspn(ec_fw_string, " ]")] = 0;
-			return kstrdup(ec_fw_string, GFP_KERNEL);
+
+			tp->ec_version_str = kstrdup(ec_fw_string, GFP_KERNEL);
+			tp->ec_model = ec_fw_string[0]
+					| (ec_fw_string[1] << 8);
+			break;
 		}
 	}
-	return NULL;
+
+	tp->model_str = kstrdup(dmi_get_system_info(DMI_PRODUCT_VERSION),
+					GFP_KERNEL);
+	if (strnicmp(tp->model_str, "ThinkPad", 8) != 0) {
+		kfree(tp->model_str);
+		tp->model_str = NULL;
+	}
 }
 
 static int __init probe_for_thinkpad(void)
@@ -4316,7 +4352,7 @@ static int __init probe_for_thinkpad(void)
 	 * Non-ancient models have better DMI tagging, but very old models
 	 * don't.
 	 */
-	is_thinkpad = dmi_name_in_vendors("ThinkPad");
+	is_thinkpad = (thinkpad_id.model_str != NULL);
 
 	/* ec is required because many other handles are relative to it */
 	IBM_ACPIHANDLE_INIT(ec);
@@ -4332,7 +4368,7 @@ static int __init probe_for_thinkpad(void)
 	 * false positives a damn great deal
 	 */
 	if (!is_thinkpad)
-		is_thinkpad = dmi_name_in_vendors("IBM");
+		is_thinkpad = (thinkpad_id.vendor == PCI_VENDOR_ID_IBM);
 
 	if (!is_thinkpad && !force_load)
 		return -ENODEV;
@@ -4475,12 +4511,16 @@ static int __init thinkpad_acpi_module_init(void)
 	int ret, i;
 
 	/* Driver-level probe */
+
+	get_thinkpad_model_data(&thinkpad_id);
 	ret = probe_for_thinkpad();
-	if (ret)
+	if (ret) {
+		thinkpad_acpi_module_exit();
 		return ret;
+	}
 
 	/* Driver initialization */
-	ibm_thinkpad_ec_found = check_dmi_for_ec();
+
 	IBM_ACPIHANDLE_INIT(ecrd);
 	IBM_ACPIHANDLE_INIT(ecwr);
 
@@ -4590,7 +4630,9 @@ static void thinkpad_acpi_module_exit(void)
 	if (proc_dir)
 		remove_proc_entry(IBM_PROC_DIR, acpi_root_dir);
 
-	kfree(ibm_thinkpad_ec_found);
+	kfree(thinkpad_id.bios_version_str);
+	kfree(thinkpad_id.ec_version_str);
+	kfree(thinkpad_id.model_str);
 }
 
 module_init(thinkpad_acpi_module_init);
diff --git a/drivers/misc/thinkpad_acpi.h b/drivers/misc/thinkpad_acpi.h
index fee0421..09b2282 100644
--- a/drivers/misc/thinkpad_acpi.h
+++ b/drivers/misc/thinkpad_acpi.h
@@ -175,9 +175,7 @@ static void tpacpi_remove_driver_attributes(struct device_driver *drv);
 static int experimental;
 static u32 dbg_level;
 static int force_load;
-static char *ibm_thinkpad_ec_found;
 
-static char* check_dmi_for_ec(void);
 static int thinkpad_acpi_module_init(void);
 static void thinkpad_acpi_module_exit(void);
 
@@ -244,6 +242,21 @@ static struct {
 	u16 input_device_registered:1;
 } tp_features;
 
+struct thinkpad_id_data {
+	unsigned int vendor;	/* ThinkPad vendor:
+				 * PCI_VENDOR_ID_IBM/PCI_VENDOR_ID_LENOVO */
+
+	char *bios_version_str;	/* Something like 1ZET51WW (1.03z) */
+	char *ec_version_str;	/* Something like 1ZHT51WW-1.04a */
+
+	u16 bios_model;		/* Big Endian, TP-1Y = 0x5931, 0 = unknown */
+	u16 ec_model;
+
+	char *model_str;
+};
+
+static struct thinkpad_id_data thinkpad_id;
+
 static struct list_head tpacpi_all_drivers;
 
 static struct ibm_init_struct ibms_init[];
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index b15c649..ced4d3f 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2040,6 +2040,8 @@
 #define PCI_DEVICE_ID_ALTIMA_AC9100	0x03ea
 #define PCI_DEVICE_ID_ALTIMA_AC1003	0x03eb
 
+#define PCI_VENDOR_ID_LENOVO		0x17aa
+
 #define PCI_VENDOR_ID_ARECA		0x17d3
 #define PCI_DEVICE_ID_ARECA_1110	0x1110
 #define PCI_DEVICE_ID_ARECA_1120	0x1120
-- 
1.5.3.rc2.22.g69a9b
