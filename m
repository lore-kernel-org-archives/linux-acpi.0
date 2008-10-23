From: Len Brown <lenb@kernel.org>
Subject: [PATCH 097/122] ACPICA: add preemption point after each opcode parse
Date: Thu, 23 Oct 2008 02:39:11 -0400
Message-ID: <8bd108d14604d9c95000751e6c6ecbd11ea6ed40.1224743917.git.len.brown@intel.com>
References: <1224743976-31033-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:55856 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755466AbYJWGkh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Oct 2008 02:40:37 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173003.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K9600FVEIJ59LY3@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Oct 2008 01:40:18 -0500 (CDT)
In-reply-to: <1224743976-31033-1-git-send-email-lenb@kernel.org>
In-reply-to: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
References: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Alexey Starikovskiy <astarikovskiy@suse.de>

Reference: http://marc.info/?l=linux-acpi&m=122236382701062&w=2

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Tested-by: Sitsofe Wheeler <sitsofe@yahoo.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/parser/psloop.c    |    2 ++
 include/acpi/acmacros.h         |    5 +++++
 include/acpi/platform/aclinux.h |    6 ++++++
 3 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/parser/psloop.c b/drivers/acpi/parser/psloop.c
index c06238e..4647039 100644
--- a/drivers/acpi/parser/psloop.c
+++ b/drivers/acpi/parser/psloop.c
@@ -719,6 +719,8 @@ acpi_ps_complete_op(struct acpi_walk_state *walk_state,
 		*op = NULL;
 	}
 
+	ACPI_PREEMPTION_POINT();
+
 	return_ACPI_STATUS(AE_OK);
 }
 
diff --git a/include/acpi/acmacros.h b/include/acpi/acmacros.h
index 2106f91..a1e3240 100644
--- a/include/acpi/acmacros.h
+++ b/include/acpi/acmacros.h
@@ -685,4 +685,9 @@ struct acpi_integer_overlay {
 
 #endif				/* ACPI_DBG_TRACK_ALLOCATIONS */
 
+/* Preemption point */
+#ifndef ACPI_PREEMPTION_POINT
+#define ACPI_PREEMPTION_POINT() /* no preemption */
+#endif
+
 #endif				/* ACMACROS_H */
diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform/aclinux.h
index 9af4645..029c8c0 100644
--- a/include/acpi/platform/aclinux.h
+++ b/include/acpi/platform/aclinux.h
@@ -53,6 +53,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/ctype.h>
+#include <linux/sched.h>
 #include <asm/system.h>
 #include <asm/atomic.h>
 #include <asm/div64.h>
@@ -137,4 +138,9 @@ static inline void *acpi_os_acquire_object(acpi_cache_t * cache)
 #define ACPI_ALLOCATE_ZEROED(a)	acpi_os_allocate_zeroed(a)
 #define ACPI_FREE(a)		kfree(a)
 
+/*
+ * We need to show where it is safe to preempt execution of ACPICA
+ */
+#define ACPI_PREEMPTION_POINT()	cond_resched()
+
 #endif				/* __ACLINUX_H__ */
-- 
1.5.5.1

