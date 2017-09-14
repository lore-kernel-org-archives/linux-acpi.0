From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [RFC 2/5] of: Return -ENODATA on accessing out of bounds indices in phandle parsing
Date: Thu, 14 Sep 2017 15:29:11 +0300
Message-ID: <20170914122914.14122-3-sakari.ailus@linux.intel.com>
References: <20170914122914.14122-1-sakari.ailus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nblzone-211-213.nblnetworks.fi ([83.145.211.213]:32850 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751766AbdINM3R (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 14 Sep 2017 08:29:17 -0400
In-Reply-To: <20170914122914.14122-1-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: devicetree@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: rafael@kernel.org, robh@kernel.org, mika.westerberg@linux.intel.com, frowand.list@gmail.com

On functions iterating over lists of phandles using
of_phandle_iterator_init() and of_phandle_iterator_next()
(of_count_phandle_with_args, of_parse_phandle_with_args() and
of_parse_phandle_with_fixed_args()), -ENOENT is used to be signal three
distinct conditions:

1) Iterating over an entry that contains an empty phandle. An empty
phandle may be situated in the middle of a phandle list but there may be
valid phandles after it.

2) Accessing an index in a property containing phandles (with possible
integer arguments) which does not exist in a property.

3) Parsing a property that does not exist.

Because of 1 and 2 above,, when parsing phandles and arguments one by one
without knowing the total number, it is not possible to distinguish
whether one has reached the end of the list or whether an individual entry
is empty.

What this patch does is that it changes the functions using
of_phandle_iterator_next() to return -ENODATA in the case of accessing an
index that is not present in an array, instead of -ENOENT. This way the
two conditions can be told apart.

This is in line with the behaviour of existing ACPI framework function
__acpi_node_get_property_reference().

-ENODATA will be also returned in case the property does not exist.
__acpi_node_get_property_reference() returns -EINVAL in that case but also
on parse error whereas for the caller a non-existent property is
essentially the same as having a property but it's got no entries, hence
-ENODATA makes sense.

-EINVAL is returned by both the OF and ACPI variants on parse error.

Document the different error codes for of_parse_phandle_with_args() and
of_parse_phandle_with_fixed_args().

As part of the change, distribute the handling of the new error code to
the callers that make use of -ENOENT to skip entries. In order to retain
the original functionality, return -ENOENT to the original caller in case
of -ENODATA.

Not call callers are changed, a majority if the callers are actually
driver probe functions or machine setup code where the precise error code
does not really matter.

For consistency, of_count_phandle_with_args() has been changed to reflect
this as well; consequently of_gpio_named_count() and of_gpio_count() are
affected, too.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/base/power/domain.c          |  2 +-
 drivers/clk/clk-conf.c               |  4 ++--
 drivers/clk/clkdev.c                 |  2 +-
 drivers/gpio/gpiolib-of.c            |  2 +-
 drivers/gpio/gpiolib.c               |  2 +-
 drivers/gpu/host1x/mipi.c            |  2 +-
 drivers/hwspinlock/hwspinlock_core.c |  2 +-
 drivers/iio/inkern.c                 |  2 +-
 drivers/of/base.c                    | 23 ++++++++++++++++++-----
 drivers/pwm/core.c                   |  2 +-
 drivers/regulator/gpio-regulator.c   |  2 +-
 drivers/reset/core.c                 |  3 ++-
 drivers/spi/spi.c                    |  2 +-
 13 files changed, 32 insertions(+), 18 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index e8ca5e2cf1e5..a346001678ff 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2112,7 +2112,7 @@ int genpd_dev_pm_attach(struct device *dev)
 	ret = of_parse_phandle_with_args(dev->of_node, "power-domains",
 					"#power-domain-cells", 0, &pd_args);
 	if (ret < 0) {
-		if (ret != -ENOENT)
+		if (ret != -ENOENT && ret != -ENODATA)
 			return ret;
 
 		/*
diff --git a/drivers/clk/clk-conf.c b/drivers/clk/clk-conf.c
index 7b7113d86875..8535f6a613cb 100644
--- a/drivers/clk/clk-conf.c
+++ b/drivers/clk/clk-conf.c
@@ -31,7 +31,7 @@ static int __set_clk_parents(struct device_node *node, bool clk_supplier)
 					"#clock-cells",	index, &clkspec);
 		if (rc < 0) {
 			/* skip empty (null) phandles */
-			if (rc == -ENOENT)
+			if (rc == -ENOENT || rc == -ENODATA)
 				continue;
 			else
 				return rc;
@@ -91,7 +91,7 @@ static int __set_clk_rates(struct device_node *node, bool clk_supplier)
 					"#clock-cells",	index, &clkspec);
 			if (rc < 0) {
 				/* skip empty (null) phandles */
-				if (rc == -ENOENT) {
+				if (rc == -ENOENT || rc == -ENODATA) {
 					index++;
 					continue;
 				} else {
diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index 6b2f29df3f70..b6946241a193 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -41,7 +41,7 @@ static struct clk *__of_clk_get(struct device_node *np, int index,
 	rc = of_parse_phandle_with_args(np, "clocks", "#clock-cells", index,
 					&clkspec);
 	if (rc)
-		return ERR_PTR(rc);
+		return ERR_PTR(rc == -ENODATA ? -ENOENT : rc);
 
 	clk = __of_clk_get_from_provider(&clkspec, dev_id, con_id);
 	of_node_put(clkspec.np);
diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index bfcd20699ec8..928f9ac732cc 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -80,7 +80,7 @@ struct gpio_desc *of_get_named_gpiod_flags(struct device_node *np,
 	if (ret) {
 		pr_debug("%s: can't parse '%s' property of node '%pOF[%d]'\n",
 			__func__, propname, np, index);
-		return ERR_PTR(ret);
+		return ERR_PTR(ret == -ENODATA ? -ENOENT : ret);
 	}
 
 	chip = of_find_gpiochip_by_xlate(&gpiospec);
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index eb80dac4e26a..5ef114a77493 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -3163,7 +3163,7 @@ static int dt_gpio_count(struct device *dev, const char *con_id)
 		if (ret > 0)
 			break;
 	}
-	return ret ? ret : -ENOENT;
+	return ret ? ret : -ENODATA;
 }
 
 static int platform_gpio_count(struct device *dev, const char *con_id)
diff --git a/drivers/gpu/host1x/mipi.c b/drivers/gpu/host1x/mipi.c
index e00809d996a2..ed08ff54e3ef 100644
--- a/drivers/gpu/host1x/mipi.c
+++ b/drivers/gpu/host1x/mipi.c
@@ -217,7 +217,7 @@ struct tegra_mipi_device *tegra_mipi_request(struct device *device)
 					 "#nvidia,mipi-calibrate-cells", 0,
 					 &args);
 	if (err < 0)
-		return ERR_PTR(err);
+		return ERR_PTR(err == -ENODATA ? -ENOENT : err);
 
 	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
 	if (!dev) {
diff --git a/drivers/hwspinlock/hwspinlock_core.c b/drivers/hwspinlock/hwspinlock_core.c
index 4074441444fe..efac9beb72c6 100644
--- a/drivers/hwspinlock/hwspinlock_core.c
+++ b/drivers/hwspinlock/hwspinlock_core.c
@@ -304,7 +304,7 @@ int of_hwspin_lock_get_id(struct device_node *np, int index)
 	ret = of_parse_phandle_with_args(np, "hwlocks", "#hwlock-cells", index,
 					 &args);
 	if (ret)
-		return ret;
+		return ret == -ENODATA ? -ENOENT : ret;
 
 	/* Find the hwspinlock device: we need its base_id */
 	ret = -EPROBE_DEFER;
diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index 069defcc6d9b..fb850b040228 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -135,7 +135,7 @@ static int __of_iio_channel_get(struct iio_channel *channel,
 					 "#io-channel-cells",
 					 index, &iiospec);
 	if (err)
-		return err;
+		return err == -ENODATA ? -ENOENT : err;
 
 	idev = bus_find_device(&iio_bus_type, NULL, iiospec.np,
 			       iio_dev_node_match);
diff --git a/drivers/of/base.c b/drivers/of/base.c
index 260d33c0f26c..fb2fd90f525c 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1142,7 +1142,7 @@ int of_phandle_iterator_init(struct of_phandle_iterator *it,
 
 	list = of_get_property(np, list_name, &size);
 	if (!list)
-		return -ENOENT;
+		return -ENODATA;
 
 	it->cells_name = cells_name;
 	it->cell_count = cell_count;
@@ -1165,7 +1165,7 @@ int of_phandle_iterator_next(struct of_phandle_iterator *it)
 	}
 
 	if (!it->cur || it->phandle_end >= it->list_end)
-		return -ENOENT;
+		return -ENODATA;
 
 	it->cur = it->phandle_end;
 
@@ -1351,6 +1351,10 @@ EXPORT_SYMBOL(of_parse_phandle);
  *
  * To get a device_node of the `node2' node you may call this:
  * of_parse_phandle_with_args(node3, "list", "#list-cells", 1, &args);
+ *
+ * Returns %0 on success, %-ENOENT on an empty phandle, %-ENODATA on
+ * out-of-bounds index or if the property does not exist and %-EINVAL on
+ * parse error or if index is negative.
  */
 int of_parse_phandle_with_args(const struct device_node *np, const char *list_name,
 				const char *cells_name, int index,
@@ -1392,6 +1396,10 @@ EXPORT_SYMBOL(of_parse_phandle_with_args);
  *
  * To get a device_node of the `node2' node you may call this:
  * of_parse_phandle_with_fixed_args(node3, "list", 2, 1, &args);
+ *
+ * Returns %0 on success, %-ENOENT on an empty phandle, %-ENODATA on
+ * out-of-bounds index or if the property does not exist and %-EINVAL on
+ * parse error or if index is negative.
  */
 int of_parse_phandle_with_fixed_args(const struct device_node *np,
 				const char *list_name, int cell_count,
@@ -1418,6 +1426,10 @@ EXPORT_SYMBOL(of_parse_phandle_with_fixed_args);
  * phandle and 1 or more arguments. The number of arguments are
  * determined by the #gpio-cells property in the node pointed to by the
  * phandle.
+ *
+ * Returns the number of phandles + arguments tuples within a property
+ * on success, %-ENODATA if the property isn't found and %-EINVAL on
+ * parse error.
  */
 int of_count_phandle_with_args(const struct device_node *np, const char *list_name,
 				const char *cells_name)
@@ -1429,11 +1441,12 @@ int of_count_phandle_with_args(const struct device_node *np, const char *list_na
 	if (rc)
 		return rc;
 
-	while ((rc = of_phandle_iterator_next(&it)) == 0)
+	for (rc = of_phandle_iterator_next(&it); !rc;
+	     rc = of_phandle_iterator_next(&it))
 		cur_index += 1;
 
-	if (rc != -ENOENT)
-		return rc;
+	if (rc != -ENODATA && rc != -ENOENT)
+		return rc == -ENOENT ? -ENODATA : rc;
 
 	return cur_index;
 }
diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 1581f6ab1b1f..f54f4f58994c 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -673,7 +673,7 @@ struct pwm_device *of_pwm_get(struct device_node *np, const char *con_id)
 					 &args);
 	if (err) {
 		pr_err("%s(): can't parse \"pwms\" property\n", __func__);
-		return ERR_PTR(err);
+		return ERR_PTR(err == -ENODATA ? -ENOENT : err);
 	}
 
 	pc = of_node_to_pwmchip(args.np);
diff --git a/drivers/regulator/gpio-regulator.c b/drivers/regulator/gpio-regulator.c
index 0fce06acfaec..8adcd25ec843 100644
--- a/drivers/regulator/gpio-regulator.c
+++ b/drivers/regulator/gpio-regulator.c
@@ -167,7 +167,7 @@ of_get_gpio_regulator_config(struct device *dev, struct device_node *np,
 
 	/* Fetch GPIOs. - optional property*/
 	ret = of_gpio_count(np);
-	if ((ret < 0) && (ret != -ENOENT))
+	if ((ret < 0) && (ret != -ENODATA))
 		return ERR_PTR(ret);
 
 	if (ret > 0) {
diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index 1d21c6f7d56c..81aab379042f 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -456,7 +456,8 @@ struct reset_control *__of_reset_control_get(struct device_node *node,
 	if (ret == -EINVAL)
 		return ERR_PTR(ret);
 	if (ret)
-		return optional ? NULL : ERR_PTR(ret);
+		return optional ? NULL :
+				  ERR_PTR(ret == -ENODATA ? -ENOENT : ret);
 
 	mutex_lock(&reset_list_mutex);
 	rcdev = NULL;
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 6e65524cbfd9..6d35154d84ff 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2031,7 +2031,7 @@ static int of_spi_register_master(struct spi_controller *ctlr)
 	ctlr->num_chipselect = max_t(int, nb, ctlr->num_chipselect);
 
 	/* Return error only for an incorrectly formed cs-gpios property */
-	if (nb == 0 || nb == -ENOENT)
+	if (nb == 0 || nb == -ENODATA)
 		return 0;
 	else if (nb < 0)
 		return nb;
-- 
2.11.0

