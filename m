From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 07/19] ACPI: save device_type in acpi_device
Date: Fri, 31 Jul 2009 15:37:09 -0600
Message-ID: <20090731213709.29930.57436.stgit@bob.kio>
References: <20090731213501.29930.39957.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0028.austin.hp.com ([15.216.28.35]:43727 "EHLO
	g1t0028.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752832AbZGaVhJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 31 Jul 2009 17:37:09 -0400
In-Reply-To: <20090731213501.29930.39957.stgit@bob.kio>
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
index aade372..b386589 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1188,6 +1188,7 @@ acpi_add_single_object(struct acpi_device **child,
 		return -ENOMEM;
 	}
 
+	device->device_type = type;
 	device->handle = handle;
 	device->parent = parent;
 	device->bus_ops = *ops; /* workround for not call .start */
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 79a6c5e..b145270 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -266,7 +266,8 @@ struct acpi_device_wakeup {
 /* Device */
 
 struct acpi_device {
-	acpi_handle handle;
+	int device_type;
+	acpi_handle handle;		/* no handle for fixed hardware */
 	struct acpi_device *parent;
 	struct list_head children;
 	struct list_head node;

