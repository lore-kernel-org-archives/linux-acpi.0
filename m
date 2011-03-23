From: Len Brown <lenb@kernel.org>
Subject: [PATCH 21/42] ACPICA: Fix unresolved name issue for no-debug and
 no-error-msg cases
Date: Wed, 23 Mar 2011 02:42:34 -0400
Message-ID: <d59a3c6b35995615fa9e4f21d63fdf21328c5b6b.1300862481.git.len.brown@intel.com>
References: <1300862575-10206-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:33781 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752088Ab1CWIHc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Mar 2011 04:07:32 -0400
Received: from localhost.localdomain ([unknown] [74.104.148.74])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LII00IQB3WFAQB4@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 23 Mar 2011 03:07:31 -0500 (CDT)
In-reply-to: <1300862575-10206-1-git-send-email-lenb@kernel.org>
In-reply-to: <073b4964b3b75fd9e19bf3933b26d9c23591c9db.1300862481.git.len.brown@intel.com>
References: <073b4964b3b75fd9e19bf3933b26d9c23591c9db.1300862481.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

The _acpi_module_name was left undefined in these cases, but it
is actually needed as a parameter to some interfaces. Define
_acpi_module_name as a null string in these cases.  Acpica BZ 888.

http://www.acpica.org/bugzilla/show_bug.cgi?id=888

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 include/acpi/acoutput.h |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/acpi/acoutput.h b/include/acpi/acoutput.h
index ef1cef7..d7bd661 100644
--- a/include/acpi/acoutput.h
+++ b/include/acpi/acoutput.h
@@ -183,13 +183,19 @@
 
 #if defined (ACPI_DEBUG_OUTPUT) || !defined (ACPI_NO_ERROR_MESSAGES)
 /*
- * Module name is included in both debug and non-debug versions primarily for
- * error messages. The __FILE__ macro is not very useful for this, because it
- * often includes the entire pathname to the module
+ * The module name is used primarily for error and debug messages.
+ * The __FILE__ macro is not very useful for this, because it
+ * usually includes the entire pathname to the module making the
+ * debug output difficult to read.
  */
 #define ACPI_MODULE_NAME(name)          static const char ACPI_UNUSED_VAR _acpi_module_name[] = name;
 #else
+/*
+ * For the no-debug and no-error-msg cases, we must at least define
+ * a null module name.
+ */
 #define ACPI_MODULE_NAME(name)
+#define _acpi_module_name ""
 #endif
 
 /*
-- 
1.7.4.1.343.ga91df

