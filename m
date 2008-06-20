From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH3/4] ACPI :  Add boot option of "idle=nomwait" to disable
 mwait for CPU C-states
Date: Fri, 20 Jun 2008 03:14:12 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0806200310160.22284@localhost.localdomain>
References: <1213685035.19901.15.camel@yakui_zhao.sh.intel.com>
 <alpine.LFD.1.10.0806200235260.22284@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:47669 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750823AbYFTHOO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Jun 2008 03:14:14 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms173005.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K2R007GB2GH1X21@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 20 Jun 2008 02:07:30 -0500 (CDT)
In-reply-to: <alpine.LFD.1.10.0806200235260.22284@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: linux-acpi@vger.kernel.org



I notice on the T61 that this disables MWAIT for C2 and C3,
but not for C1.

While I know that the issue at hand is C2 and C3,
it seems misleading to boot with idle=nomwait
and see that MWAIT is used for C1.

I think we should extend this param to also apply
to the MWAIT use for C1.  I don't think the difference
between MWAIT and HALT in C1 will be signficant, given
that this is a debugging-tool/bug workaround.

thanks,
-Len

[lenb@t61 ~]$ grep . /sys/devices/system/cpu/cpu*/cpuidle/*/*
/sys/devices/system/cpu/cpu0/cpuidle/state0/desc:<null>
/sys/devices/system/cpu/cpu0/cpuidle/state0/latency:0
/sys/devices/system/cpu/cpu0/cpuidle/state0/name:<null>
/sys/devices/system/cpu/cpu0/cpuidle/state0/power:4294967295
/sys/devices/system/cpu/cpu0/cpuidle/state0/time:24103
/sys/devices/system/cpu/cpu0/cpuidle/state0/usage:27
/sys/devices/system/cpu/cpu0/cpuidle/state1/desc:ACPI FFH INTEL MWAIT 0x0
/sys/devices/system/cpu/cpu0/cpuidle/state1/latency:1
/sys/devices/system/cpu/cpu0/cpuidle/state1/name:C1
/sys/devices/system/cpu/cpu0/cpuidle/state1/power:1000
/sys/devices/system/cpu/cpu0/cpuidle/state1/time:0
/sys/devices/system/cpu/cpu0/cpuidle/state1/usage:0
/sys/devices/system/cpu/cpu0/cpuidle/state2/desc:ACPI IOPORT 0x1014
/sys/devices/system/cpu/cpu0/cpuidle/state2/latency:1
/sys/devices/system/cpu/cpu0/cpuidle/state2/name:C2
/sys/devices/system/cpu/cpu0/cpuidle/state2/power:500
/sys/devices/system/cpu/cpu0/cpuidle/state2/time:21905
/sys/devices/system/cpu/cpu0/cpuidle/state2/usage:569
/sys/devices/system/cpu/cpu0/cpuidle/state3/desc:ACPI IOPORT 0x1015
/sys/devices/system/cpu/cpu0/cpuidle/state3/latency:17
/sys/devices/system/cpu/cpu0/cpuidle/state3/name:C3
/sys/devices/system/cpu/cpu0/cpuidle/state3/power:250
/sys/devices/system/cpu/cpu0/cpuidle/state3/time:284208055
/sys/devices/system/cpu/cpu0/cpuidle/state3/usage:53661
/sys/devices/system/cpu/cpu1/cpuidle/state0/desc:<null>
/sys/devices/system/cpu/cpu1/cpuidle/state0/latency:0
/sys/devices/system/cpu/cpu1/cpuidle/state0/name:<null>
/sys/devices/system/cpu/cpu1/cpuidle/state0/power:4294967295
/sys/devices/system/cpu/cpu1/cpuidle/state0/time:237647
/sys/devices/system/cpu/cpu1/cpuidle/state0/usage:25
/sys/devices/system/cpu/cpu1/cpuidle/state1/desc:ACPI FFH INTEL MWAIT 0x0
/sys/devices/system/cpu/cpu1/cpuidle/state1/latency:1
/sys/devices/system/cpu/cpu1/cpuidle/state1/name:C1
/sys/devices/system/cpu/cpu1/cpuidle/state1/power:1000
/sys/devices/system/cpu/cpu1/cpuidle/state1/time:0
/sys/devices/system/cpu/cpu1/cpuidle/state1/usage:0
/sys/devices/system/cpu/cpu1/cpuidle/state2/desc:ACPI IOPORT 0x1014
/sys/devices/system/cpu/cpu1/cpuidle/state2/latency:1
/sys/devices/system/cpu/cpu1/cpuidle/state2/name:C2
/sys/devices/system/cpu/cpu1/cpuidle/state2/power:500
/sys/devices/system/cpu/cpu1/cpuidle/state2/time:32354
/sys/devices/system/cpu/cpu1/cpuidle/state2/usage:1042
/sys/devices/system/cpu/cpu1/cpuidle/state3/desc:ACPI IOPORT 0x1015
/sys/devices/system/cpu/cpu1/cpuidle/state3/latency:17
/sys/devices/system/cpu/cpu1/cpuidle/state3/name:C3
/sys/devices/system/cpu/cpu1/cpuidle/state3/power:250
/sys/devices/system/cpu/cpu1/cpuidle/state3/time:294127944
/sys/devices/system/cpu/cpu1/cpuidle/state3/usage:65794

