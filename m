From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH] ACPI / APEI: fix error return code in einj_init()
Date: Wed, 5 Jun 2013 10:17:35 +0800
Message-ID: <CAPgLHd-uB=hWRNCgoUhzFzsjQiPj1cuedUk0ttu1g7UXAx=3=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-we0-f181.google.com ([74.125.82.181]:44982 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751676Ab3FECRg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 4 Jun 2013 22:17:36 -0400
Received: by mail-we0-f181.google.com with SMTP id p58so853055wes.12
        for <linux-acpi@vger.kernel.org>; Tue, 04 Jun 2013 19:17:35 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, rjw@sisk.pl, gong.chen@linux.intel.com, tony.luck@intel.com
Cc: yongjun_wei@trendmicro.com.cn, linux-acpi@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Fix to return -ENOMEM in the debugfs_create_xxx() error handling
case instead of 0, as done elsewhere in this function.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/acpi/apei/einj.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
index 9a47d85..9d60bdd 100644
--- a/drivers/acpi/apei/einj.c
+++ b/drivers/acpi/apei/einj.c
@@ -732,6 +732,7 @@ static int __init einj_init(void)
 	if (rc)
 		goto err_release;
 
+	rc = -ENOMEM;
 	einj_param = einj_get_parameter_address();
 	if ((param_extension || acpi5) && einj_param) {
 		fentry = debugfs_create_x64("param1", S_IRUSR | S_IWUSR,

