From: "Adachi, Kenichi" <aileenja-dTzOdQ2U+/YAvxtiuMwx3w@public.gmane.org>
Subject: RE: constant processor 0x80 events
Date: Fri, 3 Jan 2003 02:29:42 +0900
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <000201c2b284$89a033c0$232202d3@sayonara>
References: <20030102135937.GA9257@clara.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <20030102135937.GA9257-6JSjyQ0Qj1ReoWH0uzbU5w@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: faye-6JSjyQ0Qj1ReoWH0uzbU5w@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> This has (almost) the desired (or at least helpful) effect.
> 
> Used in combination with the autospeedstep daemon, once this 
> threshold has been met:
> 
> root@marmite faye # cat /proc/acpi/processor/CPU0/performance
> state count:             2
> active state:            P1
> states:
>     P0:                  1200 MHz, 20000 mW, 250 uS
>    *P1:                  800 MHz, 10000 mW, 250 uS
>  
> The processor is switched to low power mode and autospeedstep 
> didn't do
> it:
> 
> root@marmite faye # tail /var/log/speedstep
> Thu Jan  2 13:23:44 2003: max. speed mode
> Thu Jan  2 13:24:01 2003: power save mode
> Thu Jan  2 13:24:12 2003: max. speed mode
> Thu Jan  2 13:31:19 2003: power save mode
> Thu Jan  2 13:37:03 2003: max. speed mode
> 
> It still thinks it's in max. speed mode.
> 
> root@marmite faye # cat /proc/acpi/thermal_zone/THRM/temperature
> temperature:             51 C
> 
> The processor is now relatively chilled, it would be nice if 
> it would try to trip up again, but that's for me to change in 
> autospeedstep.

Do you mean, because of your hack in DSDT, your processor is forced to
be in P1 upon GPE0 and it saves you from turbulent storm of event
handlings by cooling your box? And after your processor is relatively
chilled, you (manually?) initiate P-State transition to P0 (by
autospeedstep?), since your processor stays in P1? 
Interesting...

>> This is what I'm currently running with.  The thing is I'm not sure 
>> whether that will cause any other side effects - any ideas?
> 
> Still not sure about the side effects.

Can you take a look at "BIOS-provided physical RAM map" in your dmesg
and verify MNVS OpRegion (0x20 bytes starting from 0x1FF73E7D) is within
ACPI NVS Memory? ACPI NVS is saved/restored across system sleep/wake
cycle and if THRT is in this range, any possible side effects are less
harmful, as it's not mapped to critical hardware resource. 

5258      OperationRegion (MNVS, SystemMemory, 0x1FF73E7D, 0x20)
5259      Field (MNVS, AnyAcc, Lock, Preserve)
5260      {
    :
5268          THRT,   8
5269      }




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
