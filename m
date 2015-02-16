From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH] Revert "ACPI / LPSS: Remove non-existing clock control from Intel Lynxpoint I2C"
Date: Mon, 16 Feb 2015 10:26:28 +0200
Message-ID: <1424075188-23834-1-git-send-email-jarkko.nikula@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:43818 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751458AbbBPI0n (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 16 Feb 2015 03:26:43 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Chris Rorvick <chris@rorvick.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>

Revert commit b893e80e3147 ("ACPI / LPSS: Remove non-existing clock control
from Intel Lynxpoint I2C") because it causes touchpad to not load on Dell
XPS13.

Regression is a clear indication that not only some early prototype version
of Lynxpoint I2C but also newer versions can be doing clock gating even
documentation does not state it.

Therefore it is best to revert since this clock gating haven't caused known
issues on those Lynxpoint version which don't do clock gating.

Reported-by: Chris Rorvick <chris@rorvick.com>
Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
For v3.20.
---
 drivers/acpi/acpi_lpss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index 02e835f3cf8a..fa0e3d61e5e7 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -125,7 +125,7 @@ static struct lpss_device_desc lpt_dev_desc = {
 };
 
 static struct lpss_device_desc lpt_i2c_dev_desc = {
-	.flags = LPSS_CLK | LPSS_LTR,
+	.flags = LPSS_CLK | LPSS_CLK_GATE | LPSS_LTR,
 	.prv_offset = 0x800,
 };
 
-- 
2.1.4

