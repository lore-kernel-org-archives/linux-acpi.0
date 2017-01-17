From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ACPI, APEI, EINJ: fix malformed newline escape
Date: Tue, 17 Jan 2017 14:57:20 +0000
Message-ID: <20170117145720.23998-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:37298 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750984AbdAQO7u (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Jan 2017 09:59:50 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>, Dan Williams <dan.j.williams@intel.com>, Toshi Kani <toshi.kani@hpe.com>, linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The pr_warn message has a malformed newline escape, add in the
missing \

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/acpi/apei/einj.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
index eebb7e3..ec50c32 100644
--- a/drivers/acpi/apei/einj.c
+++ b/drivers/acpi/apei/einj.c
@@ -711,7 +711,7 @@ static int __init einj_init(void)
 
 	rc = einj_check_table(einj_tab);
 	if (rc) {
-		pr_warn(FW_BUG "Invalid EINJ table.n");
+		pr_warn(FW_BUG "Invalid EINJ table.\n");
 		return -EINVAL;
 	}
 
-- 
2.10.2

