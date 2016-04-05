From: Irina Tirdea <irina.tirdea@intel.com>
Subject: [RFC PATCH v2 1/3] pinctrl: pinconf-generic: Add ACPI support
Date: Tue,  5 Apr 2016 18:33:24 +0300
Message-ID: <1459870406-15219-2-git-send-email-irina.tirdea@intel.com>
References: <1459870406-15219-1-git-send-email-irina.tirdea@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459870406-15219-1-git-send-email-irina.tirdea@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Octavian Purdila <octavian.purdila@intel.com>, Cristina Ciocan <cristina.ciocan@intel.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Irina Tirdea <irina.tirdea@intel.com>
List-Id: linux-acpi@vger.kernel.org

Add ACPI support for the generic device tree properties.
Convert the pinconf generic code to handle both ACPI and
device tree by using the fwnode_property API. Also include
renaming device tree references in names of functions and
structures from 'dt' to 'fwnode'.

Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
---
 drivers/acpi/property.c                 |   8 +--
 drivers/base/property.c                 |  36 ++++++++--
 drivers/pinctrl/pinconf-generic.c       | 121 +++++++++++++++++++-------------
 include/linux/acpi.h                    |   4 +-
 include/linux/pinctrl/pinconf-generic.h |  35 +++++----
 include/linux/property.h                |   9 +++
 6 files changed, 138 insertions(+), 75 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index f2fd3fe..b10f935 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -794,13 +794,13 @@ int acpi_node_prop_read(struct fwnode_handle *fwnode,  const char *propname,
 
 /**
  * acpi_get_next_subnode - Return the next child node handle for a device.
- * @dev: Device to find the next child node for.
+ * @fwnode: Handle to the device to find the next child node for.
  * @child: Handle to one of the device's child nodes or a null handle.
  */
-struct fwnode_handle *acpi_get_next_subnode(struct device *dev,
+struct fwnode_handle *acpi_get_next_subnode(struct fwnode_handle *fwnode,
 					    struct fwnode_handle *child)
 {
-	struct acpi_device *adev = ACPI_COMPANION(dev);
+	struct acpi_device *adev = to_acpi_device_node(fwnode);
 	struct list_head *head, *next;
 
 	if (!adev)
@@ -816,7 +816,7 @@ struct fwnode_handle *acpi_get_next_subnode(struct device *dev,
 			next = adev->node.next;
 			if (next == head) {
 				child = NULL;
-				adev = ACPI_COMPANION(dev);
+				adev = to_acpi_device_node(fwnode);
 				goto nondev;
 			}
 			adev = list_entry(next, struct acpi_device, node);
diff --git a/drivers/base/property.c b/drivers/base/property.c
index 9b1a65d..153a316 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -859,24 +859,37 @@ int device_add_property_set(struct device *dev, const struct property_set *pset)
 EXPORT_SYMBOL_GPL(device_add_property_set);
 
 /**
- * device_get_next_child_node - Return the next child node handle for a device
- * @dev: Device to find the next child node for.
+ * fwnode_get_next_child_node - Return the next child node handle for a device
+ * @fwnode: Handle to the device to find the next child node for.
  * @child: Handle to one of the device's child nodes or a null handle.
  */
-struct fwnode_handle *device_get_next_child_node(struct device *dev,
+struct fwnode_handle *fwnode_get_next_child_node(struct fwnode_handle *fwnode,
 						 struct fwnode_handle *child)
 {
-	if (IS_ENABLED(CONFIG_OF) && dev->of_node) {
+	if (IS_ENABLED(CONFIG_OF) && to_of_node(fwnode)) {
 		struct device_node *node;
 
-		node = of_get_next_available_child(dev->of_node, to_of_node(child));
+		node = of_get_next_available_child(to_of_node(fwnode),
+						   to_of_node(child));
 		if (node)
 			return &node->fwnode;
 	} else if (IS_ENABLED(CONFIG_ACPI)) {
-		return acpi_get_next_subnode(dev, child);
+		return acpi_get_next_subnode(fwnode, child);
 	}
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(fwnode_get_next_child_node);
+
+/**
+ * device_get_next_child_node - Return the next child node handle for a device
+ * @dev: Device to find the next child node for.
+ * @child: Handle to one of the device's child nodes or a null handle.
+ */
+struct fwnode_handle *device_get_next_child_node(struct device *dev,
+						 struct fwnode_handle *child)
+{
+	return fwnode_get_next_child_node(dev_fwnode(dev), child);
+}
 EXPORT_SYMBOL_GPL(device_get_next_child_node);
 
 /**
@@ -1016,3 +1029,14 @@ void *device_get_mac_address(struct device *dev, char *addr, int alen)
 	return device_get_mac_addr(dev, "address", addr, alen);
 }
 EXPORT_SYMBOL(device_get_mac_address);
+
+const char *fwnode_get_name(struct fwnode_handle *fwnode)
+{
+	if (is_of_node(fwnode))
+		return of_node_full_name(to_of_node(fwnode));
+	else if (is_acpi_node(fwnode))
+		return acpi_dev_name(to_acpi_device_node(fwnode));
+
+	return NULL;
+}
+EXPORT_SYMBOL(fwnode_get_name);
diff --git a/drivers/pinctrl/pinconf-generic.c b/drivers/pinctrl/pinconf-generic.c
index d5bf9fa..52ef250 100644
--- a/drivers/pinctrl/pinconf-generic.c
+++ b/drivers/pinctrl/pinconf-generic.c
@@ -21,6 +21,7 @@
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/pinctrl/pinconf.h>
 #include <linux/pinctrl/pinconf-generic.h>
+#include <linux/acpi.h>
 #include <linux/of.h>
 #include "core.h"
 #include "pinconf.h"
@@ -148,8 +149,8 @@ void pinconf_generic_dump_config(struct pinctrl_dev *pctldev,
 EXPORT_SYMBOL_GPL(pinconf_generic_dump_config);
 #endif
 
-#ifdef CONFIG_OF
-static const struct pinconf_generic_params dt_params[] = {
+#if defined(CONFIG_OF) || defined(CONFIG_ACPI)
+static const struct pinconf_generic_params fw_params[] = {
 	{ "bias-bus-hold", PIN_CONFIG_BIAS_BUS_HOLD, 0 },
 	{ "bias-disable", PIN_CONFIG_BIAS_DISABLE, 0 },
 	{ "bias-high-impedance", PIN_CONFIG_BIAS_HIGH_IMPEDANCE, 0 },
@@ -175,22 +176,22 @@ static const struct pinconf_generic_params dt_params[] = {
 };
 
 /**
- * parse_dt_cfg() - Parse DT pinconf parameters
- * @np:	DT node
+ * parse_fwnode_cfg() - Parse FW pinconf parameters
+ * @fwnode:	FW node
  * @params:	Array of describing generic parameters
  * @count:	Number of entries in @params
  * @cfg:	Array of parsed config options
  * @ncfg:	Number of entries in @cfg
  *
- * Parse the config options described in @params from @np and puts the result
+ * Parse the config options described in @params from @fwnode and puts the result
  * in @cfg. @cfg does not need to be empty, entries are added beggining at
  * @ncfg. @ncfg is updated to reflect the number of entries after parsing. @cfg
  * needs to have enough memory allocated to hold all possible entries.
  */
-static void parse_dt_cfg(struct device_node *np,
-			 const struct pinconf_generic_params *params,
-			 unsigned int count, unsigned long *cfg,
-			 unsigned int *ncfg)
+static void parse_fwnode_cfg(struct fwnode_handle *fwnode,
+			     const struct pinconf_generic_params *params,
+			     unsigned int count, unsigned long *cfg,
+			     unsigned int *ncfg)
 {
 	int i;
 
@@ -199,7 +200,7 @@ static void parse_dt_cfg(struct device_node *np,
 		int ret;
 		const struct pinconf_generic_params *par = &params[i];
 
-		ret = of_property_read_u32(np, par->property, &val);
+		ret = fwnode_property_read_u32(fwnode, par->property, &val);
 
 		/* property not found */
 		if (ret == -EINVAL)
@@ -216,38 +217,38 @@ static void parse_dt_cfg(struct device_node *np,
 }
 
 /**
- * pinconf_generic_parse_dt_config()
+ * pinconf_generic_parse_fwnode_config()
  * parse the config properties into generic pinconfig values.
- * @np: node containing the pinconfig properties
+ * @fwnode: node containing the pinconfig properties
  * @configs: array with nconfigs entries containing the generic pinconf values
  *           must be freed when no longer necessary.
  * @nconfigs: umber of configurations
  */
-int pinconf_generic_parse_dt_config(struct device_node *np,
-				    struct pinctrl_dev *pctldev,
-				    unsigned long **configs,
-				    unsigned int *nconfigs)
+static int pinconf_generic_parse_fwnode_config(struct fwnode_handle *fwnode,
+					       struct pinctrl_dev *pctldev,
+					       unsigned long **configs,
+					       unsigned int *nconfigs)
 {
 	unsigned long *cfg;
 	unsigned int max_cfg, ncfg = 0;
 	int ret;
 
-	if (!np)
+	if (!fwnode)
 		return -EINVAL;
 
 	/* allocate a temporary array big enough to hold one of each option */
-	max_cfg = ARRAY_SIZE(dt_params);
+	max_cfg = ARRAY_SIZE(fw_params);
 	if (pctldev)
 		max_cfg += pctldev->desc->num_custom_params;
 	cfg = kcalloc(max_cfg, sizeof(*cfg), GFP_KERNEL);
 	if (!cfg)
 		return -ENOMEM;
 
-	parse_dt_cfg(np, dt_params, ARRAY_SIZE(dt_params), cfg, &ncfg);
+	parse_fwnode_cfg(fwnode, fw_params, ARRAY_SIZE(fw_params), cfg, &ncfg);
 	if (pctldev && pctldev->desc->num_custom_params &&
 		pctldev->desc->custom_params)
-		parse_dt_cfg(np, pctldev->desc->custom_params,
-			     pctldev->desc->num_custom_params, cfg, &ncfg);
+		parse_fwnode_cfg(fwnode, pctldev->desc->custom_params,
+				 pctldev->desc->num_custom_params, cfg, &ncfg);
 
 	ret = 0;
 
@@ -275,24 +276,23 @@ out:
 	return ret;
 }
 
-int pinconf_generic_dt_subnode_to_map(struct pinctrl_dev *pctldev,
-		struct device_node *np, struct pinctrl_map **map,
+static int pinconf_generic_fwnode_subnode_to_map(struct pinctrl_dev *pctldev,
+		struct fwnode_handle *fwnode, struct pinctrl_map **map,
 		unsigned *reserved_maps, unsigned *num_maps,
 		enum pinctrl_map_type type)
 {
-	int ret;
 	const char *function;
 	struct device *dev = pctldev->dev;
 	unsigned long *configs = NULL;
 	unsigned num_configs = 0;
 	unsigned reserve, strings_count;
-	struct property *prop;
-	const char *group;
+	const char **groups;
 	const char *subnode_target_type = "pins";
+	int ret, i;
 
-	ret = of_property_count_strings(np, "pins");
+	ret = fwnode_property_read_string_array(fwnode, "pins", NULL, 0);
 	if (ret < 0) {
-		ret = of_property_count_strings(np, "groups");
+		ret = fwnode_property_read_string_array(fwnode, "groups", NULL, 0);
 		if (ret < 0)
 			/* skip this node; may contain config child nodes */
 			return 0;
@@ -305,20 +305,20 @@ int pinconf_generic_dt_subnode_to_map(struct pinctrl_dev *pctldev,
 	}
 	strings_count = ret;
 
-	ret = of_property_read_string(np, "function", &function);
+	ret = fwnode_property_read_string(fwnode, "function", &function);
 	if (ret < 0) {
 		/* EINVAL=missing, which is fine since it's optional */
 		if (ret != -EINVAL)
 			dev_err(dev, "%s: could not parse property function\n",
-				of_node_full_name(np));
+				fwnode_get_name(fwnode));
 		function = NULL;
 	}
 
-	ret = pinconf_generic_parse_dt_config(np, pctldev, &configs,
-					      &num_configs);
+	ret = pinconf_generic_parse_fwnode_config(fwnode, pctldev, &configs,
+						  &num_configs);
 	if (ret < 0) {
 		dev_err(dev, "%s: could not parse node property\n",
-			of_node_full_name(np));
+			fwnode_get_name(fwnode));
 		return ret;
 	}
 
@@ -333,52 +333,64 @@ int pinconf_generic_dt_subnode_to_map(struct pinctrl_dev *pctldev,
 	ret = pinctrl_utils_reserve_map(pctldev, map, reserved_maps,
 			num_maps, reserve);
 	if (ret < 0)
-		goto exit;
+		goto exit_free_configs;
+
+	groups = kcalloc(strings_count, sizeof(*groups), GFP_KERNEL);
+	if (!groups) {
+		ret = -ENOMEM;
+		goto exit_free_configs;
+	}
+
+	ret = fwnode_property_read_string_array(fwnode, subnode_target_type,
+						groups, strings_count);
+	if (ret < 0)
+		goto exit_free_groups;
 
-	of_property_for_each_string(np, subnode_target_type, prop, group) {
+	for (i = 0; i < strings_count; i++) {
 		if (function) {
 			ret = pinctrl_utils_add_map_mux(pctldev, map,
-					reserved_maps, num_maps, group,
+					reserved_maps, num_maps, groups[i],
 					function);
 			if (ret < 0)
-				goto exit;
+				goto exit_free_groups;
 		}
 
 		if (num_configs) {
 			ret = pinctrl_utils_add_map_configs(pctldev, map,
-					reserved_maps, num_maps, group, configs,
-					num_configs, type);
+					reserved_maps, num_maps, groups[i],
+					configs, num_configs, type);
 			if (ret < 0)
-				goto exit;
+				goto exit_free_groups;
 		}
 	}
 	ret = 0;
 
-exit:
+exit_free_groups:
+	kfree(groups);
+exit_free_configs:
 	kfree(configs);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(pinconf_generic_dt_subnode_to_map);
 
-int pinconf_generic_dt_node_to_map(struct pinctrl_dev *pctldev,
-		struct device_node *np_config, struct pinctrl_map **map,
+int pinconf_generic_fwnode_to_map(struct pinctrl_dev *pctldev,
+		struct fwnode_handle *fwnode, struct pinctrl_map **map,
 		unsigned *num_maps, enum pinctrl_map_type type)
 {
 	unsigned reserved_maps;
-	struct device_node *np;
+	struct fwnode_handle *fw;
 	int ret;
 
 	reserved_maps = 0;
 	*map = NULL;
 	*num_maps = 0;
 
-	ret = pinconf_generic_dt_subnode_to_map(pctldev, np_config, map,
+	ret = pinconf_generic_fwnode_subnode_to_map(pctldev, fwnode, map,
 						&reserved_maps, num_maps, type);
 	if (ret < 0)
 		goto exit;
 
-	for_each_child_of_node(np_config, np) {
-		ret = pinconf_generic_dt_subnode_to_map(pctldev, np, map,
+	fwnode_for_each_child_node(fwnode, fw) {
+		ret = pinconf_generic_fwnode_subnode_to_map(pctldev, fw, map,
 					&reserved_maps, num_maps, type);
 		if (ret < 0)
 			goto exit;
@@ -389,6 +401,17 @@ exit:
 	pinctrl_utils_free_map(pctldev, *map, *num_maps);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(pinconf_generic_dt_node_to_map);
+EXPORT_SYMBOL_GPL(pinconf_generic_fwnode_to_map);
+
+#endif
 
+#ifdef CONFIG_OF
+int pinconf_generic_parse_dt_config(struct device_node *np,
+				    struct pinctrl_dev *pctldev,
+				    unsigned long **configs,
+				    unsigned int *nconfigs)
+{
+	return pinconf_generic_parse_fwnode_config(&np->fwnode, pctldev,
+						   configs, nconfigs);
+}
 #endif
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 06ed7e5..78a1050 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -876,7 +876,7 @@ int acpi_node_prop_read(struct fwnode_handle *fwnode, const char *propname,
 int acpi_dev_prop_read(struct acpi_device *adev, const char *propname,
 		       enum dev_prop_type proptype, void *val, size_t nval);
 
-struct fwnode_handle *acpi_get_next_subnode(struct device *dev,
+struct fwnode_handle *acpi_get_next_subnode(struct fwnode_handle *fwnode,
 					    struct fwnode_handle *subnode);
 
 struct acpi_probe_entry;
@@ -986,7 +986,7 @@ static inline int acpi_dev_prop_read(struct acpi_device *adev,
 	return -ENXIO;
 }
 
-static inline struct fwnode_handle *acpi_get_next_subnode(struct device *dev,
+static inline struct fwnode_handle *acpi_get_next_subnode(struct fwnode_handle *fwnode,
 						struct fwnode_handle *subnode)
 {
 	return NULL;
diff --git a/include/linux/pinctrl/pinconf-generic.h b/include/linux/pinctrl/pinconf-generic.h
index d921afd..6a8ea74 100644
--- a/include/linux/pinctrl/pinconf-generic.h
+++ b/include/linux/pinctrl/pinconf-generic.h
@@ -155,8 +155,7 @@ static inline unsigned long pinconf_to_config_packed(enum pin_config_param param
 	return PIN_CONF_PACKED(param, argument);
 }
 
-#ifdef CONFIG_OF
-
+#if defined(CONFIG_OF) || defined(CONFIG_ACPI)
 #include <linux/device.h>
 #include <linux/pinctrl/machine.h>
 struct pinctrl_dev;
@@ -168,28 +167,36 @@ struct pinconf_generic_params {
 	u32 default_value;
 };
 
-int pinconf_generic_dt_subnode_to_map(struct pinctrl_dev *pctldev,
-		struct device_node *np, struct pinctrl_map **map,
-		unsigned *reserved_maps, unsigned *num_maps,
-		enum pinctrl_map_type type);
-int pinconf_generic_dt_node_to_map(struct pinctrl_dev *pctldev,
-		struct device_node *np_config, struct pinctrl_map **map,
+int pinconf_generic_fwnode_to_map(struct pinctrl_dev *pctldev,
+		struct fwnode_handle *fwnode, struct pinctrl_map **map,
 		unsigned *num_maps, enum pinctrl_map_type type);
+#endif
+
+#ifdef CONFIG_OF
+#include <linux/of.h>
+
+static inline int pinconf_generic_dt_node_to_map(struct pinctrl_dev *pctldev,
+		struct device_node *np_config, struct pinctrl_map **map,
+		unsigned *num_maps, enum pinctrl_map_type type)
+{
+	return pinconf_generic_fwnode_to_map(pctldev, &np_config->fwnode, map,
+					     num_maps, type);
+}
 
 static inline int pinconf_generic_dt_node_to_map_group(
 		struct pinctrl_dev *pctldev, struct device_node *np_config,
 		struct pinctrl_map **map, unsigned *num_maps)
 {
-	return pinconf_generic_dt_node_to_map(pctldev, np_config, map, num_maps,
-			PIN_MAP_TYPE_CONFIGS_GROUP);
+	return pinconf_generic_fwnode_to_map(pctldev, &np_config->fwnode, map,
+					num_maps, PIN_MAP_TYPE_CONFIGS_GROUP);
 }
 
 static inline int pinconf_generic_dt_node_to_map_pin(
 		struct pinctrl_dev *pctldev, struct device_node *np_config,
 		struct pinctrl_map **map, unsigned *num_maps)
 {
-	return pinconf_generic_dt_node_to_map(pctldev, np_config, map, num_maps,
-			PIN_MAP_TYPE_CONFIGS_PIN);
+	return pinconf_generic_fwnode_to_map(pctldev, &np_config->fwnode, map,
+					num_maps, PIN_MAP_TYPE_CONFIGS_PIN);
 }
 
 static inline int pinconf_generic_dt_node_to_map_all(
@@ -200,8 +207,8 @@ static inline int pinconf_generic_dt_node_to_map_all(
 	 * passing the type as PIN_MAP_TYPE_INVALID causes the underlying parser
 	 * to infer the map type from the DT properties used.
 	 */
-	return pinconf_generic_dt_node_to_map(pctldev, np_config, map, num_maps,
-			PIN_MAP_TYPE_INVALID);
+	return pinconf_generic_fwnode_to_map(pctldev, &np_config->fwnode, map,
+					     num_maps, PIN_MAP_TYPE_INVALID);
 }
 #endif
 
diff --git a/include/linux/property.h b/include/linux/property.h
index b51fcd3..b0868d0 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -70,9 +70,16 @@ int fwnode_property_read_string(struct fwnode_handle *fwnode,
 int fwnode_property_match_string(struct fwnode_handle *fwnode,
 				 const char *propname, const char *string);
 
+struct fwnode_handle *fwnode_get_next_child_node(struct fwnode_handle *fwnode,
+						 struct fwnode_handle *child);
+
 struct fwnode_handle *device_get_next_child_node(struct device *dev,
 						 struct fwnode_handle *child);
 
+#define fwnode_for_each_child_node(fwnode, child)			\
+	for (child = fwnode_get_next_child_node(fwnode, NULL); child;	\
+	     child = fwnode_get_next_child_node(fwnode, child))
+
 #define device_for_each_child_node(dev, child)				\
 	for (child = device_get_next_child_node(dev, NULL); child;	\
 	     child = device_get_next_child_node(dev, child))
@@ -259,4 +266,6 @@ int device_get_phy_mode(struct device *dev);
 
 void *device_get_mac_address(struct device *dev, char *addr, int alen);
 
+const char *fwnode_get_name(struct fwnode_handle *fwnode);
+
 #endif /* _LINUX_PROPERTY_H_ */
-- 
1.9.1
