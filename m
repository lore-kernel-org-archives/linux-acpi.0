From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: Toshiba Satellite P10
Date: Sat, 24 Dec 2005 01:38:08 +0100
Message-ID: <20051224003808.GB16285@elf.ucw.cz>
References: <20051222160633.GA3316@suse.de> <43AB9CD2.9090106@csstirisano.co.za> <20051223111239.GB10748@elf.ucw.cz> <43AC2B95.9060901@kroon.co.za> <20051223172459.GB15357@elf.ucw.cz> <43AC80F3.6040605@kroon.co.za> <20051223230133.GC16104@elf.ucw.cz> <43AC9127.10007@kroon.co.za> <20051224002527.GA16285@elf.ucw.cz> <43AC97E7.1030800@kroon.co.za>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <43AC97E7.1030800-P18QfuJFXGPYkQIYctQFYw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jaco Kroon <jaco-P18QfuJFXGPYkQIYctQFYw@public.gmane.org>
Cc: Stefan Seyfried <seife-l3A5Bk7waGM@public.gmane.org>, Holger Macht <hmacht-l3A5Bk7waGM@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> > Okay, what *other* patches do you have installed? What kernel are you
> > running? 2.6.15-rc6?
> 
> I'm trying with 2.6.14.3, but I've got 2.6.15rc5 available here (can
> always get the VI patch to rc6).  Was intending to run the acpi_include
> patch, but since that is a standard option in 2.6.14.x I never actually
> pulled in that patch, so no other patches and I've backed out suspend2
> now.  Will also give 15rc6 a go in the morning.

rc5 should be good enough.

> >>This feels like a post-wakeup racecondition to me... Disabling the big
> >>kernel lock preemption think again... yes, seems to be working better
> >>now.  Suspending to ram and then to disk still fails.  (resume from mem
> >>works, can do make menuconfig - a few times - and then it starts
> >>suspend-to-disk process and then just hangs).
> > 
> > So... there's no module to blame? I do have CONFIG_PREEMPT=y and
> > CONFIG_PREEMPT_BKL=y set here, but there were some problems with those
> > before, so keeping it disabled may be wise.
> 
> I've also found that I forgot to disable registers.  Neither made a
> difference though.

CONFIG_REGPARM?

> > Ouch and now that suspend-to-ram more or less works for you, can you
> > submit update to Doc*/power/video.txt?
> 
> Will do if I get it working.  more-or-less is simply not good enough (or
> should I just make a note there?).

It is good enough for video.txt. It describes how to get _video_
working, and video works just ok for you.

							Pavel
-- 
Thanks, Sharp!


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
