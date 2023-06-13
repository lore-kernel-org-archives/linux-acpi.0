Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1802AC7EE2E
	for <linux-acpi@archiver.kernel.org>; Tue, 13 Jun 2023 12:59:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242340AbjFMM7m (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Tue, 13 Jun 2023 08:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236749AbjFMM7m (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Jun 2023 08:59:42 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFCDF1998;
        Tue, 13 Jun 2023 05:59:37 -0700 (PDT)
Received: from kwepemm600004.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QgT662R9SzqTbT;
        Tue, 13 Jun 2023 20:54:38 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 kwepemm600004.china.huawei.com (7.193.23.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 20:59:34 +0800
From:   Huisong Li <lihuisong@huawei.com>
To:     <rafael@kernel.org>, <rafael.j.wysocki@intel.com>,
        <robbiek@xsightlabs.com>, <sudeep.holla@arm.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wanghuiqiang@huawei.com>, <zhangzekun11@huawei.com>,
        <wangxiongfeng2@huawei.com>, <tanxiaofei@huawei.com>,
        <guohanjun@huawei.com>, <wangkefeng.wang@huawei.com>,
        <huangdaode@huawei.com>, <lihuisong@huawei.com>
Subject: [PATCH v4 0/2] mailbox: pcc: Support platform notification for type4 and shared interrupt
Date:   Tue, 13 Jun 2023 20:57:26 +0800
Message-ID: <20230613125728.31279-1-lihuisong@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20221016034043.52227-1-lihuisong@huawei.com>
References: <20221016034043.52227-1-lihuisong@huawei.com>
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

PCC supports processing platform notification for slave subspaces and
shared interrupt for multiple subspaces.

---
 -v4: add Reviewed-by.
 -v3: update requesting shared irq code due to pcc using mbox_bind_client.
 -v2: extract cmd complete code into a function.
      unrelated types regard chan_in_use as dummy.
 -v1: using subspace type to replace comm_flow_dir in patch [1/2]
 -rfc-v3: split V2 into two patches.
 -rfc-v2: don't use platform interrupt ack register to identify if the given
      channel should respond interrupt.

Huisong Li (2):
  mailbox: pcc: Add support for platform notification handling
  mailbox: pcc: Support shared interrupt for multiple subspaces

 drivers/mailbox/pcc.c | 91 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 80 insertions(+), 11 deletions(-)

-- 
2.22.0

