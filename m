From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH] libata-acpi: don't call sleeping function from invalid
	context
Date: Thu, 10 Jul 2008 10:10:37 +0800
Message-ID: <1215655837.1617.7.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:34722 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750818AbYGJCLW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 9 Jul 2008 22:11:22 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: hmacht@suse.de, jeff@garzik.org, Andi Kleen <andi@firstfloor.org>


The problem is introduced by commit
664d080c41463570b95717b5ad86e79dc1be0877.

acpi_evaluate_integer is a sleeping function,
and it should not be called with spin_lock_irqsave.
https://bugzilla.redhat.com/show_bug.cgi?id=451399

Sighed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/ata/libata-acpi.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: linux-2.6/drivers/ata/libata-acpi.c
===================================================================
--- linux-2.6.orig/drivers/ata/libata-acpi.c	2007-05-04 10:57:08.000000000 +0800
+++ linux-2.6/drivers/ata/libata-acpi.c	2008-07-07 11:15:02.000000000 +0800
@@ -195,6 +195,8 @@
 		/* This device does not support hotplug */
 		return;
 
+	status = acpi_evaluate_integer(handle, "_STA", NULL, &sta);
+
 	spin_lock_irqsave(ap->lock, flags);
 
 	switch (event) {
@@ -202,7 +204,6 @@
 	case ACPI_NOTIFY_DEVICE_CHECK:
 		ata_ehi_push_desc(ehi, "ACPI event");
 
-		status = acpi_evaluate_integer(handle, "_STA", NULL, &sta);
 		if (ACPI_FAILURE(status)) {
 			ata_port_printk(ap, KERN_ERR,
 				"acpi: failed to determine bay status (0x%x)\n",


