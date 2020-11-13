Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9652DC55ABD
	for <linux-acpi@archiver.kernel.org>; Fri, 13 Nov 2020 03:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3630C20B80
	for <linux-acpi@archiver.kernel.org>; Fri, 13 Nov 2020 03:09:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbgKMDJS (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Thu, 12 Nov 2020 22:09:18 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7227 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgKMDJS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Nov 2020 22:09:18 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CXNjB1fmZzkjxN;
        Fri, 13 Nov 2020 11:09:02 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Fri, 13 Nov 2020 11:09:05 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC:     <linux-acpi@vger.kernel.org>, Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH 1/2] ACPI: acpi_drivers.h: Remove the leftover dead code
Date:   Fri, 13 Nov 2020 11:00:44 +0800
Message-ID: <1605236445-52540-1-git-send-email-guohanjun@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

After commit 5ba8b1c6fe40 ("ACPI: remove dead code"),
ACPI_PROCESSOR_LIMIT_* macros are not used anymore, remove it.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 include/acpi/acpi_drivers.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/include/acpi/acpi_drivers.h b/include/acpi/acpi_drivers.h
index 5eb1759..634f967 100644
--- a/include/acpi/acpi_drivers.h
+++ b/include/acpi/acpi_drivers.h
@@ -94,14 +94,6 @@ static inline struct pci_dev *acpi_get_pci_dev(acpi_handle handle)
 static inline void pci_acpi_crs_quirks(void) { }
 #endif
 
-/* --------------------------------------------------------------------------
-                                    Processor
-   -------------------------------------------------------------------------- */
-
-#define ACPI_PROCESSOR_LIMIT_NONE	0x00
-#define ACPI_PROCESSOR_LIMIT_INCREMENT	0x01
-#define ACPI_PROCESSOR_LIMIT_DECREMENT	0x02
-
 /*--------------------------------------------------------------------------
                                   Dock Station
   -------------------------------------------------------------------------- */
-- 
1.7.12.4

