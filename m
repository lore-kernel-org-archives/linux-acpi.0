From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v3 1/4] ACPICA: Linux headers: Remove ACPI_PREEMPTION_POINT() due to no usages.
Date: Mon, 12 May 2014 15:45:54 +0800
Message-ID: <5fb6fe40cb0a91e454072d567695666dccac3e16.1399880022.git.lv.zheng@intel.com>
References: <cover.1396930406.git.lv.zheng@intel.com> <cover.1399880022.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1399880022.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

This patch deletes deprecated ACPI_PREEMPTION_POINT(), there is no user for
it in Linux kernel now. Lv Zheng.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/platform/aclinux.h |   14 --------------
 1 file changed, 14 deletions(-)

diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform/aclinux.h
index 4c2f9e7..3b8b52f 100644
--- a/include/acpi/platform/aclinux.h
+++ b/include/acpi/platform/aclinux.h
@@ -228,20 +228,6 @@ static inline acpi_thread_id acpi_os_get_thread_id(void)
 
 #define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_get_thread_id
 
-#ifndef CONFIG_PREEMPT
-
-/*
- * Used within ACPICA to show where it is safe to preempt execution
- * when CONFIG_PREEMPT=n
- */
-#define ACPI_PREEMPTION_POINT() \
-	do { \
-		if (!irqs_disabled()) \
-			cond_resched(); \
-	} while (0)
-
-#endif
-
 /*
  * When lockdep is enabled, the spin_lock_init() macro stringifies it's
  * argument and uses that as a name for the lock in debugging.
-- 
1.7.10
