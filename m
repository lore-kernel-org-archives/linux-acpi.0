From: Len Brown <lenb@kernel.org>
Subject: [PATCH 30/49] xo15-ebook: convert to module_acpi_driver()
Date: Sat,  6 Oct 2012 16:09:51 -0400
Message-ID: <a509d228b690b2850fa70bef8de042d42ffe5acd.1349554106.git.len.brown@intel.com>
References: <1349554210-29978-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:35485 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751613Ab2JFUTF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 6 Oct 2012 16:19:05 -0400
In-Reply-To: <1349554210-29978-1-git-send-email-lenb@kernel.org>
In-Reply-To: <a950c135e5b2be6ef7518d54d98a7901db1b377a.1349554105.git.len.brown@intel.com>
References: <a950c135e5b2be6ef7518d54d98a7901db1b377a.1349554105.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Len Brown <len.brown@intel.com>

From: Mika Westerberg <mika.westerberg@linux.intel.com>

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/xo15-ebook.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/platform/x86/xo15-ebook.c b/drivers/platform/x86/xo15-ebook.c
index 38ba39d..16d340c 100644
--- a/drivers/platform/x86/xo15-ebook.c
+++ b/drivers/platform/x86/xo15-ebook.c
@@ -170,16 +170,4 @@ static struct acpi_driver xo15_ebook_driver = {
 	},
 	.drv.pm = &ebook_switch_pm,
 };
-
-static int __init xo15_ebook_init(void)
-{
-	return acpi_bus_register_driver(&xo15_ebook_driver);
-}
-
-static void __exit xo15_ebook_exit(void)
-{
-	acpi_bus_unregister_driver(&xo15_ebook_driver);
-}
-
-module_init(xo15_ebook_init);
-module_exit(xo15_ebook_exit);
+module_acpi_driver(xo15_ebook_driver);
-- 
1.8.0.rc0.18.gf84667d

