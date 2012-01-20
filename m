From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ACPI, APEI, EINJ, cleanup 0 vs NULL confusion
Date: Fri, 20 Jan 2012 10:57:14 +0300
Message-ID: <20120120075714.GD2295@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:56246 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752324Ab2ATH5H (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Jan 2012 02:57:07 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Huang Ying <ying.huang@intel.com>, Tony Luck <tony.luck@intel.com>, linux-acpi@vger.kernel.org, kernel-janitors@vger.kernel.org

This function is returning pointers.  Sparse complains here:
drivers/acpi/apei/einj.c:262:32: warning:
	Using plain integer as NULL pointer

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
index bb20b03..c89b0e5 100644
--- a/drivers/acpi/apei/einj.c
+++ b/drivers/acpi/apei/einj.c
@@ -259,15 +259,15 @@ static void *einj_get_parameter_address(void)
 
 		v4param = ioremap(paddrv4, sizeof(*v4param));
 		if (!v4param)
-			return 0;
+			return NULL;
 		if (readq(&v4param->reserved1) || readq(&v4param->reserved2)) {
 			iounmap(v4param);
-			return 0;
+			return NULL;
 		}
 		return v4param;
 	}
 
-	return 0;
+	return NULL;
 }
 
 /* do sanity check to trigger table */
