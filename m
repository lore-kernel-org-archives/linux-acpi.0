From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] ACPI / table: Remove duplicated include from tables.c
Date: Thu,  8 Sep 2016 15:55:41 +0000
Message-ID: <1473350141-25936-1-git-send-email-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34841 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932299AbcIHPzs (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 8 Sep 2016 11:55:48 -0400
Received: by mail-pf0-f195.google.com with SMTP id n24so2679264pfb.2
        for <linux-acpi@vger.kernel.org>; Thu, 08 Sep 2016 08:55:47 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, linux-acpi@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

Remove duplicated include.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/acpi/tables.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 4dfbf49..cdd56c4 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -35,7 +35,6 @@
 #include <linux/earlycpio.h>
 #include <linux/memblock.h>
 #include <linux/initrd.h>
-#include <linux/acpi.h>
 #include "internal.h"
 
 #ifdef CONFIG_ACPI_CUSTOM_DSDT



