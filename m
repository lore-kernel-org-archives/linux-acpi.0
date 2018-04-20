From: John Garry <john.garry@huawei.com>
Subject: [RFC PATCH 1/2] ACPI / PNP: Don't add "enumeration_by_parent" devices
Date: Fri, 20 Apr 2018 18:07:25 +0800
Message-ID: <1524218846-169934-2-git-send-email-john.garry@huawei.com>
References: <1524218846-169934-1-git-send-email-john.garry@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1524218846-169934-1-git-send-email-john.garry@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, andriy.shevchenko@linux.intel.com, linux-acpi@vger.kernel.org, lenb@kernel.org, mika.westerberg@linux.intel.com, lorenzo.pieralisi@arm.com
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, graeme.gregory@linaro.org, helgaas@kernel.org, linuxarm@huawei.com, z.liuxinliang@hisilicon.com, John Garry <john.garry@huawei.com>
List-Id: linux-acpi@vger.kernel.org

For ACPI devices with the enumeration_by_parent flag set,
we expect the parent device to enumerate the device after
the ACPI scan.

This patch does partially the same for devices which are
enumerated as PNP devices.

We still want PNP scan code to create the per-ACPI device
PNP device, but hold off adding the device to allow the
parent to do this optionally.

Flag acpi_device.driver_data is used as temp store as a
reference to the PNP device for the parent.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/pnp/pnpacpi/core.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/pnp/pnpacpi/core.c b/drivers/pnp/pnpacpi/core.c
index 3a4c1aa..92f9d6f 100644
--- a/drivers/pnp/pnpacpi/core.c
+++ b/drivers/pnp/pnpacpi/core.c
@@ -285,10 +285,14 @@ static int __init pnpacpi_add_device(struct acpi_device *device)
 	if (!dev->active)
 		pnp_init_resources(dev);
 
-	error = pnp_add_device(dev);
-	if (error) {
-		put_device(&dev->dev);
-		return error;
+	if (!device->flags.enumeration_by_parent) {
+		error = pnp_add_device(dev);
+		if (error) {
+			put_device(&dev->dev);
+			return error;
+		}
+	} else {
+		device->driver_data = dev;
 	}
 
 	num++;
-- 
1.9.1
