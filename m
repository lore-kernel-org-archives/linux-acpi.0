From: Len Brown <lenb@kernel.org>
Subject: [PATCH 01/29] ACPI: button: whitespace changes
Date: Thu, 23 Apr 2009 02:23:23 -0400
Message-ID: <50a4da890102a455e5cd3dd358c38650d07178d3.1240467664.git.len.brown@intel.com>
References: <1240467831-32613-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173009pub.verizon.net ([206.46.173.9]:41714 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753269AbZDWGX5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Apr 2009 02:23:57 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KIJ00GR3J3UDS0Z@vms173009.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Apr 2009 01:23:57 -0500 (CDT)
In-reply-to: <1240467831-32613-1-git-send-email-lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

This patch changes a bit of whitespace to follow Linux conventions.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/button.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index d73c94b..52eb06e 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -1,5 +1,5 @@
 /*
- *  acpi_button.c - ACPI Button Driver ($Revision: 30 $)
+ *  button.c - ACPI Button Driver
  *
  *  Copyright (C) 2001, 2002 Andy Grover <andrew.grover@intel.com>
  *  Copyright (C) 2001, 2002 Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>
@@ -133,7 +133,6 @@ static int acpi_button_info_seq_show(struct seq_file *seq, void *offset)
 
 	seq_printf(seq, "type:                    %s\n",
 		   acpi_device_name(button->device));
-
 	return 0;
 }
 
@@ -259,6 +258,7 @@ static int acpi_lid_send_state(struct acpi_button *button)
 					&state);
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
+
 	/* input layer checks if event is redundant */
 	input_report_switch(button->input, SW_LID, !state);
 	input_sync(button->input);
@@ -299,13 +299,12 @@ static void acpi_button_notify(struct acpi_device *device, u32 event)
 				  "Unsupported event [0x%x]\n", event));
 		break;
 	}
-
-	return;
 }
 
 static int acpi_button_resume(struct acpi_device *device)
 {
 	struct acpi_button *button;
+
 	if (!device)
 		return -EINVAL;
 	button = acpi_driver_data(device);
@@ -424,7 +423,6 @@ static int acpi_button_add(struct acpi_device *device)
 
 	printk(KERN_INFO PREFIX "%s [%s]\n",
 	       acpi_device_name(device), acpi_device_bid(device));
-
 	return 0;
 
  err_remove_fs:
@@ -448,7 +446,6 @@ static int acpi_button_remove(struct acpi_device *device, int type)
 	acpi_button_remove_fs(device);
 	input_unregister_device(button->input);
 	kfree(button);
-
 	return 0;
 }
 
@@ -459,6 +456,7 @@ static int __init acpi_button_init(void)
 	acpi_button_dir = proc_mkdir(ACPI_BUTTON_CLASS, acpi_root_dir);
 	if (!acpi_button_dir)
 		return -ENODEV;
+
 	result = acpi_bus_register_driver(&acpi_button_driver);
 	if (result < 0) {
 		remove_proc_entry(ACPI_BUTTON_CLASS, acpi_root_dir);
-- 
1.6.0.6

