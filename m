From: Len Brown <lenb@kernel.org>
Subject: [PATCH 68/70] ACPI: Create "idle=halt" boot parameter
Date: Fri, 20 Jun 2008 03:44:10 -0400
Message-ID: <bd08eac673842bab79ddaec048012b6e5d4074fd.1213947350.git.len.brown@intel.com>
References: <1213947852-10924-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:54086 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752886AbYFTHsD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Jun 2008 03:48:03 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms173005.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K2R007LB40E2241@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 20 Jun 2008 02:41:18 -0500 (CDT)
In-reply-to: <1213947852-10924-1-git-send-email-lenb@kernel.org>
In-reply-to: <087803d18fb8259cb844c075a35fb27c2d80792e.1213947349.git.len.brown@intel.com>
References: <087803d18fb8259cb844c075a35fb27c2d80792e.1213947349.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhao Yakui <yakui.zhao@intel.com>, Len Brown <len.brown@intel.com>

From: Zhao Yakui <yakui.zhao@intel.com>

"idle=halt" forces Linux to use only HLT for the idle loop.
This disables all fancy idle features, such as MWAIT
and C-states deeper than C1.  However, it is not as extreme
as "idle=poll", which disabled all idle power savings features.

While those fancy features save power, this option
is useful when there are either platform or Linux bugs,
or suspected latency issues related to those features.

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/kernel-parameters.txt |    4 +++-
 arch/x86/kernel/process.c           |    3 +++
 2 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index e07c432..1623c2f 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -785,7 +785,7 @@ and is between 256 and 4096 characters. It is defined in the file
 			See Documentation/ide/ide.txt.
 
 	idle=		[X86]
-			Format: idle=poll or idle=mwait
+			Format: idle=poll or idle=mwait, idle = halt
 			Poll forces a polling idle loop that can slightly improves the performance
 			of waking up a idle CPU, but will use a lot of power and make the system
 			run hot. Not recommended.
@@ -793,6 +793,8 @@ and is between 256 and 4096 characters. It is defined in the file
 			to not use it because it doesn't save as much power as a normal idle
 			loop use the MONITOR/MWAIT idle loop anyways. Performance should be the same
 			as idle=poll.
+			idle = halt . Halt is forced to be used for CPU idle.
+			In such case C2/C3 won't be used again.
 
 	ide-pci-generic.all-generic-ide [HW] (E)IDE subsystem
 			Claim all unknown PCI IDE storage controllers.
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index ba370dc..6a35c7d 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
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
 
-- 
1.5.6

