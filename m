Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE70C433EF
	for <linux-acpi@archiver.kernel.org>; Thu, 23 Jun 2022 13:21:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbiFWNV2 (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Thu, 23 Jun 2022 09:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbiFWNV1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Jun 2022 09:21:27 -0400
Received: from mail-m974.mail.163.com (mail-m974.mail.163.com [123.126.97.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4F1C249C8C;
        Thu, 23 Jun 2022 06:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=YzLWj
        FH8JUhO6LUNmgSCyovPzdzhMNp9p6VW4aUFODQ=; b=pOGg5PWMUFcMXdSw9EDcs
        fzpd++jNGevoWEJTaNUfilc7wi65hv/F+EkmrBa8J5EALxCocXQpxUzJFlEEJvmt
        chqsE5Qp6ry2qBgIqkRwc2pQ5vMrMPBFL4lBbRhPVtmOg4DZyHtJbh13M4iaH3oE
        sZPKXaAoptFFAMX9ckY4FM=
Received: from localhost.localdomain (unknown [116.128.244.169])
        by smtp4 (Coremail) with SMTP id HNxpCgCnbvrHaLRi0YWjKw--.7486S2;
        Thu, 23 Jun 2022 21:21:12 +0800 (CST)
From:   huhai <15815827059@163.com>
To:     rafael@kernel.org, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        huhai <huhai@kylinos.cn>
Subject: [PATCH] ACPI: LPSS: Fix missing check in register_device_clock
Date:   Thu, 23 Jun 2022 21:21:27 +0800
Message-Id: <20220623132127.1248462-1-15815827059@163.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: HNxpCgCnbvrHaLRi0YWjKw--.7486S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gry3Zr1UWFyftF43Gr17KFg_yoW3ZFb_ZF
        Z2vFWvqr4kKFn3Cr1DArnxZry0vFnI9rs5XryUKr4xZ348W347WayrZr4qvF45Ww18KFZ8
        Z3W8trW2kr13CjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbPl1JUUUUU==
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: rprvmiivyslimvzbiqqrwthudrp/xtbB0wgphVXlvuBXHAAAsS
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: huhai <huhai@kylinos.cn>

register_device_clock() misses a check for platform_device_register_simple().
Add a check to fix it.

Signed-off-by: huhai <huhai@kylinos.cn>
---
 drivers/acpi/acpi_lpss.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index fbe0756259c5..c4d4d21391d7 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -422,6 +422,9 @@ static int register_device_clock(struct acpi_device *adev,
 	if (!lpss_clk_dev)
 		lpt_register_clock_device();
 
+	if (IS_ERR(lpss_clk_dev))
+		return PTR_ERR(lpss_clk_dev);
+
 	clk_data = platform_get_drvdata(lpss_clk_dev);
 	if (!clk_data)
 		return -ENODEV;
-- 
2.27.0


No virus found
		Checked by Hillstone Network AntiVirus

