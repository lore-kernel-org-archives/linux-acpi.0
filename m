From: akpm@linux-foundation.org
Subject: [patch 18/26] acerhdf: fix resource reclaim in error path
Date: Tue, 20 Jul 2010 15:19:49 -0700
Message-ID: <201007202219.o6KMJn6w021071@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:48347 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932959Ab0GTWkn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 20 Jul 2010 18:40:43 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: mjg59@srcf.ucam.org
Cc: platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, akpm@linux-foundation.org, axel.lin@gmail.com, bp@alien8.de, mjg@redhat.com, peter@piie.net

From: Axel Lin <axel.lin@gmail.com>

Fix resource reclaim in below cases:

1. acerhdf_register_platform() does not properly handle
   platform_device_alloc() failure and platform_device_add() failure This
   patch adds error handing for acerhdf_register_platform().

2. acerhdf_register_platform() return err with acerhdf_dev == NULL. 
   as a result, acerhdf_unregister_platform() does not do resource reclaim
   in acerhdf_init() error path.  This patch adds error handing for
   acerhdf_register_platform(), thus correct the error handing path in
   acerhdf_init().  goto out_err instead of err_unreg if
   acerhdf_register_platform() fail.

3. platform_device_del() should only used in error handling.  Current
   implementation missed a platform_device_put() in acerhdf_exit.  This
   patch fixes it by using platform_device_unregister() instead of
   platform_device_del() in acerhdf_unregister_platform.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
Acked-by: Peter Feuerer <peter@piie.net>
Cc: Matthew Garrett <mjg@redhat.com>
Acked-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/platform/x86/acerhdf.c |   23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff -puN drivers/platform/x86/acerhdf.c~acerhdf-fix-resource-reclaim-in-error-path drivers/platform/x86/acerhdf.c
--- a/drivers/platform/x86/acerhdf.c~acerhdf-fix-resource-reclaim-in-error-path
+++ a/drivers/platform/x86/acerhdf.c
@@ -615,17 +615,26 @@ static int acerhdf_register_platform(voi
 		return err;
 
 	acerhdf_dev = platform_device_alloc("acerhdf", -1);
-	platform_device_add(acerhdf_dev);
+	if (!acerhdf_dev) {
+		err = -ENOMEM;
+		goto err_device_alloc;
+	}
+	err = platform_device_add(acerhdf_dev);
+	if (err)
+		goto err_device_add;
 
 	return 0;
+
+err_device_add:
+	platform_device_put(acerhdf_dev);
+err_device_alloc:
+	platform_driver_unregister(&acerhdf_driver);
+	return err;
 }
 
 static void acerhdf_unregister_platform(void)
 {
-	if (!acerhdf_dev)
-		return;
-
-	platform_device_del(acerhdf_dev);
+	platform_device_unregister(acerhdf_dev);
 	platform_driver_unregister(&acerhdf_driver);
 }
 
@@ -669,7 +678,7 @@ static int __init acerhdf_init(void)
 
 	err = acerhdf_register_platform();
 	if (err)
-		goto err_unreg;
+		goto out_err;
 
 	err = acerhdf_register_thermal();
 	if (err)
@@ -682,7 +691,7 @@ err_unreg:
 	acerhdf_unregister_platform();
 
 out_err:
-	return -ENODEV;
+	return err;
 }
 
 static void __exit acerhdf_exit(void)
_
