From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ACPI / LPSS: remove redundant initialization of clk
Date: Sun, 15 Oct 2017 12:50:34 +0100
Message-ID: <20171015115034.10162-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:46765 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750917AbdJOLuh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 15 Oct 2017 07:50:37 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The pointer clk is being initialized to ERR_PTR(-ENODEV) however
this value is never read before it is set to clk_data->clk. Thus
the initialization is redundant and can be mored.

Cleans up clang warning:
Value stored to 'clk' during its initialization is never read

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/acpi/acpi_lpss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index 97b753dd2e6e..023191aa8d7e 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -362,7 +362,7 @@ static int register_device_clock(struct acpi_device *adev,
 {
 	const struct lpss_device_desc *dev_desc = pdata->dev_desc;
 	const char *devname = dev_name(&adev->dev);
-	struct clk *clk = ERR_PTR(-ENODEV);
+	struct clk *clk;
 	struct lpss_clk_data *clk_data;
 	const char *parent, *clk_name;
 	void __iomem *prv_base;
-- 
2.14.1

