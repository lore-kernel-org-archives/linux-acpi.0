From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 4/5] ACPI: Use list_for_each_entry() in acpi_unbind_one()
Date: Tue, 06 Aug 2013 02:28:01 +0200
Message-ID: <4033872.Q1QjeRMsmt@vostro.rjw.lan>
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

Since acpi_unbind_one() walks physical_node_list under the ACPI
device object's physical_node_lock mutex and the walk may be
terminated as soon as the matching entry has been found, it is
not necessary to use list_for_each_safe() for that walk, so use
list_for_each_entry() instead and make the code slightly more
straightforward.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/glue.c |   36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

Index: linux-pm/drivers/acpi/glue.c
===================================================================
--- linux-pm.orig/drivers/acpi/glue.c
+++ linux-pm/drivers/acpi/glue.c
@@ -214,7 +214,6 @@ int acpi_unbind_one(struct device *dev)
 	struct acpi_device_physical_node *entry;
 	struct acpi_device *acpi_dev;
 	acpi_status status;
-	struct list_head *node, *next;
 
 	if (!ACPI_HANDLE(dev))
 		return 0;
@@ -224,25 +223,24 @@ int acpi_unbind_one(struct device *dev)
 		goto err;
 
 	mutex_lock(&acpi_dev->physical_node_lock);
-	list_for_each_safe(node, next, &acpi_dev->physical_node_list) {
-		char physical_node_name[PHYSICAL_NODE_NAME_SIZE];
 
-		entry = list_entry(node, struct acpi_device_physical_node,
-				   node);
-		if (entry->dev != dev)
-			continue;
-
-		list_del(node);
-		acpi_dev->physical_node_count--;
-
-		acpi_bind_physnode_name(physical_node_name, entry->node_id);
-		sysfs_remove_link(&acpi_dev->dev.kobj, physical_node_name);
-		sysfs_remove_link(&dev->kobj, "firmware_node");
-		ACPI_HANDLE_SET(dev, NULL);
-		/* acpi_bind_one increase refcnt by one */
-		put_device(dev);
-		kfree(entry);
-	}
+	list_for_each_entry(entry, &acpi_dev->physical_node_list, node)
+		if (entry->dev == dev) {
+			char physnode_name[PHYSICAL_NODE_NAME_SIZE];
+
+			list_del(&entry->node);
+			acpi_dev->physical_node_count--;
+
+			acpi_bind_physnode_name(physnode_name, entry->node_id);
+			sysfs_remove_link(&acpi_dev->dev.kobj, physnode_name);
+			sysfs_remove_link(&dev->kobj, "firmware_node");
+			ACPI_HANDLE_SET(dev, NULL);
+			/* acpi_bind_one() increase refcnt by one. */
+			put_device(dev);
+			kfree(entry);
+			break;
+		}
+
 	mutex_unlock(&acpi_dev->physical_node_lock);
 
 	return 0;
