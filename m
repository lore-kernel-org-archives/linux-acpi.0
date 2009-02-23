From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: ACPI exception with 2.6.29-rc6
Date: Mon, 23 Feb 2009 15:07:49 -0800
Message-ID: <20090223150749.0b284ba2.akpm@linux-foundation.org>
References: <871vtpqex0.wl%htd@fancy-poultry.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:37617 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754867AbZBWXH7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 23 Feb 2009 18:07:59 -0500
In-Reply-To: <871vtpqex0.wl%htd@fancy-poultry.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Heinz Diehl <htd@fancy-poultry.org>
Cc: linux-kernel@vger-kernel.org, linux-acpi@vger.kernel.org

(cc linux-acpi)

On Mon, 23 Feb 2009 17:46:51 +0100
Heinz Diehl <htd@fancy-poultry.org> wrote:

> Hi,
> 
> booting 2.6.29-rc6 shows the following in boot.log:
> 
> [....]
> <7>bus: 00 index 4 mmio: [230000000, fcffffffff]
> <6>ACPI: bus type pci registered
> <5>PCI: MCFG configuration 0: base f0000000 segment 0 buses 0 - 127
> <5>PCI: MCFG area at f0000000 reserved in E820
> <6>PCI: Using MMCONFIG at f0000000 - f7ffffff
> <6>PCI: Using configuration type 1 for base access
> <4>bio: create slab <bio-0> at 0
> <7>ACPI: EC: Look up EC in DSDT
> --> <3>ACPI: Denied BIOS AML access to invalid port 0x4d0+0x2 (ELCR)
> --> <4>ACPI Exception (dsopcode-0419): AE_AML_ILLEGAL_ADDRESS, During address validation of OpRegion [ELCR] [20081204]
> <6>ACPI: Interpreter enabled
> <6>ACPI: (supports S0 S1 S5)
> <6>ACPI: Using IOAPIC for interrupt routing
> <6>ACPI: No dock devices found.
> <6>ACPI: PCI Root Bridge [PCI0] (0000:00)
> <7>pci 0000:00:01.1: reg 10 io port: [0xe800-0xe83f]
> [....]
> 
> ...while 2.6.28.7 boots without showing any ACPI exception:
> 
> [....]
> <7>bus: 00 index 3 mmio: [d0000000, efffffff]
> <7>bus: 00 index 4 mmio: [230000000, fcffffffff]
> <6>ACPI: bus type pci registered
> <5>PCI: MCFG configuration 0: base f0000000 segment 0 buses 0 - 127
> <5>PCI: MCFG area at f0000000 reserved in E820
> <6>PCI: Using MMCONFIG at f0000000 - f7ffffff
> <6>PCI: Using configuration type 1 for base access
> <7>ACPI: EC: Look up EC in DSDT
> <6>ACPI: Interpreter enabled
> <6>ACPI: (supports S0 S1 S5)
> <6>ACPI: Using IOAPIC for interrupt routing
> <6>ACPI: No dock devices found.
> <6>ACPI: PCI Root Bridge [PCI0] (0000:00)
> <7>pci 0000:00:01.1: reg 10 io port: [0xe800-0xe83f]
> [....]

Are there any observeable effects from this apart from the scary
message?

Thanks.

