From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: IBM success ... but partial
Date: Tue, 16 Sep 2003 13:50:29 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030916115029.GC602@elf.ucw.cz>
References: <200309152119.21050.hrvoje.habjanic@zg.htnet.hr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200309152119.21050.hrvoje.habjanic-+VD6v/bdhRf0NTdHYsHBKg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Hrvoje Habjanic <hrvoje.habjanic-+VD6v/bdhRf0NTdHYsHBKg@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> After disabling actual deallocation of memory in ACPI, laptop booted!! And i 
> got working shell ... nice. But:
> 
> sh-2.05b# cat /proc/interrupts
>            CPU0
>   0:      49587          XT-PIC  timer
>   1:          2          XT-PIC  keyboard
>   2:          0          XT-PIC  cascade
>   4:       1519          XT-PIC  serial
>   8:          1          XT-PIC  rtc
>   9:         18          XT-PIC  acpi
>  14:        947          XT-PIC  ide0
>  15:          2          XT-PIC  ide1
> NMI:          0
> LOC:          0
> ERR:          0
> MIS:          0
> 
> 
> huh?

Why huh?

> sh-2.05b# cat /proc/acpi/power_resource/PUBS/state
> state:                   on
> system level:            S3
> order:                   0
> reference count:         0
> 
> (is this ok?)

Should not this be S0?

> AND FAN IS NOT DETECTED???

Thats okay if hw handles the fan.
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
