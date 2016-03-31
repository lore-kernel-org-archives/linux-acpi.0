From: Irina Tirdea <irina.tirdea@intel.com>
Subject: [RFC PATCH 4/4] pinctrl: Parse GpioInt/GpioIo resources
Date: Thu, 31 Mar 2016 14:44:45 +0300
Message-ID: <1459424685-26965-5-git-send-email-irina.tirdea@intel.com>
References: <1459424685-26965-1-git-send-email-irina.tirdea@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459424685-26965-1-git-send-email-irina.tirdea@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Octavian Purdila <octavian.purdila@intel.com>, Cristina Ciocan <cristina.ciocan@intel.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Irina Tirdea <irina.tirdea@intel.com>
List-Id: linux-acpi@vger.kernel.org

Parse GpioInt/GpioIo ACPI resources and use the pin configuration
information to generate pin controller maps. These maps are associated
with the "default" state, only if this state is defined in the _DSD
of the acpi device.

Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
---
 Documentation/acpi/pinctrl-properties.txt |   8 ++
 drivers/pinctrl/acpi.c                    | 229 ++++++++++++++++++++++++++++++
 2 files changed, 237 insertions(+)

diff --git a/Documentation/acpi/pinctrl-properties.txt b/Documentation/acpi/pinctrl-properties.txt
index e93aaaf..8243190 100644
--- a/Documentation/acpi/pinctrl-properties.txt
+++ b/Documentation/acpi/pinctrl-properties.txt
@@ -265,6 +265,14 @@ same way as it is done for device tree [5]. The format for the data subnode is:
   configname - name of the pin configuration property
   configval - value of the pin configuration property
 
+== GpioInt()/GpioIo() _CRS resources ==
+
+If the device has any GpioInt/GpioIo _CRS ACPI resources, they are parsed so
+that the pin configuration information is used (e.g. PullUp/PullDown/PullNone).
+The pin configuration from GpioInt/GpioIo will be associated with the "default"
+state, only if such a state is defined in the _DSD of the device. If no
+"default" state is defined, the GPIO configuration from _CRS will be ignored.
+
 == References ==
 
 [1] Documentation/pinctrl.txt
diff --git a/drivers/pinctrl/acpi.c b/drivers/pinctrl/acpi.c
index bed1d88..7199c3d 100644
--- a/drivers/pinctrl/acpi.c
+++ b/drivers/pinctrl/acpi.c
@@ -140,6 +140,224 @@ static int acpi_remember_or_free_map(struct pinctrl *p, const char *statename,
 	return pinctrl_register_map(map, num_maps, false);
 }
 
+#ifdef CONFIG_GENERIC_PINCONF
+struct acpi_gpio_lookup {
+	unsigned int index;
+	bool found;
+	unsigned int n;
+	struct pinctrl_map *map;
+	unsigned num_maps;
+	unsigned reserved_maps;
+	struct pinctrl_dev **pctldevs;
+};
+
+/* For now we only handle acpi pin config values */
+#define ACPI_MAX_CFGS 1
+
+static int acpi_parse_gpio_config(const struct acpi_resource_gpio *agpio,
+				  unsigned long **configs,
+				  unsigned int *nconfigs)
+{
+	enum pin_config_param param;
+	int ret;
+
+	/* Parse configs from GpioInt/GpioIo ACPI resource */
+	*nconfigs = 0;
+	*configs = kcalloc(ACPI_MAX_CFGS, sizeof(*configs), GFP_KERNEL);
+	if (!*configs)
+		return -ENOMEM;
+
+	/* For now, only parse pin_config */
+	switch (agpio->pin_config) {
+	case ACPI_PIN_CONFIG_DEFAULT:
+		param = PIN_CONFIG_BIAS_PULL_PIN_DEFAULT;
+		break;
+	case ACPI_PIN_CONFIG_PULLUP:
+		param = PIN_CONFIG_BIAS_PULL_UP;
+		break;
+	case ACPI_PIN_CONFIG_PULLDOWN:
+		param = PIN_CONFIG_BIAS_PULL_DOWN;
+		break;
+	case ACPI_PIN_CONFIG_NOPULL:
+		param = PIN_CONFIG_BIAS_DISABLE;
+		break;
+	default:
+		ret = -EINVAL;
+		goto exit_free;
+	}
+	*configs[*nconfigs] = pinconf_to_config_packed(param,
+				      param == PIN_CONFIG_BIAS_DISABLE ? 0 : 1);
+	(*nconfigs)++;
+
+	return 0;
+
+exit_free:
+	kfree(*configs);
+	return ret;
+}
+
+static int acpi_gpio_to_map(struct acpi_resource *ares, void *data)
+{
+	struct pinctrl_dev *pctldev, **new_pctldevs;
+	struct acpi_gpio_lookup *lookup = data;
+	const struct acpi_resource_gpio *agpio;
+	acpi_handle pctrl_handle = NULL;
+	unsigned int nconfigs, i;
+	unsigned long *configs;
+	acpi_status status;
+	const char *pin;
+	int ret;
+
+	if (ares->type != ACPI_RESOURCE_TYPE_GPIO)
+		return 1;
+	if (lookup->n++ != lookup->index || lookup->found)
+		return 1;
+
+	agpio = &ares->data.gpio;
+
+	/* Get configs from ACPI GPIO resource */
+	ret = acpi_parse_gpio_config(agpio, &configs, &nconfigs);
+	if (ret)
+		return ret;
+
+	/* Get pinctrl reference from GPIO resource */
+	status = acpi_get_handle(NULL, agpio->resource_source.string_ptr,
+				 &pctrl_handle);
+	if (ACPI_FAILURE(status) || !pctrl_handle) {
+		ret = -EINVAL;
+		goto exit_free_configs;
+	}
+
+	/* Find the pin controller */
+	pctldev = get_pinctrl_dev_from_acpi(pctrl_handle);
+	if (!pctldev) {
+		ret = -EINVAL;
+		goto exit_free_configs;
+	}
+
+	/* Allocate space for maps and pinctrl_dev references */
+	ret = pinctrl_utils_reserve_map(pctldev, &lookup->map,
+					&lookup->reserved_maps,
+					&lookup->num_maps,
+					agpio->pin_table_length);
+	if (ret < 0)
+		goto exit_free_configs;
+
+	new_pctldevs = krealloc(lookup->pctldevs,
+				sizeof(*new_pctldevs) * lookup->reserved_maps,
+				GFP_KERNEL);
+	if (!new_pctldevs) {
+		ret = -ENOMEM;
+		goto exit_free_configs;
+	}
+	lookup->pctldevs = new_pctldevs;
+
+	/* For each GPIO pin */
+	for (i = 0; i < agpio->pin_table_length; i++) {
+		pin = pin_get_name(pctldev, agpio->pin_table[i]);
+		if (!pin) {
+			ret = -EINVAL;
+			goto exit_free_configs;
+		}
+		lookup->pctldevs[lookup->num_maps] = pctldev;
+		ret = pinctrl_utils_add_map_configs(pctldev, &lookup->map,
+						    &lookup->reserved_maps,
+						    &lookup->num_maps, pin,
+						    configs, nconfigs,
+						    PIN_MAP_TYPE_CONFIGS_PIN);
+		if (ret < 0)
+			goto exit_free_configs;
+	}
+
+	lookup->found = true;
+	kfree(configs);
+	return 1;
+
+exit_free_configs:
+	kfree(configs);
+	return ret;
+}
+
+static int acpi_parse_gpio_res(struct pinctrl *p,
+			       struct pinctrl_map **map,
+			       unsigned *num_maps,
+			       struct pinctrl_dev ***pctldevs)
+{
+	struct acpi_gpio_lookup lookup;
+	struct list_head res_list;
+	struct acpi_device *adev;
+	unsigned int index;
+	int ret;
+
+	adev = ACPI_COMPANION(p->dev);
+
+	*map = NULL;
+	*num_maps = 0;
+	memset(&lookup, 0, sizeof(lookup));
+
+	/* Parse all GpioInt/GpioIo resources in _CRS and extract pin conf */
+	for (index = 0; ; index++) {
+		lookup.index = index;
+		lookup.n = 0;
+		lookup.found = false;
+
+		INIT_LIST_HEAD(&res_list);
+		ret = acpi_dev_get_resources(adev, &res_list, acpi_gpio_to_map,
+					     &lookup);
+		if (ret < 0)
+			goto exit_free;
+		acpi_dev_free_resource_list(&res_list);
+		if (!lookup.found)
+			break;
+	}
+
+	*map = lookup.map;
+	*num_maps = lookup.num_maps;
+	*pctldevs = lookup.pctldevs;
+
+	return 0;
+
+exit_free:
+	pinctrl_utils_free_map(NULL, lookup.map, lookup.num_maps);
+	kfree(lookup.pctldevs);
+	return ret;
+}
+
+static int acpi_parse_gpio_resources(struct pinctrl *p, char *statename)
+{
+	struct pinctrl_dev **pctldevs;
+	struct pinctrl_map *map;
+	unsigned num_maps;
+	unsigned int i;
+	int ret;
+
+	ret = acpi_parse_gpio_res(p, &map, &num_maps, &pctldevs);
+	if (ret)
+		return ret;
+
+	/* Add maps one by one since pinctrl devices might be different */
+	for (i = 0; i < num_maps; i++) {
+		ret = acpi_remember_or_free_map(p, statename, pctldevs[i],
+						&map[i], 1);
+		if (ret < 0)
+			goto exit_free;
+	}
+
+	kfree(pctldevs);
+	return 0;
+
+exit_free:
+	pinctrl_utils_free_map(NULL, map, num_maps);
+	kfree(pctldevs);
+	return ret;
+}
+#else
+static inline int acpi_parse_gpio_resources(struct pinctrl *p, char *statename)
+{
+	return 0;
+}
+#endif
+
 static int acpi_remember_dummy_state(struct pinctrl *p, const char *statename)
 {
 	struct pinctrl_map *map;
@@ -273,6 +491,17 @@ int pinctrl_acpi_to_map(struct pinctrl *p)
 		}
 		statename = statenames[state].string.pointer;
 
+		/*
+		 * Parse any GpioInt/GpioIo resources and
+		 * associate them with the 'default' state.
+		 */
+		if (!strcmp(statename, PINCTRL_STATE_DEFAULT)) {
+			ret = acpi_parse_gpio_resources(p, statename);
+			if (ret)
+				dev_err(p->dev,
+					"Could not parse GPIO resources\n");
+		}
+
 		/* Retrieve the pinctrl-* property */
 		propname = kasprintf(GFP_KERNEL, "pinctrl-%d", state);
 		ret = acpi_dev_get_property(adev, propname, ACPI_TYPE_PACKAGE,
-- 
1.9.1
