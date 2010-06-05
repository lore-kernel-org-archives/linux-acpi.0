From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 2/2] PNPACPI: check return value of pnp_add_device()
Date: Fri, 04 Jun 2010 19:24:10 -0700
Message-ID: <20100605022410.25768.42826.stgit@localhost.localdomain>
References: <20100605022058.25768.77560.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:32921 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755236Ab0FECYN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Jun 2010 22:24:13 -0400
In-Reply-To: <20100605022058.25768.77560.stgit@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

pnp_add_device() may fail so we need to ihandle errors and avoid leaking
memory. Also, do not use ACPI-specific return codes (AE_OK) but rather
standard ones.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/pnp/pnpacpi/core.c |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/pnp/pnpacpi/core.c b/drivers/pnp/pnpacpi/core.c
index 2029cb5..8c5142d 100644
--- a/drivers/pnp/pnpacpi/core.c
+++ b/drivers/pnp/pnpacpi/core.c
@@ -171,8 +171,9 @@ static char *pnpacpi_get_id(struct acpi_device *device)
 
 static int __init pnpacpi_add_device(struct acpi_device *device)
 {
-	acpi_handle temp = NULL;
+	acpi_handle temp;
 	acpi_status status;
+	int error;
 	struct pnp_dev *dev;
 	char *pnpid;
 	struct acpi_hardware_id *id;
@@ -233,10 +234,16 @@ static int __init pnpacpi_add_device(struct acpi_device *device)
 	/* clear out the damaged flags */
 	if (!dev->active)
 		pnp_init_resources(dev);
-	pnp_add_device(dev);
+
+	error = pnp_add_device(dev);
+	if (error) {
+		put_device(&dev->dev);
+		return error;
+	}
+
 	num++;
 
-	return AE_OK;
+	return 0;
 }
 
 static acpi_status __init pnpacpi_add_device_handler(acpi_handle handle,

