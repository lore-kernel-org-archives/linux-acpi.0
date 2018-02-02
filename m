From: Yang Shunyong <shunyong.yang@hxt-semitech.com>
Subject: [PATCH v3] ACPI / tables: Add IORT to injectable table list
Date: Fri, 2 Feb 2018 18:25:38 +0800
Message-ID: <1517567138-27283-1-git-send-email-shunyong.yang@hxt-semitech.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx01.hxt-semitech.com.96.203.223.in-addr.arpa ([223.203.96.7]:58510
        "EHLO barracuda.hxt-semitech.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750773AbeBBK1V (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 2 Feb 2018 05:27:21 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Yang Shunyong <shunyong.yang@hxt-semitech.com>, Joey Zheng <yu.zheng@hxt-semitech.com>, Wang Dongsheng <dongsheng.wang@hxt-semitech.com>, Jiang Yutang <yutang2.jiang@hxt-semitech.com>, Hanjun Guo <guohanjun@huawei.com>

Loading IORT table from initrd is used to fix firmware IORT defects.
Moreover, it is very useful to debug SMMU node/device probe, MSI
allocation, stream id translation and IORT table from firmware. It
is also very useful to enable SMMU and devices behind SMMU before
firmware is ready.

This patch adds ACPI_SIG_IORT to the table, which enables IORT
from initrd to override which from firmware.

Signed-off-by: Yang Shunyong <shunyong.yang@hxt-semitech.com>
Cc: Joey Zheng <yu.zheng@hxt-semitech.com>
Cc: Wang Dongsheng <dongsheng.wang@hxt-semitech.com>
Cc: Jiang Yutang <yutang2.jiang@hxt-semitech.com>
Cc: Hanjun Guo <guohanjun@huawei.com>
---

v3:
Add more detailed commit message according to Hanjun's suggestion.

v2:
Change typo ACPI_SIG_PPTT to ACPI_SIG_IORT in commit message.

---
 drivers/acpi/tables.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 80ce2a7d224b..7bcb66ccccf3 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -456,7 +456,8 @@ static u8 __init acpi_table_checksum(u8 *buffer, u32 length)
 	ACPI_SIG_SLIC, ACPI_SIG_SPCR, ACPI_SIG_SPMI, ACPI_SIG_TCPA,
 	ACPI_SIG_UEFI, ACPI_SIG_WAET, ACPI_SIG_WDAT, ACPI_SIG_WDDT,
 	ACPI_SIG_WDRT, ACPI_SIG_DSDT, ACPI_SIG_FADT, ACPI_SIG_PSDT,
-	ACPI_SIG_RSDT, ACPI_SIG_XSDT, ACPI_SIG_SSDT, NULL };
+	ACPI_SIG_RSDT, ACPI_SIG_XSDT, ACPI_SIG_SSDT, ACPI_SIG_IORT,
+	NULL };
 
 #define ACPI_HEADER_SIZE sizeof(struct acpi_table_header)
 
-- 
1.8.3.1

