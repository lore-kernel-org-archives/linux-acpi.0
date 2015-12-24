From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch 1/2] ACPI / debugger: remove some unneeded conditions
Date: Thu, 24 Dec 2015 10:23:03 +0300
Message-ID: <20151224072303.GA29642@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:41718 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752172AbbLXHXi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Dec 2015 02:23:38 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lv Zheng <lv.zheng@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

"count" is unsigned so checking for less than zero here causes a static
checker warning.  And really it's better to let the access_ok() check
fail if the user passes in a NULL "buf" pointer because -EFAULT is the
correct error code.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/acpi/acpi_dbg.c b/drivers/acpi/acpi_dbg.c
index 381beb2..f2c92ab 100644
--- a/drivers/acpi/acpi_dbg.c
+++ b/drivers/acpi/acpi_dbg.c
@@ -610,8 +610,6 @@ static ssize_t acpi_aml_read(struct file *file, char __user *buf,
 	int ret = 0;
 	int size = 0;
 
-	if (!buf || count < 0)
-		return -EINVAL;
 	if (!count)
 		return 0;
 	if (!access_ok(VERIFY_WRITE, buf, count))
@@ -681,8 +679,6 @@ static ssize_t acpi_aml_write(struct file *file, const char __user *buf,
 	int ret = 0;
 	int size = 0;
 
-	if (!buf || count < 0)
-		return -EINVAL;
 	if (!count)
 		return 0;
 	if (!access_ok(VERIFY_READ, buf, count))
