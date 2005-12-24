From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: Toshiba Satellite P10
Date: Sat, 24 Dec 2005 01:25:27 +0100
Message-ID: <20051224002527.GA16285@elf.ucw.cz>
References: <20051222120413.GA28743@suse.de> <43AAB13E.4080206@csstirisano.co.za> <20051222160633.GA3316@suse.de> <43AB9CD2.9090106@csstirisano.co.za> <20051223111239.GB10748@elf.ucw.cz> <43AC2B95.9060901@kroon.co.za> <20051223172459.GB15357@elf.ucw.cz> <43AC80F3.6040605@kroon.co.za> <20051223230133.GC16104@elf.ucw.cz> <43AC9127.10007@kroon.co.za>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <43AC9127.10007-P18QfuJFXGPYkQIYctQFYw@public.gmane.org>
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

> ... and I didn't get the rest cause as soon as I accidentally pressed a
> key it powered down ...
> 
> It halted directly after "Shutting down hda" (can't remember the exact
> message).  Powering up resuming worked just fine.  Including issues I
> had with suspend-to-ram (described below).

Okay, what *other* patches do you have installed? What kernel are you
running? 2.6.15-rc6?

> This happened at least twice.  Having to hit some key to make it go away
> is probably not the biggest issue I've had in my life, I guess if need
> be I can live with that.

I have seen that before with acpi vgapost or something like
that... Strange. Can you insert printks to find out what is going on?

> This feels like a post-wakeup racecondition to me... Disabling the big
> kernel lock preemption think again... yes, seems to be working better
> now.  Suspending to ram and then to disk still fails.  (resume from mem
> works, can do make menuconfig - a few times - and then it starts
> suspend-to-disk process and then just hangs).

So... there's no module to blame? I do have CONFIG_PREEMPT=y and
CONFIG_PREEMPT_BKL=y set here, but there were some problems with those
before, so keeping it disabled may be wise.

Ouch and now that suspend-to-ram more or less works for you, can you
submit update to Doc*/power/video.txt?

> If I posted my DSDT, could you possibly take a look?  It seems that the
> compiler error message doesn't mean what it says.  Under certain
> conditions it will complain if a certain string is set but some index is
> not.  And I don't know enough with regards to DSL to be able to spot the
> errors.

I'm not DSDT expert, sorry. (And problem is probably not in DSDT
anyway).

								Pavel
-- 
Thanks, Sharp!


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
