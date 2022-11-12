Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CFA1C4332F
	for <linux-acpi@archiver.kernel.org>; Sat, 12 Nov 2022 02:07:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbiKLCHr (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Fri, 11 Nov 2022 21:07:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbiKLCHp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Nov 2022 21:07:45 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48818606BD;
        Fri, 11 Nov 2022 18:07:44 -0800 (PST)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N8Jlg1600zbngv;
        Sat, 12 Nov 2022 10:03:59 +0800 (CST)
Received: from kwepemm600004.china.huawei.com (7.193.23.242) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 12 Nov 2022 10:07:42 +0800
Received: from localhost.localdomain (10.28.79.22) by
 kwepemm600004.china.huawei.com (7.193.23.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 12 Nov 2022 10:07:41 +0800
From:   Huisong Li <lihuisong@huawei.com>
To:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <rafael@kernel.org>, <sudeep.holla@arm.com>,
        <rafael.j.wysocki@intel.com>, <wanghuiqiang@huawei.com>,
        <zhangzekun11@huawei.com>, <wangxiongfeng2@huawei.com>,
        <tanxiaofei@huawei.com>, <guohanjun@huawei.com>,
        <xiexiuqi@huawei.com>, <wangkefeng.wang@huawei.com>,
        <huangdaode@huawei.com>, <lihuisong@huawei.com>
Subject: [PATCH V3 0/2] Optimize PCC OpRegion code and reset pcc_chan_count
Date:   Sat, 12 Nov 2022 10:05:26 +0800
Message-ID: <20221112020528.7837-1-lihuisong@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20221110015034.7943-1-lihuisong@huawei.com>
References: <20221110015034.7943-1-lihuisong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.28.79.22]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600004.china.huawei.com (7.193.23.242)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This series clarifies the dependency of PCC OpRegion on interrupt and reset
pcc_chan_count to zero in case of PCC probe failure.


---
 - v3: fix commit log and goto tags.
 - v2: drop the patch that rename platform interrupt bit macro
---

Huisong Li (2):
  ACPI: PCC: Setup PCC Opregion handler only if platform interrupt is
    available
  mailbox: pcc: Reset pcc_chan_count to zero in case of PCC probe
    failure

 drivers/acpi/acpi_pcc.c | 47 +++++++++++++++++++++++++----------------
 drivers/mailbox/pcc.c   |  1 +
 2 files changed, 30 insertions(+), 18 deletions(-)

-- 
2.22.0

