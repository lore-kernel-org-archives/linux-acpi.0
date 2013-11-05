From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch 2/2] ACPI, extlog: remove unneeded NULL check
Date: Tue, 5 Nov 2013 23:20:07 +0300
Message-ID: <20131105202007.GB3949@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:33901 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754403Ab3KEUUX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Nov 2013 15:20:23 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, Chen@elgon.mountain, Gong <gong.chen@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, kernel-janitors@vger.kernel.org

We dereference extlog_l1_addr so the check is too late.  The
"extlog_l1_addr" pointer can never be NULL when this function is called
so I have removed the check.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
index c4d5e59..d59e4bb 100644
--- a/drivers/acpi/acpi_extlog.c
+++ b/drivers/acpi/acpi_extlog.c
@@ -308,8 +308,7 @@ static void __exit extlog_exit(void)
 {
 	mce_unregister_decode_chain(&extlog_mce_dec);
 	((struct extlog_l1_head *)extlog_l1_addr)->flags &= ~FLAG_OS_OPTIN;
-	if (extlog_l1_addr)
-		acpi_os_unmap_memory(extlog_l1_addr, l1_size);
+	acpi_os_unmap_memory(extlog_l1_addr, l1_size);
 	if (elog_addr)
 		acpi_os_unmap_memory(elog_addr, elog_size);
 	release_mem_region(elog_base, elog_size);
