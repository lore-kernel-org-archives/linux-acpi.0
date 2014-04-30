From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 16/27] ACPICA: Linux header: Add support for stubbed externals.
Date: Wed, 30 Apr 2014 10:05:15 +0800
Message-ID: <278051c8af378dded8b30afe15516be313de44ed.1398817612.git.lv.zheng@intel.com>
References: <cover.1398817612.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1398817612.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

Linux wants to include all header files but leave empty inline
stub variables for a feature that is not configured during build.

This patch configures ACPICA external globals/macros/functions out and
defines them into no-op when CONFIG_ACPI is not enabled.  Lv Zheng.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 include/acpi/platform/aclinux.h |   31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform/aclinux.h
index f242909..4c2f9e7 100644
--- a/include/acpi/platform/aclinux.h
+++ b/include/acpi/platform/aclinux.h
@@ -73,6 +73,37 @@
 #endif
 #include <asm/acpi.h>
 
+#ifndef CONFIG_ACPI
+
+/* External globals for __KERNEL__, stubs is needed */
+
+#define ACPI_GLOBAL(t,a)
+#define ACPI_INIT_GLOBAL(t,a,b)
+
+/* Generating stubs for configurable ACPICA macros */
+
+#define ACPI_NO_MEM_ALLOCATIONS
+
+/* Generating stubs for configurable ACPICA functions */
+
+#define ACPI_NO_ERROR_MESSAGES
+#undef ACPI_DEBUG_OUTPUT
+
+/* External interface for __KERNEL__, stub is needed */
+
+#define ACPI_EXTERNAL_RETURN_STATUS(prototype) \
+	static ACPI_INLINE prototype {return(AE_NOT_CONFIGURED);}
+#define ACPI_EXTERNAL_RETURN_OK(prototype) \
+	static ACPI_INLINE prototype {return(AE_OK);}
+#define ACPI_EXTERNAL_RETURN_VOID(prototype) \
+	static ACPI_INLINE prototype {return;}
+#define ACPI_EXTERNAL_RETURN_UINT32(prototype) \
+	static ACPI_INLINE prototype {return(0);}
+#define ACPI_EXTERNAL_RETURN_PTR(prototype) \
+	static ACPI_INLINE prototype {return(NULL);}
+
+#endif				/* CONFIG_ACPI */
+
 /* Host-dependent types and defines for in-kernel ACPICA */
 
 #define ACPI_MACHINE_WIDTH          BITS_PER_LONG
-- 
1.7.10
