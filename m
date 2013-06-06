From: Aaron Lu <aaron.lu@intel.com>
Subject: [PATCH v2] ACPI / scan: do not match drivers against objects having
 scan handlers
Date: Thu, 06 Jun 2013 10:54:52 +0800
Message-ID: <51AFF9FC.20303@intel.com>
References: <51AC9389.3050603@intel.com> <51AD79B6.6060902@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:47530 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756919Ab3FFCyZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 5 Jun 2013 22:54:25 -0400
In-Reply-To: <51AD79B6.6060902@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Jason Cassell <bluesloth600@gmail.com>, "Dmitry S. Demin" <dmitryy.demin@gmail.com>, Lan Tianyu <tianyu.lan@intel.com>

With the introduction of ACPI scan handlers, an ACPI device object
with an ACPI scan handler attached to it must not be bound to an ACPI
driver any more.  Therefore it doesn't make sense to match those
ACPI device objects against a newly registered ACPI driver in
acpi_bus_match(), so make that function return 0 if the device
object passed to it has an ACPI scan handler attached.

This also addresses a regression related to a broken ACPI table in
the BIOS, where it has defined a _ROM method under the PCI root
bridge object.  This causes the video module to treat that object
as a display controller device (since only display devices are
supposed to have a _ROM method defined according to the ACPI spec).
As a result, the ACPI video driver binds to the PCI root bridge
object and overwrites the previously assigned driver_data field of
it, causing subsequent calls to acpi_get_pci_dev() to fail.

[rjw: Subject and changelog]
References: https://bugzilla.kernel.org/show_bug.cgi?id=58091
Reported-and-tested-by: Jason Cassell <bluesloth600@gmail.com>
Reported-bisected-and-tested-by: Dmitry S. Demin <dmitryy.demin@gmail.com>
Cc: 3.9+ <stable@kernel.org>
Signed-off-by: Aaron Lu <aaron.lu@intel.com>
---
v2:
Remove WARN_ON as it would cause unnecessary warnings for devices that
already have drivers bound.

drivers/acpi/scan.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 5e7e991..67ce501 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -553,6 +553,10 @@ static int acpi_bus_match(struct device *dev, struct device_driver *drv)
 	struct acpi_device *acpi_dev = to_acpi_device(dev);
 	struct acpi_driver *acpi_drv = to_acpi_driver(drv);
 
+	/* Skip ACPI device objects with scan handlers attached. */
+	if (acpi_dev->handler)
+		return 0;
+
 	return acpi_dev->flags.match_driver
 		&& !acpi_match_device_ids(acpi_dev, acpi_drv->ids);
 }
