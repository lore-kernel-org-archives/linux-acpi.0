From: Len Brown <lenb@kernel.org>
Subject: [PATCH 2/6] ACPICA: Silence the warning about _BIF returning the buffer
Date: Wed, 25 Nov 2009 01:11:56 -0500
Message-ID: <d0b3b119f4d9460f3947334cf384ae69c5417360.1259129450.git.len.brown@intel.com>
References: <1259129520-8281-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173015pub.verizon.net ([206.46.173.15]:41538 "EHLO
	vms173015pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751244AbZKYGMT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Nov 2009 01:12:19 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173015.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KTN00G60IK4MKRH@vms173015.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 25 Nov 2009 00:12:05 -0600 (CST)
In-reply-to: <1259129520-8281-1-git-send-email-lenb@kernel.org>
In-reply-to: <87c687be055e67bc04189ce476690be73d16063e.1259129450.git.len.brown@intel.com>
References: <87c687be055e67bc04189ce476690be73d16063e.1259129450.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Alexey Starikovskiy <astarikovskiy@suse.de>

_BIF was returning buffer instead of a string since day 1 of ACPI.
Adding a warning for that is noble, but people don't like
when someone cries wolf in a production system.

Reference: http://bugzilla.kernel.org/show_bug.cgi?id=14379
Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/acpredef.h |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/acpredef.h b/drivers/acpi/acpica/acpredef.h
index cd80d1d..57bdaf6 100644
--- a/drivers/acpi/acpica/acpredef.h
+++ b/drivers/acpi/acpica/acpredef.h
@@ -203,8 +203,9 @@ static const union acpi_predefined_info predefined_names[] =
 	{{"_BCT", 1, ACPI_RTYPE_INTEGER}},
 	{{"_BDN", 0, ACPI_RTYPE_INTEGER}},
 	{{"_BFS", 1, 0}},
-	{{"_BIF", 0, ACPI_RTYPE_PACKAGE}}, /* Fixed-length (9 Int),(4 Str) */
-			  {{{ACPI_PTYPE1_FIXED, ACPI_RTYPE_INTEGER, 9, ACPI_RTYPE_STRING}, 4,0}},
+	{{"_BIF", 0, ACPI_RTYPE_PACKAGE} }, /* Fixed-length (9 Int),(4 Str/Buf) */
+			  {{{ACPI_PTYPE1_FIXED, ACPI_RTYPE_INTEGER, 9,
+			     ACPI_RTYPE_STRING | ACPI_RTYPE_BUFFER}, 4, 0} },
 
 	{{"_BIX", 0, ACPI_RTYPE_PACKAGE}},	/* Fixed-length (16 Int),(4 Str) */
 	{{{ACPI_PTYPE1_FIXED, ACPI_RTYPE_INTEGER, 16, ACPI_RTYPE_STRING}, 4,
-- 
1.6.0.6

