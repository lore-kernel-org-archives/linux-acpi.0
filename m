From: Len Brown <lenb@kernel.org>
Subject: [PATCH 15/94] doc: fix kernel-parameters.txt formatting
Date: Fri, 09 Jan 2009 04:26:17 -0500
Message-ID: <ada9cfdd158abb8169873dc8e5ae39b1ec6ffa8c.1231492608.git.len.brown@intel.com>
References: <1231493256-11678-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms046pub.verizon.net ([206.46.252.46]:59678 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753801AbZAIJ22 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 04:28:28 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms046.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0KD700MPZ6AGVY83@vms046.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 09 Jan 2009 03:27:54 -0600 (CST)
In-reply-to: <1231493256-11678-1-git-send-email-lenb@kernel.org>
In-reply-to: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
References: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Len Brown <len.brown@intel.com>

From: Randy Dunlap <randy.dunlap@oracle.com>

Spell out "wrt".  I suspect plenty of people won't know
what that means.

Fix a '}' that should be a ']'.

Reformat long lines into shorter lines.

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/kernel-parameters.txt |   40 +++++++++++++++++++---------------
 1 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 1d089ee..350e719 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -151,15 +151,16 @@ and is between 256 and 4096 characters. It is defined in the file
 	acpi_sleep=	[HW,ACPI] Sleep options
 			Format: { s3_bios, s3_mode, s3_beep, s4_nohwsig,
 				  old_ordering, s4_nonvs }
-			See Documentation/power/video.txt for s3_bios and s3_mode.
+			See Documentation/power/video.txt for information on
+			s3_bios and s3_mode.
 			s3_beep is for debugging; it makes the PC's speaker beep
 			as soon as the kernel's real-mode entry point is called.
 			s4_nohwsig prevents ACPI hardware signature from being
 			used during resume from hibernation.
 			old_ordering causes the ACPI 1.0 ordering of the _PTS
-			control method, wrt putting devices into low power
-			states, to be enforced (the ACPI 2.0 ordering of _PTS is
-			used by default).
+			control method, with respect to putting devices into
+			low power states, to be enforced (the ACPI 2.0 ordering
+			of _PTS is used by default).
 			s4_nonvs prevents the kernel from saving/restoring the
 			ACPI NVS memory during hibernation.
 
@@ -196,7 +197,7 @@ and is between 256 and 4096 characters. It is defined in the file
 	acpi_skip_timer_override [HW,ACPI]
 			Recognize and ignore IRQ0/pin2 Interrupt Override.
 			For broken nForce2 BIOS resulting in XT-PIC timer.
-	acpi_use_timer_override [HW,ACPI}
+	acpi_use_timer_override [HW,ACPI]
 			Use timer override. For some broken Nvidia NF5 boards
 			that require a timer override, but don't have
 			HPET
@@ -860,17 +861,19 @@ and is between 256 and 4096 characters. It is defined in the file
 			See Documentation/ide/ide.txt.
 
 	idle=		[X86]
-			Format: idle=poll or idle=mwait, idle=halt, idle=nomwait
-			Poll forces a polling idle loop that can slightly improves the performance
-			of waking up a idle CPU, but will use a lot of power and make the system
-			run hot. Not recommended.
-			idle=mwait. On systems which support MONITOR/MWAIT but the kernel chose
-			to not use it because it doesn't save as much power as a normal idle
-			loop use the MONITOR/MWAIT idle loop anyways. Performance should be the same
-			as idle=poll.
-			idle=halt. Halt is forced to be used for CPU idle.
+			Format: idle=poll, idle=mwait, idle=halt, idle=nomwait
+			Poll forces a polling idle loop that can slightly
+			improve the performance of waking up a idle CPU, but
+			will use a lot of power and make the system run hot.
+			Not recommended.
+			idle=mwait: On systems which support MONITOR/MWAIT but
+			the kernel chose to not use it because it doesn't save
+			as much power as a normal idle loop, use the
+			MONITOR/MWAIT idle loop anyways. Performance should be
+			the same as idle=poll.
+			idle=halt: Halt is forced to be used for CPU idle.
 			In such case C2/C3 won't be used again.
-			idle=nomwait. Disable mwait for CPU C-states
+			idle=nomwait: Disable mwait for CPU C-states
 
 	ide-pci-generic.all-generic-ide [HW] (E)IDE subsystem
 			Claim all unknown PCI IDE storage controllers.
@@ -1052,8 +1055,8 @@ and is between 256 and 4096 characters. It is defined in the file
 	lapic		[X86-32,APIC] Enable the local APIC even if BIOS
 			disabled it.
 
-	lapic_timer_c2_ok	[X86-32,x86-64,APIC] trust the local apic timer in
-			C2 power state.
+	lapic_timer_c2_ok	[X86-32,x86-64,APIC] trust the local apic timer
+			in C2 power state.
 
 	libata.dma=	[LIBATA] DMA control
 			libata.dma=0	  Disable all PATA and SATA DMA
@@ -2241,7 +2244,8 @@ and is between 256 and 4096 characters. It is defined in the file
 
 	thermal.psv=	[HW,ACPI]
 			-1: disable all passive trip points
-			<degrees C>: override all passive trip points to this value
+			<degrees C>: override all passive trip points to this
+			value
 
 	thermal.tzp=	[HW,ACPI]
 			Specify global default ACPI thermal zone polling rate
-- 
1.5.6.6

