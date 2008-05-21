From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: ACPI CA resource encoding problem
Date: Wed, 21 May 2008 17:25:26 -0600
Message-ID: <200805211725.26397.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0009.atlanta.hp.com ([15.192.0.46]:31052 "EHLO
	g5t0009.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761698AbYEUXZX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 21 May 2008 19:25:23 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, "Moore, Robert" <robert.moore@intel.com>
Cc: linux-acpi@vger.kernel.org

I've tripped over some devices that work with PNPBIOS but not with
PNPACPI, even though Linux is configuring the devices identically.

Linux evaluates _CRS to get a template, which it then fills in and
passes to _SRS to configure the device.  The ACPI CA decodes the AML
bytestream returned from _CRS into a series of acpi_resource structs.

When Linux evaluates _SRS, the ACPI CA re-encodes the acpi_resource
structs into an AML bytestream.  However, the encoded bytestream
sometimes has a different form than that returned from _CRS.

For example, acpi_rs_set_irq encodes a small IRQ descriptor.  If the
IRQ is edge-sensitive, active high, and exclusive, acpi_rs_set_irq
optimizes the output AML by omitting the optional flags byte.

I think it would be better for acpi_rs_set_irq to generate an AML
descriptor that exactly matches the format and size of the descriptor
we got from _CRS because _SRS may not be smart enough to handle the
variation.

On a Toshiba Portege 4000, the parport_pc and smsc-ircc2 drivers both
work with PNPBIOS, and neither works with PNPACPI.  I think the reason
is this acpi_rs_set_irq optimization.  If I apply the attached patch,
which removes that optimization, both drivers work with PNPACPI.

I don't claim that this patch is correct, because it *always* generates
3-byte IRQ descriptors, while _SRS may be expecting a 2-byte descriptor.
But I think it is enough to point out a problem.

Bjorn


Index: work10/drivers/acpi/resources/rsirq.c
===================================================================
--- work10.orig/drivers/acpi/resources/rsirq.c	2008-05-21 15:14:10.000000000 -0600
+++ work10/drivers/acpi/resources/rsirq.c	2008-05-21 15:15:11.000000000 -0600
@@ -152,26 +152,6 @@ struct acpi_rsconvert_info acpi_rs_set_i
 	/* Reset length to 3 bytes (descriptor with flags byte) */
 
 	{ACPI_RSC_LENGTH, 0, 0, sizeof(struct aml_resource_irq)},
-
-	/*
-	 * Check if the flags byte is necessary. Not needed if the flags are:
-	 * ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_HIGH, ACPI_EXCLUSIVE
-	 */
-	{ACPI_RSC_EXIT_NE, ACPI_RSC_COMPARE_VALUE,
-	 ACPI_RS_OFFSET(data.irq.triggering),
-	 ACPI_EDGE_SENSITIVE},
-
-	{ACPI_RSC_EXIT_NE, ACPI_RSC_COMPARE_VALUE,
-	 ACPI_RS_OFFSET(data.irq.polarity),
-	 ACPI_ACTIVE_HIGH},
-
-	{ACPI_RSC_EXIT_NE, ACPI_RSC_COMPARE_VALUE,
-	 ACPI_RS_OFFSET(data.irq.sharable),
-	 ACPI_EXCLUSIVE},
-
-	/* We can optimize to a 2-byte irq_no_flags() descriptor */
-
-	{ACPI_RSC_LENGTH, 0, 0, sizeof(struct aml_resource_irq_noflags)}
 };
 
 /*******************************************************************************
