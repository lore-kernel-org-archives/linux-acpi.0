From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: hp dv8000t dead on resume from RAM
Date: Wed, 9 Aug 2006 21:59:53 +0200
Message-ID: <200608092159.53230.rjw@sisk.pl>
References: <1155057311.44d8c69f3f2fc@webmail.stanford.edu> <200608082230.54788.rjw@sisk.pl> <44DA2316.1060006@stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:52451 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751316AbWHIUAz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Aug 2006 16:00:55 -0400
In-Reply-To: <44DA2316.1060006@stanford.edu>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Brannon Klopfer <bklopfer@stanford.edu>
Cc: linux-acpi@vger.kernel.org, acpi@linux.intel.com, pavel@suse.cz

On Wednesday 09 August 2006 20:01, Brannon Klopfer wrote:
> Rafael J. Wysocki wrote:
> > On Tuesday 08 August 2006 19:15, Brannon Barrett Klopfer wrote:
> >   
> >> Howdy,
> >>
> >> My hp dv8000t (core duo) is completely dead on resume from RAM (no caps
> >> lock, sysrq, netconsole,
> >> nothing). I've tried a recent (2.6.18-rc4) kernel running almost entirely
> >> naked, so to speak (~990K) -- no support for:
> >>
> >> SMP
> >> preempt
> >> modules
> >> networking (+ enet drivers, unless running netconsole)
> >> USB and SATA (not at same time; rootfs is either usb drive or SATA [ext2/3])
> >> FireWire
> >> cpufreq
> >> framebuffer (vga=0)
> >> audio
> >> PCMCIA
> >> IDE (for cdrom)
> >>
> >> I've tried both native SATA (ahci) and legacy (ata_piix), but same result
> >> w/both -- completely dead on resume from RAM. Blindly entering commands
> >> does nothing, and running "$suspend ; $shutdown" does nothing either. I've
> >> also tried with and without noapic, and a number of other kernel
> >> paramaters, but nothing seems to work.
> >>
> >> Be more than happy to try out patches, etc. to get this thing working.
> >> Additionally, if someone could point me to that "beep on resume" patch,
> >> that'd be great.
> >>     
> >
> > First, please apply the appended patch and try the following:
> >
> > (1)
> > # echo testproc > /sys/power/disk
> > # echo disk > /sys/power/state
> >
> > This should turn off the non-boot CPU, freeze all processes, wait for 5
> > seconds and then thaw the processes and the CPU.
> >   
> Works fine. FWIW, after applying the patchs (so as to have 
> 2.6.18-rc3-mm2), my internal keyboard didn't work, so I used a USB one. 

That is specific to 2.6.18-rc3-mm2 and has nothing to do with the suspend.
There should be a patch for that in hot-fixes.

> It could be my simple .config'ing error, didn't spend much time with it, 
> but know that I did use a USB keyboard, hence USB support in the kernel.
> > (2)
> > # echo test > /sys/power/disk
> > # echo disk > /sys/power/state
> >
> > This should turn off the non-boot CPU, freeze all processes, shrink
> > memory, suspend all devices, wait for 5 seconds, resume the devices etc.
> > IOW it does everything that's needed for a suspend except for actually
> > suspending.
> >   
> With *legacy* ata_piix, it works fine, as does a "real" suspend-to-disk. 
> It still *will not* resume properly from suspend-to-RAM, with and 
> without noapic.

I think I know what the problem is, but unfortunately I have no patch for
that.  Please look at
http://www.ussg.iu.edu/hypermail/linux/kernel/0607.3/1566.html
but the fix discussed there is for AMD/NVidia only.

> FWIW, somehow the built-in keyboard managed to get its  
> caps lock light on (I couldn't get it off again), and it *did* come back 
> on when the machine resumed from RAM, though nothing else (network, usb, 
> etc.) worked.
> 
> Using native ahci and the "test" suspend-to-disk, the system hangs. I 
> did this from init=/bin/bash with vga=794 (so I could see all output), 
> however, at least the last few lines match w/vga=0 (i.e., fb didn't 
> affect problem). The hand-copied (pardon any typos) output is:

Some additional patches are needed for the AHCI suspend, AFAIK.
I thought they were on the way to the mainline, but it looks like I was
wrong.  See: http://www.ussg.iu.edu/hypermail/linux/kernel/0607.2/0885.html

Greetings,
Rafael
