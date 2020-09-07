Return-Path: <SRS0=PXo4=CQ=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72016C43461
	for <linux-acpi@archiver.kernel.org>; Mon,  7 Sep 2020 09:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 264EF2145D
	for <linux-acpi@archiver.kernel.org>; Mon,  7 Sep 2020 09:04:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbgIGJEh (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Mon, 7 Sep 2020 05:04:37 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33376 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728180AbgIGJEf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 7 Sep 2020 05:04:35 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 7EC0FECBFBD84D1A1059;
        Mon,  7 Sep 2020 17:04:34 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Mon, 7 Sep 2020 17:04:14 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC:     <linux-acpi@vger.kernel.org>, Ken Xue <Ken.Xue@amd.com>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH 0/5] Cleanups for ACPI APD driver
Date:   Mon, 7 Sep 2020 16:56:16 +0800
Message-ID: <1599468981-17301-1-git-send-email-guohanjun@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

ACPI APD driver has some unused code and some mis-behaved
kernel doc, make a cleanup for this driver.

Tested on Hisilicon ARM64, and compile tested on Intel x86.

Hanjun Guo (5):
  ACPI / APD: Add kernel doc for the properties in struct
    apd_device_desc
  ACPI / APD: Remove the flags in struct apd_device_desc
  ACPI / APD: Remove ACPI_MODULE_NAME()
  ACPI / APD: Remove the unneeded APD_ADDR(desc) macro define
  ACPI / APD: Head file including cleanups

 drivers/acpi/acpi_apd.c | 34 ++++++++--------------------------
 1 file changed, 8 insertions(+), 26 deletions(-)

-- 
1.7.12.4

