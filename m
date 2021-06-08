Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F40C47082
	for <linux-acpi@archiver.kernel.org>; Tue,  8 Jun 2021 02:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A07E61208
	for <linux-acpi@archiver.kernel.org>; Tue,  8 Jun 2021 02:29:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbhFHCbb (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Mon, 7 Jun 2021 22:31:31 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:8067 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbhFHCba (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Jun 2021 22:31:30 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FzYyw2FZlzYsVV;
        Tue,  8 Jun 2021 10:26:48 +0800 (CST)
Received: from dggpeml500020.china.huawei.com (7.185.36.88) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 10:29:31 +0800
Received: from huawei.com (10.175.127.227) by dggpeml500020.china.huawei.com
 (7.185.36.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 8 Jun 2021
 10:29:30 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <rjw@rjwysocki.net>, <lenb@kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
        <yangjihong1@huawei.com>, <yukuai3@huawei.com>,
        <libaokun1@huawei.com>
Subject: [PATCH -next] acpi/nvs: fix doc warnings in nvs.c
Date:   Tue, 8 Jun 2021 10:38:41 +0800
Message-ID: <20210608023841.2746826-1-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/acpi/nvs.c:94: warning: Function parameter or
  member 'start' not described in 'suspend_nvs_register'
 drivers/acpi/nvs.c:94: warning: Function parameter or
  member 'size' not described in 'suspend_nvs_register'

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 drivers/acpi/nvs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/nvs.c b/drivers/acpi/nvs.c
index 9f8712a557b3..4609a8a2e42d 100644
--- a/drivers/acpi/nvs.c
+++ b/drivers/acpi/nvs.c
@@ -83,8 +83,8 @@ static LIST_HEAD(nvs_list);
 
 /**
  *	suspend_nvs_register - register platform NVS memory region to save
- *	@start - physical address of the region
- *	@size - size of the region
+ *	@start: physical address of the region
+ *	@size: size of the region
  *
  *	The NVS region need not be page-aligned (both ends) and we arrange
  *	things so that the data from page-aligned addresses in this region will
-- 
2.31.1

