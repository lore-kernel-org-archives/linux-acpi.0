From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: [PATCH] sony-laptop: use NULL for pointer
Date: Tue, 5 Jun 2007 21:43:32 -0700
Message-ID: <20070605214332.6aceb2ec.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from agminet01.oracle.com ([141.146.126.228]:62360 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751160AbXFFEoc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Jun 2007 00:44:32 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: malattia@linux.it, akpm <akpm@linux-foundation.org>

From: Randy Dunlap <randy.dunlap@oracle.com>

Use NULL instead of 0 for pointer:
drivers/misc/sony-laptop.c:1920:6: warning: Using plain integer as NULL pointer

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 drivers/misc/sony-laptop.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-2.6.22-rc3-git7.orig/drivers/misc/sony-laptop.c
+++ linux-2.6.22-rc3-git7/drivers/misc/sony-laptop.c
@@ -1917,7 +1917,8 @@ end:
  */
 static int sony_pic_disable(struct acpi_device *device)
 {
-	if (ACPI_FAILURE(acpi_evaluate_object(device->handle, "_DIS", 0, NULL)))
+	if (ACPI_FAILURE(acpi_evaluate_object(device->handle,
+			"_DIS", NULL, NULL)))
 		return -ENXIO;
 
 	dprintk("Device disabled\n");
