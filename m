From: Chen Gong <gong.chen@linux.intel.com>
Subject: [PATCH] ACPI/APEI: fix error status check condition for CPER
Date: Tue, 19 Mar 2013 02:48:07 -0400
Message-ID: <1363675687-7839-1-git-send-email-gong.chen@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:2810 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753868Ab3CSGvO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 19 Mar 2013 02:51:14 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ying.huang@intel.com
Cc: tony.luck@intel.com, linux-acpi@vger.kernel.org, rjw@sisk.pl, Chen Gong <gong.chen@linux.intel.com>

In Table 18-289, ACPI5.0 SPEC, the error data length in CPER
Generic Error Data Entry can be 0, which means this generic
error data entry can have only one header. So fix the check
conditon for it.

Signed-off-by: Chen Gong <gong.chen@linux.intel.com>
---
 drivers/acpi/apei/cper.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/cper.c b/drivers/acpi/apei/cper.c
index 1e5d8a4..fefc2ca 100644
--- a/drivers/acpi/apei/cper.c
+++ b/drivers/acpi/apei/cper.c
@@ -405,7 +405,7 @@ int apei_estatus_check(const struct acpi_hest_generic_status *estatus)
 		return rc;
 	data_len = estatus->data_length;
 	gdata = (struct acpi_hest_generic_data *)(estatus + 1);
-	while (data_len > sizeof(*gdata)) {
+	while (data_len >= sizeof(*gdata)) {
 		gedata_len = gdata->error_data_length;
 		if (gedata_len > data_len - sizeof(*gdata))
 			return -EINVAL;
-- 
1.7.10.4

