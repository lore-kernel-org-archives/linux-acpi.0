From: Len Brown <lenb@kernel.org>
Subject: [PATCH 108/140] ACPICA: Ensure that all structures in acobject.h are aligned, via #pragma.
Date: Wed,  7 Feb 2007 13:52:02 -0500
Message-ID: <11708745244071-git-send-email-lenb@kernel.org>
References: <11708743541314-git-send-email-lenb@kernel.org> <11708743561383-git-send-email-lenb@kernel.org> <117087435785-git-send-email-lenb@kernel.org> <11708743582090-git-send-email-lenb@kernel.org> <11708743611662-git-send-email-lenb@kernel.org> <11708743653073-git-send-email-lenb@kernel.org> <11708743674006-git-send-email-lenb@kernel.org> <11708743693386-git-send-email-lenb@kernel.org> <11708743702194-git-send-email-lenb@kernel.org> <11708743723353-git-send-email-lenb@kernel.org> <11708743783727-git-send-email-lenb@kernel.org> <11708743802558-git-send-email-lenb@kernel.org> <11708743821259-git-send-email-lenb@kernel.org> <11708743853573-git-send-email-lenb@kernel.org> <11708743871468-git-send-email-lenb@kernel.org> <1170874390715-git-send-email-lenb@kernel.org> <1170874393736-git-send-email-lenb@kernel.org> <11708743943108-git-send-email-lenb@kernel.org> <11708743962377-git-send-ema
 il-lenb@kernel.org> <11708743972593-git-send-email-lenb@kernel.org> <1170874398386-git-send-email-lenb@kernel.org> <11708743993414-git-send-email-lenb@kernel.org> <11708744003959-git-send-email-lenb@kernel.org> <11708744023872-git-send-email-lenb@kernel.org> <11708744032427-git-send-email-lenb@kernel.org> <11708744053556-git-send-email-lenb@kernel.org> <11708744062538-git-send-email-lenb@kernel.org> <11708744071019-git-send-email-lenb@kernel.org> <11708744093818-git-send-email-lenb@kernel.org> <11708744101300-git-send-email-lenb@kernel.org> <1170874412494-git-send-email-lenb@kernel.org> <11708744142658-git-send-email-lenb@kernel.org> <1170874415464-git-send-email-lenb@kernel.org> <1170874417392-git-send-email-lenb@kernel.org> <1170874418134-git-send-email-lenb@kernel.org> <11708744191642-git-send-email-lenb@kernel.org> <11708744203492-git-send-email-lenb@kernel.org> <1170874421658-git-
 send-email-lenb@kernel.org> <1170874422581-git-send-email-lenb@kernel.org> <117087442385-git-send-email-lenb@kernel.org> <1170874424332-git-send-email-lenb@kernel.org> <11708744253790-git-send-email-lenb@kernel.org> <11708744263395-git-send-email-lenb@kernel.org> <11708744273028-git-send-email-lenb@kernel.org> <11708744272354-git-send-email-lenb@kernel.org> <11708744311281-git-send-email-lenb@kernel.org> <11708744322360-git-send-email-lenb@kernel.org> <1170874433382-git-send-email-lenb@kernel.org> <11708744353864-git-send-email-lenb@kernel.org> <11708744352790-git-send-email-lenb@kernel.org> <1170874437973-git-send-email-lenb@kernel.org> <11708744382626-git-send-email-lenb@kernel.org> <11708744402139-git-send-email-lenb@kernel.org> <11708744413743-git-send-email-lenb@kernel.org> <117087444256-git-send-email-lenb@kernel.org> <11708744461131-git-send-email-lenb@kernel.org> <1170874451354
 1-git-send-email-lenb@kernel.org> <11708744522444-git-send-email-lenb@kernel.org> <1170874453363-git-send-email-lenb@kernel.org> <11708744542419-git-send-email-lenb@kernel.org> <11708744562243-git-send-email-lenb@kernel.org> <1170874458256-git-send-email-lenb@kernel.org> <11708744603317-git-send-email-lenb@kernel.org> <11708744612314-git-send-email-lenb@kernel.org> <117087446376-git-send-email-lenb@kernel.org> <11708744642267-git-send-email-lenb@kernel.org> <11708744674050-git-send-email-lenb@kernel.org> <11708744692041-git-send-email-lenb@kernel.org> <11708744712690-git-send-email-lenb@kernel.org> <11708744732351-git-send-email-lenb@kernel.org> <11708744752537-git-send-email-lenb@kernel.org> <11708744772462-git-send-email-lenb@kernel.org> <11708744803527-git-send-email-lenb@kernel.org> <11708744813011-git-send-email-lenb@kernel.org> <11708744852095-git-send-email-lenb@kernel.org> <117
 08744874154-git-send-email-lenb@kernel.org> <11708744878-git-send-email-lenb@kernel.org> <1170874488430-git-send-email-lenb@kernel.org> <11708744903381-git-send-email-lenb@kernel.org> <11708744911989-git-send-email-lenb@kernel.org> <11708744922677-git-send-email-lenb@kernel.org> <11708744934033-git-send-email-lenb@kernel.org> <1170874494939-git-send-email-lenb@kernel.org> <11708744951308-git-send-emailMessage-Id: <7c9626bade13de3f160f0926455328650045d6cd.1170873818.git.len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:7723 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422851AbXBGSz3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Feb 2007 13:55:29 -0500
In-Reply-To: <1170874522525-git-send-email-lenb@kernel.org>
In-Reply-To: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
References: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

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
1.5.0.rc3.39.gec804
