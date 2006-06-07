From: Pavel Troller <patrol@sinus.cz>
Subject: Re: what is MCFG area ?
Date: Wed, 7 Jun 2006 06:15:25 +0200
Message-ID: <20060607041525.GA10931@tangens.sinus.cz>
References: <1149637549.3057.4.camel@localhost.portugal>
Reply-To: Pavel Troller <patrol@sinus.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from tangens.sinus.cz ([195.39.17.8]:43427 "EHLO tangens.sinus.cz")
	by vger.kernel.org with ESMTP id S1750818AbWFGEPc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Jun 2006 00:15:32 -0400
Content-Disposition: inline
In-Reply-To: <1149637549.3057.4.camel@localhost.portugal>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Cc: linux-acpi@vger.kernel.org

> On my buggy computer i get 
> cat dmesg09 | grep  "MM\|MCFG"
> ACPI: MCFG (v001 A M I  OEMMCFG  0x05000602 MSFT 0x00000097) @ 0x000000003ffb0410
> PCI: BIOS Bug: MCFG area is not E820-reserved
> PCI: Not using MMCONFIG.
> PCI-DMA: Disabling IOMMU.

I'm getting exactly the same messages, just the numbers in the MCFG line are
different:
root@arcus:~# dmesg | grep  "MM\|MCFG"
ACPI: MCFG (v001 A M I  OEMMCFG  0x11000524 MSFT 0x00000097) @ 0x000000003f7d03f0
PCI: BIOS Bug: MCFG area is not E820-reserved
PCI: Not using MMCONFIG.
PCI-DMA: Disabling IOMMU.

It's on a MSI motherboard with Intel 945 chipset (MS-7210). The machine
otherwise works very well.
  The "Disabling IOMMU" message I'm getting also on another, Nvidia NF4/Opteron
based board, without this MCFG bug. I think it's unrelated and because Linux
properly detected the BIOS bug and probably fixed it, I think the MCFG message
is harmless. 
               With regards, Pavel Troller
