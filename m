Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B720C48BE5
	for <linux-acpi@archiver.kernel.org>; Tue, 15 Jun 2021 07:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38DBA61417
	for <linux-acpi@archiver.kernel.org>; Tue, 15 Jun 2021 07:10:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbhFOHMV (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Tue, 15 Jun 2021 03:12:21 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:6370 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhFOHMV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Jun 2021 03:12:21 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4G3zr80FSRz62cd;
        Tue, 15 Jun 2021 15:06:16 +0800 (CST)
Received: from dggpeml500020.china.huawei.com (7.185.36.88) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 15 Jun 2021 15:10:13 +0800
Received: from huawei.com (10.175.127.227) by dggpeml500020.china.huawei.com
 (7.185.36.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 15 Jun
 2021 15:10:13 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <rjw@rjwysocki.net>, <lenb@kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
        <yangjihong1@huawei.com>, <yukuai3@huawei.com>,
        <libaokun1@huawei.com>
Subject: [PATCH -next v2] ACPI: sysfs: fix doc warnings in device_sysfs.c
Date:   Tue, 15 Jun 2021 15:19:14 +0800
Message-ID: <20210615071914.3067407-1-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/acpi/device_sysfs.c:278: warning: Function parameter or
  member 'dev' not described in 'acpi_device_uevent_modalias'
 drivers/acpi/device_sysfs.c:278: warning: Function parameter or
  member 'env' not described in 'acpi_device_uevent_modalias'
 drivers/acpi/device_sysfs.c:323: warning: Function parameter or
  member 'dev' not described in 'acpi_device_modalias'
 drivers/acpi/device_sysfs.c:323: warning: Function parameter or
  member 'buf' not described in 'acpi_device_modalias'
 drivers/acpi/device_sysfs.c:323: warning: Function parameter or
  member 'size' not described in 'acpi_device_modalias'

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
V1->V2:
	Make comments more appropriate

 drivers/acpi/device_sysfs.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
index a393e0e09381..d96e38b2a0d1 100644
--- a/drivers/acpi/device_sysfs.c
+++ b/drivers/acpi/device_sysfs.c
@@ -268,6 +268,8 @@ int __acpi_device_uevent_modalias(struct acpi_device *adev,
 
 /**
  * acpi_device_uevent_modalias - uevent modalias for ACPI-enumerated devices.
+ * @dev: Struct device to get acpi device node.
+ * @env: Environment variables of the kobject uevent.
  *
  * Create the uevent modalias field for ACPI-enumerated devices.
  *
@@ -313,6 +315,9 @@ static int __acpi_device_modalias(struct acpi_device *adev, char *buf, int size)
 
 /**
  * acpi_device_modalias - modalias sysfs attribute for ACPI-enumerated devices.
+ * @dev: Struct device to get acpi device node.
+ * @buf: The buffer to save pnp_modalias and of_modalias.
+ * @size: Size of buffer.
  *
  * Create the modalias sysfs attribute for ACPI-enumerated devices.
  *
-- 
2.31.1

