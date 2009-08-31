From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 2 11/19] ACPI: remove unnecessary argument checking
Date: Mon, 31 Aug 2009 16:33:01 -0600
Message-ID: <20090831223301.11814.5216.stgit@bob.kio>
References: <20090831223053.11814.38463.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0027.austin.hp.com ([15.216.28.34]:6075 "EHLO
	g1t0027.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752103AbZHaWcy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 31 Aug 2009 18:32:54 -0400
In-Reply-To: <20090831223053.11814.38463.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

acpi_add_single_object() is static, and all callers supply a valid "child"
argument, so we don't need to check it.  This patch also remove some
unnecessary initializations.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 drivers/acpi/scan.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index f86dee8..f54632c 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1215,14 +1215,10 @@ acpi_add_single_object(struct acpi_device **child,
 		       struct acpi_device *parent, acpi_handle handle, int type,
 			struct acpi_bus_ops *ops)
 {
-	int result = 0;
-	struct acpi_device *device = NULL;
+	int result;
+	struct acpi_device *device;
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 
-
-	if (!child)
-		return -EINVAL;
-
 	device = kzalloc(sizeof(struct acpi_device), GFP_KERNEL);
 	if (!device) {
 		printk(KERN_ERR PREFIX "Memory allocation error\n");

