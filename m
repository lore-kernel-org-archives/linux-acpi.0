From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: ACPI exception with 2.6.29-rc6
Date: Mon, 23 Feb 2009 22:25:08 +0100
Message-ID: <200902232225.09408.rjw@sisk.pl>
References: <871vtpqex0.wl%htd@fancy-poultry.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:41855 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752028AbZBWVZq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 23 Feb 2009 16:25:46 -0500
In-Reply-To: <871vtpqex0.wl%htd@fancy-poultry.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Heinz Diehl <htd@fancy-poultry.org>
Cc: linux-kernel@vger-kernel.org, Alexey Starikovskiy <astarikovskiy@suse.de>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, "Moore, Robert" <robert.moore@intel.com>

On Monday 23 February 2009, Heinz Diehl wrote:
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

Well, this looks like a result of some recent ACPICA changes.  ACPI people
CCed.

Thanks,
Rafael
