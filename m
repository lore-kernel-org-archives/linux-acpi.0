From: Adrian Bunk <bunk@stusta.de>
Subject: Re: Fw: ata-piix ACPI errors
Date: Sat, 24 Feb 2007 23:13:49 +0100
Message-ID: <20070224221349.GR12392@stusta.de>
References: <20070223020856.641452a3.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailout.stusta.mhn.de ([141.84.69.5]:43349 "EHLO
	mailhub.stusta.mhn.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933567AbXBXWNz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 24 Feb 2007 17:13:55 -0500
Content-Disposition: inline
In-Reply-To: <20070223020856.641452a3.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-acpi@vger.kernel.org, Meelis Roos <mroos@linux.ee>

On Fri, Feb 23, 2007 at 02:08:56AM -0800, Andrew Morton wrote:
> 
> I'm starting to think that big acpi merge came a bit too soon.
> 
> Begin forwarded message:

Thanks, noted.

> Date: Thu, 22 Feb 2007 15:29:42 +0200 (EET)
> From: Meelis Roos <mroos@linux.ee>
> To: Linux Kernel list <linux-kernel@vger.kernel.org>
> Subject: ata-piix ACPI errors
> 
> 
> Testbooted 2.6.21-rc1+todays git on a PC with Intel 845 chipset and PATA 
> HDD. Works fine but I now have these ACPI errors in dmesg, maybe someone 
> is interested:
> 
> ata_piix 0000:00:1f.1: version 2.00ac7
> PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
> ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
> PCI: Setting latency timer of device 0000:00:1f.1 to 64
> ata1: PATA max UDMA/100 cmd 0x000101f0 ctl 0x000103f6 bmdma 0x0001ffa0 irq 14
> ata2: PATA max UDMA/100 cmd 0x00010170 ctl 0x00010376 bmdma 0x0001ffa8 irq 15
> scsi0 : ata_piix
> ACPI Error (dsopcode-0481): Attempt to CreateField of length zero [20070126]
> ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.IDE0.RATA] (Node c18edbf8), AE_AML_OPERAND_VALUE
> ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.IDE0.CHN0.DRV0._GTF] (Node c18ed608), AE_AML_OPERAND_VALUE
> ata1.00: ATA-5: ST380021A, 3.19, max UDMA/100
> ata1.00: 156301488 sectors, multi 16: LBA
> ACPI Error (dsopcode-0481): Attempt to CreateField of length zero [20070126]
> ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.IDE0.RATA] (Node c18edbf8), AE_AML_OPERAND_VALUE
> ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.IDE0.CHN0.DRV0._GTF] (Node c18ed608), AE_AML_OPERAND_VALUE
> ata1.00: configured for UDMA/100
> scsi1 : ata_piix
> ACPI Error (dsopcode-0481): Attempt to CreateField of length zero [20070126]
> ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.IDE0.RATA] (Node c18edbf8), AE_AML_OPERAND_VALUE
> ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.IDE0.CHN1.DRV0._GTF] (Node c18ed464), AE_AML_OPERAND_VALUE
> ata2.00: ATAPI, max UDMA/33
> ACPI Error (dsopcode-0481): Attempt to CreateField of length zero [20070126]
> ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.IDE0.RATA] (Node c18edbf8), AE_AML_OPERAND_VALUE
> ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.IDE0.CHN1.DRV0._GTF] (Node c18ed464), AE_AML_OPERAND_VALUE
> ata2.00: configured for UDMA/33
> scsi 0:0:0:0: Direct-Access     ATA      ST380021A        3.19 PQ: 0 ANSI: 5
> scsi 1:0:0:0: CD-ROM            _NEC     DV-5800B         G9H3 PQ: 0 ANSI: 5
> 
> -- 
> Meelis Roos (mroos@linux.ee)

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

