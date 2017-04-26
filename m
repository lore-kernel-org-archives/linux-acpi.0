From: tnhuynh@apm.com
Subject: [PATCH V1] i2c: xgene: Set ACPI_COMPANION_I2C
Date: Wed, 26 Apr 2017 16:48:51 +0700
Message-ID: <1493200131-30171-1-git-send-email-tnhuynh@apm.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pg0-f46.google.com ([74.125.83.46]:36521 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2997907AbdDZJtK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Apr 2017 05:49:10 -0400
Received: by mail-pg0-f46.google.com with SMTP id t7so2794515pgt.3
        for <linux-acpi@vger.kernel.org>; Wed, 26 Apr 2017 02:49:10 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Loc Ho <lho@apm.com>, Phong Vo <pvo@apm.com>, Thang Nguyen <tqnguyen@apm.com>, patches@apm.com, Tin Huynh <tnhuynh@apm.com>

From: Tin Huynh <tnhuynh@apm.com>

With ACPI, i2c-core requires ACPI companion to be set in order for it
to create slave device.
This patch sets the ACPI companion accordingly.
---
 drivers/i2c/busses/i2c-xgene-slimpro.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xgene-slimpro.c b/drivers/i2c/busses/i2c-xgene-slimpro.c
index dbe7e44..6ba6c83 100644
--- a/drivers/i2c/busses/i2c-xgene-slimpro.c
+++ b/drivers/i2c/busses/i2c-xgene-slimpro.c
@@ -416,6 +416,7 @@ static int xgene_slimpro_i2c_probe(struct platform_device *pdev)
 	adapter->class = I2C_CLASS_HWMON;
 	adapter->dev.parent = &pdev->dev;
 	adapter->dev.of_node = pdev->dev.of_node;
+	ACPI_COMPANION_SET(&adapter->dev, ACPI_COMPANION(&pdev->dev));
 	i2c_set_adapdata(adapter, ctx);
 	rc = i2c_add_adapter(adapter);
 	if (rc) {
-- 
1.7.1

