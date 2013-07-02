From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH] efi_pstore: add missing iounmap() on error in erst_exec_move_data()
Date: Tue, 2 Jul 2013 09:02:32 +0800
Message-ID: <CAPgLHd-x4N6NVJUWz9Tr4onnBgEwLW6CNQqS1_upSQzPKSoX2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bk0-f52.google.com ([209.85.214.52]:55124 "EHLO
	mail-bk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755648Ab3GBBCe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Jul 2013 21:02:34 -0400
Received: by mail-bk0-f52.google.com with SMTP id d7so2008168bkh.11
        for <linux-acpi@vger.kernel.org>; Mon, 01 Jul 2013 18:02:32 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: anton@enomsg.org, ccross@android.com, keescook@chromium.org, tony.luck@intel.com, lenb@kernel.org, rjw@sisk.pl
Cc: yongjun_wei@trendmicro.com.cn, linux-acpi@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Add the missing iounmap() before return from erst_exec_move_data()
in the error handling case.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/acpi/apei/erst.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/erst.c b/drivers/acpi/apei/erst.c
index f7b3b39..7af21ed 100644
--- a/drivers/acpi/apei/erst.c
+++ b/drivers/acpi/apei/erst.c
@@ -284,8 +284,10 @@ static int erst_exec_move_data(struct apei_exec_context *ctx,
 	if (!src)
 		return -ENOMEM;
 	dst = ioremap(ctx->dst_base + offset, ctx->var2);
-	if (!dst)
+	if (!dst) {
+		iounmap(src);
 		return -ENOMEM;
+	}
 
 	memmove(dst, src, ctx->var2);
 

