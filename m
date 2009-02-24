From: Heinz Diehl <htd@fancy-poultry.org>
Subject: Re: ACPI exception with 2.6.29-rc6
Date: Tue, 24 Feb 2009 16:01:52 +0100
Message-ID: <20090224150152.GA4885@fancy-poultry.org>
References: <871vtpqex0.wl%htd@fancy-poultry.org> <20090223150749.0b284ba2.akpm@linux-foundation.org> <alpine.LFD.2.00.0902232128340.16923@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.188]:63037 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753695AbZBXO5P (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Feb 2009 09:57:15 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0902232128340.16923@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger-kernel.org, linux-acpi@vger.kernel.org

On 24.02.2009, Len Brown wrote: 

> Please attach the output of acpidump here:
> http://bugzilla.kernel.org/show_bug.cgi?id=12758

Did just upload the attachment.

> Also, if this system has both pic and IOAPIC mode,
> it would be interesting to try booting it in both,
> eg with "noapic".

Booting with the "noapic" option, the logfile shows:

[....]
<7>bus: 00 index 3 mmio: [d0000000, efffffff]
<7>bus: 00 index 4 mmio: [230000000, fcffffffff]
<6>ACPI: bus type pci registered
<5>PCI: MCFG configuration 0: base f0000000 segment 0 buses 0 - 127
<5>PCI: MCFG area at f0000000 reserved in E820
<6>PCI: Using MMCONFIG at f0000000 - f7ffffff
<6>PCI: Using configuration type 1 for base access
<4>bio: create slab <bio-0> at 0
<7>ACPI: EC: Look up EC in DSDT
<3>ACPI: Denied BIOS AML access to invalid port 0x4d0+0x2 (ELCR)
<4>ACPI Exception (dsopcode-0419): AE_AML_ILLEGAL_ADDRESS, During address validation of OpRegion [ELCR] [20081204]
<6>ACPI: Interpreter enabled
<6>ACPI: (supports S0 S1 S5)
<6>ACPI: Using PIC for interrupt routing
<6>ACPI: No dock devices found.
<6>ACPI: PCI Root Bridge [PCI0] (0000:00)
<7>pci 0000:00:01.1: reg 10 io port: [0xe800-0xe83f]
[....]

Greetings, 
Heinz.
