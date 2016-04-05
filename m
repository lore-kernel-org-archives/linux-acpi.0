From: Irina Tirdea <irina.tirdea@intel.com>
Subject: [RFC PATCH v2 3/3] pinctrl: Parse GpioInt/GpioIo resources
Date: Tue,  5 Apr 2016 18:33:26 +0300
Message-ID: <1459870406-15219-4-git-send-email-irina.tirdea@intel.com>
References: <1459870406-15219-1-git-send-email-irina.tirdea@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459870406-15219-1-git-send-email-irina.tirdea@intel.com>
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
 drivers/pinctrl/acpi.c                    | 184 ++++++++++++++++++++++++++++++
 2 files changed, 192 insertions(+)

diff --git a/Documentation/acpi/pinctrl-properties.txt b/Documentation/acpi/pinctrl-properties.txt
index 9cdf6fa..3f949d4 100644
--- a/Documentation/acpi/pinctrl-properties.txt
+++ b/Documentation/acpi/pinctrl-properties.txt
@@ -275,6 +275,14 @@ Pinctrl "sleep" state provides power management capabilities to the device that
 conflict with ACPI power management methods. Special care must be taken when using
 the "sleep" state not to create conflicts with the existing ACPI configuration.
 
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
index 0ddacaf..3b8f824 100644
--- a/drivers/pinctrl/acpi.c
+++ b/drivers/pinctrl/acpi.c
@@ -42,6 +42,17 @@ struct pinctrl_acpi_map {
 	unsigned num_maps;
 };
 
+struct acpi_gpio_lookup {
+	unsigned int index;
+	bool found;
+	unsigned int n;
+	struct pinctrl *p;
+	char *statename;
+};
+
+/* For now we only handle acpi pin config values */
+#define ACPI_MAX_CFGS 1
+
 static void acpi_maps_list_dh(acpi_handle handle, void *data)
 {
 	/* The address of this function is used as a key. */
@@ -152,6 +163,166 @@ static int acpi_remember_or_free_map(struct pinctrl *p, const char *statename,
 	return pinctrl_register_map(map, num_maps, false);
 }
 
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
+	unsigned num_maps = 0, reserved_maps = 0;
+	struct acpi_gpio_lookup *lookup = data;
+	const struct acpi_resource_gpio *agpio;
+	acpi_handle pctrl_handle = NULL;
+	struct pinctrl_map *map = NULL;
+	struct pinctrl_dev *pctldev;
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
+	ret = pinctrl_utils_reserve_map(pctldev, &map, &reserved_maps,
+					&num_maps, agpio->pin_table_length);
+	if (ret < 0)
+		goto exit_free_configs;
+
+	/* For each GPIO pin */
+	for (i = 0; i < agpio->pin_table_length; i++) {
+		pin = pin_get_name(pctldev, agpio->pin_table[i]);
+		if (!pin) {
+			ret = -EINVAL;
+			goto exit_free_map;
+		}
+		ret = pinctrl_utils_add_map_configs(pctldev, &map,
+						    &reserved_maps,
+						    &num_maps, pin,
+						    configs, nconfigs,
+						    PIN_MAP_TYPE_CONFIGS_PIN);
+		if (ret < 0)
+			goto exit_free_map;
+	}
+
+	ret = acpi_remember_or_free_map(lookup->p, lookup->statename, pctldev,
+					map, num_maps);
+	if (ret < 0)
+		goto exit_free_maps;
+
+	lookup->found = true;
+	kfree(configs);
+	return 1;
+
+exit_free_maps:
+	pinctrl_acpi_free_maps(lookup->p);
+exit_free_map:
+	pinctrl_utils_free_map(NULL, map, num_maps);
+exit_free_configs:
+	kfree(configs);
+	return ret;
+}
+
+static int acpi_parse_gpio_resources(struct pinctrl *p, char *statename)
+{
+	struct acpi_gpio_lookup lookup;
+	struct list_head res_list;
+	struct acpi_device *adev;
+	unsigned int index;
+	int ret;
+
+	adev = ACPI_COMPANION(p->dev);
+
+	memset(&lookup, 0, sizeof(lookup));
+	lookup.p = p;
+	lookup.statename = statename;
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
+			goto exit_free_maps;
+		acpi_dev_free_resource_list(&res_list);
+		if (!lookup.found)
+			break;
+	}
+
+	return 0;
+
+exit_free_maps:
+	pinctrl_acpi_free_maps(p);
+	return ret;
+}
+
 static int acpi_remember_dummy_state(struct pinctrl *p, const char *statename)
 {
 	struct pinctrl_map *map;
@@ -285,6 +456,19 @@ int pinctrl_acpi_to_map(struct pinctrl *p)
 		}
 		statename = statenames[state].string.pointer;
 
+		/*
+		 * Parse any GpioInt/GpioIo resources and
+		 * associate them with the 'default' state.
+		 */
+		if (!strcmp(statename, PINCTRL_STATE_DEFAULT)) {
+			ret = acpi_parse_gpio_resources(p, statename);
+			if (ret) {
+				dev_err(p->dev,
+					"Could not parse GPIO resources\n");
+				goto err_free_maps;
+			}
+		}
+
 		/* Retrieve the pinctrl-* property */
 		propname = kasprintf(GFP_KERNEL, "pinctrl-%d", state);
 		ret = acpi_dev_get_property(adev, propname, ACPI_TYPE_PACKAGE,
-- 
1.9.1
