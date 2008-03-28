From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: RE: 2.6.25 regression: powertop says 120K wakeups/sec
Date: Fri, 28 Mar 2008 14:55:57 -0700
Message-ID: <924EFEDD5F540B4284297C4DC59F3DEEC83E08@orsmsx423.amr.corp.intel.com>
References: <20080322202454.9D69DCC0EF@adsl-69-226-248-13.dsl.pltn13.pacbell.net> <200803281244.27012.david-b@pacbell.net> <20080328203014.GA16105@linux-os.sc.intel.com> <200803281409.09622.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:20226 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756189AbYC1V6R convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 28 Mar 2008 17:58:17 -0400
Content-class: urn:content-classes:message
In-Reply-To: <200803281409.09622.david-b@pacbell.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

 

>-----Original Message-----
>From: David Brownell [mailto:david-b@pacbell.net] 
>Sent: Friday, March 28, 2008 2:09 PM
>To: Pallipadi, Venkatesh
>Cc: Andrew Morton; linux-kernel@vger.kernel.org; Rafael J. 
>Wysocki; linux-acpi@vger.kernel.org; Len Brown
>Subject: Re: 2.6.25 regression: powertop says 120K wakeups/sec
>
>On Friday 28 March 2008, Venki Pallipadi wrote:
>> Can you send me the output of
>> # grep . /sys/devices/system/cpu/cpu*/cpuidle/*/*
>> with upstream kernel.
>
>This is "upstream" to 3085354de635179d70c240e6d942bcbd1d93056c:
>
>/sys/devices/system/cpu/cpu0/cpuidle/state0/desc:CPUIDLE CORE POLL IDLE
>/sys/devices/system/cpu/cpu0/cpuidle/state0/latency:0
>/sys/devices/system/cpu/cpu0/cpuidle/state0/name:C0
>/sys/devices/system/cpu/cpu0/cpuidle/state0/power:4294967295
>/sys/devices/system/cpu/cpu0/cpuidle/state0/time:0
>/sys/devices/system/cpu/cpu0/cpuidle/state0/usage:0
>/sys/devices/system/cpu/cpu0/cpuidle/state1/desc:<null>
>/sys/devices/system/cpu/cpu0/cpuidle/state1/latency:0
>/sys/devices/system/cpu/cpu0/cpuidle/state1/name:C1
>/sys/devices/system/cpu/cpu0/cpuidle/state1/power:0
>/sys/devices/system/cpu/cpu0/cpuidle/state1/time:2781727265
>/sys/devices/system/cpu/cpu0/cpuidle/state1/usage:927242422
>
>... as I mentioned, powertop says C2 doesn't get used any more,
>moreover that only C0 ever gets used.  The "usage" seems to be
>saying otherwise.
>

Looks like C2 state detection got broken somehow..
There was new state0 (polling) that was added recently which should
never get used.
state1 is actually C1 which for some reason is not staying idle and
waking up immediately (that is the reason for high usage). And C2 is
missing. I do see, in acpidump that you sent, there is a C2 state info
there.
You should have a dmesg line which looks like
ACPI: CPU0 (power states: C1[C1] C2[C2]
Do you see C2 in such line?

Thanks,
Venki
