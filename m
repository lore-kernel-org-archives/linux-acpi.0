Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA32CC4321E
	for <linux-acpi@archiver.kernel.org>; Mon,  5 Dec 2022 11:51:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbiLELvA (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Mon, 5 Dec 2022 06:51:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbiLELuy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Dec 2022 06:50:54 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C6115838;
        Mon,  5 Dec 2022 03:50:53 -0800 (PST)
Received: from kwepemi500015.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NQhgH5cm9zRpR6;
        Mon,  5 Dec 2022 19:50:03 +0800 (CST)
Received: from huawei.com (10.175.124.27) by kwepemi500015.china.huawei.com
 (7.221.188.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 5 Dec
 2022 19:50:50 +0800
From:   Lv Ying <lvying6@huawei.com>
To:     <rafael@kernel.org>, <lenb@kernel.org>, <james.morse@arm.com>,
        <tony.luck@intel.com>, <bp@alien8.de>, <naoya.horiguchi@nec.com>,
        <linmiaohe@huawei.com>, <akpm@linux-foundation.org>,
        <xueshuai@linux.alibaba.com>, <ashish.kalra@amd.com>
CC:     <xiezhipeng1@huawei.com>, <wangkefeng.wang@huawei.com>,
        <xiexiuqi@huawei.com>, <tanxiaofei@huawei.com>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: [RFC 0/2] ACPI: APEI: Make synchronization errors call and
Date:   Mon, 5 Dec 2022 19:51:09 +0800
Message-ID: <20221205115111.131568-1-lvying6@huawei.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500015.china.huawei.com (7.221.188.92)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This patchset try to fix two problems:
- memory_failure() triggered by synchronization errors run in kernel
  thread context
- ignore memory_failure() failure cause synchronous error infinite loop,
  the platform firmware exceed some threshold and reboot

Lv Ying (2):
  ACPI: APEI: Make memory_failure() triggered by synchronization errors
    execute in the current context
  ACPI: APEI: fix reboot caused by synchronous error loop because of
    memory_failure() failed

 drivers/acpi/apei/ghes.c | 27 ++++++++++++++-------------
 mm/memory-failure.c      | 38 ++++++++++++++++++++++++++------------
 2 files changed, 40 insertions(+), 25 deletions(-)

-- 
2.33.0

