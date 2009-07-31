From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 03/19] ACPI: don't pass handle for fixed hardware notifications
Date: Fri, 31 Jul 2009 15:36:48 -0600
Message-ID: <20090731213648.29930.29139.stgit@bob.kio>
References: <20090731213501.29930.39957.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0017.houston.hp.com ([15.201.24.20]:32304 "EHLO
	g4t0017.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753068AbZGaVgu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 31 Jul 2009 17:36:50 -0400
In-Reply-To: <20090731213501.29930.39957.stgit@bob.kio>
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
index 4a89f08..652d104 100644
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
 

