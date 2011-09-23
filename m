From: Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH] ACPI: Fix CONFIG_ACPI_DOCK=n compiler warning
Date: Fri, 23 Sep 2011 19:58:55 +0200
Message-ID: <201109231958.55067.bvanassche@acm.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, Vasiliy Kulikov <segoon@openwall.com>, Jeff Garzik <jgarzik@redhat.com>
List-Id: linux-acpi@vger.kernel.org

Recently the ACPI ops structs were constified but the inline version
of register_hotplug_dock_device() was overlooked (see also commit
9c8b04be443b33939f374a811c82abeebe0a61d1, June 25 2011). Update
the inline function register_hotplug_dock_device() that is
enabled with CONFIG_ACPI_DOCK=n too. This patch fixes at
least the following compiler warnings:

drivers/ata/libata-acpi.c: In function .ata_acpi_associate.:
drivers/ata/libata-acpi.c:266:11: warning: passing argument 2 of .register_hotplug_dock_device. discards qualifiers from pointer target type
include/acpi/acpi_drivers.h:146:19: note: expected .struct acpi_dock_ops *. but argument is of type .const struct acpi_dock_ops *.
drivers/ata/libata-acpi.c:275:11: warning: passing argument 2 of .register_hotplug_dock_device. discards qualifiers from pointer target type
include/acpi/acpi_drivers.h:146:19: note: expected .struct acpi_dock_ops *. but argument is of type .const struct acpi_dock_ops *.

Cc: Len Brown <len.brown@intel.com>
Cc: Vasiliy Kulikov <segoon@openwall.com>
Cc: Jeff Garzik <jgarzik@redhat.com>
Cc: <stable@kernel.org>
---
 include/acpi/acpi_drivers.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/acpi/acpi_drivers.h b/include/acpi/acpi_drivers.h
index e49c36d..bb145e4 100644
--- a/include/acpi/acpi_drivers.h
+++ b/include/acpi/acpi_drivers.h
@@ -144,7 +144,7 @@ static inline void unregister_dock_notifier(struct notifier_block *nb)
 {
 }
 static inline int register_hotplug_dock_device(acpi_handle handle,
-					       struct acpi_dock_ops *ops,
+					       const struct acpi_dock_ops *ops,
 					       void *context)
 {
 	return -ENODEV;
-- 
1.7.3.4
