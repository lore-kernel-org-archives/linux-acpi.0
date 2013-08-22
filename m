From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH] ACPI / APEI: remove unnecessary platform_set_drvdata()
Date: Thu, 22 Aug 2013 10:47:09 +0900
Message-ID: <001401ce9ed9$83d74c60$8b85e520$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:26083 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751853Ab3HVBrL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 21 Aug 2013 21:47:11 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MRW002UASYMGUC0@mailout4.samsung.com> for
 linux-acpi@vger.kernel.org; Thu, 22 Aug 2013 10:47:10 +0900 (KST)
Content-language: ko
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: 'Len Brown' <lenb@kernel.org>
Cc: "'Rafael J. Wysocki'" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, "'Naveen N. Rao'" <naveen.n.rao@linux.vnet.ibm.com>, 'Betty Dall' <betty.dall@hp.com>, 'Jingoo Han' <jg1.han@samsung.com>

The driver core clears the driver data to NULL after device_release
or on probe failure. Thus, it is not needed to manually clear the
device driver data to NULL.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/acpi/apei/ghes.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 8ec37bb..3f9771d 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -1044,8 +1044,6 @@ static int ghes_remove(struct platform_device *ghes_dev)
 
 	kfree(ghes);
 
-	platform_set_drvdata(ghes_dev, NULL);
-
 	return 0;
 }
 
-- 
1.7.10.4


