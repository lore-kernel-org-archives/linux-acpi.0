From: Nirmal Govind <nirmalg-8DAjSxpRXgY@public.gmane.org>
Subject: Re: problems with acpi (sleep states) on vaio notebook z1sp
Date: Wed, 24 Dec 2003 20:11:07 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3FEA392B.2020206@psu.edu>
References: <3ACA40606221794F80A5670F0AF15F8401720C50@PDSMSX403.ccr.corp.intel.com> <1072201432.3134.10.camel@garrett.darkzone> <20031224153617.GI1632@luna.mooo.com> <3FE9DA42.1050909@psu.edu> <20031224224236.GA25026@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20031224224236.GA25026-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> What's likely is that you're hitting several problems at once:

I minimized the number of errors by unloading ALL modules before 
trying to suspend. Finally, it came down to what seemed like just 
one error message while resuming:

kernel: MCE: The hardware reports a non fatal, correctable incident 
occurred on CPU 0

So I booted up with the "nomce" option and the acpi option you had 
below and now the MCE error does not show up while resuming.. but I 
still don't have display after resume.

> 1) display reinit: if acpi_sleep=s3_{bios,mode} at boot doesn't help, I
>    don't know what does,


> 2) keyboard / mouse (touchpad) dead: apply the patches found here [1]
>    against a vanilla 2.6.0, should fix it once and for all,

Hopefull I'll get to the point where the only things that don't work 
on resume are the keyboard/mouse.

> 3) uhci-hcd's appalling PM / suspend / resume support -- a workaround is to
>    unload all USB drivers prior to suspend.

Yes, I unloaded all USB drivers before suspending.

> it seems you're not so far from having S3 working, the video adapter being
> the most important issue.

This definitely seems to be the issue.. wonder if this will help but 
here's the output on resume (and the last line from suspend) from 
syslog:

Dec 24 19:51:01 variance kernel:  hwsleep-0257 [33] 
acpi_enter_sleep_state: Entering sleep state [S3]
Dec 24 19:51:01 variance kernel: Back to C!
Dec 24 19:51:01 variance kernel: PM: Finishing up.
Dec 24 19:51:01 variance kernel: hda: Wakeup request inited, waiting 
for !BSY...
Dec 24 19:51:01 variance kernel: hda: start_power_step(step: 1000)
Dec 24 19:51:01 variance kernel: blk: queue cf568e00, I/O limit 
4095Mb (mask 0xf
fffffff)
Dec 24 19:51:01 variance kernel: hda: completing PM request, resume
Dec 24 19:51:01 variance kernel: hdc: Wakeup request inited, waiting 
for !BSY...
Dec 24 19:51:01 variance kernel: hdc: start_power_step(step: 1000)
Dec 24 19:51:01 variance kernel: hdc: completing PM request, resume
Dec 24 19:51:01 variance kernel: Restarting tasks... done

I don't see anything suspicious here.. please let me know if you see 
something...

Thanks,
nirmal


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
