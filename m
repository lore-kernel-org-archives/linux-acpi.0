From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 2/5] ACPI: Create symlinks in acpi_bind_one() under physical_node_lock
Date: Tue, 06 Aug 2013 02:26:46 +0200
Message-ID: <5865465.O2TCJ2dK9V@vostro.rjw.lan>
References: <3015032.qfOqgEVZKP@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3015032.qfOqgEVZKP@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Toshi Kani <toshi.kani@hp.com>
List-Id: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Put the creation of symlinks in acpi_bind_one() under the
physical_node_lock mutex of the given ACPI device objects, because
that is part of the binding operation logically (those links are
already removed under that mutex too).

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/glue.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-pm/drivers/acpi/glue.c
===================================================================
--- linux-pm.orig/drivers/acpi/glue.c
+++ linux-pm/drivers/acpi/glue.c
@@ -177,8 +177,6 @@ int acpi_bind_one(struct device *dev, ac
 	list_add(&physical_node->node, physnode_list);
 	acpi_dev->physical_node_count++;
 
-	mutex_unlock(&acpi_dev->physical_node_lock);
-
 	if (!ACPI_HANDLE(dev))
 		ACPI_HANDLE_SET(dev, acpi_dev->handle);
 
@@ -188,6 +186,8 @@ int acpi_bind_one(struct device *dev, ac
 	retval = sysfs_create_link(&dev->kobj, &acpi_dev->dev.kobj,
 		"firmware_node");
 
+	mutex_unlock(&acpi_dev->physical_node_lock);
+
 	if (acpi_dev->wakeup.flags.valid)
 		device_set_wakeup_capable(dev, true);
 
