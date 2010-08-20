From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 3/10] ACPI / PCI: Reorder checks in acpi_pci_osc_control_set()
Date: Sat, 21 Aug 2010 01:52:37 +0200
Message-ID: <201008210152.37415.rjw@sisk.pl>
References: <201008060303.51224.rjw@sisk.pl> <201008210149.39576.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:59489 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751211Ab0HUABg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 20 Aug 2010 20:01:36 -0400
In-Reply-To: <201008210149.39576.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Cc: linux-pm@lists.linux-foundation.org, Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>, linux-pci@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Matthew Garrett <mjg@redhat.com>

From: Rafael J. Wysocki <rjw@sisk.pl>

Make acpi_pci_osc_control_set() attempt to find the handle of the
_OSC object under the given PCI root bridge object after verifying
that its second argument is correct and that there is a struct
acpi_pci_root object for the given root bridge handle, which is
more logical than the old code.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Reviewed-by: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
---
 drivers/acpi/pci_root.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Index: linux-2.6/drivers/acpi/pci_root.c
===================================================================
--- linux-2.6.orig/drivers/acpi/pci_root.c
+++ linux-2.6/drivers/acpi/pci_root.c
@@ -378,10 +378,6 @@ acpi_status acpi_pci_osc_control_set(acp
 	acpi_handle tmp;
 	struct acpi_pci_root *root;
 
-	status = acpi_get_handle(handle, "_OSC", &tmp);
-	if (ACPI_FAILURE(status))
-		return status;
-
 	control_req = (flags & OSC_PCI_CONTROL_MASKS);
 	if (!control_req)
 		return AE_TYPE;
@@ -390,6 +386,10 @@ acpi_status acpi_pci_osc_control_set(acp
 	if (!root)
 		return AE_NOT_EXIST;
 
+	status = acpi_get_handle(handle, "_OSC", &tmp);
+	if (ACPI_FAILURE(status))
+		return status;
+
 	mutex_lock(&osc_lock);
 	/* No need to evaluate _OSC if the control was already granted. */
 	if ((root->osc_control_set & control_req) == control_req)

