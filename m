From: Thomas Renninger <trenn@suse.de>
Subject: Re: toshiba satelli 1800-712
Date: Tue, 13 Jun 2006 11:37:17 +0200
Message-ID: <1150191437.5124.180.camel@queen.suse.de>
References: <200606071852.34813.maurizio.bongini@poste.it>
	 <1149862557.5124.92.camel@queen.suse.de>
	 <200606101141.42832.maurizio.bongini@poste.it>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:10675 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750831AbWFMJgj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 13 Jun 2006 05:36:39 -0400
In-Reply-To: <200606101141.42832.maurizio.bongini@poste.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Maurizio Bongini <maurizio.bongini@poste.it>
Cc: linux-acpi@vger.kernel.org

On Sat, 2006-06-10 at 11:41 +0200, Maurizio Bongini wrote:
> Hi Thomas
> 
> i searched without results the bugzilla site ....
> my problem seems to be common to other people with my computer and other of 
> the
> same brand...   
> 
> take a look to these links...
> 
> http://www.ussg.iu.edu/hypermail/linux/kernel/0502.1/0946.html
If you have the same problem this is probably not ACPI related.

> http://gentoo-wiki.com/HARDWARE_Gentoo_on_Toshiba_Satellite_3005-S403
> 
> then this one..
> http://www.weizmann.ac.il/home/fesegre/Linux_on_a_Toshiba_Satellite_1800-712.html
> it is reported also by toshiba official  site !  
> http://linux.toshiba-dme.co.jp/linux/eng/pc/sat1800_memo.htm
> 
> 
> two years ago i added myself to the toshiba linux forum but the problem was 
> not
> resolved, as you can see by above links....
> 
> are you in contact with some people  working in toshiba to obtain technical 
> data about ? IMHO this may truly help ,saving a lot of debugging time...
> if you cannot obtain any info ,then ...:
No. This is a very old machine anyway? Ah, do you run the latest BIOS of
the vendor? If not, better upgrade.
> 
> i need to ask you some little questions about your requirements:
> my laptop currently run  with a mandriva 2006 distribution:
> it is the same if i compile an alternate kernel with the existing mandriva
>  source,or you  absolutely need suse ?
> my laptop has a parallel port and i have an old  desktop running mandrake 10.1
> i have not a cross parallel cable...
> i have to find  one it or build it from a normal parallel cutting wires and 
> soldering it making a cross connection ( i already done the work in the past 
> with a lan cable). 
> 
My next try would have been to not load all ACPI and sensor/i2c modules,
but as stated in one of the links above acpi=off works and I doubt this
helps much then.

The one link states, that it does not reboot as soon as "volumes" are
mounted readonly..., maybe this is IDE HW related? No idea.

You may want to try to find out at which particular part the system
hangs. You need a serial cable (maybe you still get a backtrace with
sysreq-T?), long endurance and some luck.

Sorry, I can't really help here.

        Thomas
> Thanks
> 
>  Maurizio 
> 
>  
> 
> On Friday 09 June 2006 16:15, Thomas Renninger wrote:
> > Does the laptop have a serial adapter?
> > If not, I don't know how to debug that (There will be firescope to
> > redirect kernel output over firewire, but that is future).
> >
> > If yes, connect the machine over a crossed serial cable with another
> > one. On the remote machine watch the serial output with e.g.
> > screen /dev/ttyS0 57600
> > On the machine that gets debugged add the kernel option
> > console=ttyS0,57600
> > You should now see the kernel messages popping up on the remote screen
> > session.
> >
> > Try to boot a SuSE debug kernel.
> > If it does not boot you have to compile the kernel yourself:
> >  - Install the kernel-source.rpm
> >  - cd /usr/src/linux
> >  - cp arch/i386/defconfig.default .config
> >  - Edit .config and search for ACPI_DEBUG and set this line to:
> >      ACPI_DEBUG=y
> >  - make
> >  - make install modules_install
> >  - mkinitrd
> >  - add a new boot entry for the kernel/initrd in /boot/grub/menu.lst
> >  - reboot
> >
> > Now you can enable extended ACPI debugging (carefully, not too high):
> > echo 0x1F >/proc/acpi/debug_level
> >
> > I wonder whether the machine hangs while processing some ACPI functions
> > and which.
> >
> > Best you first search on http://bugzilla.kernel.org whether a similar
> > bug exists and try to help there.
> > If there is none, create a new one describing your problem, assign it to
> > the ACPI component and take me into CC, please.
> >
> > Thanks,
> >
> >      Thomas
> >

