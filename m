From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: [PATCH 1/3] ACPICA: Don't switch task then not allowed
Date: Fri, 28 Aug 2009 23:29:38 +0400
Message-ID: <20090828192938.19961.63714.stgit@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:58954 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752645AbZH1T3h (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Fri, 28 Aug 2009 15:29:37 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Linux-acpi@vger.kernel.org

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
---

 include/acpi/platform/aclinux.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform/aclinux.h
index fcb8e4b..9d7febd 100644
--- a/include/acpi/platform/aclinux.h
+++ b/include/acpi/platform/aclinux.h
@@ -149,10 +149,10 @@ static inline void *acpi_os_acquire_object(acpi_cache_t * cache)
 #define ACPI_FREE(a)            kfree(a)
 
 /* Used within ACPICA to show where it is safe to preempt execution */
-
+#include <linux/hardirq.h>
 #define ACPI_PREEMPTION_POINT() \
 	do { \
-		if (!irqs_disabled()) \
+		if (!in_atomic_preempt_off()) \
 			cond_resched(); \
 	} while (0)
 

