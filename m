From: Lucas Nussbaum <lucas@lucas-nussbaum.net>
Subject: Re: [linux-usb-devel] [Bugme-new] [Bug 8249] New: NMI watchdog detected LOCKUP when plugging USB devices with acpi=off
Date: Thu, 22 Mar 2007 16:38:47 +0100
Message-ID: <20070322153847.GA24904@xanadu.blop.info>
References: <20070321175624.GA10891@xanadu.blop.info> <Pine.LNX.4.44L0.0703221047300.3605-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vds456.sivit.org ([80.248.208.235]:53253 "EHLO xanadu.blop.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933251AbXCVPjK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 22 Mar 2007 11:39:10 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0703221047300.3605-100000@iolanthe.rowland.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, linux-usb-devel@lists.sourceforge.net, "bugme-daemon@kernel-bugs.osdl.org" <bugme-daemon@bugzilla.kernel.org>

On 22/03/07 at 10:49 -0400, Alan Stern wrote:
> On Wed, 21 Mar 2007, Lucas Nussbaum wrote:
> 
> > On 21/03/07 at 08:41 -0800, Andrew Morton wrote:
> > > On Wed, 21 Mar 2007 07:18:45 -0700 bugme-daemon@bugzilla.kernel.org wrote:
> > > 
> > > > http://bugzilla.kernel.org/show_bug.cgi?id=8249
> > > > 
> > > >            Summary: NMI watchdog detected LOCKUP when plugging USB devices
> > > >                     with acpi=off
> > > >     Kernel Version: 2.6.21-rc4
> > > >             Status: NEW
> > > >           Severity: high
> > > >              Owner: greg@kroah.com
> > > >          Submitter: lucas@lucas-nussbaum.net
> > > > 
> > > > 
> > > > Most recent kernel where this bug did *NOT* occur: none, as far as I know
> > > > Problem Description:
> > > > 
> > > > My kernel is running with acpi=off to workaround another bug. When I turn on my
> > > > USB printer (a Canon PIXMA MP750), I get this on the serial console:
> 
> It looks like your problem occurs either as a result of the USB printer
> driver's actions or as a result of HAL.  You could try turning off the HAL
> daemon and renaming the usblp.ko file so that it won't get loaded
> automatically.  Then after plugging in the printer you could insmod the
> renamed driver file by hand, and see whether that causes the oops.  Then
> start HAL by hand and see whether that causes the oops.

Ah, good idea.

A problem specific to usblp is unlikely, since it also fails with other
USB devices (mouse, remote controler).

If I kill hald before turning on the printer, the kernel doesn't
deadlock.

If then, I modprobe usblp, the module gets inserted ok.

If then, I start hald (or if I start if with the module unloaded), it
deadlocks.

I straced hald. The output is on http://blop.info/strace-hald.log, but
it's probably not very interesting, except for the end:
[pid  2619] close(14)                   = 0
[pid  2619] munmap(0xb7f19000, 4096)    = 0
[pid  2619] readlink("/sys/block/ram0/device", 0x8150f30, 256) = -1 ENOENT (No such file or directory)
[pid  2619] open("/sys/block/ram0/slaves", O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY) = 14
[pid  2619] fstat64(14, {st_mode=S_IFDIR|0755, st_size=0, ...}) = 0
[pid  2619] fcntl64(14, F_SETFD, FD_CLOEXEC) = 0
[pid  2619] getdents64(14, /* 2 entries */, 4096) = 48
[pid  2619] getdents64(14, /* 0 entries */, 4096) = 0
[pid  2619] close(14)                   = 0
[pid  2619] open("//proc/apm", O_RDONLY|O_LARGEFILE) = 14

I also confirmed that "cat /proc/apm" works fine when the USB printer is
off. But it deadlocks when the USB printer is on. With the printer off:
# cat /proc/apm 
1.16ac 1.2 0x03 0x01 0xff 0x80 -1% -1 ?
-- 
| Lucas Nussbaum
| lucas@lucas-nussbaum.net   http://www.lucas-nussbaum.net/ |
| jabber: lucas@nussbaum.fr             GPG: 1024D/023B3F4F |
