From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] ACPI: remove duplicated include from container.c
Date: Thu, 4 Apr 2013 09:17:00 +0800
Message-ID: <CAPgLHd8MdWkAZjJJ0T895YJtz74vJ6iVjmncD9pvwamSeL8fQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bk0-f52.google.com ([209.85.214.52]:54418 "EHLO
	mail-bk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761846Ab3DDBRC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Apr 2013 21:17:02 -0400
Received: by mail-bk0-f52.google.com with SMTP id it16so1180862bkc.11
        for <linux-acpi@vger.kernel.org>; Wed, 03 Apr 2013 18:17:01 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, rjw@sisk.pl
Cc: yongjun_wei@trendmicro.com.cn, linux-acpi@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Remove duplicated include.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/acpi/container.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/acpi/container.c b/drivers/acpi/container.c
index e231516..f9f8a08 100644
--- a/drivers/acpi/container.c
+++ b/drivers/acpi/container.c
@@ -30,8 +30,6 @@
 
 #include "internal.h"
 
-#include "internal.h"
-
 #define PREFIX "ACPI: "
 
 #define _COMPONENT			ACPI_CONTAINER_COMPONENT

