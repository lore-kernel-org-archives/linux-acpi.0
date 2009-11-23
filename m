From: Erik Slagter <erik@slagter.name>
Subject: Re: No c2-c7 states on core i7
Date: Mon, 23 Nov 2009 09:52:50 +0100
Message-ID: <4B0A4D62.2040001@slagter.name>
References: <4B06A7A8.109@slagter.name> <1258945512.3773.33.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from eriks.xs4all.nl ([83.160.41.216]:52816 "EHLO eriks.xs4all.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750938AbZKWIww (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 23 Nov 2009 03:52:52 -0500
In-Reply-To: <1258945512.3773.33.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ykzhao <yakui.zhao@intel.com>
Cc: linux-acpi@vger.kernel.org

On 23-11-09 04:05, ykzhao wrote:
> On Fri, 2009-11-20 at 22:28 +0800, Erik Slagter wrote:
>> Hi there,
>>
>> I already put on my flame retardant underwear, I know this is a FAQ, but
>> I really need a bit of a jumpstart, google won't tell me where to start,
>> so please be gentle ;-)
>>
>> I bought a Gigabyte EX58-UD3R motherboard recently and put a core i7 920
>> on it. This seems to be a fairly common combination.
>>
>> In short: I know the core i7 does implement several C-states, from
>> memory c1, c1e, c3, c6 and c7. Linux (vanilla, 2.6.31.6) does not
>> recognise any of them.
>>
>> The kernel configuration is very similar to the one I am running on my
>> laptop with a recent mobile core2duo processor, and this one reports
>> C1,C2,C3 (although it should also report yet another C state, but I
>> guess that one is disabled by the bios or something alike).
>>
>> Is this normal (WIP?)?
>>
>> If not, where should I start debugging? I know there is "something" with
>> decoding the DSDT table, but what should I look for?
>>
>> I seem to remember that with an earlier linux version (before 2.6.30.5)
>> it actually did work, but I am not completely sure.
>>
>> Thanks for your help in advance!
>>
>> Additional info that might be useful:
>>
>> - all options related to power saving and C-states are ENABLED in the BIOS
>> - all options related to power management and idling are ENABLED in the
>> kernel, which runs in 64 bits mode
>> - frequency switching runs fine using acpi-cpufreq and ondemand governor
>>
>> If I compare the dmesg from both computers after booting, the laptop
>> says "ACPI: CPU1 (power states: C1[C1] C2[C2] C3[C3])" at some point,
>> this message is not output at all by the server.
>>
>> Output from proc/acpi/processor/CPU0/info
>> processor id:            0
>> acpi id:                 0
>> bus mastering control:   yes
>> power management:        no
>> throttling control:      yes
>> limit interface:         yes
>>
>> Output from proc/acpi/processor/CPU0/power
>> active state:            C0
>> max_cstate:              C8
>> maximum allowed latency: 2000000000 usec
>> states:
>>       C1:                  type[C1] promotion[--] demotion[--]
>> latency[000] usage[00000000] duration[00000000000000000000]
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

 > Will you please attach the output of acpidump on the machine with the
 > core i7 cpu?
 > Please attach the output of every file
 > under /sys/firmware/acpi/tables/dynamic/SSDT*?
 >     cat /sys/firmware/acpi/tables/dynamic/SSDT1>  ssdt1
 >
 > Please also attach the output of /proc/cpuinfo.

Hi,

Thank you for your attention. This specific issue has already been 
solved for me, it turns out be yet another bios issue (as I have 
experienced before). Enable base clock setting and all C states are gone!

But now I have a few other issues that maybe you can help me with:

- How are intel core i7 C states mapped to linux C states? Both my 
laptop (core2duo T9300) and desktop (core i7 920) should have 
c1-c3-c6-c7, but on both machines linux only sees c1-c2-c3.

- On said desktop, I see no difference in power consumption with c 
states enabled or disabled; if they're enabled (and base clock control 
is off...) linux is using c3 almost all of the time, but power 
consumption remains the same (about 110 watts for the complete 
motherboard, is that normal?).

- From a quick inspection of the acpi tables (I am not quite an expert 
on this...) it looks like a number of _CST objects are exported with 
default bios settings, while with base clock control enabled, these are 
gone. I would to try (yes I know, not recommended, etc.) to copy the 
_CST objects from the one boot instance's tables to the other. Now I 
think of it, it would probably even suffice to boot one time with 
baseclock control disabled, record the acpi tables (SSDT?) and then make 
the kernel use that in subsequent boots with the base clock control 
enabled (with all other bios settings the same, off course). Is that 
difficult to achieve? I seem to remember that's possible one way or another.

Thanks for your help!

P.S. I am going to have a look at the /sys/* files you mentioned anyway, 
I didn't even know they were there!
