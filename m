From: Brannon Barrett Klopfer <bklopfer@stanford.edu>
Subject: Re: hp dv8000t dead on resume from RAM
Date: Thu, 10 Aug 2006 11:29:54 -0700
Message-ID: <1155234594.44db7b221296f@webmail.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp3.Stanford.EDU ([171.67.20.26]:17610 "EHLO
	smtp3.stanford.edu") by vger.kernel.org with ESMTP id S1751453AbWHJS37
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 10 Aug 2006 14:29:59 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-acpi@vger.kernel.org, acpi@linux.intel.com, pavel@suse.cz

Quoting "Rafael J. Wysocki" <rjw@sisk.pl>:

> On Wednesday 09 August 2006 20:01, Brannon Klopfer wrote:
> > Rafael J. Wysocki wrote:
> > > On Tuesday 08 August 2006 19:15, Brannon Barrett Klopfer wrote:
> > >
> > >> Howdy,
> > >>
> > >> My hp dv8000t (core duo) is completely dead on resume from RAM (no
> caps
> > >> lock, sysrq, netconsole,
> > >> nothing). I've tried a recent (2.6.18-rc4) kernel running almost
> entirely
> > >> naked, so to speak (~990K) -- no support for:
> > >>
> > >> SMP
> > >> preempt
> > >> modules
> > >> networking (+ enet drivers, unless running netconsole)
> > >> USB and SATA (not at same time; rootfs is either usb drive or SATA
> [ext2/3])
> > >> FireWire
> > >> cpufreq
> > >> framebuffer (vga=0)
> > >> audio
> > >> PCMCIA
> > >> IDE (for cdrom)
> > >>
> > >> I've tried both native SATA (ahci) and legacy (ata_piix), but same
> result
> > >> w/both -- completely dead on resume from RAM. Blindly entering
> commands
> > >> does nothing, and running "$suspend ; $shutdown" does nothing
> either. I've
> > >> also tried with and without noapic, and a number of other kernel
> > >> paramaters, but nothing seems to work.
> > >>
> > >> Be more than happy to try out patches, etc. to get this thing
> working.
> > >> Additionally, if someone could point me to that "beep on resume"
> patch,
> > >> that'd be great.
> > >>
> > >
> > > First, please apply the appended patch and try the following:
> > >
> > > (1)
> > > # echo testproc > /sys/power/disk
> > > # echo disk > /sys/power/state
> > >
> > > This should turn off the non-boot CPU, freeze all processes, wait for
> 5
> > > seconds and then thaw the processes and the CPU.
> > >
> > Works fine. FWIW, after applying the patchs (so as to have
> > 2.6.18-rc3-mm2), my internal keyboard didn't work, so I used a USB one.
>
> That is specific to 2.6.18-rc3-mm2 and has nothing to do with the
> suspend.
> There should be a patch for that in hot-fixes.
>
> > It could be my simple .config'ing error, didn't spend much time with
> it,
> > but know that I did use a USB keyboard, hence USB support in the
> kernel.
> > > (2)
> > > # echo test > /sys/power/disk
> > > # echo disk > /sys/power/state
> > >
> > > This should turn off the non-boot CPU, freeze all processes, shrink
> > > memory, suspend all devices, wait for 5 seconds, resume the devices
> etc.
> > > IOW it does everything that's needed for a suspend except for
> actually
> > > suspending.
> > >
> > With *legacy* ata_piix, it works fine, as does a "real"
> suspend-to-disk.
> > It still *will not* resume properly from suspend-to-RAM, with and
> > without noapic.
>
> I think I know what the problem is, but unfortunately I have no patch for
> that.  Please look at
> http://www.ussg.iu.edu/hypermail/linux/kernel/0607.3/1566.html
> but the fix discussed there is for AMD/NVidia only.

Hmmm...I did try a kernel with *no* SATA or IDE support, and used a pen
drive for my root; would that rule out that sort of problem, or does the
hardware freak out regardless of whether or not there's a driver for it?


> > Using native ahci and the "test" suspend-to-disk, the system hangs. I
> > did this from init=/bin/bash with vga=794 (so I could see all output),
> > however, at least the last few lines match w/vga=0 (i.e., fb didn't
> > affect problem). The hand-copied (pardon any typos) output is:
>
> Some additional patches are needed for the AHCI suspend, AFAIK.
> I thought they were on the way to the mainline, but it looks like I was
> wrong.  See:
> http://www.ussg.iu.edu/hypermail/linux/kernel/0607.2/0885.html

I tried to patch the kernel with the "test/testproc" suspend to disk trick,
but it didn't apply cleanly; I applied it cleanly to 2.6.18-rc4 and then
copied drivers/scsi/ahci.c to the "test/testproc" kernel, but it didn't
seem to make a difference.

Thanks,
Brannon
