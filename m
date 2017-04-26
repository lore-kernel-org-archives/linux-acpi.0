From: tnhuynh@apm.com
Subject: [PATCH V1] i2c: xgene: Add support for I2C_FUNC_I2C functionality
Date: Wed, 26 Apr 2017 11:41:45 +0700
Message-ID: <1493181705-18531-1-git-send-email-tnhuynh@apm.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:36531 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1953219AbdDZEmX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Apr 2017 00:42:23 -0400
Received: by mail-pf0-f175.google.com with SMTP id 194so36155685pfv.3
        for <linux-acpi@vger.kernel.org>; Tue, 25 Apr 2017 21:42:22 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Loc Ho <lho@apm.com>, Phong Vo <pvo@apm.com>, patches@apm.com, Tin Huynh <tnhuynh@apm.com>

From: Tin Huynh <tnhuynh@apm.com>

Certain I2C slave drivers, such as the pca95xx, require
only I2C operations instead of SMBus extensions.
This patch adds I2C_FUNC_I2C functionally to support those drivers.
---
 drivers/i2c/busses/i2c-xgene-slimpro.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xgene-slimpro.c b/drivers/i2c/busses/i2c-xgene-slimpro.c
index dbe7e44..439357c 100644
--- a/drivers/i2c/busses/i2c-xgene-slimpro.c
+++ b/drivers/i2c/busses/i2c-xgene-slimpro.c
@@ -365,7 +365,8 @@ static int xgene_slimpro_i2c_xfer(struct i2c_adapter *adap, u16 addr,
 */
 static u32 xgene_slimpro_i2c_func(struct i2c_adapter *adapter)
 {
-	return I2C_FUNC_SMBUS_BYTE |
+	return I2C_FUNC_I2C |
+		I2C_FUNC_SMBUS_BYTE |
 		I2C_FUNC_SMBUS_BYTE_DATA |
 		I2C_FUNC_SMBUS_WORD_DATA |
 		I2C_FUNC_SMBUS_BLOCK_DATA |
-- 
1.7.1

