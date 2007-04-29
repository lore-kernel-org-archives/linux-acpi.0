From: Len Brown <len.brown@intel.com>
Subject: [PATCH 091/105] ACPI: thinkpad-acpi: improve debugging for acpi helpers
Date: Sun, 29 Apr 2007 00:51:31 -0400
Message-ID: <1177822388542-git-send-email-len.brown@intel.com>
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
 <1177822324973-git-send-email-len.brown@intel.com>
 <11778223251849-git-send-email-len.brown@intel.com>
 <1177822326583-git-send-email-len.brown@intel.com>
 <11778223273782-git-send-email-len.brown@intel.com>
 <11778223282154-git-send-email-len.brown@intel.com>
 <11778223282215-git-send-email-len.brown@intel.com>
 <11778223304019-git-send-email-len.brown@intel.com>
 <1177822331727-git-send-email-len.brown@intel.com>
 <117782233197-git-send-email-len.brown@intel.com>
 <11778223331858-git-send-email-len.brown@intel.com>
 <11778223353919-git-send-email-len.brown@intel.com>
 <1177822337332-git-send-email-len.brown@intel.com>
 <11778223382880-git-send-email-len.brown@intel.com>
 <11778223392178-git-send-email-len.brown@intel.com>
 <11778223401417-git-send-email-len.brown@intel.com>
 <11778223411658-git-send-email-len.brown@intel.com>
 <11778223412672-git-send-email-len.brown@intel.com>
 <11778223423-git-send-email-len.brown@intel.com>
 <1177822343712-git-send-email-len.brown@intel.com>
 <11778223442065-git-send-email-len.brown@intel.com>
 <11778223452843-git-send-email-len.brown@intel.com>
 <11778223461282-git-send-email-len.brown@intel.com>
 <11778223472316-git-send-email-len.brown@intel.com>
 <1177822347845-git-send-email-len.brown@intel.com>
 <1177822348546-git-send-email-len.brown@intel.com>
 <11778223493327-git-send-email-len.brown@intel.com>
 <11778223502745-git-send-email-len.brown@intel.com>
 <11778223512990-git-send-email-len.brown@intel.com>
 <1177822352591-git-send-email-len.brown@intel.com>
 <11778223532461-git-send-email-len.brown@intel.com>
 <11778223544100-git-send-email-len.brown@intel.com>
 <11778223553521-git-send-email-len.brown@intel.com>
 <11778223551720-git-send-email-len.brown@intel.com>
 <11778223562656-git-send-email-len.brown@intel.com>
 <11778223571390-git-send-email-len.brown@intel.com>
 <11778223581484-git-send-email-len.brown@intel.com>
 <11778223593048-git-send-email-len.brown@intel.com>
 <11778223602019-git-send-email-len.brown@intel.com>
 <11778223612093-git-send-email-len.brown@intel.com>
 <117782236226-git-send-email-len.brown@intel.com>
 <11778223624095-git-send-email-len.brown@intel.com>
 <11778223633408-git-send-email-len.brown@intel.com>
 <1177822364262-git-send-email-len.brown@intel.com>
 <11778223653391-git-send-email-len.brown@intel.com>
 <11778223663850-git-send-email-len.brown@intel.com>
 <11778223673988-git-send-email-len.brown@intel.com>
 <1177822368767-git-send-email-len.brown@intel.com>
 <1177822368793-git-send-email-len.brown@intel.com>
 <11778223692377-git-send-email-len.brown@intel.com>
 <1177822370442-git-send-email-len.brown@intel.com>
 <1177822371935-git-send-email-len.brown@intel.com>
 <11778223721984-git-send-email-len.brown@intel.com>
 <11778223732286-git-send-email-len.brown@intel.com>
 <11778223733679-git-send-email-len.brown@intel.com>
 <11778223741-git-send-email-len.brown@intel.com>
 <11778223752175-git-send-email-len.brown@intel.com>
 <1177822376123-git-send-email-len.brown@intel.com>
 <11778223771048-git-send-email-len.brown@intel.com>
 <11778223782086-git-send-email-len.brown@intel.com>
 <11778223792074-git-send-email-len.brown@intel.com>
 <11778223802796-git-send-email-len.brown@intel.com>
 <11778223812071-git-send-email-len.brown@intel.com>
 <11778223823637-git-send-email-len.brown@intel.com>
 <117782238310-git-send-email-len.brown@intel.com>
 <11778223843825-git-send-email-len.brown@intel.com>
 <11778223852391-git-send-email-len.brown@intel.com>
 <11778223861983-git-send-email-len.brown@intel.com>
 <11778223872566-git-send-email-len.brown@intel.com>
 <1177822387623-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:18569 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756203AbXD2ExN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 29 Apr 2007 00:53:13 -0400
In-Reply-To: <1177822387623-git-send-email-len.brown@intel.com>
Message-Id: <5ae930e685018e2dc6d4139362213e4b283e5700.1177822058.git.len.brown@intel.com>
In-Reply-To: <ac122bb64b0d51f0512185d3522a75f3f3a80bc9.1177822058.git.len.brown@intel.com>
References: <ac122bb64b0d51f0512185d3522a75f3f3a80bc9.1177822058.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Some issues with the dock subdriver proved that a slightly improved
debugging setup for ACPI notifiers and handler helpers would be useful.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/thinkpad_acpi.c |   31 ++++++++++++++++++++-----------
 1 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 7aed118..68f1cc0 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -296,14 +296,22 @@ static void drv_acpi_handle_init(char *name,
 	int i;
 	acpi_status status;
 
+	vdbg_printk(TPACPI_DBG_INIT, "trying to locate ACPI handle for %s\n",
+		name);
+
 	for (i = 0; i < num_paths; i++) {
 		status = acpi_get_handle(parent, paths[i], handle);
 		if (ACPI_SUCCESS(status)) {
 			*path = paths[i];
+			dbg_printk(TPACPI_DBG_INIT,
+				   "Found ACPI handle %s for %s\n",
+				   *path, name);
 			return;
 		}
 	}
 
+	vdbg_printk(TPACPI_DBG_INIT, "ACPI handle for %s not found\n",
+		    name);
 	*handle = NULL;
 }
 
@@ -320,19 +328,20 @@ static void dispatch_acpi_notify(acpi_handle handle, u32 event, void *data)
 static int __init setup_acpi_notify(struct ibm_struct *ibm)
 {
 	acpi_status status;
-	int ret;
+	int rc;
 
 	BUG_ON(!ibm->acpi);
 
 	if (!*ibm->acpi->handle)
 		return 0;
 
-	dbg_printk(TPACPI_DBG_INIT,
+	vdbg_printk(TPACPI_DBG_INIT,
 		"setting up ACPI notify for %s\n", ibm->name);
 
-	ret = acpi_bus_get_device(*ibm->acpi->handle, &ibm->acpi->device);
-	if (ret < 0) {
-		printk(IBM_ERR "%s device not present\n", ibm->name);
+	rc = acpi_bus_get_device(*ibm->acpi->handle, &ibm->acpi->device);
+	if (rc < 0) {
+		printk(IBM_ERR "acpi_bus_get_device(%s) failed: %d\n",
+			ibm->name, rc);
 		return -ENODEV;
 	}
 
@@ -364,7 +373,7 @@ static int __init tpacpi_device_add(struct acpi_device *device)
 
 static int __init register_tpacpi_subdriver(struct ibm_struct *ibm)
 {
-	int ret;
+	int rc;
 
 	dbg_printk(TPACPI_DBG_INIT,
 		"registering %s as an ACPI driver\n", ibm->name);
@@ -381,16 +390,16 @@ static int __init register_tpacpi_subdriver(struct ibm_struct *ibm)
 	ibm->acpi->driver->ids = ibm->acpi->hid;
 	ibm->acpi->driver->ops.add = &tpacpi_device_add;
 
-	ret = acpi_bus_register_driver(ibm->acpi->driver);
-	if (ret < 0) {
+	rc = acpi_bus_register_driver(ibm->acpi->driver);
+	if (rc < 0) {
 		printk(IBM_ERR "acpi_bus_register_driver(%s) failed: %d\n",
-		       ibm->acpi->hid, ret);
+		       ibm->acpi->hid, rc);
 		kfree(ibm->acpi->driver);
 		ibm->acpi->driver = NULL;
-	} else if (!ret)
+	} else if (!rc)
 		ibm->flags.acpi_driver_registered = 1;
 
-	return ret;
+	return rc;
 }
 
 
-- 
1.5.2.rc0.34.gda94
