From: Len Brown <lenb@kernel.org>
Subject: [PATCH 12/16] ACPI: Fix the ERST build warning
Date: Tue, 28 Sep 2010 23:44:42 -0400
Message-ID: <ee1827c255bf83e105747e60a50cce810d1d5e5e.1285731809.git.len.brown@intel.com>
References: <1285731886-18321-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:58382 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754478Ab0I2DyS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Sep 2010 23:54:18 -0400
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L9H00JMZPI2KR79@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 28 Sep 2010 22:54:06 -0500 (CDT)
In-reply-to: <1285731886-18321-1-git-send-email-lenb@kernel.org>
In-reply-to: <b137b9942a07843c64a934cfdb7d43155e507e13.1285731809.git.len.brown@intel.com>
References: <b137b9942a07843c64a934cfdb7d43155e507e13.1285731809.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alan Cox <alan@linux.intel.com>, Len Brown <len.brown@intel.com>

From: Alan Cox <alan@linux.intel.com>

drivers/acpi/apei/erst.c:273: warning: cast to pointer from integer of different size
drivers/acpi/apei/erst.c:274: warning: cast to pointer from integer of different size

Signed-off-by: Alan Cox <alan@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/apei/erst.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/apei/erst.c b/drivers/acpi/apei/erst.c
index a4904f1..37d7a05 100644
--- a/drivers/acpi/apei/erst.c
+++ b/drivers/acpi/apei/erst.c
@@ -270,8 +270,8 @@ static int erst_exec_move_data(struct apei_exec_context *ctx,
 	rc = __apei_exec_read_register(entry, &offset);
 	if (rc)
 		return rc;
-	memmove((void *)ctx->dst_base + offset,
-		(void *)ctx->src_base + offset,
+	memmove((void *)(unsigned long)ctx->dst_base + offset,
+		(void *)(unsigned long)ctx->src_base + offset,
 		ctx->var2);
 
 	return 0;
-- 
1.7.3.2.g9027fa

