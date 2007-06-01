From: Len Brown <lenb@kernel.org>
Subject: Re: [RFC][PATCH 0/3] A Dynticks Aware Processor Idle PM Governor
Date: Thu, 31 May 2007 21:17:48 -0400
Message-ID: <200705312117.48690.lenb@kernel.org>
References: <1174722412.32554.81.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:50299 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758332AbXFABSl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 31 May 2007 21:18:41 -0400
In-Reply-To: <1174722412.32554.81.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Adam Belay <abelay@novell.com>
Cc: Len Brown <len.brown@intel.com>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>, Shaohua Li <shaohua.li@intel.com>, Pallipadi@vger.kernel.org, Venkatesh <venkatesh.pallipadi@intel.com>, linux-acpi@vger.kernel.org

Applied this series to acpi-test
in anticipation that Venki is about to send some incremental
patches to address the feedback on it.

thanks,
-Len

On Saturday 24 March 2007 03:46, Adam Belay wrote:
> Hi All,
> 
> Here is my first take at implementing an idle PM governor that takes
> full advantage of NO_HZ.  I call it the 'menu' governor because it
> considers the full list of idle states before each entry.
> 
> I've kept the implementation fairly simple.  It attempts to guess the
> next residency time and then chooses a state that would meet at least
> the break-even point between power savings and entry cost.  To this end,
> it selects the deepest idle state that satisfies the following
> constraints:
>      1. If the idle time elapsed since bus master activity was detected
>         is below a threshold (currently 20 ms), then limit the selection
>         to C2-type or above.
>      2. Do not choose a state with a break-even residency that exceeds
>         the expected time remaining until the next timer interrupt.
>      3. Do not choose a state with a break-even residency that exceeds
>         the elapsed time between the last pair of break events,
>         excluding timer interrupts.
> 
> This governor has an advantage over "ladder" governor because it
> proactively checks how much time remains until the next timer interrupt
> using the tick infrastructure.  Also, it handles device interrupt
> activity more intelligently by not including timer interrupts in break
> event calculations.  Finally, it doesn't make policy decisions using the
> number of state entries, which can have variable residency times (NO_HZ
> makes these potentially very large), and instead only considers sleep
> time deltas.
> 
> The menu governor can be selected during runtime using the cpuidle sysfs
> interface like so:
> "echo "menu" > /sys/devices/system/cpu/cpuidle/current_governor"
> 
> This patchset applies against 2.6.21-rc4 plus the latest from the acpi
> testing tree, which is available here:
> ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/test/2.6.21/acpi-test-20070126-2.6.21-rc4.diff.bz2
> 
> I'd really appreciate any comments, benchmarks, or suggestions.
> 
> Cheers,
> Adam
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
