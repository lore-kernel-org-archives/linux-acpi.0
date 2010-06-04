From: Len Brown <lenb@kernel.org>
Subject: [PATCH 04/16] ACPICA: iASL/Core: Add support for _WDG/_WED MS methods
Date: Fri, 04 Jun 2010 15:51:34 -0400
Message-ID: <dc9fdf22dc5d17961156ae657aa7eaecadbb2a58.1275680880.git.len.brown@intel.com>
References: <1275681106-8450-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:56531 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754289Ab0FDTvv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Jun 2010 15:51:51 -0400
Received: from localhost.localdomain ([unknown] [98.118.125.200])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L3I00AA99UC9VS5@vms173011.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 04 Jun 2010 14:51:51 -0500 (CDT)
In-reply-to: <1275681106-8450-1-git-send-email-lenb@kernel.org>
In-reply-to: <8aa4b14eb023fecaa48d55402e98bdf84b375c4a.1275680880.git.len.brown@intel.com>
References: <8aa4b14eb023fecaa48d55402e98bdf84b375c4a.1275680880.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

These objects are defined by "Windows Instrumentation", and are
not part of the ACPI spec. Adds compiler support and runtime
typechecking support in the ACPICA core. ACPICA BZ 860.

http://www.acpica.org/bugzilla/show_bug.cgi?id=860

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/acpredef.h |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/acpica/acpredef.h b/drivers/acpi/acpica/acpredef.h
index 9711608..10998d3 100644
--- a/drivers/acpi/acpica/acpredef.h
+++ b/drivers/acpi/acpica/acpredef.h
@@ -503,15 +503,16 @@ static const union acpi_predefined_info predefined_names[] =
 	{{"_WAK", 1, ACPI_RTYPE_NONE | ACPI_RTYPE_INTEGER | ACPI_RTYPE_PACKAGE}},
 			  {{{ACPI_PTYPE1_FIXED, ACPI_RTYPE_INTEGER, 2,0}, 0,0}}, /* Fixed-length (2 Int), but is optional */
 
-	{{{0,0,0,0}, 0,0}} /* Table terminator */
-};
+	/* _WDG/_WED are MS extensions defined by "Windows Instrumentation" */
 
-#if 0
-	/* Not implemented */
+	{{"_WDG", 0, ACPI_RTYPE_BUFFER}},
+	{{"_WED", 1,
+	  ACPI_RTYPE_INTEGER | ACPI_RTYPE_STRING | ACPI_RTYPE_BUFFER}},
 
-	{{"_WDG", 0, ACPI_RTYPE_BUFFER}},  /* MS Extension */
-	{{"_WED", 1, ACPI_RTYPE_PACKAGE}}, /* MS Extension */
+	{{{0, 0, 0, 0}, 0, 0}}  /* Table terminator */
+};
 
+#if 0
 	/* This is an internally implemented control method, no need to check */
 	{{"_OSI", 1, ACPI_RTYPE_INTEGER}},
 
-- 
1.6.0.6

