From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH] device property: Track owner device of device property
Date: Mon,  9 Oct 2017 16:28:37 +0300
Message-ID: <20171009132837.1096-1-jarkko.nikula@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Lukas Wunner <lukas@wunner.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, stable@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Deletion of subdevice will remove device properties associated to parent
when they share the same firmware node after commit 478573c93abd ("driver
core: Don't leak secondary fwnode on device removal"). This was observed
with a driver adding subdevice that driver wasn't able to read device
properties after rmmod/modprobe cycle.

Consider the lifecycle of it:

parent device registration
	ACPI_COMPANION_SET()
	device_add_properties()
		pset_copy_set()
		set_secondary_fwnode(dev, &p->fwnode)
	device_add()

parent probe
	read device properties
	ACPI_COMPANION_SET(subdevice, ACPI_COMPANION(parent))
	device_add(subdevice)

parent remove
	device_del(subdevice)
		device_remove_properties()
			set_secondary_fwnode(dev, NULL);
			pset_free()

Parent device will have its primary firmware node pointing to an ACPI node
and secondary firmware node point to device properties.
ACPI_COMPANION_SET() call in parent probe will set the subdevice's firmware
node to point to the same 'struct fwnode_handle' and the associated
secondary firmware node, i.e. the device properties as the parent.

When subdevice is deleted in parent remove that will remove those device
properties and attempt to read device properties in next parent probe call
will fail.

Fix this by tracking the owner device of device properties and delete them
only when owner device is being deleted.

Fixes: 478573c93abd ("driver core: Don't leak secondary fwnode on device removal")
Cc: <stable@vger.kernel.org> # v4.9+
Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 drivers/base/property.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index d0b65bbe7e15..21fcc13013a5 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -21,6 +21,7 @@
 #include <linux/phy.h>
 
 struct property_set {
+	struct device *dev;
 	struct fwnode_handle fwnode;
 	const struct property_entry *properties;
 };
@@ -891,6 +892,7 @@ static struct property_set *pset_copy_set(const struct property_set *pset)
 void device_remove_properties(struct device *dev)
 {
 	struct fwnode_handle *fwnode;
+	struct property_set *pset;
 
 	fwnode = dev_fwnode(dev);
 	if (!fwnode)
@@ -900,16 +902,16 @@ void device_remove_properties(struct device *dev)
 	 * the pset. If there is no real firmware node (ACPI/DT) primary
 	 * will hold the pset.
 	 */
-	if (is_pset_node(fwnode)) {
+	pset = to_pset_node(fwnode);
+	if (pset) {
 		set_primary_fwnode(dev, NULL);
-		pset_free_set(to_pset_node(fwnode));
 	} else {
-		fwnode = fwnode->secondary;
-		if (!IS_ERR(fwnode) && is_pset_node(fwnode)) {
+		pset = to_pset_node(fwnode->secondary);
+		if (pset && dev == pset->dev)
 			set_secondary_fwnode(dev, NULL);
-			pset_free_set(to_pset_node(fwnode));
-		}
 	}
+	if (pset && dev == pset->dev)
+		pset_free_set(pset);
 }
 EXPORT_SYMBOL_GPL(device_remove_properties);
 
@@ -938,6 +940,7 @@ int device_add_properties(struct device *dev,
 
 	p->fwnode.ops = &pset_fwnode_ops;
 	set_secondary_fwnode(dev, &p->fwnode);
+	p->dev = dev;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(device_add_properties);
-- 
2.14.2
