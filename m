From: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
Subject: [PATCH] ACPI: bus.c: Let acpi_device_get_match_data() return DT
 compatibility data
Date: Tue, 3 Jul 2018 08:09:24 +0200
Message-ID: <20180704102240.2C00942D43@mail.steuer-voss.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>, Ray Jui <ray.jui@broadcom.com>, Vladimir Olovyannikov <vladimir.olovyannikov@broadcom.com>, Vikram Prakash <vikram.prakash@broadcom.com>, Scott Branden <scott.branden@broadcom.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinath Mannam <srinath.mannam@broadcom.com>, nv@vosn.de
List-Id: linux-acpi@vger.kernel.org

When using ACPI with ACPI_DT_NAMESPACE_HID/ PRP0001 HID and referring to
of_device_id table "compatible" strings in DSD, a pointer to the
corresponding DT table entry should be returned instead of a null
pointer. An acpi_device_id match still takes precedence.

Signed-off-by: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
---
 drivers/acpi/bus.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 84b4a62018eb..c2deffea842e 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -832,13 +832,18 @@ EXPORT_SYMBOL_GPL(acpi_match_device);
 
 const void *acpi_device_get_match_data(const struct device *dev)
 {
-	const struct acpi_device_id *match;
+	const struct acpi_device_id *acpi_id = NULL;
+	const struct of_device_id *of_id = NULL;
+	const struct device_driver *drv = dev->driver;
 
-	match = acpi_match_device(dev->driver->acpi_match_table, dev);
-	if (!match)
+	__acpi_match_device(acpi_companion_match(dev), drv->acpi_match_table,
+			    drv->of_match_table, &acpi_id, &of_id);
+	if (acpi_id)
+		return (const void*)acpi_id->driver_data;
+	else if (of_id)
+		return (const void*)of_id->data;
+	else
 		return NULL;
-
-	return (const void *)match->driver_data;
 }
 EXPORT_SYMBOL_GPL(acpi_device_get_match_data);
 
-- 
2.17.1
