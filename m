From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 11/20] ACPI: thinkpad-acpi: use bitfields to hold subdriver flags
Date: Sat, 21 Apr 2007 11:08:35 -0300
Message-ID: <11771645272450-git-send-email-hmh@hmh.eng.br>
References: <11771645253042-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:51001 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1031229AbXDUOJH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 21 Apr 2007 10:09:07 -0400
In-Reply-To: <11771645253042-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Save some memory by using bitfields to hold boolean flags for the
subdrivers.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
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
1.5.1

