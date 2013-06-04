From: Aaron Lu <aaron.lu@intel.com>
Subject: [PATCH] ACPI: do not match devices that have scan handler
Date: Tue, 04 Jun 2013 13:23:02 +0800
Message-ID: <51AD79B6.6060902@intel.com>
References: <51AC9389.3050603@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:2453 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753954Ab3FDFWl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 4 Jun 2013 01:22:41 -0400
In-Reply-To: <51AC9389.3050603@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Aaron Lu <aaron.lwe@gmail.com>, Zhang Rui <rui.zhang@intel.com>

With the introduction of acpi scan handler, an acpi device that has acpi
scan handler does not need an acpi driver any more. For those devices,
there is no meaning to match them against a newly registered acpi driver
in acpi_bus_match.

This can also solve a regression caused by a broken BIOS table, where it
has defined a _ROM method under PCI root. The video module would think
devices that have _ROM defined under it is a display controller device
since only display devices would have _ROM method defined according to
the ACPI SPEC. As a resule, this method under PCI root would make video
module tries to drive PCI root acpi device and the pre-assigned
driver_data by PCI root's scan handler will be emptied, making subsequent
call to acpi_get_pci_dev fail.

Buglink:https://bugzilla.kernel.org/show_bug.cgi?id=58091
Reported-by: Jason Cassell <bluesloth600@gmail.com>
Reported-and-bisected-by: Dmitry S. Demin <dmitryy.demin@gmail.com>
Cc: stable@kernel.org
Signed-off-by: Aaron Lu <aaron.lu@intel.com>
---
 drivers/acpi/scan.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 5e7e991..67ce501 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -553,6 +553,12 @@ static int acpi_bus_match(struct device *dev, struct device_driver *drv)
 	struct acpi_device *acpi_dev = to_acpi_device(dev);
 	struct acpi_driver *acpi_drv = to_acpi_driver(drv);
 
+	/* No need to bind driver for devices that have scan handler */
+	if (acpi_dev->handler)
+		return 0;
+
+	WARN_ON(acpi_dev->driver_data);
+
 	return acpi_dev->flags.match_driver
 		&& !acpi_match_device_ids(acpi_dev, acpi_drv->ids);
 }
-- 
1.8.3.3.gfada522

