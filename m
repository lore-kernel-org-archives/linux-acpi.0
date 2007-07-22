From: Len Brown <len.brown@intel.com>
Subject: [PATCH 76/77] ACPI: create CONFIG_ACPI_DEBUG_FUNC_TRACE
Date: Sun, 22 Jul 2007 05:15:01 -0400
Message-ID: <11850957811573-git-send-email-len.brown@intel.com>
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
 <1185095777144-git-send-email-len.brown@intel.com>
 <11850957781461-git-send-email-len.brown@intel.com>
 <11850957791127-git-send-email-len.brown@intel.com>
 <11850957801755-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:31622 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764630AbXGVJQW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 22 Jul 2007 05:16:22 -0400
In-Reply-To: <11850957801755-git-send-email-len.brown@intel.com>
Message-Id: <798d91039849486c7a4f1a458a5680cb55a65408.1185095456.git.len.brown@intel.com>
In-Reply-To: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
References: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Thomas Renninger <trenn@suse.de>, Len Brown <len.brown@intel.com>

From: Thomas Renninger <trenn@suse.de>

Split ACPI_DEBUG into function trace enabled and not enabled.

Function trace is most of the ACPI_DEBUG costs, but is
not much of use for kernel ACPI debugging.

Size of kernel image increased on test compile:
+ 48k  (Full ACPI_DEBUG)
+ 35k  (ACPI_DEBUG with function trace compiled out)

Performance without function trace is also much better.

Also remove ACPI_LV_DEBUG_OBJECT from default debug level as
a lot vendors let Store (value, debug) in their code and this
might confuse users when it pops up in syslog.

Signed-off-by: Thomas Renninger <trenn@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/Kconfig    |    8 ++++++++
 include/acpi/acmacros.h |   23 +++++++++++++++++++++++
 include/acpi/acoutput.h |    4 ++--
 3 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 139f41f..1121a1f 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -280,6 +280,14 @@ config ACPI_DEBUG
 	  of verbosity. Saying Y enables these statements. This will increase
 	  your kernel size by around 50K.
 
+config ACPI_DEBUG_FUNC_TRACE
+	bool "Additionally enable ACPI function tracing"
+	default n
+	depends on ACPI_DEBUG
+	help
+	  ACPI Debug Statements slow down ACPI processing. Function trace
+	  is about half of the penalty and is rarely useful.
+
 config ACPI_EC
 	bool
 	default y
diff --git a/include/acpi/acmacros.h b/include/acpi/acmacros.h
index 8948a64..c22f6da 100644
--- a/include/acpi/acmacros.h
+++ b/include/acpi/acmacros.h
@@ -486,6 +486,8 @@
 #define ACPI_FUNCTION_NAME(name)
 #endif
 
+#ifdef DEBUG_FUNC_TRACE
+
 #define ACPI_FUNCTION_TRACE(a)          ACPI_FUNCTION_NAME(a) \
 			  acpi_ut_trace(ACPI_DEBUG_PARAMETERS)
 #define ACPI_FUNCTION_TRACE_PTR(a,b)    ACPI_FUNCTION_NAME(a) \
@@ -563,6 +565,27 @@
 
 #endif				/* ACPI_SIMPLE_RETURN_MACROS */
 
+#else /* !DEBUG_FUNC_TRACE */
+
+#define ACPI_FUNCTION_TRACE(a)
+#define ACPI_FUNCTION_TRACE_PTR(a,b)
+#define ACPI_FUNCTION_TRACE_U32(a,b)
+#define ACPI_FUNCTION_TRACE_STR(a,b)
+#define ACPI_FUNCTION_EXIT
+#define ACPI_FUNCTION_STATUS_EXIT(s)
+#define ACPI_FUNCTION_VALUE_EXIT(s)
+#define ACPI_FUNCTION_TRACE(a)
+#define ACPI_FUNCTION_ENTRY()
+
+#define return_VOID                     return
+#define return_ACPI_STATUS(s)           return(s)
+#define return_VALUE(s)                 return(s)
+#define return_UINT8(s)                 return(s)
+#define return_UINT32(s)                return(s)
+#define return_PTR(s)                   return(s)
+
+#endif /* DEBUG_FUNC_TRACE */
+
 /* Conditional execution */
 
 #define ACPI_DEBUG_EXEC(a)              a
diff --git a/include/acpi/acoutput.h b/include/acpi/acoutput.h
index 7812267..c090a8b 100644
--- a/include/acpi/acoutput.h
+++ b/include/acpi/acoutput.h
@@ -178,8 +178,8 @@
 
 /* Defaults for debug_level, debug and normal */
 
-#define ACPI_DEBUG_DEFAULT          (ACPI_LV_INIT | ACPI_LV_WARN | ACPI_LV_ERROR | ACPI_LV_DEBUG_OBJECT)
-#define ACPI_NORMAL_DEFAULT         (ACPI_LV_INIT | ACPI_LV_WARN | ACPI_LV_ERROR | ACPI_LV_DEBUG_OBJECT)
+#define ACPI_DEBUG_DEFAULT          (ACPI_LV_INIT | ACPI_LV_WARN | ACPI_LV_ERROR)
+#define ACPI_NORMAL_DEFAULT         (ACPI_LV_INIT | ACPI_LV_WARN | ACPI_LV_ERROR)
 #define ACPI_DEBUG_ALL              (ACPI_LV_AML_DISASSEMBLE | ACPI_LV_ALL_EXCEPTIONS | ACPI_LV_ALL)
 
 #endif				/* __ACOUTPUT_H__ */
-- 
1.5.3.rc2.22.g69a9b
