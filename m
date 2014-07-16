From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v3 3/7] ACPICA: Linux: Add support to exclude <asm/acenv.h> inclusion.
Date: Wed, 16 Jul 2014 16:58:08 +0800
Message-ID: <c36d318533eebf48ae114dc74a2478f6b9d9ccd1.1405500886.git.lv.zheng@intel.com>
References: <cover.1387336613.git.lv.zheng@intel.com> <cover.1405500886.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:40174 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761194AbaGPI6f (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 Jul 2014 04:58:35 -0400
In-Reply-To: <cover.1405500886.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

The forthcoming patch will make <acpi/acpi.h> to be visible to all kernel
source code. Thus for the architectures that do not support ACPI and
haven't implemented <asm/acenv.h>, we need to make it excluded.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 arch/ia64/include/asm/acenv.h   |    4 ----
 arch/x86/include/asm/acenv.h    |    4 ----
 include/acpi/platform/aclinux.h |    2 ++
 3 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/ia64/include/asm/acenv.h b/arch/ia64/include/asm/acenv.h
index 3f9eaee..35ff13a 100644
--- a/arch/ia64/include/asm/acenv.h
+++ b/arch/ia64/include/asm/acenv.h
@@ -19,8 +19,6 @@
 
 /* Asm macros */
 
-#ifdef CONFIG_ACPI
-
 static inline int
 ia64_acpi_acquire_global_lock(unsigned int *lock)
 {
@@ -51,6 +49,4 @@ ia64_acpi_release_global_lock(unsigned int *lock)
 #define ACPI_RELEASE_GLOBAL_LOCK(facs, Acq)				\
 	((Acq) = ia64_acpi_release_global_lock(&facs->global_lock))
 
-#endif
-
 #endif /* _ASM_IA64_ACENV_H */
diff --git a/arch/x86/include/asm/acenv.h b/arch/x86/include/asm/acenv.h
index 6687329..1b010a8 100644
--- a/arch/x86/include/asm/acenv.h
+++ b/arch/x86/include/asm/acenv.h
@@ -18,8 +18,6 @@
 
 #define ACPI_FLUSH_CPU_CACHE()	wbinvd()
 
-#ifdef CONFIG_ACPI
-
 int __acpi_acquire_global_lock(unsigned int *lock);
 int __acpi_release_global_lock(unsigned int *lock);
 
@@ -44,6 +42,4 @@ int __acpi_release_global_lock(unsigned int *lock);
 	    : "=r"(n_hi), "=r"(n_lo)	\
 	    : "0"(n_hi), "1"(n_lo))
 
-#endif
-
 #endif /* _ASM_X86_ACENV_H */
diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform/aclinux.h
index cd1f052..dfba354 100644
--- a/include/acpi/platform/aclinux.h
+++ b/include/acpi/platform/aclinux.h
@@ -70,7 +70,9 @@
 #ifdef EXPORT_ACPI_INTERFACES
 #include <linux/export.h>
 #endif
+#ifdef CONFIG_ACPI
 #include <asm/acenv.h>
+#endif
 
 #ifndef CONFIG_ACPI
 
-- 
1.7.10

