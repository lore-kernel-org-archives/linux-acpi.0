From: David Brownell <david-b@pacbell.net>
Subject: Re: 2.6.25 regression: powertop says 120K wakeups/sec
Date: Fri, 28 Mar 2008 14:09:09 -0700
Message-ID: <200803281409.09622.david-b@pacbell.net>
References: <20080322202454.9D69DCC0EF@adsl-69-226-248-13.dsl.pltn13.pacbell.net> <200803281244.27012.david-b@pacbell.net> <20080328203014.GA16105@linux-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp117.sbc.mail.sp1.yahoo.com ([69.147.64.90]:21493 "HELO
	smtp117.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755085AbYC1VXv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 28 Mar 2008 17:23:51 -0400
In-Reply-To: <20080328203014.GA16105@linux-os.sc.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Venki Pallipadi <venkatesh.pallipadi@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

On Friday 28 March 2008, Venki Pallipadi wrote:
> Can you send me the output of
> # grep . /sys/devices/system/cpu/cpu*/cpuidle/*/*
> with upstream kernel.

This is "upstream" to 3085354de635179d70c240e6d942bcbd1d93056c:

/sys/devices/system/cpu/cpu0/cpuidle/state0/desc:CPUIDLE CORE POLL IDLE
/sys/devices/system/cpu/cpu0/cpuidle/state0/latency:0
/sys/devices/system/cpu/cpu0/cpuidle/state0/name:C0
/sys/devices/system/cpu/cpu0/cpuidle/state0/power:4294967295
/sys/devices/system/cpu/cpu0/cpuidle/state0/time:0
/sys/devices/system/cpu/cpu0/cpuidle/state0/usage:0
/sys/devices/system/cpu/cpu0/cpuidle/state1/desc:<null>
/sys/devices/system/cpu/cpu0/cpuidle/state1/latency:0
/sys/devices/system/cpu/cpu0/cpuidle/state1/name:C1
/sys/devices/system/cpu/cpu0/cpuidle/state1/power:0
/sys/devices/system/cpu/cpu0/cpuidle/state1/time:2781727265
/sys/devices/system/cpu/cpu0/cpuidle/state1/usage:927242422

... as I mentioned, powertop says C2 doesn't get used any more,
moreover that only C0 ever gets used.  The "usage" seems to be
saying otherwise.


> Below is a test patch which should effectively revert commit bc71bec91f987
> Can you check with this patch on latest git and see whether things come back
> to normal.

I'll get back to you with results.

 
> Also, it will help if you can send the output of acpidump from this system.

Sent off-list.

- Dave

