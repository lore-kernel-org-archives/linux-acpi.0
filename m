From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 7/9] ACPI: EC: remove .start() method
Date: Fri, 19 Jun 2009 15:32:09 -0600
Message-ID: <20090619213209.18001.27739.stgit@bob.kio>
References: <20090619213038.18001.16533.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0017.houston.hp.com ([15.201.24.20]:47550 "EHLO
	g4t0017.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752698AbZFSVcH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Jun 2009 17:32:07 -0400
In-Reply-To: <20090619213038.18001.16533.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Alexey Starikovskiy <astarikovskiy@suse.de>, Alex Chiang <achiang@hp.com>

This patch folds the .start() method into .add().

acpi_ec_start() is always called immediately after acpi_ec_add(),
so there's no need to have it be a separate method.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Reviewed-by: Alex Chiang <achiang@hp.com>
CC: Alexey Starikovskiy <astarikovskiy@suse.de>
---
 drivers/acpi/ec.c |   19 +------------------
 1 files changed, 1 insertions(+), 18 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 8b387a4..1feedce 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -838,9 +838,8 @@ static void ec_remove_handlers(struct acpi_ec *ec)
 static int acpi_ec_add(struct acpi_device *device)
 {
 	struct acpi_ec *ec = NULL;
+	int ret;
 
-	if (!device)
-		return -EINVAL;
 	strcpy(acpi_device_name(device), ACPI_EC_DEVICE_NAME);
 	strcpy(acpi_device_class(device), ACPI_EC_CLASS);
 
@@ -875,21 +874,6 @@ static int acpi_ec_add(struct acpi_device *device)
 			  ec->gpe, ec->command_addr, ec->data_addr);
 	pr_info(PREFIX "driver started in %s mode\n",
 		(test_bit(EC_FLAGS_GPE_MODE, &ec->flags))?"interrupt":"poll");
-	return 0;
-}
-
-static int acpi_ec_start(struct acpi_device *device)
-{
-	struct acpi_ec *ec;
-	int ret = 0;
-
-	if (!device)
-		return -EINVAL;
-
-	ec = acpi_driver_data(device);
-
-	if (!ec)
-		return -EINVAL;
 
 	ret = ec_install_handlers(ec);
 
@@ -1077,7 +1061,6 @@ static struct acpi_driver acpi_ec_driver = {
 	.ops = {
 		.add = acpi_ec_add,
 		.remove = acpi_ec_remove,
-		.start = acpi_ec_start,
 		.stop = acpi_ec_stop,
 		.suspend = acpi_ec_suspend,
 		.resume = acpi_ec_resume,

