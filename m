From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: [PATCH] doc: fix kernel-parameters.txt formatting
Date: Fri, 19 Dec 2008 10:57:32 -0800
Message-ID: <20081219105732.5bd7b671.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rcsinet12.oracle.com ([148.87.113.124]:27991 "EHLO
	rgminet12.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751479AbYLSS5t (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Dec 2008 13:57:49 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>

Spell out "wrt".  I suspect plenty of people won't know
what that means.

Fix a '}' that should be a ']'.

Reformat long lines into shorter lines.

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 Documentation/kernel-parameters.txt |   40 +++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 18 deletions(-)

--- linux-next-20081219.orig/Documentation/kernel-parameters.txt
+++ linux-next-20081219/Documentation/kernel-parameters.txt
@@ -153,15 +153,16 @@ and is between 256 and 4096 characters. 
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
 
@@ -198,7 +199,7 @@ and is between 256 and 4096 characters. 
 	acpi_skip_timer_override [HW,ACPI]
 			Recognize and ignore IRQ0/pin2 Interrupt Override.
 			For broken nForce2 BIOS resulting in XT-PIC timer.
-	acpi_use_timer_override [HW,ACPI}
+	acpi_use_timer_override [HW,ACPI]
 			Use timer override. For some broken Nvidia NF5 boards
 			that require a timer override, but don't have
 			HPET
@@ -873,17 +874,19 @@ and is between 256 and 4096 characters. 
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
@@ -1078,8 +1081,8 @@ and is between 256 and 4096 characters. 
 	lapic		[X86-32,APIC] Enable the local APIC even if BIOS
 			disabled it.
 
-	lapic_timer_c2_ok	[X86-32,x86-64,APIC] trust the local apic timer in
-			C2 power state.
+	lapic_timer_c2_ok	[X86-32,x86-64,APIC] trust the local apic timer
+			in C2 power state.
 
 	libata.dma=	[LIBATA] DMA control
 			libata.dma=0	  Disable all PATA and SATA DMA
@@ -2301,7 +2304,8 @@ and is between 256 and 4096 characters. 
 
 	thermal.psv=	[HW,ACPI]
 			-1: disable all passive trip points
-			<degrees C>: override all passive trip points to this value
+			<degrees C>: override all passive trip points to this
+			value
 
 	thermal.tzp=	[HW,ACPI]
 			Specify global default ACPI thermal zone polling rate
