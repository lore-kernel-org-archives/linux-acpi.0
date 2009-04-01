From: Mattia Dongili <malattia@linux.it>
Subject: [PATCH 1/4] sony-laptop: Fix some typos in log messages (Unabe/Unable)
Date: Wed,  1 Apr 2009 22:10:44 +0900
Message-ID: <1238591447-13338-2-git-send-email-malattia@linux.it>
References: <1238591447-13338-1-git-send-email-malattia@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static-220-247-10-204.b-man.svips.gol.ne.jp ([220.247.10.204]:56572
	"EHLO smtp.kamineko.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754828AbZDANKt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Apr 2009 09:10:49 -0400
In-Reply-To: <1238591447-13338-1-git-send-email-malattia@linux.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Alessio Igor Bogani <abogani@texware.it>, Mattia Dongili <malattia@linux.it>

From: Alessio Igor Bogani <abogani@texware.it>

Signed-off-by: Alessio Igor Bogani <abogani@texware.it>
Signed-off-by: Mattia Dongili <malattia@linux.it>
---
 drivers/platform/x86/sony-laptop.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
index 0f71031..5837156 100644
--- a/drivers/platform/x86/sony-laptop.c
+++ b/drivers/platform/x86/sony-laptop.c
@@ -397,7 +397,7 @@ static int sony_laptop_setup_input(struct acpi_device *acpi_device)
 	sony_laptop_input.wq = create_singlethread_workqueue("sony-laptop");
 	if (!sony_laptop_input.wq) {
 		printk(KERN_ERR DRV_PFX
-				"Unabe to create workqueue.\n");
+				"Unable to create workqueue.\n");
 		error = -ENXIO;
 		goto err_free_kfifo;
 	}
@@ -1267,7 +1267,7 @@ static int sony_nc_add(struct acpi_device *device)
 	result = sony_laptop_setup_input(device);
 	if (result) {
 		printk(KERN_ERR DRV_PFX
-				"Unabe to create input devices.\n");
+				"Unable to create input devices.\n");
 		goto outwalk;
 	}
 
@@ -2816,7 +2816,7 @@ static int sony_pic_add(struct acpi_device *device)
 	result = sony_pic_possible_resources(device);
 	if (result) {
 		printk(KERN_ERR DRV_PFX
-				"Unabe to read possible resources.\n");
+				"Unable to read possible resources.\n");
 		goto err_free_resources;
 	}
 
@@ -2824,7 +2824,7 @@ static int sony_pic_add(struct acpi_device *device)
 	result = sony_laptop_setup_input(device);
 	if (result) {
 		printk(KERN_ERR DRV_PFX
-				"Unabe to create input devices.\n");
+				"Unable to create input devices.\n");
 		goto err_free_resources;
 	}
 
-- 
1.6.2.1

