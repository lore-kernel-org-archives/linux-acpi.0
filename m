From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 27/53] ACPICA: Core: Always set GPIO VendorOffset
Date: Mon,  5 Jun 2017 16:39:50 +0800
Message-ID: <a2b74d007239637ea8a43d8170f025abe0b8872c.1496650343.git.lv.zheng@intel.com>
References: <cover.1496650343.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:3013 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751771AbdFEIjx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Jun 2017 04:39:53 -0400
In-Reply-To: <cover.1496650343.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Bob Moore <robert.moore@intel.com>

From: Mika Westerberg <mika.westerberg@linux.intel.com>

ACPICA commit 51a92f414de7af1f7f7524de3f61daf5413cac9f

Acpiexec gives this warning when resources containing GPIOs are extracted
using Resource command:

  **** Data mismatch in descriptor [00] type 8C, Offset 00000000 ****
  Mismatch at byte offset 13: is 00, should be 25
  **** Data mismatch in descriptor [01] type 8C, Offset 00000025 ****
  Mismatch at byte offset 13: is 00, should be 25

This happens because we do not set VendorOffset when doing resource to AML
conversion. Fix this by always setting VendorOffset.

Link: https://github.com/acpica/acpica/commit/51a92f41
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/rsmisc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/rsmisc.c b/drivers/acpi/acpica/rsmisc.c
index 2ae79613..cc4b548 100644
--- a/drivers/acpi/acpica/rsmisc.c
+++ b/drivers/acpi/acpica/rsmisc.c
@@ -596,9 +596,7 @@ acpi_rs_convert_resource_to_aml(struct acpi_resource *resource,
 
 			/* Set vendor offset only if there is vendor data */
 
-			if (resource->data.gpio.vendor_length) {
-				ACPI_SET16(target, aml_length);
-			}
+			ACPI_SET16(target, aml_length);
 
 			acpi_rs_set_resource_length(aml_length, aml);
 			break;
-- 
2.7.4

