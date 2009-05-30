From: Len Brown <lenb@kernel.org>
Subject: [PATCH 02/11] cpuidle: fix AMD C1E suspend hang
Date: Fri, 29 May 2009 21:37:12 -0400
Message-ID: <7d60e8ab0d5507229dfbdf456501cc378610fa01.1243647312.git.len.brown@intel.com>
References: <1243647441-31392-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:56372 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751647AbZE3Bh1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 29 May 2009 21:37:27 -0400
Received: from localhost.localdomain ([98.118.45.40])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KKF002A4OIEOCZ0@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 29 May 2009 20:37:27 -0500 (CDT)
In-reply-to: <1243647441-31392-1-git-send-email-lenb@kernel.org>
In-reply-to: <87ad57bacb25c3f24c54f142ef445f68277705f0.1243647311.git.len.brown@intel.com>
References: <87ad57bacb25c3f24c54f142ef445f68277705f0.1243647311.git.len.brown@intel.com>
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

