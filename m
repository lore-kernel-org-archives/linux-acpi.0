From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: 2.6.18-rc1-mm1
Date: Sun, 9 Jul 2006 22:35:16 -0700
Message-ID: <20060709223516.f70827e1.rdunlap@xenotime.net>
References: <20060709021106.9310d4d1.akpm@osdl.org>
	<44B0E6E6.6070904@reub.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:11686 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751079AbWGJFca (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 10 Jul 2006 01:32:30 -0400
Received: from midway.site ([71.117.253.75]) by xenotime.net for <linux-acpi@vger.kernel.org>; Sun, 9 Jul 2006 22:32:28 -0700
In-Reply-To: <44B0E6E6.6070904@reub.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Reuben Farrelly <reuben-lkml@reub.net>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk, linux-acpi@vger.kernel.org, greg@kroah.com

On Sun, 09 Jul 2006 23:22:14 +1200 Reuben Farrelly wrote:

> 2. Onto some more minor warnings:
> 
> ACPI: bus type pci registered
> PCI: BIOS Bug: MCFG area at f0000000 is not E820-reserved
> PCI: Not using MMCONFIG.
> PCI: Using configuration type 1

Yes, I have all of those.

> ACPI: Interpreter enabled
> 
> Is there any way to verify that there really is a BIOS bug there?  If it is, is 
> there anyone within Intel or are there any known contacts who can push and poke 
> to get this looked at/fixed?  (It's a new Intel board, I'd hope they could get 
> it right..).
> 
> Plus we're not using MMCONFIG - even though I have it enabled.
> 
> Based on previous postings to lkml, I believe Randy Dunlap may have one of these 
> boards too - Randy are you seeing this and the next bunch of warnings I am seeing?

Yes, but Len says that they (*/namespace/*) will be going away.

---
~Randy
