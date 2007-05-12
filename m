From: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: [announce] Intel announces the PowerTOP utility for Linux
Date: Sat, 12 May 2007 13:00:26 +0200 (MEST)
Message-ID: <Pine.LNX.4.61.0705121256430.9570@yvahk01.tjqt.qr>
References: <4644F726.1050806@linux.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailer.gwdg.de ([134.76.10.26]:58704 "EHLO mailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756159AbXELLBQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 12 May 2007 07:01:16 -0400
In-Reply-To: <4644F726.1050806@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org


On May 11 2007 16:07, Arjan van de Ven wrote:
>
> A typical Linux distribution has many components that wake the processor up
> frequently for no good reason. In our testing with PowerTOP, we have seen many
> cases where with some simple fixes, the battery life of typical laptops was
> increased by one hour or more!
>
> We are providing fixes for several of the issues we identified, and we
> encourage the Linux community to help us in this quest to get the maximum
> battery life out of your (hopefully Intel based) laptops. Try the PowerTOP
> tool, join the mailing list or the IRC channel and provide feedback, problem
> reports or fixes!

Yeah, hal happily wakes up every two seconds. So much for
the effectivity of NO_HZ.

# ps afx | grep hal
 ...
 3003 ?        S      0:00      \_ hald-addon-storage: polling /dev/hdb
 ...
# strace -p 3003
Process 3003 attached - interrupt to quit
restart_syscall(<... resuming interrupted call ...>) = 0
open("/dev/hdb", O_RDONLY|O_NONBLOCK|O_EXCL|O_LARGEFILE) = 4
ioctl(4, CDROM_DRIVE_STATUS, 0x7fffffff) = 1
close(4)                                = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGCHLD, NULL, {SIG_DFL}, 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
nanosleep({2, 0}, {2, 0})               = 0
open("/dev/hdb", O_RDONLY|O_NONBLOCK|O_EXCL|O_LARGEFILE) = 4
ioctl(4, CDROM_DRIVE_STATUS, 0x7fffffff) = 1
close(4)                                = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGCHLD, NULL, {SIG_DFL}, 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
nanosleep({2, 0}, {2, 0})               = 0
open("/dev/hdb", O_RDONLY|O_NONBLOCK|O_EXCL|O_LARGEFILE) = 4
ioctl(4, CDROM_DRIVE_STATUS, 0x7fffffff) = 1
close(4)                                = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGCHLD, NULL, {SIG_DFL}, 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
nanosleep({2, 0},  <unfinished ...>


	Jan
-- 
