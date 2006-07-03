From: Pavel Machek <pavel@ucw.cz>
Subject: Re: 2.6.17-mm3: swsusp fails when process is debugged by ptrace
Date: Mon, 3 Jul 2006 23:33:53 +0200
Message-ID: <20060703213353.GC1674@elf.ucw.cz>
References: <44A2B9AF.50803@goop.org> <20060628212616.GB30373@elf.ucw.cz> <44A2FA20.3020809@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:27284 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750775AbWGCVeE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 3 Jul 2006 17:34:04 -0400
Content-Disposition: inline
In-Reply-To: <44A2FA20.3020809@goop.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Andrew Morton <akpm@osdl.org>

Hi!

> >Does it also happen when you do strace? ...I remember trying to solve
> >that, but 2.6.17-mm3 is very recent...?
> 
> I could suspend while running "strace sleep 100" without any problem.
> 
> I think the issue is when the process is blocked in T state,
> freeze_process() tries to kick the process with signal_wake_up(p, /*
> resume=0 */ 0), but with resume=0 it will only wake processes in
> TASK_INTERRUPTIBLE state.  With resume=1, it will also kick STOPPED and
> TRACED processes.  I also tried suspending while I had a process in T
> state caused by kill -STOP, and that worked, so some part of the puzzle
> is still missing.

So... does signal_wake_up(p, 1) fix it?

> I noticed that when I ran sleep 100 under strace over the suspend/resume
> cycle, its nanosleep() syscall was interrupted and not restarted.

I'm afraid there may be more problems lurking in the refrigerator.

(If this is going to take more than few mail iterations... perhaps you
should start bug at bugzilla.kernel.org?)
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
