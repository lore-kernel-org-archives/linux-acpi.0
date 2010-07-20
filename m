From: akpm@linux-foundation.org
Subject: [patch 11/26] asus_acpi: fix coding style to improve readability
Date: Tue, 20 Jul 2010 15:19:42 -0700
Message-ID: <201007202219.o6KMJgb8021028@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:57292 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932948Ab0GTWki (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 20 Jul 2010 18:40:38 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: mjg59@srcf.ucam.org
Cc: platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, akpm@linux-foundation.org, axel.lin@gmail.com, corentincj@iksaif.net, len.brown@intel.com, mjg@redhat.com, sziwan@users.sourceforge.net

From: Axel Lin <axel.lin@gmail.com>

In the case of no match ( hotk->model == END_MODEL ), the only posible
case to return 0 is to have a Samsung P30 detected.  This patch improves
readability by moving related code after if/else clause to be inside if
clause.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
Cc: Corentin Chary <corentincj@iksaif.net>
Cc: Karol Kozimor <sziwan@users.sourceforge.net>
Cc: Matthew Garrett <mjg@redhat.com>
Cc: Len Brown <len.brown@intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/platform/x86/asus_acpi.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff -puN drivers/platform/x86/asus_acpi.c~asus_acpi-fix-coding-style-to-improve-readability drivers/platform/x86/asus_acpi.c
--- a/drivers/platform/x86/asus_acpi.c~asus_acpi-fix-coding-style-to-improve-readability
+++ a/drivers/platform/x86/asus_acpi.c
@@ -1330,6 +1330,9 @@ static int asus_hotk_get_info(void)
 			hotk->model = P30;
 			printk(KERN_NOTICE
 			       "  Samsung P30 detected, supported\n");
+			hotk->methods = &model_conf[hotk->model];
+			kfree(model);
+			return 0;
 		} else {
 			hotk->model = M2E;
 			printk(KERN_NOTICE "  unsupported model %s, trying "
@@ -1339,9 +1342,6 @@ static int asus_hotk_get_info(void)
 			kfree(model);
 			return -ENODEV;
 		}
-		hotk->methods = &model_conf[hotk->model];
-		kfree(model);
-		return 0;
 	}
 	hotk->methods = &model_conf[hotk->model];
 	printk(KERN_NOTICE "  %s model detected, supported\n", string);
_
