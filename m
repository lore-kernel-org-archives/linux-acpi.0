From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH v3 05/17] ACPI: save device_type in acpi_device
Date: Mon, 21 Sep 2009 13:29:10 -0600
Message-ID: <20090921192910.21322.13930.stgit@bob.kio>
References: <20090921192656.21322.23072.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0014.houston.hp.com ([15.201.24.17]:2445 "EHLO
	g4t0014.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753348AbZIUT3G (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Sep 2009 15:29:06 -0400
In-Reply-To: <20090921192656.21322.23072.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

Most uses of the ACPI bus device_type (ACPI_BUS_TYPE_DEVICE,
ACPI_BUS_TYPE_POWER, etc) are during device initialization, but
we do need it later for notify handler installation, since that
is different for fixed hardware devices vs. namespace devices.

This patch saves the device_type in the acpi_device structure,
so we can check that rather than comparing against the _HID string.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 drivers/acpi/scan.c     |    1 +
 include/acpi/acpi_bus.h |    3 ++-
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index ab5a264..c73681b 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1240,6 +1240,7 @@ acpi_add_single_object(struct acpi_device **child,
 		return -ENOMEM;
 	}
 
+	device->device_type = type;
 	device->handle = handle;
 	device->parent = parent;
 	device->bus_ops = *ops; /* workround for not call .start */
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 89bbb2a..8e39b3e 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -262,7 +262,8 @@ struct acpi_device_wakeup {
 /* Device */
 
 struct acpi_device {
-	acpi_handle handle;
+	int device_type;
+	acpi_handle handle;		/* no handle for fixed hardware */
 	struct acpi_device *parent;
 	struct list_head children;
 	struct list_head node;

