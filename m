From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH]acpi c-states: Fix ACPI C3 is wrongly mapped to C2
Date: Wed, 16 Dec 2009 04:28:25 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0912160419400.30935@localhost.localdomain>
References: <20091212181442.GA22832@youquan-linux.bj.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:45656 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751981AbZLPJ26 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 04:28:58 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KUQ00E23NNFNGN5@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 16 Dec 2009 03:28:30 -0600 (CST)
In-reply-to: <20091212181442.GA22832@youquan-linux.bj.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Youquan,Song" <youquan.song@linux.intel.com>
Cc: venkatesh.pallipadi@intel.com, kent.liu@intel.com, chaohong.guo@intel.com, youquan.song@intel.com, linux-acpi@vger.kernel.org

I agree that this is confusing.
I disagree that this is the fix.
The fix is actually a lot more complicated,
and it involves the removal of the /proc/acpi/.../power file
modification to /sysfs names from cpuidle,
and fixing powertop.

On Sat, 12 Dec 2009, Youquan,Song wrote:

>     C1:                  type[C1] promotion[--] demotion[--] 
>     C2:                  type[C3] promotion[--] demotion[--] 
> 
> While
> /sys/devices/system/cpu/cpux/cpuidle/state1
> ACPI FFH INTEL MWAIT 0x0
> 1
> C1
> 1000
> 58312355
> 323873
> 
> /sys/devices/system/cpu/cpux/cpuidle/state2
> ACPI FFH INTEL MWAIT 0x10
> 17
> C2
> 500
> 83706664055
> 18926855
> 
> In /proc, "type[C3]" mean acpi C3, but from its title "C2:" mean processor
> support max C-state is ACPI C2.

No, type[C3] means type C3,
and C2: means the 2nd C-state, which in this case happens to be type C3
because a useful state between type C1 and type C3 was not exported.

This is unusual, but not rare.  There were systems before
NHM that did it this way.

> In /sys, there is no any information show that this processor support ACPI C3. 
> 
> these issues are rooted cause to ACPI C2 miss at some platforms, ACPI C3 is
> wrongly mapped to C2.

There is nothing "wrong" with ACPI C2 being mapped to a C3 type state.
The original output above is correct.
The output below is not correct.

> This patch will invalidate ACPI C2 when platform does not support ACPI C2.
> 
> After apply the patch, the C-state information in /proc and /sys are reasonable
> 
> /proc/acpi/processor/CPUx/power
>     C1:                  type[C1] promotion[--] demotion[--] 
>     C2:                  <not supported>
>     C3:                  type[C3] promotion[--] demotion[--] 

That said, I agree this confuses uses, and that doesn't even start
to get into hardware C-states vs ACPI C-states and powertop output...

I believe that powertop is bugged in how it reverse-engineers
the C-state names and displays hardware names.  I think that
we should put the hardware names in /sysfs and it should
simply use them -- but more on that later.

thanks,
Len Brown, Intel Open Source Technology Center
