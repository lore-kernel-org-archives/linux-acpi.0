From: Zhao Yakui <yakui.zhao@intel.com>
Subject: [PATCH2/4] ACPI :  Add the boot option of "idle=halt" to use halt
	for CPU idle
Date: Tue, 17 Jun 2008 14:42:53 +0800
Message-ID: <1213684973.19901.13.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:63237 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750793AbYFQGcz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 17 Jun 2008 02:32:55 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org

Subject: ACPI: Add the boot option of "idle=halt" to use halt for CPU idle
From: Zhao Yakui <yakui.zhao@intel.com>

    If the boot option of "idle=halt" is added, OSPM will be forced to use
Halt for CPU idle. In such case CPU C-state won't be used again for CPU idle.

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
---
 Documentation/kernel-parameters.txt |    4 +++-
 arch/x86/kernel/process.c           |    3 +++
 2 files changed, 6 insertions(+), 1 deletion(-)

Index: linux-2.6/arch/x86/kernel/process.c
===================================================================
--- linux-2.6.orig/arch/x86/kernel/process.c
+++ linux-2.6/arch/x86/kernel/process.c
@@ -6,6 +6,7 @@
 #include <linux/sched.h>
 #include <linux/module.h>
 #include <linux/pm.h>
+#include <asm/system.h>
 
 struct kmem_cache *task_xstate_cachep;
 
@@ -169,6 +170,8 @@ static int __init idle_setup(char *str)
 		pm_idle = poll_idle;
 	} else if (!strcmp(str, "mwait"))
 		force_mwait = 1;
+	else if (!strcmp(str, "halt"))
+		pm_idle = default_idle;
 	else
 		return -1;
 
Index: linux-2.6/Documentation/kernel-parameters.txt
===================================================================
--- linux-2.6.orig/Documentation/kernel-parameters.txt
+++ linux-2.6/Documentation/kernel-parameters.txt
@@ -785,7 +785,7 @@ and is between 256 and 4096 characters. 
 			See Documentation/ide/ide.txt.
 
 	idle=		[X86]
-			Format: idle=poll or idle=mwait
+			Format: idle=poll or idle=mwait, idle = halt
 			Poll forces a polling idle loop that can slightly improves the performance
 			of waking up a idle CPU, but will use a lot of power and make the system
 			run hot. Not recommended.
@@ -793,6 +793,8 @@ and is between 256 and 4096 characters. 
 			to not use it because it doesn't save as much power as a normal idle
 			loop use the MONITOR/MWAIT idle loop anyways. Performance should be the same
 			as idle=poll.
+			idle = halt . Halt is forced to be used for CPU idle.
+			In such case C2/C3 won't be used again.
 
 	ide-pci-generic.all-generic-ide [HW] (E)IDE subsystem
 			Claim all unknown PCI IDE storage controllers.


