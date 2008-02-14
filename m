From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI, CPU_IDLE: Add more information about C-states
Date: Thu, 14 Feb 2008 03:09:01 -0500
Message-ID: <200802140309.01871.lenb@kernel.org>
References: <20080212015036.GC32468@linux-os.sc.intel.com> <200802140010.22097.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:41193 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752294AbYBNIJh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 14 Feb 2008 03:09:37 -0500
In-Reply-To: <200802140010.22097.lenb@kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Venki Pallipadi <venkatesh.pallipadi@intel.com>
Cc: linux-acpi@vger.kernel.org

I'm confused by state0 -- why are usage and time non-zero --
is this due to some residency there during initialization?

I don't know if I like the looks of 2^32 - 1 as the power number...

-Len

[root@t61 cpuidle]# cat /proc/acpi/processor/CPU0/power
active state:            C0
max_cstate:              C8
bus master activity:     00000000
maximum allowed latency: 2000000000 usec
states:
    C1:                  type[C1] promotion[--] demotion[--] latency[001] usage[00000000] duration[00000000000000000000]
    C2:                  type[C2] promotion[--] demotion[--] latency[001] usage[00000161] duration[00000000000000018522]
    C3:                  type[C3] promotion[--] demotion[--] latency[017] usage[00088238] duration[00000000002957934702]
[root@t61 cpuidle]# grep . */*
state0/desc:CPUIDLE CORE POLL IDLE
state0/latency:0
state0/name:C0
state0/power:4294967295
state0/time:11623
state0/usage:6
state1/desc:ACPI FFH INTEL MWAIT 0x0
state1/latency:1
state1/name:C1
state1/power:1000
state1/time:0
state1/usage:0
state2/desc:ACPI FFH INTEL MWAIT 0x10
state2/latency:1
state2/name:C2
state2/power:500
state2/time:5104
state2/usage:163
state3/desc:ACPI FFH INTEL MWAIT 0x20
state3/latency:17
state3/name:C3
state3/power:250
state3/time:830738297
state3/usage:89280

of course this isnt' new with this patch -- 2.6.25-rc1 looks as below:

[root@t61 cpuidle]# cat /proc/acpi/processor/CPU0/power
active state:            C0
max_cstate:              C8
bus master activity:     00000000
maximum allowed latency: 2000000000 usec
states:
    C1:                  type[C1] promotion[--] demotion[--] latency[001] usage[00000000] duration[00000000000000000000]
    C2:                  type[C2] promotion[--] demotion[--] latency[001] usage[00000202] duration[00000000000000028172]
    C3:                  type[C3] promotion[--] demotion[--] latency[017] usage[00026011] duration[00000000000264174466]
[root@t61 cpuidle]# grep . */*
state0/latency:0
state0/name:C0 (poll idle)
state0/power:4294967295
state0/time:35713
state0/usage:6
state1/latency:1
state1/name:C1
state1/power:1000
state1/time:0
state1/usage:0
state2/latency:1
state2/name:C2
state2/power:500
state2/time:7771
state2/usage:203
state3/latency:17
state3/name:C3
state3/power:250
state3/time:74950731
state3/usage:26286

and 2.6.24 showed no C0, as expected.

[root@t61 cpuidle]# cat /proc/acpi/processor/CPU0/power
active state:            C0
max_cstate:              C8
bus master activity:     00000000
maximum allowed latency: 2000 usec
states:
    C1:                  type[C1] promotion[--] demotion[--] latency[001] usage[00000030] duration[00000000000000000000]
    C2:                  type[C2] promotion[--] demotion[--] latency[001] usage[00000714] duration[00000000000000531448]
    C3:                  type[C3] promotion[--] demotion[--] latency[017] usage[00020563] duration[00000000000168147357]
[root@t61 cpuidle]# grep . */*
state0/latency:1
state0/name:C1
state0/power:1000
state0/time:0
state0/usage:30
state1/latency:1
state1/name:C2
state1/power:500
state1/time:148317
state1/usage:719
state2/latency:17
state2/name:C3
state2/power:250
state2/time:48238649
state2/usage:21034
[root@t61 cpuidle]#                        
