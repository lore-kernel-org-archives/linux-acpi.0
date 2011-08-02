From: Len Brown <lenb@kernel.org>
Subject: [PATCH 02/27] ACPICA: Add missing _TDL to list of predefined names
Date: Tue, 02 Aug 2011 16:53:04 -0400
Message-ID: <f631f9cafbc47bbfe5eb2aa831cd323175298448.1312318300.git.len.brown@intel.com>
References: <1312318409-29363-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173009pub.verizon.net ([206.46.173.9]:47448 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755266Ab1HBUxy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Aug 2011 16:53:54 -0400
Received: from localhost.localdomain ([unknown] [65.175.195.226])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LPB00B5BJDEUSC0@vms173009.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 02 Aug 2011 15:53:44 -0500 (CDT)
In-reply-to: <1312318409-29363-1-git-send-email-lenb@kernel.org>
In-reply-to: <c8cefe307d79c57b32ca1d4c9ebff528f8dd914c.1312318300.git.len.brown@intel.com>
References: <c8cefe307d79c57b32ca1d4c9ebff528f8dd914c.1312318300.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Affects both iASL and core ACPICA.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/acpredef.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/acpica/acpredef.h b/drivers/acpi/acpica/acpredef.h
index 94e73c9..c445cca 100644
--- a/drivers/acpi/acpica/acpredef.h
+++ b/drivers/acpi/acpica/acpredef.h
@@ -468,6 +468,7 @@ static const union acpi_predefined_info predefined_names[] =
 	{{"_SWS", 0, ACPI_RTYPE_INTEGER}},
 	{{"_TC1", 0, ACPI_RTYPE_INTEGER}},
 	{{"_TC2", 0, ACPI_RTYPE_INTEGER}},
+	{{"_TDL", 0, ACPI_RTYPE_INTEGER}},
 	{{"_TIP", 1, ACPI_RTYPE_INTEGER}},
 	{{"_TIV", 1, ACPI_RTYPE_INTEGER}},
 	{{"_TMP", 0, ACPI_RTYPE_INTEGER}},
-- 
1.7.6.396.ge0613

