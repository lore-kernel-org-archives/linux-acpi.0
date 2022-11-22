Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56061C433FE
	for <linux-acpi@archiver.kernel.org>; Tue, 22 Nov 2022 12:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233499AbiKVM4o (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Tue, 22 Nov 2022 07:56:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233103AbiKVM4P (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 22 Nov 2022 07:56:15 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33DAB61BBF
        for <linux-acpi@vger.kernel.org>; Tue, 22 Nov 2022 04:56:15 -0800 (PST)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NGkkx1t9YzHw0v
        for <linux-acpi@vger.kernel.org>; Tue, 22 Nov 2022 20:55:37 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 22 Nov 2022 20:56:13 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 22 Nov
 2022 20:56:12 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-acpi@vger.kernel.org>, <rafael.j.wysocki@intel.com>
CC:     <yangyingliang@huawei.com>, <guohanjun@huawei.com>
Subject: [PATCH] PNP: fix name memory leak in pnp_register_protocol()
Date:   Tue, 22 Nov 2022 20:54:25 +0800
Message-ID: <20221122125425.1107474-1-yangyingliang@huawei.com>
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

After commit 1fa5ae857bb1 ("driver core: get rid of struct device's
bus_id string array"), the name of device is allocated dynamically,
it need be freed in error path.

Current all protocols used in pnp_register_protocol() is static, they
don't have a release function(), so just call kfree_const() to free
the name.

Fixes: 1fa5ae857bb1 ("driver core: get rid of struct device's bus_id string array")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/pnp/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pnp/core.c b/drivers/pnp/core.c
index 6a60c5d83383..390e449c17ef 100644
--- a/drivers/pnp/core.c
+++ b/drivers/pnp/core.c
@@ -72,8 +72,10 @@ int pnp_register_protocol(struct pnp_protocol *protocol)
 	mutex_unlock(&pnp_lock);
 
 	ret = device_register(&protocol->dev);
-	if (ret)
+	if (ret) {
 		pnp_remove_protocol(protocol);
+		kfree_const(protocol->dev.kobj.name);
+	}
 
 	return ret;
 }
-- 
2.25.1

