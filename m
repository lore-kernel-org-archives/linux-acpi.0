From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: [ACPI] Re: [PATCH] s4bios for 2.5.59 + apci-20030123
Date: Fri, 7 Feb 2003 17:00:56 +0100
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20030207160055.GA485@elf.ucw.cz>
References: <F760B14C9561B941B89469F59BA3A847137FFE@orsmsx401.jf.intel.com> <20030204221003.GA250@elf.ucw.cz> <1044477704.1648.19.camel@laptop-linux.cunninghams> <20030206101645.GO1205@poup.poupinou.org> <1044560486.1700.13.camel@laptop-linux.cunninghams> <20030206210542.GW1205@poup.poupinou.org> <1044590241.1649.41.camel@laptop-linux.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1044590241.1649.41.camel-udXHSmD1qAz9bBlWBkG5g4WQyAnV0byH@public.gmane.org>
To: Nigel Cunningham <ncunningham-oKK1aGe2n869koe0gwxAeg@public.gmane.org>
Cc: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Swsusp <swsusp-LcL5texQODR2DW0IdvIQ2g@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

> Machine 1: Celeron 933 laptop 17MB/s disk throughput, 128MB RAM
> Machine 2: Duron 700 desktop, 30MB/s disk throughput, 320MB RAM
> 
> Algorithm 1: Eat as much memory as possible, save remaining in one set
> of pages
> Algorithm 2: Save memory in two pages, only eating memory if necessary.
> 
> Same code base, just different parameters to /proc/sys/kernel/swsusp.
> This means that the result for algorithm 1 are exactly the same as
> Pavel's code, but should give some idea.
> 
> Columns:
> (1) Machine
> (2) Algorithm
> (3) Initial # pages free
> (4) Image size written to disk
> (5) Approximate time taken (date command run on other computer at same
> time as pressing enter to start command, then when computer restarts)
> 
> 1  2  3           4     5
> ---------------------------------
> 1  1  25655/30592  1562 0:07
> 1  2  26246/30592  4302 0:05

You can suspend and resume your notebook within 5 seconds? Wow!

> 1  1   1005/30592  5165 0:20
> 1  2    900/30592 30126 0:16
> 2  1  38604/79755     ? 0:49
> 2  2  39122/79755 30398 0:21
> 2  1   1113/79755     ? 0:50
> 2  2   1109/79755 82149 0:40
> 
> The question marks are because the desktop machine didn't successfully
> resume using this algorithm, so stats weren't logged (probably driver
> problems).
> 
> In each case, the new method is slightly faster than the old, so we don't seem to loose anything.
> Particularly interesting to me was the fact that the gain was not as
> high as we might expect when the memory was heavily used. I guess the
> amount of I/O is getting to the point where benefits from not eating
> pages are being erroded. It would be interesting to see if a machine
> with more memory readed a point where it was faster to eat the memory
> instead of write it.

Well, if all the memory is in disk-backed clean pages, it should be
faster to discard then write out...

Anyway... So your method is faster. Good. Now, how much more
complicated is it?
								Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
