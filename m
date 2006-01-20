From: Bruno Ducrot <ducrot@poupinou.org>
Subject: Re: Gentoo on Acer Aspire 3502WLCi with bugged DSDT (Phoenix BIOS)
Date: Fri, 20 Jan 2006 14:24:34 +0100
Message-ID: <20060120132434.GB21264@poupinou.org>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005C6CEF2@hdsmsx401.amr.corp.intel.com> <1137752031.26366.14.camel@redstar> <20060120130936.GA21264@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from poup.poupinou.org ([195.101.94.96]:64772 "EHLO
	poup.poupinou.org") by vger.kernel.org with ESMTP id S1750952AbWATNYi
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 20 Jan 2006 08:24:38 -0500
Content-Disposition: inline
In-Reply-To: <20060120130936.GA21264@poupinou.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Fabio Venturi <fabio.venturi@studenti.unipr.it>
Cc: "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org

On Fri, Jan 20, 2006 at 02:09:36PM +0100, Bruno Ducrot wrote:
> On Fri, Jan 20, 2006 at 11:13:51AM +0100, Fabio Venturi wrote:
> > Thank you for the answer ,
> > as i wrote, i already downloaded (from the ACPI site)
> > and compiled with iasl a bug-fixed DSDT for my laptop,
> > the problem is I can't make the kernel read it during the boot.
> > In a gentoo forum (http://forums.gentoo.org/viewtopic.php?t=122145)
> > i found that i can pass the new DSDT.aml to the kernel
> > like an initrd image so i changes grub.conf like this:
> > 
> > [...]
> > title Gentoo GNU/Linux (Fixed DSDT)
> > kernel (hd0,2)/boot/bzImage-2.6.15 root=/dev/hda3
> > initrd=(hd0,2)/boot/DSDT.aml
> > [...]
> > 
> > but when the system finish to boot, "dmsg |grep -i dsdt" says:
> > 
> > ACPI: DSDT (v001 PTLTD     661MX 0x06040000 MSFT 0x0100000e) @
> > 0x00000000
> > ACPI: Looking for DSDT in initramfs... error, file /DSDT.aml not found.
> > Table [DSDT](id 0006) - 485 Objects with 39 Devices 93 Methods 10
> > Regions
> > 
> > So the original DSDT from the BIOS is loaded instead of
> > loading the custom one.
> > (Yes, i activate the CONFIG_ACPI_CUSTOM_DSDT, RamDisk Support ecc..
> > options)
> 
> What wanted to tell you Len is that you should consider the other method
> as pointed by gentoo link you provided (the static one, instead of the
> initrd method).  This method is now in mainstream, so you don't have to
> patch the kernel anymore.
> 
> Just get for example a kernel version 2.6.15, then you must have
> something like that:
> 
> # CONFIG_STANDALONE is not set
> CONFIG_ACPI_CUSTOM_DSDT=y
> CONFIG_ACPI_CUSTOM_DSDT_FILE="/path/to/foo.hex"
> 
> where foo.hex is a C header file (NOT an aml one) that is generated
> by the command
> iasl -p foo -tc foo.dsl
> 

BTW if you have a problem with your battery and that's why you have to
override the DSDT, you should consider to *NOT* override it, and instead
test Len's next ACPI release.

http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/test/2.6.15/

Instead of doing some black magic, you also will be able to report if
the workaround made by ACPI intel developers is helpful for your laptop.

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.
