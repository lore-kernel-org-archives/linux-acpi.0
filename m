From: weiyj_lk@163.com
Subject: [PATCH -next] ACPI / battery: remove duplicated include from battery.c
Date: Mon, 28 Jul 2014 21:22:55 +0800
Message-ID: <1406553775-30104-1-git-send-email-weiyj_lk@163.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from m12-14.163.com ([220.181.12.14]:60637 "EHLO m12-14.163.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752140AbaG1NXN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 28 Jul 2014 09:23:13 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: Wei Yongjun <yongjun_wei@trendmicro.com.cn>, linux-acpi@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Remove duplicated include.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/acpi/battery.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 130f513..48bcf38 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -35,7 +35,6 @@
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/suspend.h>
-#include <linux/delay.h>
 #include <asm/unaligned.h>
 
 #ifdef CONFIG_ACPI_PROCFS_POWER

