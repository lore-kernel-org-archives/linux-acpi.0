From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: ACPI CA resource encoding problem
Date: Thu, 22 May 2008 09:48:29 -0700
Message-ID: <9D39833986E69849A2A8E74C1078B6B35F4D93@orsmsx415.amr.corp.intel.com>
References: <200805211725.26397.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:7709 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753510AbYEVQse convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 22 May 2008 12:48:34 -0400
Content-class: urn:content-classes:message
In-Reply-To: <200805211725.26397.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

This has already been addressed by two patches to the ACPICA code. See
bugzilla 9487.


>-----Original Message-----
>From: Bjorn Helgaas [mailto:bjorn.helgaas@hp.com]
>Sent: Wednesday, May 21, 2008 4:25 PM
>To: Len Brown; Moore, Robert
>Cc: linux-acpi@vger.kernel.org
>Subject: ACPI CA resource encoding problem
>
>I've tripped over some devices that work with PNPBIOS but not with
>PNPACPI, even though Linux is configuring the devices identically.
>
>Linux evaluates _CRS to get a template, which it then fills in and
>passes to _SRS to configure the device.  The ACPI CA decodes the AML
>bytestream returned from _CRS into a series of acpi_resource structs.
>
>When Linux evaluates _SRS, the ACPI CA re-encodes the acpi_resource
>structs into an AML bytestream.  However, the encoded bytestream
>sometimes has a different form than that returned from _CRS.
>
>For example, acpi_rs_set_irq encodes a small IRQ descriptor.  If the
>IRQ is edge-sensitive, active high, and exclusive, acpi_rs_set_irq
>optimizes the output AML by omitting the optional flags byte.
>
>I think it would be better for acpi_rs_set_irq to generate an AML
>descriptor that exactly matches the format and size of the descriptor
>we got from _CRS because _SRS may not be smart enough to handle the
>variation.
>
>On a Toshiba Portege 4000, the parport_pc and smsc-ircc2 drivers both
>work with PNPBIOS, and neither works with PNPACPI.  I think the reason
>is this acpi_rs_set_irq optimization.  If I apply the attached patch,
>which removes that optimization, both drivers work with PNPACPI.
>
>I don't claim that this patch is correct, because it *always* generates
>3-byte IRQ descriptors, while _SRS may be expecting a 2-byte
descriptor.
>But I think it is enough to point out a problem.
>
>Bjorn
>
>
>Index: work10/drivers/acpi/resources/rsirq.c
>===================================================================
>--- work10.orig/drivers/acpi/resources/rsirq.c	2008-05-21
>15:14:10.000000000 -0600
>+++ work10/drivers/acpi/resources/rsirq.c	2008-05-21
15:15:11.000000000 -
>0600
>@@ -152,26 +152,6 @@ struct acpi_rsconvert_info acpi_rs_set_i
> 	/* Reset length to 3 bytes (descriptor with flags byte) */
>
> 	{ACPI_RSC_LENGTH, 0, 0, sizeof(struct aml_resource_irq)},
>-
>-	/*
>-	 * Check if the flags byte is necessary. Not needed if the flags
are:
>-	 * ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_HIGH, ACPI_EXCLUSIVE
>-	 */
>-	{ACPI_RSC_EXIT_NE, ACPI_RSC_COMPARE_VALUE,
>-	 ACPI_RS_OFFSET(data.irq.triggering),
>-	 ACPI_EDGE_SENSITIVE},
>-
>-	{ACPI_RSC_EXIT_NE, ACPI_RSC_COMPARE_VALUE,
>-	 ACPI_RS_OFFSET(data.irq.polarity),
>-	 ACPI_ACTIVE_HIGH},
>-
>-	{ACPI_RSC_EXIT_NE, ACPI_RSC_COMPARE_VALUE,
>-	 ACPI_RS_OFFSET(data.irq.sharable),
>-	 ACPI_EXCLUSIVE},
>-
>-	/* We can optimize to a 2-byte irq_no_flags() descriptor */
>-
>-	{ACPI_RSC_LENGTH, 0, 0, sizeof(struct aml_resource_irq_noflags)}
> };
>
>
>/**********************************************************************
****
>*****
