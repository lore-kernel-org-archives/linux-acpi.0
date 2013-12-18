From: Lv Zheng <lv.zheng@intel.com>
Subject: [RFC PATCH 04/15] ACPICA: OSL: Cleanup external macros and add stubs for macros.
Date: Wed, 18 Dec 2013 17:06:14 +0800
Message-ID: <b8e6ffb89762bd9e97fb2b4755ae37497756ee47.1387336613.git.lv.zheng@intel.com>
References: <cover.1387336613.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1387336613.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

OSPMs like Linux trend to include all header files but leave empty stub
macros for a feature that is not configured during build.

For macros defined to constants or defined to functions without other
functions referencesd (exceptions are ACPI_ALLOCATE_BUFFER and
ACPI_OFFSET-like macros), it is safe to leave them without protections.

By investigation, there are only the following internal/external
functions referenced by the ACPICA macros:
1. C library functions, including string, ctype, stdarg APIs.  Such
   functionalities are always accessbile in the kernel source tree, so
   it is safe to leave them without protected for Linux.
2. ACPICA OSL functions, such functions are designed to be used only by
   ACPICA internal APIs.  But in the Linux kernel, there are references
   in the macros referencing mutex and memory allocation APIs.
   Fortunately, there is no external users directly invoking ACPI_MUTEX
   OSL functions.  But for ACPI_ALLOCATE and ACPI_ALLOCATE_BUFFER, there
   are AcpiOsFree or kfree called as their reversals.  This patch adds
   mechanism to protect ACPICA memory allocation APIs for Linux so that
   Linux can have full control of such macros to configure them into
   no-ops.
3. ACPI_OFFSET and other macros that would access structure members that
   are not accessible under a specific configuration.  Fortunately,
   currently Linux doesn't use such structure members when CONFIG_ACPI
   is disabled.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/actypes.h          |   21 +++++++++++++++++++++
 include/acpi/platform/aclinux.h |   12 ++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 809b1a0..8332d95 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -329,6 +329,15 @@ typedef u32 acpi_physical_address;
  *
  ******************************************************************************/
 
+#ifdef ACPI_NO_MEM_ALLOCATIONS
+
+#define ACPI_ALLOCATE(a)                NULL
+#define ACPI_ALLOCATE_ZEROED(a)         NULL
+#define ACPI_FREE(a)
+#define ACPI_MEM_TRACKING(a)
+
+#else				/* ACPI_NO_MEM_ALLOCATIONS */
+
 #ifdef ACPI_DBG_TRACK_ALLOCATIONS
 /*
  * Memory allocation tracking (used by acpi_exec to detect memory leaks)
@@ -350,6 +359,8 @@ typedef u32 acpi_physical_address;
 
 #endif				/* ACPI_DBG_TRACK_ALLOCATIONS */
 
+#endif				/* ACPI_NO_MEM_ALLOCATIONS */
+
 /******************************************************************************
  *
  * ACPI Specification constants (Do not change unless the specification changes)
@@ -928,9 +939,19 @@ struct acpi_object_list {
  * Miscellaneous common Data Structures used by the interfaces
  */
 #define ACPI_NO_BUFFER              0
+
+#ifdef ACPI_NO_MEM_ALLOCATIONS
+
+#define ACPI_ALLOCATE_BUFFER        (acpi_size) (0)
+#define ACPI_ALLOCATE_LOCAL_BUFFER  (acpi_size) (0)
+
+#else				/* ACPI_NO_MEM_ALLOCATIONS */
+
 #define ACPI_ALLOCATE_BUFFER        (acpi_size) (-1)
 #define ACPI_ALLOCATE_LOCAL_BUFFER  (acpi_size) (-2)
 
+#endif				/* ACPI_NO_MEM_ALLOCATIONS */
+
 struct acpi_buffer {
 	acpi_size length;	/* Length in bytes of the buffer */
 	void *pointer;		/* pointer to buffer */
diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform/aclinux.h
index 5e5de9c..fce521d 100644
--- a/include/acpi/platform/aclinux.h
+++ b/include/acpi/platform/aclinux.h
@@ -52,6 +52,18 @@
 
 #ifdef __KERNEL__
 
+/* Never using tracking mechanism for Linux kernel */
+
+#undef ACPI_DBG_TRACK_ALLOCATIONS
+
+#ifndef CONFIG_ACPI
+
+/* Generating stubs for configurable ACPICA macros */
+
+#define ACPI_NO_MEM_ALLOCATIONS
+
+#endif
+
 #include <linux/string.h>
 #include <linux/kernel.h>
 #include <linux/ctype.h>
-- 
1.7.10.4
