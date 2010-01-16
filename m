From: Len Brown <lenb@kernel.org>
Subject: [PATCH 10/16] ACPI: don't cond_resched if irq is disabled
Date: Sat, 16 Jan 2010 02:33:00 -0500
Message-ID: <c084ca704a3661bf77690a05bc6bd2c305d87c34.1263627123.git.len.brown@intel.com>
References: <1263627186-21384-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173009pub.verizon.net ([206.46.173.9]:58800 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751922Ab0APHef (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 16 Jan 2010 02:34:35 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KWB00L58X1LW0J1@vms173009.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 16 Jan 2010 01:34:35 -0600 (CST)
In-reply-to: <1263627186-21384-1-git-send-email-lenb@kernel.org>
In-reply-to: <a62e8f1978f49e52f87a711ff6711b323d4b12ff.1263627123.git.len.brown@intel.com>
References: <a62e8f1978f49e52f87a711ff6711b323d4b12ff.1263627123.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Xiaotian Feng <dfeng@redhat.com>, Len Brown <len.brown@intel.com>

From: Xiaotian Feng <dfeng@redhat.com>

commit 8bd108d adds preemption point after each opcode parse, then
a sleeping function called from invalid context bug was founded
during suspend/resume stage. this was fixed in commit abe1dfa by
don't cond_resched when irq_disabled. But recent commit 138d156 changes
the behaviour to don't cond_resched when in_atomic. This makes the
sleeping function called from invalid context bug happen again, which
is reported in http://lkml.org/lkml/2009/12/1/371.

This patch also fixes http://bugzilla.kernel.org/show_bug.cgi?id=14483

Reported-and-bisected-by: Larry Finger <Larry.Finger@lwfinger.net>
Reported-and-bisected-by: Justin P. Mattock <justinmattock@gmail.com>
Signed-off-by: Xiaotian Feng <dfeng@redhat.com>
Acked-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 include/acpi/platform/aclinux.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform/aclinux.h
index 9d7febd..0946997 100644
--- a/include/acpi/platform/aclinux.h
+++ b/include/acpi/platform/aclinux.h
@@ -152,7 +152,7 @@ static inline void *acpi_os_acquire_object(acpi_cache_t * cache)
 #include <linux/hardirq.h>
 #define ACPI_PREEMPTION_POINT() \
 	do { \
-		if (!in_atomic_preempt_off()) \
+		if (!in_atomic_preempt_off() && !irqs_disabled()) \
 			cond_resched(); \
 	} while (0)
 
-- 
1.6.0.6

