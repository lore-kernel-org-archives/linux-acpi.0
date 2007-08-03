From: Mattia Dongili <malattia@linux.it>
Subject: [PATCH 3/3] sonypi: fix ids member of struct acpi_driver
Date: Sat,  4 Aug 2007 00:22:32 +0900
Message-ID: <11861545522290-git-send-email-malattia@linux.it>
References: <118615455219-git-send-email-malattia@linux.it>
 <1186154552588-git-send-email-malattia@linux.it>
 <11861545523738-git-send-email-malattia@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mtoichi14.ns.itscom.net ([219.110.2.184]:62141 "EHLO
	mtoichi14.ns.itscom.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761477AbXHCPWz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Aug 2007 11:22:55 -0400
In-Reply-To: <11861545523738-git-send-email-malattia@linux.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Stelian Pop <stelian@popies.net>, Eugene Teo <eugeneteo@kernel.sg>, Mattia Dongili <malattia@linux.it>

From: Eugene Teo <eugeneteo@kernel.sg>

ids member of struct acpi_driver is of type struct acpi_device_id, not a
character array.

Signed-off-by: Eugene Teo <eugeneteo@kernel.sg>
Signed-off-by: Mattia Dongili <malattia@linux.it>
---
 drivers/char/sonypi.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/char/sonypi.c b/drivers/char/sonypi.c
index 73037a4..aeec67e 100644
--- a/drivers/char/sonypi.c
+++ b/drivers/char/sonypi.c
@@ -1147,10 +1147,15 @@ static int sonypi_acpi_remove(struct acpi_device *device, int type)
 	return 0;
 }
 
+const static struct acpi_device_id sonypi_device_ids[] = {
+	{"SNY6001", 0},
+	{"", 0},
+};
+
 static struct acpi_driver sonypi_acpi_driver = {
 	.name           = "sonypi",
 	.class          = "hkey",
-	.ids            = "SNY6001",
+	.ids            = sonypi_device_ids,
 	.ops            = {
 		           .add = sonypi_acpi_add,
 			   .remove = sonypi_acpi_remove,
-- 
1.5.2.4

