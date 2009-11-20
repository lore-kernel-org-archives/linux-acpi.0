From: Erik Slagter <erik@slagter.name>
Subject: No c2-c7 states on core i7
Date: Fri, 20 Nov 2009 15:28:56 +0100
Message-ID: <4B06A7A8.109@slagter.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from eriks.xs4all.nl ([83.160.41.216]:53857 "EHLO eriks.xs4all.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753216AbZKTOl4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 20 Nov 2009 09:41:56 -0500
Received: from nemesis.slagter.name (nemesis-eth0.ipv4.slagter.name [10.1.7.2])
	by nemesis.slagter.name (Postfix) with ESMTP id A3C6E3B4E6
	for <linux-acpi@vger.kernel.org>; Fri, 20 Nov 2009 15:28:56 +0100 (CET)
Received: from artemis.slagter.name (artemis-vlan7.ipv6.slagter.name [IPv6:2001:888:133a:107::1])
	by nemesis.slagter.name (Postfix) with ESMTP
	for <linux-acpi@vger.kernel.org>; Fri, 20 Nov 2009 15:28:56 +0100 (CET)
Received: from [IPv6:2001:888:133a:103::2] (skylla.ipv6.slagter.name [IPv6:2001:888:133a:103::2])
	by artemis.slagter.name (Postfix) with ESMTP id 64CF73930B86
	for <linux-acpi@vger.kernel.org>; Fri, 20 Nov 2009 15:28:56 +0100 (CET)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi there,

I already put on my flame retardant underwear, I know this is a FAQ, but 
I really need a bit of a jumpstart, google won't tell me where to start, 
so please be gentle ;-)

I bought a Gigabyte EX58-UD3R motherboard recently and put a core i7 920 
on it. This seems to be a fairly common combination.

In short: I know the core i7 does implement several C-states, from 
memory c1, c1e, c3, c6 and c7. Linux (vanilla, 2.6.31.6) does not 
recognise any of them.

The kernel configuration is very similar to the one I am running on my 
laptop with a recent mobile core2duo processor, and this one reports 
C1,C2,C3 (although it should also report yet another C state, but I 
guess that one is disabled by the bios or something alike).

Is this normal (WIP?)?

If not, where should I start debugging? I know there is "something" with 
decoding the DSDT table, but what should I look for?

I seem to remember that with an earlier linux version (before 2.6.30.5) 
it actually did work, but I am not completely sure.

Thanks for your help in advance!

Additional info that might be useful:

- all options related to power saving and C-states are ENABLED in the BIOS
- all options related to power management and idling are ENABLED in the 
kernel, which runs in 64 bits mode
- frequency switching runs fine using acpi-cpufreq and ondemand governor

If I compare the dmesg from both computers after booting, the laptop 
says "ACPI: CPU1 (power states: C1[C1] C2[C2] C3[C3])" at some point, 
this message is not output at all by the server.

Output from proc/acpi/processor/CPU0/info
processor id:            0
acpi id:                 0
bus mastering control:   yes
power management:        no
throttling control:      yes
limit interface:         yes

Output from proc/acpi/processor/CPU0/power
active state:            C0
max_cstate:              C8
maximum allowed latency: 2000000000 usec
states:
     C1:                  type[C1] promotion[--] demotion[--] 
latency[000] usage[00000000] duration[00000000000000000000]

