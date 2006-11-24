From: Len Brown <len.brown@intel.com>
Subject: [PATCH 61/65] ACPICA: Ensure that all structures in acobject.h are aligned, via #pragma.
Date: Fri, 24 Nov 2006 02:19:11 -0500
Message-ID: <11643528211744-git-send-email-len.brown@intel.com>
References: <1164352755500-git-send-email-len.brown@intel.com> <11643527561399-git-send-email-len.brown@intel.com> <11643527572123-git-send-email-len.brown@intel.com> <11643527582206-git-send-email-len.brown@intel.com> <11643527591227-git-send-email-len.brown@intel.com> <11643527604195-git-send-email-len.brown@intel.com> <1164352761941-git-send-email-len.brown@intel.com> <1164352762703-git-send-email-len.brown@intel.com> <11643527631929-git-send-email-len.brown@intel.com> <11643527633954-git-send-email-len.brown@intel.com> <11643527641142-git-send-email-len.brown@intel.com> <11643527654192-git-send-email-len.brown@intel.com> <11643527703526-git-send-email-len.brown@intel.com> <11643527731111-git-send-email-len.brown@intel.com> <11643527743390-git-send-email-len.brown@intel.com> <11643527752251-git-send-email-len.brown@intel.com> <1164352776767-git-send-email-len.brown@intel.com> <1164352
 7782767-git-send-email-len.brown@intel.com> <11643527804057-git-send-email-len.brown@intel.com> <11643527812144-git-send-email-len.brown@intel.com> <11643527821346-git-send-email-len.brown@intel.com> <11643527832869-git-send-email-len.brown@intel.com> <11643527843465-git-send-email-len.brown@intel.com> <11643527853403-git-send-email-len.brown@intel.com> <1164352786236-git-send-email-len.brown@intel.com> <11643527871558-git-send-email-len.brown@intel.com> <1164352787694-git-send-email-len.brown@intel.com> <1164352788512-git-send-email-len.brown@intel.com> <11643527891947-git-send-email-len.brown@intel.com> <1164352791852-git-send-email-len.brown@intel.com> <1164352792447-git-send-email-len.brown@intel.com> <11643527931850-git-send-email-len.brown@intel.com> <11643527943385-git-send-email-len.brown@intel.com> <11643527951196-git-send-email-len.brown@intel.com> <1164352796746-git-send-ema
 il-len.brown@intel.com> <11643527973892-git-send-email-len.brown@intel.com> <11643527982269-git-send-email-len.brown@intel.com> <11643527993578-git-send-email-len.brown@intel.com> <11643527992802-git-send-email-len.brown@intel.com> <11643528001078-git-send-email-len.brown@intel.com> <11643528013509-git-send-email-len.brown@intel.com> <11643528022585-git-send-email-len.brown@intel.com> <11643528032291-git-send-email-len.brown@intel.com> <11643528042439-git-send-email-len.brown@intel.com> <11643528053298-git-send-email-len.brown@intel.com> <11643528062723-git-send-email-len.brown@intel.com> <1164352807227-git-send-email-len.brown@intel.com> <11643528083991-git-send-email-len.brown@intel.com> <1164352808199-git-send-email-len.brown@intel.com> <11643528091601-git-send-email-len.brown@intel.com> <11643528111088-git-send-email-len.brown@intel.com> <11643528124177-git-send-email-len.brown@int
 el.com> <11643528134106-git-send-email-len.brown@intel.com> <11643528141248-git-send-email-len.brown@intel.com> <11643528153363-git-send-email-len.brown@intel.com> <11643528161204-git-send-email-len.brown@intel.com> <11643528173586-git-send-email-len.brown@intel.com> <11643528181135-git-send-email-len.brown@intel.com> <11643528181927-git-send-email-len.brown@intel.com> <1164352819583-git-send-email-len.brown@intel.com> <11643528201749-git-send-email-len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:58137 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S934509AbWKXHQX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Nov 2006 02:16:23 -0500
In-Reply-To: <11643528201749-git-send-email-len.brown@intel.com>
Message-Id: <7898d448d7775b5433f156acc113f00d9c740720.1164352294.git.len.brown@intel.com>
In-Reply-To: <410c2f0190f74c35505beda6ff3f2da7819f8bac.1164352285.git.len.brown@intel.com>
References: <410c2f0190f74c35505beda6ff3f2da7819f8bac.1164352285.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Robert Moore <robert.moore@intel.com>, Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Len Brown <len.brown@intel.com>

From: Robert Moore <robert.moore@intel.com>

Thus, even if the default compiler setting is non-aligned, the header is compiled
 correctly.

Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 include/acpi/acobject.h |   17 +++++++++++++++--
 include/acpi/actypes.h  |    4 ++++
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/include/acpi/acobject.h b/include/acpi/acobject.h
index 8fdee31..b81e923 100644
--- a/include/acpi/acobject.h
+++ b/include/acpi/acobject.h
@@ -52,7 +52,15 @@
  * to the interpreter, and to keep track of the various handlers such as
  * address space handlers and notify handlers. The object is a constant
  * size in order to allow it to be cached and reused.
+ *
+ * Note: The object is optimized to be aligned and will not work if it is
+ * byte-packed.
  */
+#if ACPI_MACHINE_WIDTH == 64
+#pragma pack(8)
+#else
+#pragma pack(4)
+#endif
 
 /*******************************************************************************
  *
@@ -101,7 +109,8 @@ struct acpi_object_common {
 ACPI_OBJECT_COMMON_HEADER};
 
 struct acpi_object_integer {
-	ACPI_OBJECT_COMMON_HEADER acpi_integer value;
+	ACPI_OBJECT_COMMON_HEADER u8 fill[3];	/* Prevent warning on some compilers */
+	acpi_integer value;
 };
 
 /*
@@ -203,7 +212,9 @@ struct acpi_object_power_resource {
 };
 
 struct acpi_object_processor {
-	ACPI_OBJECT_COMMON_HEADER u8 proc_id;
+	ACPI_OBJECT_COMMON_HEADER
+	    /* The next two fields take advantage of the 3-byte space before NOTIFY_INFO */
+	u8 proc_id;
 	u8 length;
 	 ACPI_COMMON_NOTIFY_INFO acpi_io_address address;
 };
@@ -406,4 +417,6 @@ union acpi_descriptor {
 	union acpi_parse_object op;
 };
 
+#pragma pack()
+
 #endif				/* _ACOBJECT_H */
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 6fa3f2a..d213f97 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -156,6 +156,7 @@ typedef u64 acpi_physical_address;
 #define ACPI_MAX_PTR                    ACPI_UINT64_MAX
 #define ACPI_SIZE_MAX                   ACPI_UINT64_MAX
 
+#define ACPI_NATIVE_BOUNDARY            8
 #define ACPI_USE_NATIVE_DIVIDE	/* Has native 64-bit integer support */
 
 /*
@@ -196,6 +197,8 @@ typedef u32 acpi_physical_address;
 #define ACPI_MAX_PTR                    ACPI_UINT32_MAX
 #define ACPI_SIZE_MAX                   ACPI_UINT32_MAX
 
+#define ACPI_NATIVE_BOUNDARY            4
+
 /*******************************************************************************
  *
  * Types specific to 16-bit targets
@@ -222,6 +225,7 @@ typedef char *acpi_physical_address;
 #define ACPI_MAX_PTR                    ACPI_UINT16_MAX
 #define ACPI_SIZE_MAX                   ACPI_UINT16_MAX
 
+#define ACPI_NATIVE_BOUNDARY            2
 #define ACPI_USE_NATIVE_DIVIDE	/* No 64-bit integers, ok to use native divide */
 
 /* 64-bit integers cannot be supported */
-- 
1.4.4.1
