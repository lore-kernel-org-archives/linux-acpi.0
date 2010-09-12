From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: [PATCH] ACPI: apei: Cast u64 to unsigned long, fix compile warning
Date: Sun, 12 Sep 2010 09:48:25 -0400
Message-ID: <1284299305.7239.4.camel__18026.4530507431$1284299339$gmane$org@lenovo>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:56449 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752726Ab0ILNsf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 12 Sep 2010 09:48:35 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, Huang Ying <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Andi Kleen <ak@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>linu

In today linux-net I got a compile warning in acpi/apei

drivers/acpi/apei/erst.c: In function =E2=80=98erst_exec_move_data=E2=80=
=99:
drivers/acpi/apei/erst.c:273: warning: cast to pointer from integer of =
different size
drivers/acpi/apei/erst.c:274: warning: cast to pointer from integer of =
different size

The problem is that apei_exec_context->dst_base type is u64.
But in 32 bits architecture void * is 32 bits long.=20
Casting it to unsigned long solves the issue

Signed-off-by: Javier Martinez Canillas <martinez.javier@gmail.com>
---
 drivers/acpi/apei/erst.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/apei/erst.c b/drivers/acpi/apei/erst.c
index a4904f1..37d7a05 100644
--- a/drivers/acpi/apei/erst.c
+++ b/drivers/acpi/apei/erst.c
@@ -270,8 +270,8 @@ static int erst_exec_move_data(struct apei_exec_con=
text *ctx,
 	rc =3D __apei_exec_read_register(entry, &offset);
 	if (rc)
 		return rc;
-	memmove((void *)ctx->dst_base + offset,
-		(void *)ctx->src_base + offset,
+	memmove((void *)(unsigned long)ctx->dst_base + offset,
+		(void *)(unsigned long)ctx->src_base + offset,
 		ctx->var2);
=20
 	return 0;
--=20
1.7.0.4



--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
