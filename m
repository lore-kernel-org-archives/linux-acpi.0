From: Len Brown <lenb@kernel.org>
Subject: [PATCH 103/103] acpi_pad: squish warning
Date: Wed, 16 Dec 2009 03:36:54 -0500
Message-ID: <f67538f81e6b8da9175c82807d649fbdb0055844.1260952472.git.len.brown@intel.com>
References: <1260952614-3152-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:47186 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762000AbZLPLGA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 06:06:00 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KUQ00BZPS5OJK34@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 16 Dec 2009 05:05:54 -0600 (CST)
In-reply-to: <1260952614-3152-1-git-send-email-lenb@kernel.org>
In-reply-to: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
References: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Shaohua Li <shaohua.li@intel.com>, Len Brown <len.brown@intel.com>

From: Andrew Morton <akpm@linux-foundation.org>

drivers/acpi/acpi_pad.c: In function 'power_saving_thread':
drivers/acpi/acpi_pad.c:103: warning: 'preferred_cpu' may be used uninitialized in this function

Cc: Shaohua Li <shaohua.li@intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpi_pad.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
index 0d2cdb8..97991ac 100644
--- a/drivers/acpi/acpi_pad.c
+++ b/drivers/acpi/acpi_pad.c
@@ -100,7 +100,8 @@ static void round_robin_cpu(unsigned int tsk_index)
 	struct cpumask *pad_busy_cpus = to_cpumask(pad_busy_cpus_bits);
 	cpumask_var_t tmp;
 	int cpu;
-	unsigned long min_weight = -1, preferred_cpu;
+	unsigned long min_weight = -1;
+	unsigned long uninitialized_var(preferred_cpu);
 
 	if (!alloc_cpumask_var(&tmp, GFP_KERNEL))
 		return;
-- 
1.6.0.6

