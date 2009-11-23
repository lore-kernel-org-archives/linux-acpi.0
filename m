From: ykzhao <yakui.zhao@intel.com>
Subject: Re: No c2-c7 states on core i7
Date: Mon, 23 Nov 2009 11:05:12 +0800
Message-ID: <1258945512.3773.33.camel@localhost.localdomain>
References: <4B06A7A8.109@slagter.name>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:26443 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756031AbZKWDG6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 22 Nov 2009 22:06:58 -0500
In-Reply-To: <4B06A7A8.109@slagter.name>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Erik Slagter <erik@slagter.name>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Fri, 2009-11-20 at 22:28 +0800, Erik Slagter wrote:
> Hi there,
> 
> I already put on my flame retardant underwear, I know this is a FAQ, but 
> I really need a bit of a jumpstart, google won't tell me where to start, 
> so please be gentle ;-)
> 
> I bought a Gigabyte EX58-UD3R motherboard recently and put a core i7 920 
> on it. This seems to be a fairly common combination.
> 
> In short: I know the core i7 does implement several C-states, from 
> memory c1, c1e, c3, c6 and c7. Linux (vanilla, 2.6.31.6) does not 
> recognise any of them.
> 
> The kernel configuration is very similar to the one I am running on my 
> laptop with a recent mobile core2duo processor, and this one reports 
> C1,C2,C3 (although it should also report yet another C state, but I 
> guess that one is disabled by the bios or something alike).
> 
> Is this normal (WIP?)?
> 
> If not, where should I start debugging? I know there is "something" with 
> decoding the DSDT table, but what should I look for?
> 
> I seem to remember that with an earlier linux version (before 2.6.30.5) 
> it actually did work, but I am not completely sure.
> 
> Thanks for your help in advance!
> 
> Additional info that might be useful:
> 
> - all options related to power saving and C-states are ENABLED in the BIOS
> - all options related to power management and idling are ENABLED in the 
> kernel, which runs in 64 bits mode
> - frequency switching runs fine using acpi-cpufreq and ondemand governor
> 
> If I compare the dmesg from both computers after booting, the laptop 
> says "ACPI: CPU1 (power states: C1[C1] C2[C2] C3[C3])" at some point, 
> this message is not output at all by the server.

Will you please attach the output of acpidump on the machine with the
core i7 cpu?
Please attach the output of every file
under /sys/firmware/acpi/tables/dynamic/SSDT*? 
   cat /sys/firmware/acpi/tables/dynamic/SSDT1 > ssdt1

Please also attach the output of /proc/cpuinfo.

Thanks.
> 
> Output from proc/acpi/processor/CPU0/info
> processor id:            0
> acpi id:                 0
> bus mastering control:   yes
> power management:        no
> throttling control:      yes
> limit interface:         yes
> 
> Output from proc/acpi/processor/CPU0/power
> active state:            C0
> max_cstate:              C8
> maximum allowed latency: 2000000000 usec
> states:
>      C1:                  type[C1] promotion[--] demotion[--] 
> latency[000] usage[00000000] duration[00000000000000000000]
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

