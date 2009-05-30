From: Len Brown <lenb@kernel.org>
Subject: [PATCH 07/65] cpuidle: fix AMD C1E suspend hang
Date: Fri, 29 May 2009 21:41:45 -0400
Message-ID: <7d60e8ab0d5507229dfbdf456501cc378610fa01.1243647607.git.len.brown@intel.com>
References: <1243647763-31572-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:61678 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755294AbZE3Bms (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 29 May 2009 21:42:48 -0400
Received: from localhost.localdomain ([98.118.45.40])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KKF00B26ORDFTT3@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 29 May 2009 20:42:50 -0500 (CDT)
In-reply-to: <1243647763-31572-1-git-send-email-lenb@kernel.org>
In-reply-to: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
References: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Shaohua Li <shaohua.li@intel.com>, Len Brown <len.brown@intel.com>

From: Shaohua Li <shaohua.li@intel.com>

When AMD C1E is enabled, local APIC timer will stop even in C1. To avoid
suspend/resume hang, this patch removes C1 and replace it with a cpu_relax() in
suspend/resume path. This hasn't any impact in runtime path.

http://bugzilla.kernel.org/show_bug.cgi?id=13233

[ impact: avoid suspend/resume hang in AMD CPU with C1E enabled ]

Tested-by: Dmitry Lyzhyn <thisistempbox@yahoo.com>
Signed-off-by: Shaohua Li <shaohua.li@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_idle.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 6b7bcc7..10a2d91 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -834,8 +834,8 @@ static int acpi_idle_enter_c1(struct cpuidle_device *dev,
 
 	/* Do not access any ACPI IO ports in suspend path */
 	if (acpi_idle_suspend) {
-		acpi_safe_halt();
 		local_irq_enable();
+		cpu_relax();
 		return 0;
 	}
 
-- 
1.6.0.6

