From: Irina Tirdea <irina.tirdea@intel.com>
Subject: [RFC PATCH 3/4] pinctrl: Add ACPI support
Date: Thu, 31 Mar 2016 14:44:44 +0300
Message-ID: <1459424685-26965-4-git-send-email-irina.tirdea@intel.com>
References: <1459424685-26965-1-git-send-email-irina.tirdea@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459424685-26965-1-git-send-email-irina.tirdea@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Octavian Purdila <octavian.purdila@intel.com>, Cristina Ciocan <cristina.ciocan@intel.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Irina Tirdea <irina.tirdea@intel.com>
List-Id: linux-acpi@vger.kernel.org

Add ACPI support for pin controller properties. These are
based on ACPI _DSD properties and follow the device tree
model based on states and node configurations. The states
are defined as _DSD properties and configuration nodes
are defined using the _DSD Hierarchical Properties Extension.

A configuration node supports the generic device tree properties.

The implementation is based on device tree code from devicetree.c.

Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
---
 Documentation/acpi/pinctrl-properties.txt | 274 +++++++++++++++++++++++++
 drivers/pinctrl/Makefile                  |   1 +
 drivers/pinctrl/acpi.c                    | 322 ++++++++++++++++++++++++++++++
 drivers/pinctrl/acpi.h                    |  32 +++
 drivers/pinctrl/core.c                    |  26 +++
 drivers/pinctrl/core.h                    |   2 +
 6 files changed, 657 insertions(+)
 create mode 100644 Documentation/acpi/pinctrl-properties.txt
 create mode 100644 drivers/pinctrl/acpi.c
 create mode 100644 drivers/pinctrl/acpi.h

diff --git a/Documentation/acpi/pinctrl-properties.txt b/Documentation/acpi/pinctrl-properties.txt
new file mode 100644
index 0000000..e93aaaf
--- /dev/null
+++ b/Documentation/acpi/pinctrl-properties.txt
@@ -0,0 +1,274 @@
+= _DSD Device Properties related to pin controllers =
+
+== Introduction ==
+
+This document is an extension of the pin control subsystem in Linux [1]
+and provides a way to describe pin controller properties in ACPI. It is
+based on the Device Specific Data (_DSD) configuration object [2] that
+was introduced in ACPI 5.1.
+
+Pin controllers are hardware modules that control pins by allowing pin
+multiplexing and configuration. Pin multiplexing allows using the same
+physical pins for multiple functions; for example, one pin or group of pins
+may be used for the I2C bus, SPI bus or as general-purpose GPIO pin. Pin
+configuration allows setting various properties such as pull-up/down,
+tri-state, drive-strength, etc.
+
+Hardware modules whose signals are affected by pin configuration are
+designated client devices. For a client device to operate correctly,
+certain pin controllers must set up certain specific pin configurations.
+Some client devices need a single static pin configuration, e.g. set up
+during initialization. Others need to reconfigure pins at run-time,
+for example to tri-state pins when the device is inactive. Hence, each
+client device can define a set of named states. Each named state is
+mapped to a pin controller configuration that describes the pin multiplexing
+or configuration for that state.
+
+In ACPI, each pin controller and each client device is represented as an
+ACPI device, just like any other hardware module. The pin controller
+properties are defined using _DSD properties [2] under these devices.
+The named states are defined using Device Properties UUID [3] under the
+ACPI client device. The configuration nodes are defined using Hierarchical
+Properties Extension UUID [4] and are split between the ACPI client device
+and the pin controller device. The configuration nodes contain properties
+that describe pin multiplexing or configuration that very similar to the
+ones used for device tree [5].
+
+== Example ==
+
+For example, let's consider an accelerometer connected to the I2C bus on
+a platform with a Baytrail pin controller. The accelerometer uses 2 GPIO
+pins for I2C (SDA, SCL) and one GPIO pin for interrupt.
+
+The name for the pins, groups and functions used are the ones defined in the
+pin controller driver, in the same way as it is done for device tree [5].
+
+For the I2C pins, the pin controller driver defines one group called
+"i2c5_grp" that can be multiplexed with functions "i2c" or "gpio".
+In our case, we need to select function "i2c" for group "i2c5_grp" in
+the ACPI description.
+
+For the GPIO pin, the pin controller driver defines the name "GPIO_S5[00]"
+for the pin with index 0 that we use. We need to configure this pin to
+pull-down with pull strength of 10000 Ohms. We might also want to disable
+the bias for the GPIO interrupt pin when entering sleep.
+
+Here is an ASL example for this device:
+
+  // Pin controller device
+  Scope (_SB.GPO0)
+  {
+      Name (MUX0, Package()
+      {
+          ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
+          Package()
+          {
+              Package (2) {"function", "i2c"},
+              Package (2) {"groups", Package () {"i2c5_grp"}},
+          }
+      })
+
+      Name (CFG0, Package()
+      {
+          ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
+          Package()
+          {
+              Package (2) {"pins", Package () {"GPIO_S5[00]"}},
+              Package (2) {"bias-pull-down", 10000},
+          }
+      })
+
+      Name (CFG1, Package()
+      {
+          ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
+          Package()
+          {
+              Package (2) {"pins", Package () {"GPIO_S5[00]"}},
+              Package (2) {"bias-disable", 0},
+          }
+      })
+  }
+
+  // Accelerometer device with default pinmux and pinconfig for i2c and
+  // GPIO pins
+  Scope (_SB.I2C0)
+  {
+      Device (ACL0)
+      {
+          Name (_HID, ...)
+
+          Method (_CRS, 0, Serialized)
+          {
+              Name (RBUF, ResourceTemplate ()
+              {
+                  I2cSerialBus (...)
+                  GpioInt (Edge, ActiveHigh, Exclusive, PullDown, 0x0000,
+                           "\\_SB.GPO0", 0x00, ResourceConsumer, , ) { 0 }
+              })
+              Return (RBUF)
+          }
+
+          Name (_DSD, Package ()
+          {
+              ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
+              Package ()
+              {
+                  Package () {"pinctrl-names", Package() {"default", "sleep"}},
+                  Package ()
+                  {
+                      "pinctrl-0",
+                      Package()
+                      {
+                          "accel-default-mux-i2c",
+                          "accel-default-cfg-int",
+                      }
+                  },
+                  Package ()
+                  {
+                      "pinctrl-1",
+                      Package()
+                      {
+                          "accel-sleep-cfg-int",
+                      }
+                  },
+
+              },
+              ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
+              Package ()
+              {
+                  Package (2) {"accel-default-mux-i2c", "\\_SB.GPO0.MUX0"},
+                  Package (2) {"accel-default-cfg-int", "\\_SB.GPO0.CFG0"},
+                  Package (2) {"accel-sleep-cfg-int", "\\_SB.GPO0.CFG1"},
+              },
+          })
+      }
+  }
+
+In the ASL excerpt, the accelerometer device has 2 states:
+  - a default state with 2 pin configurations:
+    - a pin multiplexing node for the i2c pins that sets function "i2c"
+      for the "i2c5_grp" pin group
+    - a pin configuration node for the GPIO interrupt pin that pull down
+      the "GPIO_S5[00]" pin and sets a pull strength of 10000 Ohms
+  - a sleep state with 1 pin configuration:
+    - a pin configuration node for pin "GPIO_S5[00]" that disables pin
+    bias
+
+== _DSD pinctrl properties format ==
+
+=== Pin controller client device states  ===
+
+The pinctrl states are defined under the device node they apply to.
+The format of the pinctrl states is:
+
+  Name (_DSD, Package ()
+  {
+      ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
+      Package ()
+      {
+          Package () {"pinctrl-names", Package() {statename0, statename1, ...}},
+          Package () {"pinctrl-0", Package() {cfgname0, cfgname1, ...}},
+          Package () {"pinctrl-1", Package() {cfgname2, cfgname3, ...}},
+      }
+  }
+
+  statename - name of the pinctrl device state (e.g.: default, sleep, etc.).
+              These names are associated with the lists of configurations
+	      defined below: statename0 defines the name for configuration
+	      property "pinctrl-0", statename1 defines the name for
+	      configuration property "pinctrl-1", etc.
+  cfgname - name for the configuration data-only subnode.
+
+=== Pin controller configuration nodes  ===
+
+The configuration data-only subnodes are defined using the Hierarchical
+Properties Extension UUID [4]. Their definition is split between the device
+node and the pin controller node. The format for these subnodes is:
+
+  Scope (DEV0)
+  {
+      Name (_DSD, Package ()
+      {
+          ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
+          Package ()
+          {
+              Package (2) {cfgname0, "\\GPO0.DNP0"},
+              Package (2) {cfgname1, "\\GPO0.DNP1"},
+          },
+      })
+  }
+
+  Scope (GPO0)
+  {
+      Name (DPN0, Package()
+      {
+          ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
+          Package() {...}
+      })
+      Name (DPN1, Package()
+      {
+          ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
+          Package() {...}
+      })
+  }
+
+Each DPN data subnode is a regular _DSD node that uses Device Properties
+UUID [3]. There are 2 types of subnodes, depending on the properties it
+contains: pin multiplexing nodes and pin configuration nodes.
+
+==== Pin multiplexing nodes  ====
+
+The pin multiplexing nodes must contain a property named "function" and
+define a mux function to be applied to a list of pin groups. The properties
+supported by this node are the same as for device tree [5]. The name for the
+pins, groups and functions used are the ones defined in the pin controller
+driver, in the same way as it is done for device tree [5]. The format for
+this data subnode is:
+
+  Name (DPN0, Package()
+  {
+      ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
+          Package()
+          {
+              Package (2) {"function", functioname},
+              Package (2) {"groups", Package () {groupname1, groupname2, ...}},
+          }
+  })
+
+  functioname - the pinmux function to select.
+  groups - the list of groups to select with this function
+
+==== Pin configuration nodes  ====
+
+The pin configuration nodes do not contain a property named "function".
+They must contain a property named "group" or "pins". They will also
+contain one or more configuration properties like bias-pull-up,
+drive-open-drain, etc. The properties supported by this node are the
+same as for device tree. Standard pinctrl properties are defined in the
+device tree documentation [5] and in <include/linux/pinctrl/pinconf-generic.h>.
+Pinctrl drivers may also define their own custom properties. The name for the
+pins/groups  used are the ones defined in the pin controller driver, in the
+same way as it is done for device tree [5]. The format for the data subnode is:
+
+  Name (DPN0, Package()
+  {
+      ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
+          Package()
+          {
+              Package (2) {"pins", Package () {pin1, pin2, ...}},
+              Package (2) {configname1, configval1},
+              Package (2) {configname2, configval2},
+          }
+  })
+
+  pins - list of pins that properties in the node apply to
+  configname - name of the pin configuration property
+  configval - value of the pin configuration property
+
+== References ==
+
+[1] Documentation/pinctrl.txt
+[2] http://www.uefi.org/sites/default/files/resources/_DSD-implementation-guide-toplevel-1_1.htm
+[3] http://www.uefi.org/sites/default/files/resources/_DSD-device-properties-UUID.pdf
+[4] http://www.uefi.org/sites/default/files/resources/_DSD-hierarchical-data-extension-UUID-v1.pdf
+[5] Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index e4bc115..12d3af6 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -6,6 +6,7 @@ obj-y				+= core.o pinctrl-utils.o
 obj-$(CONFIG_PINMUX)		+= pinmux.o
 obj-$(CONFIG_PINCONF)		+= pinconf.o
 obj-$(CONFIG_OF)		+= devicetree.o
+obj-$(CONFIG_ACPI)		+= acpi.o
 obj-$(CONFIG_GENERIC_PINCONF)	+= pinconf-generic.o
 obj-$(CONFIG_PINCTRL_ADI2)	+= pinctrl-adi2.o
 obj-$(CONFIG_PINCTRL_AS3722)	+= pinctrl-as3722.o
diff --git a/drivers/pinctrl/acpi.c b/drivers/pinctrl/acpi.c
new file mode 100644
index 0000000..bed1d88
--- /dev/null
+++ b/drivers/pinctrl/acpi.c
@@ -0,0 +1,322 @@
+/*
+ * ACPI integration for the pin control subsystem
+ *
+ * Copyright (c) 2016, Intel Corporation.
+ *
+ * Derived from:
+ *  devicetree.c - Copyright (C) 2012 NVIDIA CORPORATION
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ */
+
+#include <linux/acpi.h>
+#include <linux/device.h>
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/pinctrl/pinconf-generic.h>
+
+#include "acpi.h"
+#include "core.h"
+#include "pinconf.h"
+#include "pinctrl-utils.h"
+
+/**
+ * struct pinctrl_acpi_map - mapping table chunk parsed from ACPI
+ * @node: list node for struct pinctrl's @fw_maps field
+ * @pctldev: the pin controller that allocated this struct, and will free it
+ * @maps: the mapping table entries
+ */
+struct pinctrl_acpi_map {
+	struct list_head node;
+	struct pinctrl_dev *pctldev;
+	struct pinctrl_map *map;
+	unsigned num_maps;
+};
+
+static void acpi_maps_list_dh(acpi_handle handle, void *data)
+{
+	/* The address of this function is used as a key. */
+}
+
+static struct list_head *acpi_get_maps(struct device *dev)
+{
+	acpi_handle handle = ACPI_HANDLE(dev);
+	struct list_head *maps;
+	acpi_status status;
+
+	status = acpi_get_data(handle, acpi_maps_list_dh, (void **)&maps);
+	if (ACPI_FAILURE(status))
+		return NULL;
+
+	return maps;
+}
+
+static void acpi_free_maps(struct device *dev, struct list_head *maps)
+{
+	acpi_handle handle = ACPI_HANDLE(dev);
+
+	acpi_detach_data(handle, acpi_maps_list_dh);
+	kfree(maps);
+}
+
+static int acpi_init_maps(struct device *dev)
+{
+	acpi_handle handle = ACPI_HANDLE(dev);
+	struct list_head *maps;
+	acpi_status status;
+
+	maps = kzalloc(sizeof(*maps), GFP_KERNEL);
+	if (!maps)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(maps);
+
+	status = acpi_attach_data(handle, acpi_maps_list_dh, maps);
+	if (ACPI_FAILURE(status))
+		return -EINVAL;
+
+	return 0;
+}
+
+void pinctrl_acpi_free_maps(struct pinctrl *p)
+{
+	struct pinctrl_acpi_map *map, *_map;
+	struct list_head *maps;
+
+	maps = acpi_get_maps(p->dev);
+	if (!maps)
+		goto out;
+
+	list_for_each_entry_safe(map, _map, maps, node) {
+		pinctrl_unregister_map(map->map);
+		list_del(&map->node);
+		pinctrl_utils_free_map(map->pctldev, map->map, map->num_maps);
+		kfree(map);
+	}
+
+	acpi_free_maps(p->dev, maps);
+out:
+	acpi_bus_put_acpi_device(ACPI_COMPANION(p->dev));
+}
+
+static int acpi_remember_or_free_map(struct pinctrl *p, const char *statename,
+				     struct pinctrl_dev *pctldev,
+				     struct pinctrl_map *map, unsigned num_maps)
+{
+	struct pinctrl_acpi_map *acpi_map;
+	struct list_head *acpi_maps;
+	unsigned int i;
+
+	acpi_maps = acpi_get_maps(p->dev);
+	if (!acpi_maps)
+		return -EINVAL;
+
+	/* Initialize common mapping table entry fields */
+	for (i = 0; i < num_maps; i++) {
+		map[i].dev_name = dev_name(p->dev);
+		map[i].name = statename;
+		if (pctldev)
+			map[i].ctrl_dev_name = dev_name(pctldev->dev);
+	}
+
+	/* Remember the converted mapping table entries */
+	acpi_map = kzalloc(sizeof(*acpi_map), GFP_KERNEL);
+	if (!acpi_map) {
+		pinctrl_utils_free_map(pctldev, map, num_maps);
+		return -ENOMEM;
+	}
+
+	acpi_map->pctldev = pctldev;
+	acpi_map->map = map;
+	acpi_map->num_maps = num_maps;
+	list_add_tail(&acpi_map->node, acpi_maps);
+
+	return pinctrl_register_map(map, num_maps, false);
+}
+
+static int acpi_remember_dummy_state(struct pinctrl *p, const char *statename)
+{
+	struct pinctrl_map *map;
+
+	map = kzalloc(sizeof(*map), GFP_KERNEL);
+	if (!map)
+		return -ENOMEM;
+
+	/* There is no pctldev for PIN_MAP_TYPE_DUMMY_STATE */
+	map->type = PIN_MAP_TYPE_DUMMY_STATE;
+
+	return acpi_remember_or_free_map(p, statename, NULL, map, 1);
+}
+
+static struct pinctrl_dev *acpi_find_pctldev(struct fwnode_handle *fw_config)
+{
+	struct acpi_buffer path = {ACPI_ALLOCATE_BUFFER, NULL};
+	acpi_handle pctrl_handle, cfg_handle;
+	struct acpi_data_node *dn;
+	acpi_status status;
+	int ret;
+
+	/*
+	 * In ACPI, the pinctrl device is the parent of the configuration
+	 * node. In the kernel internal representation, the device node is
+	 * the parent of the configuration node. We need to extract the
+	 * original path for the configuration node and search for its parent
+	 * in the ACPI hierarchy.
+	 */
+	dn = to_acpi_data_node(fw_config);
+	if (!dn)
+		return ERR_PTR(-EINVAL);
+
+	ret = acpi_get_name(dn->handle, ACPI_FULL_PATHNAME, &path);
+	if (ret)
+		return ERR_PTR(ret);
+
+	status = acpi_get_handle(NULL, (char *)path.pointer, &cfg_handle);
+	kfree(path.pointer);
+	if (ACPI_FAILURE(status))
+		return ERR_PTR(-EINVAL);
+
+	status = acpi_get_parent(cfg_handle, &pctrl_handle);
+	if (ACPI_FAILURE(status))
+		return ERR_PTR(-EINVAL);
+
+	return get_pinctrl_dev_from_acpi(pctrl_handle);
+}
+
+static int acpi_to_map_one_config(struct pinctrl *p, const char *statename,
+				  struct fwnode_handle *fw_config)
+{
+	struct pinctrl_map *map;
+	struct pinctrl_dev *pctldev;
+	unsigned num_maps;
+	int ret;
+
+	/* Find the pin controller containing fw_config */
+	pctldev = acpi_find_pctldev(fw_config);
+	if (!pctldev)
+		return -ENODEV;
+	if (IS_ERR(pctldev))
+		return PTR_ERR(pctldev);
+
+	/* Parse ACPI node and generate mapping table entries */
+	ret = pinconf_generic_fwnode_to_map(pctldev, fw_config, &map, &num_maps,
+					    PIN_MAP_TYPE_INVALID);
+	if (ret < 0)
+		return ret;
+
+	/* Stash the mapping table chunk away for later use */
+	return acpi_remember_or_free_map(p, statename, pctldev, map, num_maps);
+}
+
+static struct fwnode_handle *acpi_find_config_prop(struct device *dev,
+						   char *propname)
+{
+	struct fwnode_handle *child;
+	struct acpi_data_node *dn;
+
+	/*
+	 * Pinctrl configuration properties are described with ACPI data
+	 * nodes using _DSD Hierarchical Properties Extension.
+	 */
+	device_for_each_child_node(dev, child) {
+		dn = to_acpi_data_node(child);
+		if (!dn)
+			continue;
+		if (!strcmp(dn->name, propname))
+			break;
+	}
+
+	return child;
+}
+
+int pinctrl_acpi_to_map(struct pinctrl *p)
+{
+	const union acpi_object *prop, *statenames, *configs;
+	unsigned int state, nstates, nconfigs, config;
+	char *statename, *propname, *configname;
+	struct fwnode_handle *fw_prop;
+	struct acpi_device *adev;
+	int ret;
+
+	/* We may store pointers to property names within the node */
+	adev = acpi_bus_get_acpi_device(ACPI_HANDLE(p->dev));
+	if (!adev)
+		return -ENODEV;
+
+	/* Only allow named states (device must have prop 'pinctrl-names') */
+	ret = acpi_dev_get_property(adev, "pinctrl-names", ACPI_TYPE_PACKAGE,
+				    &prop);
+	if (ret) {
+		acpi_bus_put_acpi_device(adev);
+		/* No pinctrl properties */
+		return 0;
+	}
+	statenames = prop->package.elements;
+	nstates = prop->package.count;
+
+	ret = acpi_init_maps(p->dev);
+	if (ret)
+		return ret;
+
+	/* For each defined state ID */
+	for (state = 0; state < nstates; state++) {
+		/* Get state name */
+		if (statenames[state].type != ACPI_TYPE_STRING) {
+			ret = -EINVAL;
+			goto err_free_map;
+		}
+		statename = statenames[state].string.pointer;
+
+		/* Retrieve the pinctrl-* property */
+		propname = kasprintf(GFP_KERNEL, "pinctrl-%d", state);
+		ret = acpi_dev_get_property(adev, propname, ACPI_TYPE_PACKAGE,
+					    &prop);
+		kfree(propname);
+		if (ret)
+			break;
+		configs = prop->package.elements;
+		nconfigs = prop->package.count;
+
+		/* For every referenced pin configuration node in it */
+		for (config = 0; config < nconfigs; config++) {
+			if (configs[config].type != ACPI_TYPE_STRING) {
+				ret = -EINVAL;
+				goto err_free_map;
+			}
+			configname = configs[config].string.pointer;
+
+			/*
+			 * Look up the pin configuration node as
+			 * an ACPI data node in the device node.
+			 */
+			fw_prop = acpi_find_config_prop(p->dev, configname);
+			if (!fw_prop) {
+				ret = -EINVAL;
+				goto err_free_map;
+			}
+
+			/* Parse the configuration node */
+			ret = acpi_to_map_one_config(p, statename, fw_prop);
+			if (ret < 0)
+				goto err_free_map;
+		}
+		/* No entries in ACPI? Generate a dummy state table entry */
+		if (!nconfigs) {
+			ret = acpi_remember_dummy_state(p, statename);
+			if (ret < 0)
+				goto err_free_map;
+		}
+	}
+
+	return 0;
+
+err_free_map:
+	pinctrl_acpi_free_maps(p);
+	return ret;
+}
diff --git a/drivers/pinctrl/acpi.h b/drivers/pinctrl/acpi.h
new file mode 100644
index 0000000..fb9f6ed
--- /dev/null
+++ b/drivers/pinctrl/acpi.h
@@ -0,0 +1,32 @@
+/*
+ * Internal interface to pinctrl ACPI integration
+ *
+ * Copyright (c) 2016, Intel Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ */
+
+#ifdef CONFIG_ACPI
+
+void pinctrl_acpi_free_maps(struct pinctrl *p);
+int pinctrl_acpi_to_map(struct pinctrl *p);
+
+#else
+
+static inline int pinctrl_acpi_to_map(struct pinctrl *p)
+{
+	return 0;
+}
+
+static inline void pinctrl_acpi_free_maps(struct pinctrl *p)
+{
+}
+
+#endif
diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index f67a8b7..1bf3774 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -36,6 +36,7 @@
 #include "devicetree.h"
 #include "pinmux.h"
 #include "pinconf.h"
+#include "acpi.h"
 
 
 static bool pinctrl_dummy_state;
@@ -137,6 +138,23 @@ struct pinctrl_dev *get_pinctrl_dev_from_of_node(struct device_node *np)
 	return NULL;
 }
 
+struct pinctrl_dev *get_pinctrl_dev_from_acpi(acpi_handle handle)
+{
+	struct pinctrl_dev *pctldev;
+
+	mutex_lock(&pinctrldev_list_mutex);
+
+	list_for_each_entry(pctldev, &pinctrldev_list, node)
+		if (ACPI_HANDLE(pctldev->dev) == handle) {
+			mutex_unlock(&pinctrldev_list_mutex);
+			return pctldev;
+		}
+
+	mutex_unlock(&pinctrldev_list_mutex);
+
+	return NULL;
+}
+
 /**
  * pin_get_from_name() - look up a pin number from a name
  * @pctldev: the pin control device to lookup the pin on
@@ -827,6 +845,12 @@ static struct pinctrl *create_pinctrl(struct device *dev)
 		return ERR_PTR(ret);
 	}
 
+	ret = pinctrl_acpi_to_map(p);
+	if (ret < 0) {
+		kfree(p);
+		return ERR_PTR(ret);
+	}
+
 	devname = dev_name(dev);
 
 	mutex_lock(&pinctrl_maps_mutex);
@@ -937,6 +961,8 @@ static void pinctrl_free(struct pinctrl *p, bool inlist)
 
 	pinctrl_dt_free_maps(p);
 
+	pinctrl_acpi_free_maps(p);
+
 	if (inlist)
 		list_del(&p->node);
 	kfree(p);
diff --git a/drivers/pinctrl/core.h b/drivers/pinctrl/core.h
index ca08723..797ab8b 100644
--- a/drivers/pinctrl/core.h
+++ b/drivers/pinctrl/core.h
@@ -14,6 +14,7 @@
 #include <linux/radix-tree.h>
 #include <linux/pinctrl/pinconf.h>
 #include <linux/pinctrl/machine.h>
+#include <linux/acpi.h>
 
 struct pinctrl_gpio_range;
 
@@ -171,6 +172,7 @@ struct pinctrl_maps {
 
 struct pinctrl_dev *get_pinctrl_dev_from_devname(const char *dev_name);
 struct pinctrl_dev *get_pinctrl_dev_from_of_node(struct device_node *np);
+struct pinctrl_dev *get_pinctrl_dev_from_acpi(acpi_handle handle);
 int pin_get_from_name(struct pinctrl_dev *pctldev, const char *name);
 const char *pin_get_name(struct pinctrl_dev *pctldev, const unsigned pin);
 int pinctrl_get_group_selector(struct pinctrl_dev *pctldev,
-- 
1.9.1
