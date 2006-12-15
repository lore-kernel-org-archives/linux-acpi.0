From: Len Brown <lenb@kernel.org>
Subject: ACPICA 20061109 regression on Supermicro X7DB8+
Date: Fri, 15 Dec 2006 14:36:27 -0500
Message-ID: <200612151436.27426.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:51934 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753283AbWLOThB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 15 Dec 2006 14:37:01 -0500
Received: from d975xbx2.site (c-65-96-213-102.hsd1.ma.comcast.net [65.96.213.102])
	(authenticated bits=0)
	by hera.kernel.org (8.13.8/8.13.7) with ESMTP id kBFJaW2f009833
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-acpi@vger.kernel.org>; Fri, 15 Dec 2006 19:36:59 GMT
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

A Supermicro X7DB8+ does not boot for me -- SCSI driver dies.

Possibly related to this difference -- which by itself is a regression.

I'll send more details when I get a chance to narrow it down.

-Len

< ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P2._PRT]
< ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P2.BMD0._PRT]
< ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P2.BMD0.BPD0.PXH0._PRT]
< ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P2.BMD0.BPD0.PXH1._PRT]
< ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P2.BMD0.BPD2._PRT]
< ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P2.BMF3._PRT]
< ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P4._PRT]
< ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P6._PRT]
< ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX0._PRT]
< ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
268a318,327
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P2._PRT]
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P2.BMD0._PRT]
> ACPI Exception (pci_bind-0153): AE_NOT_FOUND, Invalid ACPI-PCI context for parent device BPD0 [20061109]
> ACPI Exception (pci_bind-0153): AE_NOT_FOUND, Invalid ACPI-PCI context for parent device BPD0 [20061109]
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P2.BMD0.BPD2._PRT]
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P2.BMF3._PRT]
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P4._PRT]
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P6._PRT]
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX0._PRT]
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
