From: Vasileios Gkanis <gkanis@cems.umn.edu>
Subject: High pitched sound with 2.6.15-ck1 --  Need your help
Date: Thu, 19 Jan 2006 01:54:04 +0200
Message-ID: <200601190154.04718.gkanis@cems.umn.edu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from tyr.cems.umn.edu ([134.84.164.251]:63141 "EHLO
	mail.cems.umn.edu") by vger.kernel.org with ESMTP id S1030465AbWARXy7
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 18 Jan 2006 18:54:59 -0500
Received: from [192.168.1.3] (ipa213.1.tellas.gr [84.254.1.213])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.cems.umn.edu (Postfix) with ESMTP id B1B3537000F
	for <linux-acpi@vger.kernel.org>; Wed, 18 Jan 2006 17:53:47 -0600 (CST)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

I have a laptop which makes this high pitched sound when HZ is 1000.  Up to 
2.6.13 kernel, the dynamic tick patch would do the trick and this sound would 
not be audible. Unfortunately, this is not the case with 2.6.15 kernel and 
ck1 patch (Con Kolivas' patch).

I am sending you the output from cat /proc/acpi/processor/CPU0/power and 
dmesg | grep dyn for these two kernels.

2.6.15

dmesg | grep dyn
dyn-tick: Disabling APIC timer, using PIT reprogramming
dyn-tick: Maximum ticks to skip limited to 54
dyn-tick: Enabling dynamic tick timer v060101

cat /proc/acpi/processor/CPU0/power
active state:            C4
max_cstate:              C8
bus master activity:     00000000
states:
    C1:                  type[C1] promotion[C2] demotion[--] latency[001] 
usage[00000010] duration[00000000000000000000]
    C2:                  type[C2] promotion[C3] demotion[C1] latency[001] 
usage[00002323] duration[00000000000028289396]
    C3:                  type[C3] promotion[C4] demotion[C2] latency[085] 
usage[00004662] duration[00000000000033903705]
   *C4:                  type[C3] promotion[--] demotion[C3] latency[185] 
usage[00040131] duration[00000000000671395256]



2.6.13

dmesg | grep dyn
dyn-tick: Found suitable timer: pmtmr
dyn-tick: Registering dynamic tick timer v050610-1
dyn-tick: Maximum ticks to skip limited to 54
dyn-tick: Timer not enabled during boot

cat /proc/acpi/processor/CPU0/power
active state:            C2
max_cstate:              C8
bus master activity:     1ffa7ffc
states:
    C1:                  type[C1] promotion[C2] demotion[--] latency[001] 
usage[00000010]
   *C2:                  type[C2] promotion[C3] demotion[C1] latency[001] 
usage[00017371]
    C3:                  type[C3] promotion[C4] demotion[C2] latency[085] 
usage[00002288]
    C4:                  type[C3] promotion[--] demotion[C3] latency[185] 
usage[00009309]



I would like to add that pmstats for both kernel reports the same value of HZ. 
Also, I use the conservative governor for both kernel. It is important to say 
here that for the 2.6.13 kernel, if I do not use the dynamic tick patch, the 
sound will not be audible if I change the governor to performance.  
Nevertheless, this is not the case for the 2.6.15 kernel.

Finally, I found out that if I have "idle=poll" in the kernel arguments then I 
will not hear this sound, but then again my system runs in C1 state. This is 
a solution, but it is not the best one, and I would like to know if there are 
alternative solutions to this problem.

If you need more info about my system, I will be happy to provide it.

Thank you,
Vasilis
