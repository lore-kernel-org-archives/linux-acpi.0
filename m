Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E973ECAAD8
	for <linux-acpi@archiver.kernel.org>; Tue, 20 Sep 2022 09:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbiITJsD (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Tue, 20 Sep 2022 05:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbiITJry (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 20 Sep 2022 05:47:54 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4F56F54A;
        Tue, 20 Sep 2022 02:47:47 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MWxV12wDNzpTF9;
        Tue, 20 Sep 2022 17:44:57 +0800 (CST)
Received: from kwepemm600004.china.huawei.com (7.193.23.242) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 20 Sep 2022 17:47:45 +0800
Received: from localhost.localdomain (10.69.192.56) by
 kwepemm600004.china.huawei.com (7.193.23.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 20 Sep 2022 17:47:44 +0800
From:   Huisong Li <lihuisong@huawei.com>
To:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <rafael@kernel.org>, <sudeep.holla@arm.com>,
        <rafael.j.wysocki@intel.com>, <wanghuiqiang@huawei.com>,
        <huangdaode@huawei.com>, <lihuisong@huawei.com>
Subject: [PATCH 0/2] ACPI: PCC: add waiting timeout and fix Tx done interface 
Date:   Tue, 20 Sep 2022 17:44:58 +0800
Message-ID: <20220920094500.11283-1-lihuisong@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600004.china.huawei.com (7.193.23.242)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This patchset is used to fix following problems:
1) method execution may be blocked in abnormal case.
2) a error log when command is executed successfully.

Huisong Li (2):
  ACPI: PCC: replace wait_for_completion()
  ACPI: PCC: fix Tx done interface in handler

 drivers/acpi/acpi_pcc.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

-- 
2.33.0

