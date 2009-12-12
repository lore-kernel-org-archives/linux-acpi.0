From: "Youquan,Song" <youquan.song@linux.intel.com>
Subject: [PATCH]acpi c-states: Fix ACPI C3 is wrongly mapped to C2
Date: Sat, 12 Dec 2009 13:14:42 -0500
Message-ID: <20091212181442.GA22832@youquan-linux.bj.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga12.intel.com ([143.182.124.36]:52653 "EHLO
	azsmga102.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1761471AbZLLKjD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 12 Dec 2009 05:39:03 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: venkatesh.pallipadi@intel.com, kent.liu@intel.com, chaohong.guo@intel.com, youquan.song@intel.com, linux-acpi@vger.kernel.org

On Nehalem-EX, CPU C3 is mapped to ACPI C3, but C-states information in /proc
 and /sys are conflicting with ACPI C2 mapping and confused user.

/proc/acpi/processor/CPUx/power

    C1:                  type[C1] promotion[--] demotion[--] 
    C2:                  type[C3] promotion[--] demotion[--] 

While
/sys/devices/system/cpu/cpux/cpuidle/state1
ACPI FFH INTEL MWAIT 0x0
1
C1
1000
58312355
323873

/sys/devices/system/cpu/cpux/cpuidle/state2
ACPI FFH INTEL MWAIT 0x10
17
C2
500
83706664055
18926855

In /proc, "type[C3]" mean acpi C3, but from its title "C2:" mean processor
support max C-state is ACPI C2.
In /sys, there is no any information show that this processor support ACPI C3. 

these issues are rooted cause to ACPI C2 miss at some platforms, ACPI C3 is
wrongly mapped to C2.

This patch will invalidate ACPI C2 when platform does not support ACPI C2.

After apply the patch, the C-state information in /proc and /sys are reasonable

/proc/acpi/processor/CPUx/power
    C1:                  type[C1] promotion[--] demotion[--] 
    C2:                  <not supported>
    C3:                  type[C3] promotion[--] demotion[--] 
/sys/devices/system/cpu/cpux/cpuidle/state1/
ACPI FFH INTEL MWAIT 0x0
1
C1
1000
65220
1923

/sys/devices/system/cpu/cpux/cpuidle/state2/
ACPI FFH INTEL MWAIT 0x10
17
C3
500
5794034076
1530073

Signed-off-by: Youquan, Song <youquan.song@intel.com>
---

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index bbd066e..302d656 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -459,6 +459,10 @@ static int acpi_processor_get_power_info_cst(struct acpi_processor *pr)
 		cx.power = obj->integer.value;
 
 		current_count++;
+
+		if (current_count == 2 && cx.type != ACPI_STATE_C2)
+			current_count++;
+
 		memcpy(&(pr->power.states[current_count]), &cx, sizeof(cx));
 
 		/*
