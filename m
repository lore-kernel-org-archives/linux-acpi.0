From: Tom Todd <thomas.m.a.todd@gmail.com>
Subject: [PATCH] acpi: bus: Fixed a pointer coding style issue
Date: Wed,  8 Aug 2018 01:52:02 +0100
Message-ID: <20180808005202.4011-1-thomas.m.a.todd@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@jwysocki.net, lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Tom Todd <thomas.m.a.todd@gmail.com>
List-Id: linux-acpi@vger.kernel.org

Fixed a coding style issue.

Signed-off-by: Tom Todd <thomas.m.a.todd@gmail.com>
---
 drivers/acpi/bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 84b4a62018eb..73e43d81ec63 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -962,7 +962,7 @@ static int acpi_device_probe(struct device *dev)
 	return 0;
 }
 
-static int acpi_device_remove(struct device * dev)
+static int acpi_device_remove(struct device *dev)
 {
 	struct acpi_device *acpi_dev = to_acpi_device(dev);
 	struct acpi_driver *acpi_drv = acpi_dev->driver;
-- 
2.18.0
