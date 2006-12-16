From: Len Brown <lenb@kernel.org>
Subject: Re: ACPICA 20061109 regression on Supermicro X7DB8+
Date: Fri, 15 Dec 2006 19:25:48 -0500
Message-ID: <200612151925.48887.lenb@kernel.org>
References: <200612151436.27426.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:41529 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030468AbWLPA0X (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 15 Dec 2006 19:26:23 -0500
Received: from d975xbx2.site (c-65-96-213-102.hsd1.ma.comcast.net [65.96.213.102])
	(authenticated bits=0)
	by hera.kernel.org (8.13.8/8.13.7) with ESMTP id kBG0Pskb032654
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-acpi@vger.kernel.org>; Sat, 16 Dec 2006 00:26:20 GMT
In-Reply-To: <200612151436.27426.lenb@kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

On Friday 15 December 2006 14:36, Len Brown wrote:
> A Supermicro X7DB8+ does not boot for me -- SCSI driver dies.
> I'll send more details when I get a chance to narrow it down.
> 
> -Len
> 
> < ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P2._PRT]
> < ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P2.BMD0._PRT]
> < ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P2.BMD0.BPD0.PXH0._PRT]
> < ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P2.BMD0.BPD0.PXH1._PRT]
> < ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P2.BMD0.BPD2._PRT]
> < ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P2.BMF3._PRT]
> < ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P4._PRT]
> < ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P6._PRT]
> < ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX0._PRT]
> < ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
> 268a318,327
> > ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P2._PRT]
> > ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P2.BMD0._PRT]
> > ACPI Exception (pci_bind-0153): AE_NOT_FOUND, Invalid ACPI-PCI context for parent device BPD0 [20061109]
> > ACPI Exception (pci_bind-0153): AE_NOT_FOUND, Invalid ACPI-PCI context for parent device BPD0 [20061109]

Neither 2.6.19.1 nor 2.6.19+ACPICA 20061109 show this exception
So either it is transient, or it comes in some later 2.6.20-related patch.
(and the SCSI, hanging off a PCIX AIC79XXX works fine)

-Len

> > ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P2.BMD0.BPD2._PRT]
> > ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P2.BMF3._PRT]
> > ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P4._PRT]
> > ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P6._PRT]
> > ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX0._PRT]
> > ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
