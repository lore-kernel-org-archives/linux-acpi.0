Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B986C001DC
	for <linux-acpi@archiver.kernel.org>; Sat, 22 Jul 2023 02:52:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjGVCwy (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Fri, 21 Jul 2023 22:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbjGVCwx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Jul 2023 22:52:53 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0857010E5;
        Fri, 21 Jul 2023 19:52:50 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4R79r2159zztRSk;
        Sat, 22 Jul 2023 10:49:38 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 22 Jul
 2023 10:52:47 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <rafael@kernel.org>, <lenb@kernel.org>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ACPI: Remove unsued extern declaration acpi_paddr_to_node()
Date:   Sat, 22 Jul 2023 10:52:46 +0800
Message-ID: <20230722025246.8332-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This is never used since commit 1e3590e2e4a3 ("[PATCH] pgdat allocation for new node
add (get node id by acpi)")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 include/linux/acpi.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 641dc4843987..58a0fdf68ca2 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -477,8 +477,6 @@ static inline int acpi_get_node(acpi_handle handle)
 	return 0;
 }
 #endif
-extern int acpi_paddr_to_node(u64 start_addr, u64 size);
-
 extern int pnpacpi_disabled;
 
 #define PXM_INVAL	(-1)
-- 
2.34.1

