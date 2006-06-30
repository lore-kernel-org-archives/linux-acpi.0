From: Pavel Machek <pavel@suse.cz>
Subject: Re: swsusp problems with 2.6.17-1.2139_FC5
Date: Fri, 30 Jun 2006 23:16:17 +0200
Message-ID: <20060630211617.GC1717@elf.ucw.cz>
References: <m2irmj9937.fsf@phoenix.squirrel.nl> <20060630180141.GC9225@elf.ucw.cz> <m2y7vetmvn.fsf@phoenix.squirrel.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:19384 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932590AbWF3VQ0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 30 Jun 2006 17:16:26 -0400
Content-Disposition: inline
In-Reply-To: <m2y7vetmvn.fsf@phoenix.squirrel.nl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Johan Vromans <jvromans@squirrel.nl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org

Hi!

> > Stop right here. Can you reproduce the problem without ATI driver?
> > Reproducing it on vanilla kernel (not -FC5) would be nice, too.
> 
> A lot of suspend/reboot/resumes later...
> 
> The problem does not seem to be related to the ATI driver, but whether
> or not the pm-suspend program is used. With the Xorg driver I get the
> same problem when I suspend with

>   echo shutdown > /sys/power/disk; echo disk > /sys/power/state
> 
> When I use pm-hibernate suspend/resume seems works okay (with Xorg and
> ATI driver).

What is pm-suspend and pm-hibernate, anyway?

> With 2.6.16, I did not have the need to use pm-hibernate. So something
> changed here.

Okay, find out 

> As mentioned in my OP using pm-hibernate does not give any feedback
> what is going on (except for the disk led). I find this annoying.
> Another annoyance is that pm-hibernate locks this kernel for the next
> reboot, so it is not possible to boot something else and resume
> later.

grub lockup is a distro problem. Turn up console loglevel to see  the
messages.

> Apart from that, suspend/resume is a life saver!
> 
> (Now it would be nice to get suspend to memory working. It seems to
> suspend okay, but I haven't found out how to resume...)

Resume is always harder :-). Is resume completely broken, or does it
"only" break video?
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
