From: Huang Ying <ying.huang@intel.com>
Subject: [PATCH 5/5] ACPI, APEI, Fix ERST MOVE_DATA instruction implementation
Date: Sun, 19 Sep 2010 11:00:35 +0800
Message-ID: <1284865235-29920-6-git-send-email-ying.huang@intel.com>
References: <1284865235-29920-1-git-send-email-ying.huang@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:29657 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754274Ab0ISDBd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 18 Sep 2010 23:01:33 -0400
In-Reply-To: <1284865235-29920-1-git-send-email-ying.huang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, linux-acpi@vger.kernel.org, Huang Ying <ying.huang@intel.com>

The src_base and dst_base fields in apei_exec_context are physical
address, so they should be ioremaped before being used in ERST
MOVE_DATA instruction.

Reported-by: Javier Martinez Canillas <martinez.javier@gmail.com>
Reported-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Huang Ying <ying.huang@intel.com>
---
 drivers/acpi/apei/erst.c |   20 +++++++++++++++++---
 1 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/apei/erst.c b/drivers/acpi/apei/erst.c
index 40b01c3..a103963 100644
--- a/drivers/acpi/apei/erst.c
+++ b/drivers/acpi/apei/erst.c
@@ -266,13 +266,27 @@ static int erst_exec_move_data(struct apei_exec_context *ctx,
 {
 	int rc;
 	u64 offset;
+	void *src, *dst;
+
+	/* ioremap does not work in interrupt context */
+	if (in_interrupt())
+		return -EBUSY;
 
 	rc = __apei_exec_read_register(entry, &offset);
 	if (rc)
 		return rc;
-	memmove((void *)ctx->dst_base + offset,
-		(void *)ctx->src_base + offset,
-		ctx->var2);
+
+	src = ioremap(ctx->src_base + offset, ctx->var2);
+	if (!src)
+		return -ENOMEM;
+	dst = ioremap(ctx->dst_base + offset, ctx->var2);
+	if (!dst)
+		return -ENOMEM;
+
+	memmove(dst, src, ctx->var2);
+
+	iounmap(src);
+	iounmap(dst);
 
 	return 0;
 }
-- 
1.7.1

