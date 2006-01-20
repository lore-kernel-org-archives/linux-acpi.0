From: Fabio Venturi <fabio.venturi@studenti.unipr.it>
Subject: RE: Gentoo on Acer Aspire 3502WLCi with bugged DSDT (Phoenix BIOS)
Date: Fri, 20 Jan 2006 11:13:51 +0100
Message-ID: <1137752031.26366.14.camel@redstar>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005C6CEF2@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from as1.cineca.com ([130.186.84.251]:2486 "EHLO as1.cineca.com")
	by vger.kernel.org with ESMTP id S1750797AbWATKNR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 20 Jan 2006 05:13:17 -0500
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B3005C6CEF2@hdsmsx401.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org

Thank you for the answer ,
as i wrote, i already downloaded (from the ACPI site)
and compiled with iasl a bug-fixed DSDT for my laptop,
the problem is I can't make the kernel read it during the boot.
In a gentoo forum (http://forums.gentoo.org/viewtopic.php?t=122145)
i found that i can pass the new DSDT.aml to the kernel
like an initrd image so i changes grub.conf like this:

[...]
title Gentoo GNU/Linux (Fixed DSDT)
kernel (hd0,2)/boot/bzImage-2.6.15 root=/dev/hda3
initrd=(hd0,2)/boot/DSDT.aml
[...]

but when the system finish to boot, "dmsg |grep -i dsdt" says:

ACPI: DSDT (v001 PTLTD     661MX 0x06040000 MSFT 0x0100000e) @
0x00000000
ACPI: Looking for DSDT in initramfs... error, file /DSDT.aml not found.
Table [DSDT](id 0006) - 485 Objects with 39 Devices 93 Methods 10
Regions

So the original DSDT from the BIOS is loaded instead of
loading the custom one.
(Yes, i activate the CONFIG_ACPI_CUSTOM_DSDT, RamDisk Support ecc..
options)
I hope I clearly explained my problem (in a bad english :oP ),
thank you for this and any further help
regards
Fabio

Il giorno ven, 20/01/2006 alle 00.57 -0500, Brown, Len ha scritto:
> Note that in most cases when Linux doesn't digest the DSDT
> that the vendor shipped, it is a Linux bug that needs to
> be filed and fixed.  We're not taking the moral high ground here,
> in most cases we're trying to be resilient to the bugs
> in DSDTs that Windows allows.
> 
> That said, if you want to run a custom DSDT and you're
> building a custom kernel for the box, then simply
> use the CONFIG_ACPI_CUSTOM_DSDT option.
> 
> cheers,
> -Len
> 

