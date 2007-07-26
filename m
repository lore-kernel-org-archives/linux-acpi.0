From: david@lang.hm
Subject: Re: [GIT PATCH] ACPI patches for 2.6.23-rc1
Date: Wed, 25 Jul 2007 19:20:28 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0707251917320.21378@asgard.lang.hm>
References: <200707251238.50218.lenb@kernel.org>
 <alpine.LFD.0.999.0707251147130.3607@woody.linux-foundation.org>
 <200707251851.22777.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759426AbXGZCW2@vger.kernel.org>
In-Reply-To: <200707251851.22777.lenb@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wed, 25 Jul 2007, Len Brown wrote:

> On Wednesday 25 July 2007 14:48, Linus Torvalds wrote:
>
>> ... ACPI now seems to select CPU hotplug. Why?
>
> ACPI=y SMP=y systems require SUSPEND_SMP=y for system sleep support,
> and that requires HOTPLUG_CPU=y.
>
> Note that ACPI=y SMP=n systems do not need it,
> and thus will not select HOTPLUG_CPU=y
>
>> That is just *broken*. Sure, if you select STR or hibernation, we need CPU
>> hotplug, but just for picking ACPI? Why?
>
> My assumption is that if somebody selects CONFIG_ACPI,
> that 99% of the time, they intend that to include support for
> the ACPI hooks for system sleep states.
>
> Conversely, supporting the 1% of people who don't want it
> isn't worth messing with the 99% who do, nor is
> the burden of yet another config option to maintain and
> #ifdefs in the code.

so you are saying that you know better then we do what we need?

some people configure ACPI only becouse their system won't work properly 
without it. they have no intention of ever doing a STR or hibernate.

David Lang

> On UP, they'd get ACPI system sleep support 100% of the time
> by default, but on SMP this option had become problematic.
>
> We used to have this:
>
> if ACPI
> ...
> config ACPI_SLEEP
>        bool "Sleep States"
>        depends on X86 && (!SMP || SUSPEND_SMP)
>        depends on PM
>        default y
>
> So the poster-child failure was i386/defconfig itself...
> It couldn't support suspend to RAM because it didn't include
> CONFIG_ACPI_SLEEP.  Not trivial for a user to select it
> when it doesn't even appear on the menu.  It doesn't appear
> because CONFIG_SUSPEND_SMP isn't enabled, but that doesn't
> appear either -- because CONFIG_HOTPLUG_CPU isn't selected.

so have something like

config ACPI_SLEEP
         select HOTPLUG_CPU if X86 && SMP
         select SUSPEND_SMP if X86 && SMP

instead of makeing it dependant on ACPI.

David Lang

> Most users don't want that.
>
> So today we have this:
>
> menuconfig ACPI
> 	...
>        select HOTPLUG_CPU if X86 && SMP
>        select SUSPEND_SMP if X86 && SMP
>
> Which I think leads to fewer surprises, and less complicated code.
> (even though using select itself is fraught with peril:-)
>
> thanks,
> -Len
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
