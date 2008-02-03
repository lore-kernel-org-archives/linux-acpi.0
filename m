From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 1/3] PCI ACPI: Fix comment describing acpi_pci_choose_state
Date: Sun, 3 Feb 2008 22:53:31 +0100
Message-ID: <200802032253.31780.rjw@sisk.pl>
References: <200802032252.04852.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:41726 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751218AbYBCWCj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 3 Feb 2008 17:02:39 -0500
In-Reply-To: <200802032252.04852.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, pm list <linux-pm@lists.linux-foundation.org>

From: Rafael J. Wysocki <rjw@sisk.pl>

The last line of the comment preceding the definition of
acpi_pci_choose_state() is incorrect.  Remove it.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/pci/pci-acpi.c |    2 --
 1 file changed, 2 deletions(-)

Index: linux-2.6/drivers/pci/pci-acpi.c
===================================================================
--- linux-2.6.orig/drivers/pci/pci-acpi.c
+++ linux-2.6/drivers/pci/pci-acpi.c
@@ -241,8 +241,6 @@ EXPORT_SYMBOL(pci_osc_control_set);
  *	choose from highest power _SxD to lowest power _SxW
  * else // no _PRW at S-state x
  * 	choose highest power _SxD or any lower power
- *
- * currently we simply return _SxD, if present.
  */
 
 static pci_power_t acpi_pci_choose_state(struct pci_dev *pdev,

