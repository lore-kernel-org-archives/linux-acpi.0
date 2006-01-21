From: Fabio Venturi <fabio.venturi@studenti.unipr.it>
Subject: Re: Gentoo on Acer Aspire 3502WLCi with bugged DSDT (Phoenix BIOS)
Date: Sat, 21 Jan 2006 16:44:16 +0100
Message-ID: <1137858256.25402.19.camel@redstar>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005C6CEF2@hdsmsx401.amr.corp.intel.com>
	 <1137752031.26366.14.camel@redstar> <20060120130936.GA21264@poupinou.org>
	 <20060120132434.GB21264@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from as1.cineca.com ([130.186.84.251]:13716 "EHLO as1.cineca.com")
	by vger.kernel.org with ESMTP id S1750769AbWAUOnk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 21 Jan 2006 09:43:40 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by as1.cineca.com (Postfix) with ESMTP id B74F571490
	for <linux-acpi@vger.kernel.org>; Sat, 21 Jan 2006 15:43:31 +0100 (CET)
Received: from unipr.mm.cineca.it (unipr.mm.cineca.it [130.186.10.204])
	by as1.cineca.com (Postfix) with ESMTP id DC6987148F
	for <linux-acpi@vger.kernel.org>; Sat, 21 Jan 2006 15:43:30 +0100 (CET)
Received: from host82-138.pool8253.interbusiness.it (host82-138.pool8253.interbusiness.it [82.53.138.82])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	as user fabio.venturi@studenti.unipr.it by unipr.mm.cineca.it (Postfix) with ESMTP id CD867265439
	for <linux-acpi@vger.kernel.org>; Sat, 21 Jan 2006 15:43:29 +0100 (MET)
In-Reply-To: <20060120132434.GB21264@poupinou.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


> On Fri, Jan 20, 2006 at 02:09:36PM +0100, Bruno Ducrot wrote:
> > On Fri, Jan 20, 2006 at 11:13:51AM +0100, Fabio Venturi wrote:
> > > Thank you for the answer ,
> > > as i wrote, i already downloaded (from the ACPI site)
> > > and compiled with iasl a bug-fixed DSDT for my laptop,
> > > the problem is I can't make the kernel read it during the boot.
> > > In a gentoo forum (http://forums.gentoo.org/viewtopic.php?t=122145)
> > > i found that i can pass the new DSDT.aml to the kernel
> > > like an initrd image so i changes grub.conf like this:
> > > 
> > > [...]
> > > title Gentoo GNU/Linux (Fixed DSDT)
> > > kernel (hd0,2)/boot/bzImage-2.6.15 root=/dev/hda3
> > > initrd=(hd0,2)/boot/DSDT.aml
> > > [...]
> > > 
> > > but when the system finish to boot, "dmsg |grep -i dsdt" says:
> > > 
> > > ACPI: DSDT (v001 PTLTD     661MX 0x06040000 MSFT 0x0100000e) @
> > > 0x00000000
> > > ACPI: Looking for DSDT in initramfs... error, file /DSDT.aml not found.
> > > Table [DSDT](id 0006) - 485 Objects with 39 Devices 93 Methods 10
> > > Regions
> > > 
> > > So the original DSDT from the BIOS is loaded instead of
> > > loading the custom one.
> > > (Yes, i activate the CONFIG_ACPI_CUSTOM_DSDT, RamDisk Support ecc..
> > > options)
> > 
> > What wanted to tell you Len is that you should consider the other method
> > as pointed by gentoo link you provided (the static one, instead of the
> > initrd method).  This method is now in mainstream, so you don't have to
> > patch the kernel anymore.
> > 
> > Just get for example a kernel version 2.6.15, then you must have
> > something like that:
> > 
> > # CONFIG_STANDALONE is not set
> > CONFIG_ACPI_CUSTOM_DSDT=y
> > CONFIG_ACPI_CUSTOM_DSDT_FILE="/path/to/foo.hex"
> > 
> > where foo.hex is a C header file (NOT an aml one) that is generated
> > by the command
> > iasl -p foo -tc foo.dsl
> > 
> 
> BTW if you have a problem with your battery and that's why you have to
> override the DSDT, you should consider to *NOT* override it, and instead
> test Len's next ACPI release.
> 
> http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/test/2.6.15/
> 
> Instead of doing some black magic, you also will be able to report if
> the workaround made by ACPI intel developers is helpful for your laptop.
> 

GREAT! Everything is working well now and all I did was:
trash the existing kernel, decompress the vanilla 2.6.15 kernel
(I don't know if this work also with custom kernel), patched to the
last stable 2.6.15-1 and, as Bruno Ducrot suggested, patched
with Len Brown's patch found at:
http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/test/2.6.15/acpi-test-20051216-2.6.15.diff.bz2
and now the battery (the only device with a problem) is regularly
monitored by ACPI.
If you need some dumps or my kernel .config file just tell me,
I'll sent it immediately.
Thank you very much for the great help you gave me!
Regards
Fabio


