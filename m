From: "Chen, Gong" <gong.chen@linux.intel.com>
Subject: [PATCH 2/2] acpi, apei, bert: Clear error status at the end of error handling
Date: Thu,  7 May 2015 10:57:31 -0400
Message-ID: <1431010651-23117-3-git-send-email-gong.chen@linux.intel.com>
References: <1431010651-23117-1-git-send-email-gong.chen@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:32261 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751109AbbEGCDi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 6 May 2015 22:03:38 -0400
In-Reply-To: <1431010651-23117-1-git-send-email-gong.chen@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Tomasz Nowicki <tomasz.nowicki@linaro.org>, "Chen, Gong" <gong.chen@linux.intel.com>, Tony Luck <tony.luck@intel.com>

From: Tomasz Nowicki <tomasz.nowicki@linaro.org>

Once error log is printed out clear error status so it would not be
print during next boot again.

Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Signed-off-by: Chen, Gong <gong.chen@linux.intel.com>
Tested-by: Jonathan (Zhixiong) Zhang <zjzhang@codeaurora.org>
Cc: Tony Luck <tony.luck@intel.com>
---
 drivers/acpi/apei/bert.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/acpi/apei/bert.c b/drivers/acpi/apei/bert.c
index c35a748a2be5..3e608e8f2dd7 100644
--- a/drivers/acpi/apei/bert.c
+++ b/drivers/acpi/apei/bert.c
@@ -65,6 +65,9 @@ static void __init bert_print_all(struct acpi_hest_generic_status *region,
 			first = 0;
 		}
 		cper_estatus_print(KERN_INFO HW_ERR, estatus);
+
+		/* Clear error status */
+		estatus->block_status = 0;
 next:
 		estatus = (void *)estatus + estatus_len;
 		remain -= estatus_len;
-- 
2.3.2

