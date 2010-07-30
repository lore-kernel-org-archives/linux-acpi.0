From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 6/7] ACPI / PCI: Do not preserve _OSC control bits returned by a query
Date: Sat, 31 Jul 2010 00:36:46 +0200
Message-ID: <201007310036.46769.rjw@sisk.pl>
References: <201007310020.56546.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:49412 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755622Ab0G3Wkb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 30 Jul 2010 18:40:31 -0400
In-Reply-To: <201007310020.56546.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>, Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, Matthew Garrett <mjg59@srcf.ucam.org>, linux-pci@vger.kernel.org, linux-pm@lists.linux-foundation.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

From: Rafael J. Wysocki <rjw@sisk.pl>

All of the remaining callers of acpi_pci_osc_control_set() either
use acpi_pci_root_osc_query() right before calling it, like
pcie_port_acpi_setup(), or ask for control of one feature only,
like acpi_get_hp_hw_control_from_firmware().  Thus there is no
reason to preserve the _OSC control bits returned by an _OSC query
and the osc_control_qry and osc_queried fields of struct
acpi_pci_root are not necessary any more.  Remove them and modify the
code that uses them accordingly.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/pci_root.c |   15 ---------------
 include/acpi/acpi_bus.h |    3 ---
 2 files changed, 18 deletions(-)

Index: linux-2.6/drivers/acpi/pci_root.c
===================================================================
--- linux-2.6.orig/drivers/acpi/pci_root.c
+++ linux-2.6/drivers/acpi/pci_root.c
@@ -247,10 +247,8 @@ static acpi_status acpi_pci_query_osc(st
 	status = acpi_pci_run_osc(root->device->handle, capbuf);
 	if (ACPI_SUCCESS(status)) {
 		root->osc_support_set = support;
-		root->osc_control_qry = capbuf[OSC_CONTROL_TYPE];
 		if (control)
 			*control = capbuf[OSC_CONTROL_TYPE];
-		root->osc_queried = 1;
 	}
 	return status;
 }
@@ -433,19 +431,6 @@ acpi_status acpi_pci_osc_control_set(acp
 	if ((root->osc_control_set & control_req) == control_req)
 		goto out;
 
-	/* Need to query controls first before requesting them */
-	if (!root->osc_queried) {
-		status = acpi_pci_query_osc(root, root->osc_support_set, NULL);
-		if (ACPI_FAILURE(status))
-			goto out;
-	}
-	if ((root->osc_control_qry & control_req) != control_req) {
-		printk(KERN_DEBUG
-		       "Firmware did not grant requested _OSC control\n");
-		status = AE_SUPPORT;
-		goto out;
-	}
-
 	capbuf[OSC_QUERY_TYPE] = 0;
 	capbuf[OSC_SUPPORT_TYPE] = root->osc_support_set;
 	capbuf[OSC_CONTROL_TYPE] = root->osc_control_set | control_req;
Index: linux-2.6/include/acpi/acpi_bus.h
===================================================================
--- linux-2.6.orig/include/acpi/acpi_bus.h
+++ linux-2.6/include/acpi/acpi_bus.h
@@ -377,9 +377,6 @@ struct acpi_pci_root {
 
 	u32 osc_support_set;	/* _OSC state of support bits */
 	u32 osc_control_set;	/* _OSC state of control bits */
-	u32 osc_control_qry;	/* the latest _OSC query result */
-
-	u32 osc_queried:1;	/* has _OSC control been queried? */
 };
 
 /* helper */

