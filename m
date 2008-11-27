From: Len Brown <lenb@kernel.org>
Subject: [PATCH 11/11] ACPICA: disable _BIF warning
Date: Thu, 27 Nov 2008 02:25:16 -0500
Message-ID: <e899b6485c332aa2d7510739507ab5e5d7b28e59.1227770639.git.len.brown@intel.com>
References: <1227770716-26525-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms046pub.verizon.net ([206.46.252.46]:43800 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751836AbYK0HZ2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 27 Nov 2008 02:25:28 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms046.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0KAZ0007HDYDM9U1@vms046.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 27 Nov 2008 01:25:26 -0600 (CST)
In-reply-to: <1227770716-26525-1-git-send-email-lenb@kernel.org>
In-reply-to: <7b4d469228a92a00e412675817cedd60133de38a.1227770639.git.len.brown@intel.com>
References: <7b4d469228a92a00e412675817cedd60133de38a.1227770639.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Lin Ming <ming.m.lin@intel.com>

A generic work-around from ACPICA is in the queue,
but since Linux has a work-around in its battery
driver, we can disable this warning now.

Allow _BIF method to return an Package with Buffer elements

http://bugzilla.kernel.org/show_bug.cgi?id=11822

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 include/acpi/acpredef.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/acpi/acpredef.h b/include/acpi/acpredef.h
index e6452db..16a9ca9 100644
--- a/include/acpi/acpredef.h
+++ b/include/acpi/acpredef.h
@@ -167,7 +167,7 @@ static const union acpi_predefined_info predefined_names[] = {
 	{.info = {"_BFS", 1, 0}},
 	{.info = {"_BIF", 0, ACPI_RTYPE_PACKAGE}}, {.ret_info = {ACPI_PTYPE1_FIXED, ACPI_RTYPE_INTEGER,
 					  9,
-					  ACPI_RTYPE_STRING, 4, 0}},	/* fixed (9 Int),(4 Str) */
+					  ACPI_RTYPE_STRING | ACPI_RTYPE_BUFFER, 4, 0}},	/* fixed (9 Int),(4 Str) */
 	{.info = {"_BLT", 3, 0}},
 	{.info = {"_BMC", 1, 0}},
 	{.info = {"_BMD", 0, ACPI_RTYPE_PACKAGE}}, {.ret_info = {ACPI_PTYPE1_FIXED, ACPI_RTYPE_INTEGER, 5, 0, 0, 0}},	/* fixed (5 Int) */
-- 
1.5.6.5

