From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: [PATCH 1/6] ACPI/PCI: cleanup acpi_pci_run_osc
Date: Fri, 30 Jul 2010 15:20:15 +0900
Message-ID: <4C526F1F.6060701@jp.fujitsu.com>
References: <201007282323.56351.rjw@sisk.pl> <20100728144358.5e2c12ce@virtuousgeek.org> <4C510B90.9070302@jp.fujitsu.com> <201007291745.39285.rjw@sisk.pl> <4C526A85.3070902@jp.fujitsu.com> <4C526E3E.3000600@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:55417 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752285Ab0G3GUx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 30 Jul 2010 02:20:53 -0400
In-Reply-To: <4C526E3E.3000600@jp.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org, linux-pci@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>, Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>

Make capabilitis buffer in acpi_pci_run_osc() instead of caller of
this function. This makes the code a little cleaner. This has no
functional changes.

Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>

---
 drivers/acpi/pci_root.c |   34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

Index: linux-2.6.35-rc6/drivers/acpi/pci_root.c
===================================================================
--- linux-2.6.35-rc6.orig/drivers/acpi/pci_root.c
+++ linux-2.6.35-rc6/drivers/acpi/pci_root.c
@@ -206,9 +206,10 @@ static void acpi_pci_bridge_scan(struct 
 
 static u8 pci_osc_uuid_str[] = "33DB4D5B-1FF7-401C-9657-7441C03DD766";
 
-static acpi_status acpi_pci_run_osc(acpi_handle handle,
-				    const u32 *capbuf, u32 *retval)
+static acpi_status acpi_pci_run_osc(acpi_handle handle, u32 support,
+				    u32 control, bool query, u32 *retval)
 {
+	u32 capbuf[3];
 	struct acpi_osc_context context = {
 		.uuid_str = pci_osc_uuid_str,
 		.rev = 1,
@@ -217,6 +218,10 @@ static acpi_status acpi_pci_run_osc(acpi
 	};
 	acpi_status status;
 
+	capbuf[OSC_QUERY_TYPE] = (query == true) ? OSC_QUERY_ENABLE : 0;
+	capbuf[OSC_SUPPORT_TYPE] = support;
+	capbuf[OSC_CONTROL_TYPE] = control;
+
 	status = acpi_run_osc(handle, &context);
 	if (ACPI_SUCCESS(status)) {
 		*retval = *((u32 *)(context.ret.pointer + 8));
@@ -228,17 +233,16 @@ static acpi_status acpi_pci_run_osc(acpi
 static acpi_status acpi_pci_query_osc(struct acpi_pci_root *root, u32 flags)
 {
 	acpi_status status;
-	u32 support_set, result, capbuf[3];
+	u32 result;
 
 	/* do _OSC query for all possible controls */
-	support_set = root->osc_support_set | (flags & OSC_PCI_SUPPORT_MASKS);
-	capbuf[OSC_QUERY_TYPE] = OSC_QUERY_ENABLE;
-	capbuf[OSC_SUPPORT_TYPE] = support_set;
-	capbuf[OSC_CONTROL_TYPE] = OSC_PCI_CONTROL_MASKS;
-
-	status = acpi_pci_run_osc(root->device->handle, capbuf, &result);
+	flags &= OSC_PCI_SUPPORT_MASKS;
+	status = acpi_pci_run_osc(root->device->handle,
+				  root->osc_support_set | flags,
+				  OSC_PCI_CONTROL_MASKS,
+				  true, &result);
 	if (ACPI_SUCCESS(status)) {
-		root->osc_support_set = support_set;
+		root->osc_support_set |= flags;
 		root->osc_control_qry = result;
 		root->osc_queried = 1;
 	}
@@ -373,7 +377,7 @@ EXPORT_SYMBOL_GPL(acpi_get_pci_dev);
 acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 flags)
 {
 	acpi_status status;
-	u32 control_req, result, capbuf[3];
+	u32 control_req, result;
 	acpi_handle tmp;
 	struct acpi_pci_root *root;
 
@@ -407,10 +411,10 @@ acpi_status acpi_pci_osc_control_set(acp
 		goto out;
 	}
 
-	capbuf[OSC_QUERY_TYPE] = 0;
-	capbuf[OSC_SUPPORT_TYPE] = root->osc_support_set;
-	capbuf[OSC_CONTROL_TYPE] = root->osc_control_set | control_req;
-	status = acpi_pci_run_osc(handle, capbuf, &result);
+	status = acpi_pci_run_osc(handle,
+				  root->osc_support_set,
+				  root->osc_control_set | control_req,
+				  false, &result);
 	if (ACPI_SUCCESS(status))
 		root->osc_control_set = result;
 out:

