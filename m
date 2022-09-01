Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E27F5ECAAD3
	for <linux-acpi@archiver.kernel.org>; Thu,  1 Sep 2022 10:10:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233093AbiIAKKe (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Thu, 1 Sep 2022 06:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232082AbiIAKKc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Sep 2022 06:10:32 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4231A6F570;
        Thu,  1 Sep 2022 03:10:29 -0700 (PDT)
Received: from fraeml739-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MJGsr46wNz6813w;
        Thu,  1 Sep 2022 18:06:40 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml739-chm.china.huawei.com (10.206.15.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 1 Sep 2022 12:10:27 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 1 Sep 2022 11:10:25 +0100
From:   John Garry <john.garry@huawei.com>
To:     <rafael@kernel.org>, <lenb@kernel.org>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <andy.shevchenko@gmail.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH] ACPI: platform: Use PLATFORM_DEVID_NONE in acpi_create_platform_device()
Date:   Thu, 1 Sep 2022 18:04:11 +0800
Message-ID: <1662026651-172787-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Instead of hardcoding the value for the id, use PLATFORM_DEVID_NONE.

Signed-off-by: John Garry <john.garry@huawei.com>

diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
index de3cbf152dee..d33334c9b8e5 100644
--- a/drivers/acpi/acpi_platform.c
+++ b/drivers/acpi/acpi_platform.c
@@ -140,7 +140,7 @@ struct platform_device *acpi_create_platform_device(struct acpi_device *adev,
 	pdevinfo.parent = adev->parent ?
 		acpi_get_first_physical_node(adev->parent) : NULL;
 	pdevinfo.name = dev_name(&adev->dev);
-	pdevinfo.id = -1;
+	pdevinfo.id = PLATFORM_DEVID_NONE;
 	pdevinfo.res = resources;
 	pdevinfo.num_res = count;
 	pdevinfo.fwnode = acpi_fwnode_handle(adev);
-- 
2.35.3

