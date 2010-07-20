From: akpm@linux-foundation.org
Subject: [patch 10/26] asus_acpi: fix a memory leak in asus_hotk_get_info()
Date: Tue, 20 Jul 2010 15:19:41 -0700
Message-ID: <201007202219.o6KMJf6c021025@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:50313 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932959Ab0GTWki (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 20 Jul 2010 18:40:38 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: mjg59@srcf.ucam.org
Cc: platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, akpm@linux-foundation.org, axel.lin@gmail.com, corentincj@iksaif.net, len.brown@intel.com, mjg@redhat.com, sziwan@users.sourceforge.net

From: Axel Lin <axel.lin@gmail.com>

In the case of no match ( hotk->model == END_MODEL ), model sholud be
kfreed before return AE_OK.

This patch includes below fixes:

1. adds a missing kfree(model) before return AE_OK.

2. asus_hotk_get_info should return int, thus return 0 instead of AE_OK.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
Cc: Corentin Chary <corentincj@iksaif.net>
Cc: Karol Kozimor <sziwan@users.sourceforge.net>
Cc: Matthew Garrett <mjg@redhat.com>
Cc: Len Brown <len.brown@intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/platform/x86/asus_acpi.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff -puN drivers/platform/x86/asus_acpi.c~asus_acpi-fix-a-memory-leak-in-asus_hotk_get_info drivers/platform/x86/asus_acpi.c
--- a/drivers/platform/x86/asus_acpi.c~asus_acpi-fix-a-memory-leak-in-asus_hotk_get_info
+++ a/drivers/platform/x86/asus_acpi.c
@@ -1340,7 +1340,8 @@ static int asus_hotk_get_info(void)
 			return -ENODEV;
 		}
 		hotk->methods = &model_conf[hotk->model];
-		return AE_OK;
+		kfree(model);
+		return 0;
 	}
 	hotk->methods = &model_conf[hotk->model];
 	printk(KERN_NOTICE "  %s model detected, supported\n", string);
@@ -1374,7 +1375,7 @@ static int asus_hotk_get_info(void)
 
 	kfree(model);
 
-	return AE_OK;
+	return 0;
 }
 
 static int asus_hotk_check(void)
_
