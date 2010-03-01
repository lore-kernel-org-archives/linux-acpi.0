From: Len Brown <lenb@kernel.org>
Subject: [PATCH 7/9] ACPICA: Remove unused uint32_struct type
Date: Mon, 01 Mar 2010 01:56:16 -0500
Message-ID: <a8f13b7083a10580eeed0723df4b414ed741e0d2.1267426486.git.len.brown@intel.com>
References: <1267426578-4406-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173015pub.verizon.net ([206.46.173.15]:45261 "EHLO
	vms173015pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751257Ab0CAG4X (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Mar 2010 01:56:23 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173015.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KYL0029ECLX8PP0@vms173015.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 01 Mar 2010 00:56:23 -0600 (CST)
In-reply-to: <1267426578-4406-1-git-send-email-lenb@kernel.org>
In-reply-to: <2147d3f00f85c9e993786863d8138694672da01b.1267426486.git.len.brown@intel.com>
References: <2147d3f00f85c9e993786863d8138694672da01b.1267426486.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

This type is not used in ACPICA and thus removed.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 include/acpi/actypes.h |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 07f2cdc..2ccfa47 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -385,11 +385,6 @@ union uint64_overlay {
 	struct uint64_struct part;
 };
 
-struct uint32_struct {
-	u32 lo;
-	u32 hi;
-};
-
 #define ACPI_INTEGER_BIT_SIZE           64
 #define ACPI_MAX_DECIMAL_DIGITS         20	/* 2^64 = 18,446,744,073,709,551,616 */
 
-- 
1.6.0.6

