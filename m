From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: [PATCH] ACPICA: add preemption point after each opcode parse
Date: Thu, 25 Sep 2008 21:40:30 +0400
Message-ID: <20080925174030.17128.78242.stgit@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:38724 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753185AbYIYRk3 (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Thu, 25 Sep 2008 13:40:29 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: LenBrown <lenb@kernel.org>
Cc: Linux-acpi@vger.kernel.org

Reference: http://marc.info/?l=linux-acpi&m=122236382701062&w=2

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Tested-by: Sitsofe Wheeler <sitsofe@yahoo.com>
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
index 57ab9e9..b402685 100644
--- a/include/acpi/acmacros.h
+++ b/include/acpi/acmacros.h
@@ -703,4 +703,9 @@ struct acpi_integer_overlay {
 
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

