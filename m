From: "Mark M." <maalox-XzQKRVe1yT0V+D8aMU/kSg@public.gmane.org>
Subject: Re: RE: acpi-20031203-2.6.0.diff brokes the battery status
 readings with 2.6.0 in DELL Inspiron 8500
Date: Wed, 31 Dec 2003 14:12:54 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3FF31FB6.7040306@videotron.ca>
References: <3ACA40606221794F80A5670F0AF15F8401720C69@PDSMSX403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8401720C69-SRlDPOYGfgogGBtAFL8yw7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Success! I used the patch below and things seem to be working again. 
Actually, I manually edited my (2.6.0-mm) 
/usr/src/linux/drivers/acpi/dispatcher/dsmthdat.c
because i don't think the paths in the patch would have worked. I just 
recompiled the kernel and rebooted.

As a side note, I didn't include the before last line of the patch 
"new_obj_desc;", because it wasn't in my version of the file.

Here is the proof:

maalox-2T+B9ReNDUQ@public.gmane.org maalox $ uname -a
Linux laptop 2.6.0-mm1 #4 Wed Dec 31 13:53:35 EST 2003 i686 Mobile 
Intel(R) Pentium(R) 4     CPU 3.06GHz GenuineIntel GNU/Linux

maalox-2T+B9ReNDUQ@public.gmane.org maalox $ cat /proc/acpi/thermal_zone/THM/temperature
temperature:             50 C

maalox-2T+B9ReNDUQ@public.gmane.org maalox $ cat /proc/acpi/battery/BAT0/
alarm  info   state
maalox-2T+B9ReNDUQ@public.gmane.org maalox $ cat /proc/acpi/battery/BAT0/alarm
alarm:                   626 mAh

maalox-2T+B9ReNDUQ@public.gmane.org maalox $ cat /proc/acpi/battery/BAT0/info
present:                 yes
design capacity:         6450 mAh
last full capacity:      6263 mAh
battery technology:      rechargeable
design voltage:          14800 mV
design capacity warning: 626 mAh
design capacity low:     189 mAh
capacity granularity 1:  5 mAh
capacity granularity 2:  5 mAh
model number:            DELL 0009Y
serial number:           10421
battery type:            LION
OEM info:                Sony

maalox-2T+B9ReNDUQ@public.gmane.org maalox $ cat /proc/acpi/battery/BAT0/state
present:                 yes
capacity state:          ok
charging state:          unknown
present rate:            unknown
remaining capacity:      6450 mAh
present voltage:         16355 mV

Obviously, the KDE battery monitor is working again, as is the gkrellm 
stuff.

Thanks,
Mark

P.S. Does anyone know why the temparature reading from acpi is always 1 
degree higher than the one reported by the i8k module for dells? I see 
both readings side by side in gkrellm.

Yu, Luming wrote:
>>>     -0091: *** Error: ut_allocate: Attempt to allocate zero bytes
>>>     -0091: *** Error: ut_allocate: Attempt to allocate zero bytes
>>>     -0091: *** Error: ut_allocate: Attempt to allocate zero bytes
>>>     -0091: *** Error: ut_allocate: Attempt to allocate zero bytes
>>
>>Here is the bug info.  Note that Luming's patch does NOT fix the
> 
> problem
> 
>>but just silences the warnings.  If you use the ASL patch I have
> 
> attached
> 
>>that adds RefOf/DerefOf (credit Mark Santcroos), the problems are
> 
> fixed.
> 
>>You can also revert dsmthdat.c back to what it was pre-0619 and that
> 
> also
> 
>>fixes the problem.
>>
>>http://bugme.osdl.org/show_bug.cgi?id=1728
>>
>>The issue is, ACPI-CA is still not getting its argument-passing right
>>after moving away from "always copy" semantics.
> 
> 
> Please try patch filed at  http://bugme.osdl.org/show_bug.cgi?id=1766
> 
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: IBM Linux Tutorials.
> Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
> Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
> Click now! http://ads.osdn.com/?ad_id78&alloc_id371&op=click
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
> 




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
