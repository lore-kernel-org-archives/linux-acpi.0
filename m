From: Len Brown <lenb@kernel.org>
Subject: [PATCH 09/11] ACPICA: Allow _WAK method to return an Integer
Date: Thu, 27 Nov 2008 02:25:14 -0500
Message-ID: <95a28ed08619cc70f31611886ac7b26ab0e462dc.1227770639.git.len.brown@intel.com>
References: <1227770716-26525-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:51975 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751836AbYK0HZ0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 27 Nov 2008 02:25:26 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173007.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KAZ00F7CDWLHSQC@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 27 Nov 2008 01:24:22 -0600 (CST)
In-reply-to: <1227770716-26525-1-git-send-email-lenb@kernel.org>
In-reply-to: <7b4d469228a92a00e412675817cedd60133de38a.1227770639.git.len.brown@intel.com>
References: <7b4d469228a92a00e412675817cedd60133de38a.1227770639.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

This can happen if the _WAK method returns nothing (as per ACPI
1.0) but does return an integer if the implicit return mechanism
is enabled.  This is the only method that has this problem,
since it is also defined to return a package of two integers
(ACPI 1.0b+). In all other cases, if a method returns an object
when one was not expected, no warning is issued.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 include/acpi/acpredef.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/acpi/acpredef.h b/include/acpi/acpredef.h
index 619fb75..e6452db 100644
--- a/include/acpi/acpredef.h
+++ b/include/acpi/acpredef.h
@@ -346,7 +346,7 @@ static const union acpi_predefined_info predefined_names[] = {
 
 	/* Acpi 1.0 defined _WAK with no return value. Later, it was changed to return a package */
 
-	{.info = {"_WAK", 1, ACPI_RTYPE_NONE | ACPI_RTYPE_PACKAGE}},
+	{.info = {"_WAK", 1, ACPI_RTYPE_NONE | ACPI_RTYPE_INTEGER | ACPI_RTYPE_PACKAGE}},
 	{.ret_info = {ACPI_PTYPE1_FIXED, ACPI_RTYPE_INTEGER, 2, 0, 0, 0}},	/* fixed (2 Int), but is optional */
 	{.ret_info = {0, 0, 0, 0, 0, 0}}	/* Table terminator */
 };
-- 
1.5.6.5

