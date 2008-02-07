From: Len Brown <lenb@kernel.org>
Subject: [PATCH 103/112] ACPICA: fix CONFIG_ACPI_DEBUG_FUNC_TRACE build
Date: Thu,  7 Feb 2008 04:35:05 -0500
Message-ID: <4e83dd95b343a4ecfdb236aa046a5366a29e6f1e.1202376824.git.len.brown@intel.com>
References: <1202376914-21030-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:48010 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758525AbYBGJg5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Feb 2008 04:36:57 -0500
In-Reply-To: <1202376914-21030-1-git-send-email-lenb@kernel.org>
In-Reply-To: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
References: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

798d91039849486c7a4f1a458a5680cb55a65408
(ACPI: create CONFIG_ACPI_DEBUG_FUNC_TRACE)

failed to associate the new tracing config option with the tracing code.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 include/acpi/acmacros.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/acpi/acmacros.h b/include/acpi/acmacros.h
index 45662f6..99d171c 100644
--- a/include/acpi/acmacros.h
+++ b/include/acpi/acmacros.h
@@ -486,7 +486,7 @@
 #define ACPI_FUNCTION_NAME(name)
 #endif
 
-#ifdef DEBUG_FUNC_TRACE
+#ifdef CONFIG_ACPI_DEBUG_FUNC_TRACE
 
 #define ACPI_FUNCTION_TRACE(a)          ACPI_FUNCTION_NAME(a) \
 			  acpi_ut_trace(ACPI_DEBUG_PARAMETERS)
@@ -565,7 +565,7 @@
 
 #endif				/* ACPI_SIMPLE_RETURN_MACROS */
 
-#else /* !DEBUG_FUNC_TRACE */
+#else /* !CONFIG_ACPI_DEBUG_FUNC_TRACE */
 
 #define ACPI_FUNCTION_TRACE(a)
 #define ACPI_FUNCTION_TRACE_PTR(a,b)
@@ -584,7 +584,7 @@
 #define return_UINT32(s)                return(s)
 #define return_PTR(s)                   return(s)
 
-#endif /* DEBUG_FUNC_TRACE */
+#endif /* CONFIG_ACPI_DEBUG_FUNC_TRACE */
 
 /* Conditional execution */
 
-- 
1.5.4.23.gef5b9

