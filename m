Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D023C43217
	for <linux-acpi@archiver.kernel.org>; Thu, 10 Nov 2022 15:30:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbiKJPaE (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Thu, 10 Nov 2022 10:30:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiKJP3u (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Nov 2022 10:29:50 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509F8DFBA
        for <linux-acpi@vger.kernel.org>; Thu, 10 Nov 2022 07:28:30 -0800 (PST)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N7QhP1FBKzmVZs
        for <linux-acpi@vger.kernel.org>; Thu, 10 Nov 2022 23:28:05 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 23:28:19 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 10 Nov
 2022 23:28:19 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-acpi@vger.kernel.org>
CC:     <rafael.j.wysocki@intel.com>, <yangyingliang@huawei.com>,
        <guohanjun@huawei.com>
Subject: [PATCH] PNP: fix name memory leak in pnp_alloc_dev()
Date:   Thu, 10 Nov 2022 23:26:58 +0800
Message-ID: <20221110152658.403160-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Afer commit 1fa5ae857bb1 ("driver core: get rid of struct device's
bus_id string array"), the name of device is allocated dynamically,
it need be freed in the error path.

Fixes: 1fa5ae857bb1 ("driver core: get rid of struct device's bus_id string array")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/pnp/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pnp/core.c b/drivers/pnp/core.c
index 4df5aa6a309c..bb3976566822 100644
--- a/drivers/pnp/core.c
+++ b/drivers/pnp/core.c
@@ -152,6 +152,7 @@ struct pnp_dev *pnp_alloc_dev(struct pnp_protocol *protocol, int id,
 
 	dev_id = pnp_add_id(dev, pnpid);
 	if (!dev_id) {
+		kfree_const(dev->dev.kobj.name);
 		kfree(dev);
 		return NULL;
 	}
-- 
2.25.1

