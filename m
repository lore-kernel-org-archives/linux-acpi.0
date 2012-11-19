From: Bill Pemberton <wfp5p@virginia.edu>
Subject: [PATCH 387/493] acpi: remove use of __devexit
Date: Mon, 19 Nov 2012 13:25:36 -0500
Message-ID: <1353349642-3677-387-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from viridian.itc.Virginia.EDU ([128.143.12.139]:42013 "EHLO
	viridian.itc.virginia.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754230Ab2KSSr7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 19 Nov 2012 13:47:59 -0500
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-acpi@vger.kernel.org

CONFIG_HOTPLUG is going away as an option so __devexit is no
longer needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: linux-acpi@vger.kernel.org 
---
 drivers/acpi/apei/ghes.c | 2 +-
 drivers/acpi/hed.c       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 73bca11..7ae2750 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -994,7 +994,7 @@ err:
 	return rc;
 }
 
-static int __devexit ghes_remove(struct platform_device *ghes_dev)
+static int ghes_remove(struct platform_device *ghes_dev)
 {
 	struct ghes *ghes;
 	struct acpi_hest_generic *generic;
diff --git a/drivers/acpi/hed.c b/drivers/acpi/hed.c
index 0ec28a3..a0cc796 100644
--- a/drivers/acpi/hed.c
+++ b/drivers/acpi/hed.c
@@ -70,7 +70,7 @@ static int acpi_hed_add(struct acpi_device *device)
 	return 0;
 }
 
-static int __devexit acpi_hed_remove(struct acpi_device *device, int type)
+static int acpi_hed_remove(struct acpi_device *device, int type)
 {
 	hed_handle = NULL;
 	return 0;
-- 
1.8.0

