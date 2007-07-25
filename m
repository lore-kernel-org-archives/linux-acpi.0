From: Len Brown <lenb@kernel.org>
Subject: Re: [GIT PATCH] ACPI patches for 2.6.23-rc1
Date: Wed, 25 Jul 2007 18:51:22 -0400
Message-ID: <200707251851.22777.lenb@kernel.org>
References: <200707251238.50218.lenb@kernel.org> <alpine.LFD.0.999.0707251147130.3607@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:54644 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756293AbXGYWv2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 25 Jul 2007 18:51:28 -0400
In-Reply-To: <alpine.LFD.0.999.0707251147130.3607@woody.linux-foundation.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday 25 July 2007 14:48, Linus Torvalds wrote:

> ... ACPI now seems to select CPU hotplug. Why? 

ACPI=y SMP=y systems require SUSPEND_SMP=y for system sleep support,
and that requires HOTPLUG_CPU=y.

Note that ACPI=y SMP=n systems do not need it,
and thus will not select HOTPLUG_CPU=y

> That is just *broken*. Sure, if you select STR or hibernation, we need CPU 
> hotplug, but just for picking ACPI? Why?

My assumption is that if somebody selects CONFIG_ACPI,
that 99% of the time, they intend that to include support for
the ACPI hooks for system sleep states.

Conversely, supporting the 1% of people who don't want it
isn't worth messing with the 99% who do, nor is
the burden of yet another config option to maintain and
#ifdefs in the code.

On UP, they'd get ACPI system sleep support 100% of the time
by default, but on SMP this option had become problematic.

We used to have this:

if ACPI
...
config ACPI_SLEEP
        bool "Sleep States"
        depends on X86 && (!SMP || SUSPEND_SMP)
        depends on PM
        default y

So the poster-child failure was i386/defconfig itself...
It couldn't support suspend to RAM because it didn't include
CONFIG_ACPI_SLEEP.  Not trivial for a user to select it
when it doesn't even appear on the menu.  It doesn't appear
because CONFIG_SUSPEND_SMP isn't enabled, but that doesn't
appear either -- because CONFIG_HOTPLUG_CPU isn't selected.

Most users don't want that.

So today we have this:

menuconfig ACPI
	...
        select HOTPLUG_CPU if X86 && SMP
        select SUSPEND_SMP if X86 && SMP

Which I think leads to fewer surprises, and less complicated code.
(even though using select itself is fraught with peril:-)

thanks,
-Len

