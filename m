From: Len Brown <len.brown@intel.com>
Subject: [PATCH 25/77] ACPI: sbs: probe smart battery vis SMBus controller
Date: Sun, 22 Jul 2007 05:14:10 -0400
Message-ID: <11850957282082-git-send-email-len.brown@intel.com>
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
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:36470 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762887AbXGVJPa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 22 Jul 2007 05:15:30 -0400
In-Reply-To: <11850957272369-git-send-email-len.brown@intel.com>
Message-Id: <addad45494cb4f9c03470a4e5155f442791b0d7f.1185095456.git.len.brown@intel.com>
In-Reply-To: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
References: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Alexey Starikovskiy <astarikovskiy@suse.de>

http://bugzilla.kernel.org/show_bug.cgi?id=8559

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/sbs.c |   33 +++++++--------------------------
 1 files changed, 7 insertions(+), 26 deletions(-)

diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
index c1bae10..974d00c 100644
--- a/drivers/acpi/sbs.c
+++ b/drivers/acpi/sbs.c
@@ -127,7 +127,7 @@ static int acpi_sbs_resume(struct acpi_device *device);
 static struct acpi_driver acpi_sbs_driver = {
 	.name = "sbs",
 	.class = ACPI_SBS_CLASS,
-	.ids = ACPI_SBS_HID,
+	.ids = "ACPI0001,ACPI0005",
 	.ops = {
 		.add = acpi_sbs_add,
 		.remove = acpi_sbs_remove,
@@ -176,10 +176,8 @@ struct acpi_battery {
 };
 
 struct acpi_sbs {
-	acpi_handle handle;
 	int base;
 	struct acpi_device *device;
-	struct acpi_ec_smbus *smbus;
 	struct mutex mutex;
 	int sbsm_present;
 	int sbsm_batteries_supported;
@@ -511,7 +509,7 @@ static int acpi_sbsm_get_info(struct acpi_sbs *sbs)
 				"acpi_sbs_read_word() failed"));
 		goto end;
 	}
-
+	sbs->sbsm_present = 1;
 	sbs->sbsm_batteries_supported = battery_system_info & 0x000f;
 
       end:
@@ -1630,13 +1628,12 @@ static int acpi_sbs_add(struct acpi_device *device)
 {
 	struct acpi_sbs *sbs = NULL;
 	int result = 0, remove_result = 0;
-	unsigned long sbs_obj;
 	int id;
 	acpi_status status = AE_OK;
 	unsigned long val;
 
 	status =
-	    acpi_evaluate_integer(device->parent->handle, "_EC", NULL, &val);
+	    acpi_evaluate_integer(device->handle, "_EC", NULL, &val);
 	if (ACPI_FAILURE(status)) {
 		ACPI_EXCEPTION((AE_INFO, AE_ERROR, "Error obtaining _EC"));
 		return -EIO;
@@ -1653,7 +1650,7 @@ static int acpi_sbs_add(struct acpi_device *device)
 
 	sbs_mutex_lock(sbs);
 
-	sbs->base = (val & 0xff00ull) >> 8;
+	sbs->base = 0xff & (val >> 8);
 	sbs->device = device;
 
 	strcpy(acpi_device_name(device), ACPI_SBS_DEVICE_NAME);
@@ -1665,24 +1662,10 @@ static int acpi_sbs_add(struct acpi_device *device)
 		ACPI_EXCEPTION((AE_INFO, AE_ERROR, "acpi_ac_add() failed"));
 		goto end;
 	}
-	status = acpi_evaluate_integer(device->handle, "_SBS", NULL, &sbs_obj);
-	if (status) {
-		ACPI_EXCEPTION((AE_INFO, status,
-				"acpi_evaluate_integer() failed"));
-		result = -EIO;
-		goto end;
-	}
-	if (sbs_obj > 0) {
-		result = acpi_sbsm_get_info(sbs);
-		if (result) {
-			ACPI_EXCEPTION((AE_INFO, AE_ERROR,
-					"acpi_sbsm_get_info() failed"));
-			goto end;
-		}
-		sbs->sbsm_present = 1;
-	}
 
-	if (sbs->sbsm_present == 0) {
+	acpi_sbsm_get_info(sbs);
+
+	if (!sbs->sbsm_present) {
 		result = acpi_battery_add(sbs, 0);
 		if (result) {
 			ACPI_EXCEPTION((AE_INFO, AE_ERROR,
@@ -1702,8 +1685,6 @@ static int acpi_sbs_add(struct acpi_device *device)
 		}
 	}
 
-	sbs->handle = device->handle;
-
 	init_timer(&sbs->update_timer);
 	result = acpi_check_update_proc(sbs);
 	if (result)
-- 
1.5.3.rc2.22.g69a9b
