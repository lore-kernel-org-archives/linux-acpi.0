From: Len Brown <len.brown@intel.com>
Subject: [PATCH 056/105] ACPI: thinkpad-acpi: use bitfields to hold subdriver flags
Date: Sun, 29 Apr 2007 00:50:56 -0400
Message-ID: <11778223571390-git-send-email-len.brown@intel.com>
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
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:54971 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756131AbXD2Ewk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 29 Apr 2007 00:52:40 -0400
In-Reply-To: <11778223562656-git-send-email-len.brown@intel.com>
Message-Id: <926411779287ad4f7013c9d80aa44fd131b70cd9.1177822058.git.len.brown@intel.com>
In-Reply-To: <ac122bb64b0d51f0512185d3522a75f3f3a80bc9.1177822058.git.len.brown@intel.com>
References: <ac122bb64b0d51f0512185d3522a75f3f3a80bc9.1177822058.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Save some memory by using bitfields to hold boolean flags for the
subdrivers.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/thinkpad_acpi.c |   32 ++++++++++++++++----------------
 drivers/misc/thinkpad_acpi.h |   13 +++++++------
 2 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index cddf81b..a5efd06 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -339,7 +339,7 @@ static int __init setup_notify(struct ibm_struct *ibm)
 		}
 		return -ENODEV;
 	}
-	ibm->notify_installed = 1;
+	ibm->flags.notify_installed = 1;
 	return 0;
 }
 
@@ -372,7 +372,7 @@ static int __init register_tpacpi_subdriver(struct ibm_struct *ibm)
 		kfree(ibm->driver);
 		ibm->driver = NULL;
 	} else if (!ret)
-		ibm->driver_registered = 1;
+		ibm->flags.driver_registered = 1;
 
 	return ret;
 }
@@ -815,7 +815,7 @@ static struct ibm_struct wan_driver_data = {
 	.name = "wan",
 	.read = wan_read,
 	.write = wan_write,
-	.experimental = 1,
+	.flags.experimental = 1,
 };
 
 /*************************************************************************
@@ -1851,7 +1851,7 @@ static struct ibm_struct ecdump_driver_data = {
 	.name = "ecdump",
 	.read = ecdump_read,
 	.write = ecdump_write,
-	.experimental = 1,
+	.flags.experimental = 1,
 };
 
 /*************************************************************************
@@ -2684,7 +2684,7 @@ static struct ibm_struct fan_driver_data = {
 	.read = fan_read,
 	.write = fan_write,
 	.exit = fan_exit,
-	.experimental = 1,
+	.flags.experimental = 1,
 };
 
 /****************************************************************************
@@ -2725,7 +2725,7 @@ static int __init ibm_init(struct ibm_init_struct *iibm)
 
 	INIT_LIST_HEAD(&ibm->all_drivers);
 
-	if (ibm->experimental && !experimental)
+	if (ibm->flags.experimental && !experimental)
 		return 0;
 
 	dbg_printk(TPACPI_DBG_INIT,
@@ -2738,7 +2738,7 @@ static int __init ibm_init(struct ibm_init_struct *iibm)
 		if (ret)
 			return ret;
 
-		ibm->init_called = 1;
+		ibm->flags.init_called = 1;
 	}
 
 	if (ibm->hid) {
@@ -2777,7 +2777,7 @@ static int __init ibm_init(struct ibm_init_struct *iibm)
 		entry->read_proc = &dispatch_read;
 		if (ibm->write)
 			entry->write_proc = &dispatch_write;
-		ibm->proc_created = 1;
+		ibm->flags.proc_created = 1;
 	}
 
 	list_add_tail(&ibm->all_drivers, &tpacpi_all_drivers);
@@ -2799,33 +2799,33 @@ static void ibm_exit(struct ibm_struct *ibm)
 
 	list_del_init(&ibm->all_drivers);
 
-	if (ibm->notify_installed) {
+	if (ibm->flags.notify_installed) {
 		dbg_printk(TPACPI_DBG_EXIT,
 			"%s: acpi_remove_notify_handler\n", ibm->name);
 		acpi_remove_notify_handler(*ibm->handle, ibm->type,
 					   dispatch_notify);
-		ibm->notify_installed = 0;
+		ibm->flags.notify_installed = 0;
 	}
 
-	if (ibm->proc_created) {
+	if (ibm->flags.proc_created) {
 		dbg_printk(TPACPI_DBG_EXIT,
 			"%s: remove_proc_entry\n", ibm->name);
 		remove_proc_entry(ibm->name, proc_dir);
-		ibm->proc_created = 0;
+		ibm->flags.proc_created = 0;
 	}
 
-	if (ibm->driver_registered) {
+	if (ibm->flags.driver_registered) {
 		dbg_printk(TPACPI_DBG_EXIT,
 			"%s: acpi_bus_unregister_driver\n", ibm->name);
 		acpi_bus_unregister_driver(ibm->driver);
 		kfree(ibm->driver);
 		ibm->driver = NULL;
-		ibm->driver_registered = 0;
+		ibm->flags.driver_registered = 0;
 	}
 
-	if (ibm->init_called && ibm->exit) {
+	if (ibm->flags.init_called && ibm->exit) {
 		ibm->exit();
-		ibm->init_called = 0;
+		ibm->flags.init_called = 0;
 	}
 
 	dbg_printk(TPACPI_DBG_INIT, "finished removing %s\n", ibm->name);
diff --git a/drivers/misc/thinkpad_acpi.h b/drivers/misc/thinkpad_acpi.h
index 2020398..8b72061 100644
--- a/drivers/misc/thinkpad_acpi.h
+++ b/drivers/misc/thinkpad_acpi.h
@@ -157,12 +157,13 @@ struct ibm_struct {
 
 	struct list_head all_drivers;
 
-	int driver_registered;
-	int proc_created;
-	int init_called;
-	int notify_installed;
-
-	int experimental;
+	struct {
+		u8 driver_registered:1;
+		u8 proc_created:1;
+		u8 init_called:1;
+		u8 notify_installed:1;
+		u8 experimental:1;
+	} flags;
 };
 
 struct ibm_init_struct {
-- 
1.5.2.rc0.34.gda94
