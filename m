From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch] ACPI: stop complaints about interrupt link End Tags and blank IRQ descriptors
Date: Tue, 15 Jul 2008 09:42:57 -0600
Message-ID: <200807150942.57756.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0026.austin.hp.com ([15.216.28.33]:38015 "EHLO
	g1t0026.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752094AbYGOPnr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Jul 2008 11:43:47 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Gabriele Trombetti <g.trombetti.lkrnl1213@logicschema.com>, yakui.zhao@intel.com

Silently ignore _PRS End Tags.  We already ignore Start Dependent Functions in
_PRS, and we already ignore End Tags in _CRS, so we might as well ignore End
Tags in _PRS as well.

Silently ignore _PRS IRQ descriptors that mention no interrupts.  The spec
allows this (section 6.4.2.1 in ACPI 3.0b spec), and it probably means the
interrupt link can't be configured at all.

This patch doesn't change any functional behavior; it just removes confusing
complaints like these:

    ACPI: Blank IRQ resource
    ACPI: Resource is not an IRQ entry

when parsing _PRS data "23 00 00 18 79 00" from an IBM xSeries 335 dual
Pentium IV Xeon 2.40 GHz machine.  For more details, see
    http://bugzilla.kernel.org/show_bug.cgi?id=11049

The "23 00 00 18" part is a three-byte-long small IRQ resource with no bits set
in the IRQ mask ("00 00"), and level-triggered, active low, shareable ("18").

The "79 00" is an End Tag (type 0x7).  It is superfluous since there is no
Start Dependent Function tag and there are no resources after it, but it is
harmless.

Thanks to Gabriele Trombetti <g.trombetti.lkrnl1213@logicschema.com>
(aka Kurk) for reporting this and testing the patch.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work14/drivers/acpi/pci_link.c
===================================================================
--- work14.orig/drivers/acpi/pci_link.c	2008-07-10 15:23:38.000000000 -0600
+++ work14/drivers/acpi/pci_link.c	2008-07-10 15:23:52.000000000 -0600
@@ -113,20 +113,23 @@ acpi_pci_link_check_possible(struct acpi
 
 	switch (resource->type) {
 	case ACPI_RESOURCE_TYPE_START_DEPENDENT:
+	case ACPI_RESOURCE_TYPE_END_TAG:
 		return AE_OK;
 	case ACPI_RESOURCE_TYPE_IRQ:
 		{
 			struct acpi_resource_irq *p = &resource->data.irq;
 			if (!p || !p->interrupt_count) {
-				printk(KERN_WARNING PREFIX "Blank IRQ resource\n");
+				ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+						  "Blank _PRS IRQ resource\n"));
 				return AE_OK;
 			}
 			for (i = 0;
 			     (i < p->interrupt_count
 			      && i < ACPI_PCI_LINK_MAX_POSSIBLE); i++) {
 				if (!p->interrupts[i]) {
-					printk(KERN_WARNING PREFIX "Invalid IRQ %d\n",
-						      p->interrupts[i]);
+					printk(KERN_WARNING PREFIX
+					       "Invalid _PRS IRQ %d\n",
+					       p->interrupts[i]);
 					continue;
 				}
 				link->irq.possible[i] = p->interrupts[i];
@@ -143,15 +146,16 @@ acpi_pci_link_check_possible(struct acpi
 			    &resource->data.extended_irq;
 			if (!p || !p->interrupt_count) {
 				printk(KERN_WARNING PREFIX
-					      "Blank EXT IRQ resource\n");
+					      "Blank _PRS EXT IRQ resource\n");
 				return AE_OK;
 			}
 			for (i = 0;
 			     (i < p->interrupt_count
 			      && i < ACPI_PCI_LINK_MAX_POSSIBLE); i++) {
 				if (!p->interrupts[i]) {
-					printk(KERN_WARNING PREFIX "Invalid IRQ %d\n",
-						      p->interrupts[i]);
+					printk(KERN_WARNING PREFIX
+					       "Invalid _PRS IRQ %d\n",
+					       p->interrupts[i]);
 					continue;
 				}
 				link->irq.possible[i] = p->interrupts[i];
@@ -163,7 +167,8 @@ acpi_pci_link_check_possible(struct acpi
 			break;
 		}
 	default:
-		printk(KERN_ERR PREFIX "Resource is not an IRQ entry\n");
+		printk(KERN_ERR PREFIX "_PRS resource type 0x%x isn't an IRQ\n",
+		       resource->type);
 		return AE_OK;
 	}
 
@@ -199,6 +204,9 @@ acpi_pci_link_check_current(struct acpi_
 
 
 	switch (resource->type) {
+	case ACPI_RESOURCE_TYPE_START_DEPENDENT:
+	case ACPI_RESOURCE_TYPE_END_TAG:
+		return AE_OK;
 	case ACPI_RESOURCE_TYPE_IRQ:
 		{
 			struct acpi_resource_irq *p = &resource->data.irq;
@@ -208,7 +216,7 @@ acpi_pci_link_check_current(struct acpi_
 				 * particularly those those w/ _STA disabled
 				 */
 				ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-						  "Blank IRQ resource\n"));
+						  "Blank _CRS IRQ resource\n"));
 				return AE_OK;
 			}
 			*irq = p->interrupts[0];
@@ -224,7 +232,7 @@ acpi_pci_link_check_current(struct acpi_
 				 * return at least 1 IRQ
 				 */
 				printk(KERN_WARNING PREFIX
-					      "Blank EXT IRQ resource\n");
+					      "Blank _CRS EXT IRQ resource\n");
 				return AE_OK;
 			}
 			*irq = p->interrupts[0];
@@ -232,10 +240,11 @@ acpi_pci_link_check_current(struct acpi_
 		}
 		break;
 	default:
-		printk(KERN_ERR PREFIX "Resource %d isn't an IRQ\n", resource->type);
-	case ACPI_RESOURCE_TYPE_END_TAG:
+		printk(KERN_ERR PREFIX "_CRS resource type 0x%x isn't an IRQ\n",
+		       resource->type);
 		return AE_OK;
 	}
+
 	return AE_CTRL_TERMINATE;
 }
 
