From: Len Brown <len.brown@intel.com>
Subject: [PATCH 72/77] ACPI: fix empty macros found by -Wextra
Date: Sun, 22 Jul 2007 05:14:57 -0400
Message-ID: <1185095777144-git-send-email-len.brown@intel.com>
References: <11850957022956-git-send-email-len.brown@intel.com>
 <11850957033938-git-send-email-len.brown@intel.com>
 <11850957043270-git-send-email-len.brown@intel.com>
 <11850957053842-git-send-email-len.brown@intel.com>
 <11850957062754-git-send-email-len.brown@intel.com>
 <11850957073494-git-send-email-len.brown@intel.com>
 <1185095708928-git-send-email-len.brown@intel.com>
 <11850957093360-git-send-email-len.brown@intel.com>
 <11850957102641-git-send-email-len.brown@intel.com>
 <11850957111797-git-send-email-len.brown@intel.com>
 <11850957123807-git-send-email-len.brown@intel.com>
 <11850957131802-git-send-email-len.brown@intel.com>
 <1185095714699-git-send-email-len.brown@intel.com>
 <1185095715506-git-send-email-len.brown@intel.com>
 <11850957162801-git-send-email-len.brown@intel.com>
 <11850957173842-git-send-email-len.brown@intel.com>
 <11850957181201-git-send-email-len.brown@intel.com>
 <11850957192175-git-send-email-len.brown@intel.com>
 <1185095721166-git-send-email-len.brown@intel.com>
 <1185095721760-git-send-email-len.brown@intel.com>
 <11850957232745-git-send-email-len.brown@intel.com>
 <11850957242656-git-send-email-len.brown@intel.com>
 <11850957252722-git-send-email-len.brown@intel.com>
 <11850957262869-git-send-email-len.brown@intel.com>
 <11850957272369-git-send-email-len.brown@intel.com>
 <11850957282082-git-send-email-len.brown@intel.com>
 <11850957292555-git-send-email-len.brown@intel.com>
 <11850957302782-git-send-email-len.brown@intel.com>
 <11850957311269-git-send-email-len.brown@intel.com>
 <11850957323059-git-send-email-len.brown@intel.com>
 <11850957332171-git-send-email-len.brown@intel.com>
 <11850957342584-git-send-email-len.brown@intel.com>
 <11850957362476-git-send-email-len.brown@intel.com>
 <11850957361736-git-send-email-len.brown@intel.com>
 <1185095737422-git-send-email-len.brown@intel.com>
 <11850957384004-git-send-email-len.brown@intel.com>
 <1185095739370-git-send-email-len.brown@intel.com>
 <11850957403722-git-send-email-len.brown@intel.com>
 <11850957413607-git-send-email-len.brown@intel.com>
 <11850957432095-git-send-email-len.brown@intel.com>
 <11850957443711-git-send-email-len.brown@intel.com>
 <11850957451942-git-send-email-len.brown@intel.com>
 <11850957462109-git-send-email-len.brown@intel.com>
 <11850957471828-git-send-email-len.brown@intel.com>
 <11850957482671-git-send-email-len.brown@intel.com>
 <11850957491254-git-send-email-len.brown@intel.com>
 <11850957503243-git-send-email-len.brown@intel.com>
 <1185095751279-git-send-email-len.brown@intel.com>
 <11850957522609-git-send-email-len.brown@intel.com>
 <11850957531914-git-send-email-len.brown@intel.com>
 <11850957541879-git-send-email-len.brown@intel.com>
 <11850957552824-git-send-email-len.brown@intel.com>
 <11850957561003-git-send-email-len.brown@intel.com>
 <11850957571080-git-send-email-len.brown@intel.com>
 <11850957591101-git-send-email-len.brown@intel.com>
 <11850957601664-git-send-email-len.brown@intel.com>
 <1185095761326-git-send-email-len.brown@intel.com>
 <11850957621605-git-send-email-len.brown@intel.com>
 <11850957633613-git-send-email-len.brown@intel.com>
 <11850957641697-git-send-email-len.brown@intel.com>
 <11850957651127-git-send-email-len.brown@intel.com>
 <1185095766274-git-send-email-len.brown@intel.com>
 <1185095767879-git-send-email-len.brown@intel.com>
 <1185095768376-git-send-email-len.brown@intel.com>
 <11850957691561-git-send-email-len.brown@intel.com>
 <11850957703097-git-send-email-len.brown@intel.com>
 <11850957712166-git-send-email-len.brown@intel.com>
 <11850957721285-git-send-email-len.brown@intel.com>
 <11850957721315-git-send-email-len.brown@intel.com>
 <11850957741937-git-send-email-len.brown@intel.com>
 <1185095775978-git-send-email-len.brown@intel.com>
 <1185095776538-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:6024 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764548AbXGVJQT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 22 Jul 2007 05:16:19 -0400
In-Reply-To: <1185095776538-git-send-email-len.brown@intel.com>
Message-Id: <4ebf83c8cf89ab13bc23e46b0fcb6178ca23b43c.1185095456.git.len.brown@intel.com>
In-Reply-To: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
References: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Dave Jones <davej@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>

From: Dave Jones <davej@redhat.com>

ACPI has a ton of macros which make a bunch of empty if's when configured
in non-debug mode.

[lenb: The code it complaines about is functionally correct,
 so this patch is just to make -Wextra happier]

#define DBG()

if(...)
        DBG();
next_c_statement

which turns into
if(...) ;
next_c_statement

Signed-off-by: Dave Jones <davej@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/glue.c     |    2 +-
 include/acpi/acmacros.h |   40 ++++++++++++++++++++--------------------
 2 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/acpi/glue.c b/drivers/acpi/glue.c
index 41427a4..4893e25 100644
--- a/drivers/acpi/glue.c
+++ b/drivers/acpi/glue.c
@@ -16,7 +16,7 @@
 #if ACPI_GLUE_DEBUG
 #define DBG(x...) printk(PREFIX x)
 #else
-#define DBG(x...)
+#define DBG(x...) do { } while(0)
 #endif
 static LIST_HEAD(bus_type_list);
 static DECLARE_RWSEM(bus_type_sem);
diff --git a/include/acpi/acmacros.h b/include/acpi/acmacros.h
index 8948a64..e64a748 100644
--- a/include/acpi/acmacros.h
+++ b/include/acpi/acmacros.h
@@ -599,26 +599,26 @@
 #define ACPI_DEBUG_EXEC(a)
 #define ACPI_NORMAL_EXEC(a)             a;
 
-#define ACPI_DEBUG_DEFINE(a)
-#define ACPI_DEBUG_ONLY_MEMBERS(a)
-#define ACPI_FUNCTION_NAME(a)
-#define ACPI_FUNCTION_TRACE(a)
-#define ACPI_FUNCTION_TRACE_PTR(a,b)
-#define ACPI_FUNCTION_TRACE_U32(a,b)
-#define ACPI_FUNCTION_TRACE_STR(a,b)
-#define ACPI_FUNCTION_EXIT
-#define ACPI_FUNCTION_STATUS_EXIT(s)
-#define ACPI_FUNCTION_VALUE_EXIT(s)
-#define ACPI_FUNCTION_ENTRY()
-#define ACPI_DUMP_STACK_ENTRY(a)
-#define ACPI_DUMP_OPERANDS(a,b,c,d,e)
-#define ACPI_DUMP_ENTRY(a,b)
-#define ACPI_DUMP_TABLES(a,b)
-#define ACPI_DUMP_PATHNAME(a,b,c,d)
-#define ACPI_DUMP_RESOURCE_LIST(a)
-#define ACPI_DUMP_BUFFER(a,b)
-#define ACPI_DEBUG_PRINT(pl)
-#define ACPI_DEBUG_PRINT_RAW(pl)
+#define ACPI_DEBUG_DEFINE(a)		do { } while(0)
+#define ACPI_DEBUG_ONLY_MEMBERS(a)	do { } while(0)
+#define ACPI_FUNCTION_NAME(a)		do { } while(0)
+#define ACPI_FUNCTION_TRACE(a)		do { } while(0)
+#define ACPI_FUNCTION_TRACE_PTR(a,b)	do { } while(0)
+#define ACPI_FUNCTION_TRACE_U32(a,b)	do { } while(0)
+#define ACPI_FUNCTION_TRACE_STR(a,b)	do { } while(0)
+#define ACPI_FUNCTION_EXIT		do { } while(0)
+#define ACPI_FUNCTION_STATUS_EXIT(s)	do { } while(0)
+#define ACPI_FUNCTION_VALUE_EXIT(s)	do { } while(0)
+#define ACPI_FUNCTION_ENTRY()		do { } while(0)
+#define ACPI_DUMP_STACK_ENTRY(a)	do { } while(0)
+#define ACPI_DUMP_OPERANDS(a,b,c,d,e)	do { } while(0)
+#define ACPI_DUMP_ENTRY(a,b)		do { } while(0)
+#define ACPI_DUMP_TABLES(a,b)		do { } while(0)
+#define ACPI_DUMP_PATHNAME(a,b,c,d)	do { } while(0)
+#define ACPI_DUMP_RESOURCE_LIST(a)	do { } while(0)
+#define ACPI_DUMP_BUFFER(a,b)		do { } while(0)
+#define ACPI_DEBUG_PRINT(pl)		do { } while(0)
+#define ACPI_DEBUG_PRINT_RAW(pl)	do { } while(0)
 
 #define return_VOID                     return
 #define return_ACPI_STATUS(s)           return(s)
-- 
1.5.3.rc2.22.g69a9b
