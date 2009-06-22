From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 8/9] ACPI: EC: remove .stop() method
Date: Mon, 22 Jun 2009 14:41:40 -0600
Message-ID: <20090622204140.32761.14300.stgit@bob.kio>
References: <20090622204016.32761.47464.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0017.houston.hp.com ([15.201.24.20]:2689 "EHLO
	g4t0017.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753745AbZFVUlh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 22 Jun 2009 16:41:37 -0400
In-Reply-To: <20090622204016.32761.47464.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Alexey Starikovskiy <astarikovskiy@suse.de>, Alex Chiang <achiang@hp.com>

This patch folds the .stop() method into .remove().

acpi_ec_stop() is only called via acpi_device_probe() and
acpi_device_remove(), and in both cases it is called immediately before
acpi_ec_remove(), so there's no need to have it be a separate method.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Reviewed-by: Alex Chiang <achiang@hp.com>
CC: Alexey Starikovskiy <astarikovskiy@suse.de>
---
 drivers/acpi/ec.c |   15 +--------------
 1 files changed, 1 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 1feedce..d6bf057 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -891,6 +891,7 @@ static int acpi_ec_remove(struct acpi_device *device, int type)
 		return -EINVAL;
 
 	ec = acpi_driver_data(device);
+	ec_remove_handlers(ec);
 	mutex_lock(&ec->lock);
 	list_for_each_entry_safe(handler, tmp, &ec->list, node) {
 		list_del(&handler->node);
@@ -928,19 +929,6 @@ ec_parse_io_ports(struct acpi_resource *resource, void *context)
 	return AE_OK;
 }
 
-static int acpi_ec_stop(struct acpi_device *device, int type)
-{
-	struct acpi_ec *ec;
-	if (!device)
-		return -EINVAL;
-	ec = acpi_driver_data(device);
-	if (!ec)
-		return -EINVAL;
-	ec_remove_handlers(ec);
-
-	return 0;
-}
-
 int __init acpi_boot_ec_enable(void)
 {
 	if (!boot_ec || test_bit(EC_FLAGS_HANDLERS_INSTALLED, &boot_ec->flags))
@@ -1061,7 +1049,6 @@ static struct acpi_driver acpi_ec_driver = {
 	.ops = {
 		.add = acpi_ec_add,
 		.remove = acpi_ec_remove,
-		.stop = acpi_ec_stop,
 		.suspend = acpi_ec_suspend,
 		.resume = acpi_ec_resume,
 		},

