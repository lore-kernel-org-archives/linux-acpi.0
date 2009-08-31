From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 2 03/19] ACPI: don't pass handle for fixed hardware
	notifications
Date: Mon, 31 Aug 2009 16:32:20 -0600
Message-ID: <20090831223220.11814.36037.stgit@bob.kio>
References: <20090831223053.11814.38463.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0007.atlanta.hp.com ([15.192.0.44]:9667 "EHLO
	g5t0007.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752036AbZHaWcO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 31 Aug 2009 18:32:14 -0400
In-Reply-To: <20090831223053.11814.38463.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

Fixed hardware devices have no handles, so just pass an explicit
NULL rather than something that looks like it might be meaningful.
acpi_device_notify() doesn't need the handle anyway; the only
reason it takes it as an argument is because the acpi_notify_handler
typedef requires it.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 drivers/acpi/scan.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 3ceebfe..e680306 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -366,7 +366,8 @@ static acpi_status acpi_device_notify_fixed(void *data)
 {
 	struct acpi_device *device = data;
 
-	acpi_device_notify(device->handle, ACPI_FIXED_HARDWARE_EVENT, device);
+	/* Fixed hardware devices have no handles */
+	acpi_device_notify(NULL, ACPI_FIXED_HARDWARE_EVENT, device);
 	return AE_OK;
 }
 

