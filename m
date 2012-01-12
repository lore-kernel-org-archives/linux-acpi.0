From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 9/15] drivers/acpi/apei/erst.c: add missing iounmap
Date: Thu, 12 Jan 2012 10:55:11 +0100
Message-ID: <1326362117-29371-9-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: kernel-janitors@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

From: Julia Lawall <Julia.Lawall@lip6.fr>

Add missing iounmap in error handling code, in a case where the function
already preforms iounmap on some other execution path.

A simplified version of the semantic match that finds this problem is as
follows: (http://coccinelle.lip6.fr/)

// <smpl>
@@
expression e;
statement S,S1;
int ret;
@@
e = \(ioremap\|ioremap_nocache\)(...)
... when != iounmap(e)
if (<+...e...+>) S
... when any
    when != iounmap(e)
*if (...)
   { ... when != iounmap(e)
     return ...; }
... when any
iounmap(e);
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/acpi/apei/erst.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/apei/erst.c b/drivers/acpi/apei/erst.c
index 6a9e3ba..cd260f7 100644
--- a/drivers/acpi/apei/erst.c
+++ b/drivers/acpi/apei/erst.c
@@ -284,15 +284,18 @@ static int erst_exec_move_data(struct apei_exec_context *ctx,
 	if (!src)
 		return -ENOMEM;
 	dst = ioremap(ctx->dst_base + offset, ctx->var2);
-	if (!dst)
-		return -ENOMEM;
+	if (!dst) {
+		rc = -ENOMEM;
+		goto out;
+	}
 
 	memmove(dst, src, ctx->var2);
 
-	iounmap(src);
 	iounmap(dst);
+out:
+	iounmap(src);
 
-	return 0;
+	return rc;
 }
 
 static struct apei_exec_ins_type erst_ins_type[] = {
