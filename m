From: Len Brown <lenb@kernel.org>
Subject: [PATCH 1/6] ACPI: don't cond_resched if irq is disabled
Date: Wed, 30 Dec 2009 02:41:17 -0500
Message-ID: <4c291b9021e33aac046ee8abeb9ea8fe76086342.1262158615.git.len.brown@intel.com>
References: <1262158882-9713-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:49688 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751612AbZL3Hl0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Dec 2009 02:41:26 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KVG00JWSG1128PL@vms173011.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 30 Dec 2009 01:41:26 -0600 (CST)
In-reply-to: <1262158882-9713-1-git-send-email-lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Xiaotian Feng <dfeng@redhat.com>, Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>

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
Cc: Len Brown <lenb@kernel.org>
Cc: Bob Moore <robert.moore@intel.com>
Cc: Lin Ming <ming.m.lin@intel.com>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Pavel Machek <pavel@ucw.cz>
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

