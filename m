From: Chen Gong <gong.chen@linux.intel.com>
Subject: [PATCH] ACPI, APEI, EINJ, limit the range of einj_param
Date: Tue, 28 Feb 2012 16:44:55 +0800
Message-ID: <1330418695-8005-1-git-send-email-gong.chen@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:42831 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756862Ab2B1IoI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 28 Feb 2012 03:44:08 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: tony.luck@intel.com, ying.huang@intel.com
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, Chen Gong <gong.chen@linux.intel.com>

On the platforms with ACPI4.x support, parameter extension
is not always doable, which means only parameter extension
is enabled, einj_param can take effect.

Signed-off-by: Chen Gong <gong.chen@linux.intel.com>
---
 drivers/acpi/apei/einj.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
index 4ca087d..0323684 100644
--- a/drivers/acpi/apei/einj.c
+++ b/drivers/acpi/apei/einj.c
@@ -466,7 +466,7 @@ static int __einj_error_inject(u32 type, u64 param1, u64 param2)
 		rc = apei_exec_run(&ctx, ACPI_EINJ_SET_ERROR_TYPE);
 		if (rc)
 			return rc;
-		if (einj_param) {
+		if (param_extension && einj_param) {
 			struct einj_parameter *v4param = einj_param;
 			v4param->param1 = param1;
 			v4param->param2 = param2;
-- 
1.7.8.2.302.g17b4e

