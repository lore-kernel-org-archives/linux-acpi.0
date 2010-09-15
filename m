From: Huang Ying <ying.huang@intel.com>
Subject: [BUGFIX] ACPI, APEI, Fix ERST MOVE_DATA instruction implementation
Date: Wed, 15 Sep 2010 17:00:57 +0800
Message-ID: <1284541257.2754.15.camel@yhuang-dev>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:39207 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752409Ab0IOJBA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 15 Sep 2010 05:01:00 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Javier Martinez Canillas <martinez.javier@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>

The src_base and dst_base fields in apei_exec_context are physical
address, so they should be ioremaped before being used in ERST
MOVE_DATA instruction.

Reported-by: Javier Martinez Canillas <martinez.javier@gmail.com>
Reported-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Huang Ying <ying.huang@intel.com>
---
 drivers/acpi/apei/erst.c |   20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

--- a/drivers/acpi/apei/erst.c
+++ b/drivers/acpi/apei/erst.c
@@ -266,13 +266,27 @@ static int erst_exec_move_data(struct ap
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


