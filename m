From: Len Brown <lenb@kernel.org>
Subject: [PATCH 43/84] ACPICA: Fix for invalid large array index on 64-bit
 systems
Date: Sat, 28 Jun 2008 01:43:47 -0400
Message-ID: <7a2f8b5ef68463827bdcf2a916ec94a1a75761a3.1214631214.git.len.brown@intel.com>
References: <1214631868-1715-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:61938 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752689AbYF1FpO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Jun 2008 01:45:14 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms173003.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K35001DGRZCFQB4@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 28 Jun 2008 00:45:13 -0500 (CDT)
In-reply-to: <1214631868-1715-1-git-send-email-lenb@kernel.org>
In-reply-to: <087803d18fb8259cb844c075a35fb27c2d80792e.1214631213.git.len.brown@intel.com>
References: <087803d18fb8259cb844c075a35fb27c2d80792e.1214631213.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernrel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

This problem was introduced in 20080514 as a result of the
elimination of the acpi_native_uint type. Code uses a negative
array index, which should be eliminated.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/executer/exdump.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/executer/exdump.c b/drivers/acpi/executer/exdump.c
index c94638d..f337c3f 100644
--- a/drivers/acpi/executer/exdump.c
+++ b/drivers/acpi/executer/exdump.c
@@ -776,7 +776,7 @@ acpi_ex_dump_operands(union acpi_operand_object **operands,
 		      const char *note,
 		      const char *module_name, u32 line_number)
 {
-	u32 i;
+	s32 i;
 
 	ACPI_FUNCTION_NAME(ex_dump_operands);
 
-- 
1.5.6.1.89.gd544

