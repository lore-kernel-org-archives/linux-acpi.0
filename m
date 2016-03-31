From: Irina Tirdea <irina.tirdea@intel.com>
Subject: [RFC PATCH 1/4] pinctrl: Rename pinctrl_utils_dt_free_map to pinctrl_utils_free_map
Date: Thu, 31 Mar 2016 14:44:42 +0300
Message-ID: <1459424685-26965-2-git-send-email-irina.tirdea@intel.com>
References: <1459424685-26965-1-git-send-email-irina.tirdea@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459424685-26965-1-git-send-email-irina.tirdea@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Octavian Purdila <octavian.purdila@intel.com>, Cristina Ciocan <cristina.ciocan@intel.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Irina Tirdea <irina.tirdea@intel.com>
List-Id: linux-acpi@vger.kernel.org

Rename pinctrl_utils_dt_free_map to pinctrl_utils_free_map, since
it does not depend on device tree despite the current name. This
will enforce a consistent naming in pinctr-utils.c and will make
it clear it can be called from outside device tree (e.g. from
ACPI handling code).

Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
---
 drivers/pinctrl/bcm/pinctrl-bcm281xx.c           | 2 +-
 drivers/pinctrl/bcm/pinctrl-cygnus-mux.c         | 2 +-
 drivers/pinctrl/bcm/pinctrl-iproc-gpio.c         | 2 +-
 drivers/pinctrl/bcm/pinctrl-nsp-gpio.c           | 2 +-
 drivers/pinctrl/berlin/berlin.c                  | 2 +-
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c    | 4 ++--
 drivers/pinctrl/meson/pinctrl-meson.c            | 2 +-
 drivers/pinctrl/nomadik/pinctrl-abx500.c         | 4 ++--
 drivers/pinctrl/nomadik/pinctrl-nomadik.c        | 4 ++--
 drivers/pinctrl/pinconf-generic.c                | 2 +-
 drivers/pinctrl/pinctrl-amd.c                    | 2 +-
 drivers/pinctrl/pinctrl-as3722.c                 | 2 +-
 drivers/pinctrl/pinctrl-at91-pio4.c              | 4 ++--
 drivers/pinctrl/pinctrl-digicolor.c              | 2 +-
 drivers/pinctrl/pinctrl-lpc18xx.c                | 2 +-
 drivers/pinctrl/pinctrl-palmas.c                 | 2 +-
 drivers/pinctrl/pinctrl-pic32.c                  | 2 +-
 drivers/pinctrl/pinctrl-pistachio.c              | 2 +-
 drivers/pinctrl/pinctrl-tb10x.c                  | 2 +-
 drivers/pinctrl/pinctrl-utils.c                  | 4 ++--
 drivers/pinctrl/pinctrl-utils.h                  | 2 +-
 drivers/pinctrl/pinctrl-zynq.c                   | 2 +-
 drivers/pinctrl/pxa/pinctrl-pxa2xx.c             | 2 +-
 drivers/pinctrl/qcom/pinctrl-msm.c               | 2 +-
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c         | 2 +-
 drivers/pinctrl/qcom/pinctrl-spmi-mpp.c          | 2 +-
 drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c         | 2 +-
 drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c          | 2 +-
 drivers/pinctrl/stm32/pinctrl-stm32.c            | 4 ++--
 drivers/pinctrl/tegra/pinctrl-tegra-xusb.c       | 2 +-
 drivers/pinctrl/tegra/pinctrl-tegra.c            | 4 ++--
 drivers/pinctrl/uniphier/pinctrl-uniphier-core.c | 2 +-
 32 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/drivers/pinctrl/bcm/pinctrl-bcm281xx.c b/drivers/pinctrl/bcm/pinctrl-bcm281xx.c
index c3c692e..f043b83 100644
--- a/drivers/pinctrl/bcm/pinctrl-bcm281xx.c
+++ b/drivers/pinctrl/bcm/pinctrl-bcm281xx.c
@@ -1024,7 +1024,7 @@ static struct pinctrl_ops bcm281xx_pinctrl_ops = {
 	.get_group_pins = bcm281xx_pinctrl_get_group_pins,
 	.pin_dbg_show = bcm281xx_pinctrl_pin_dbg_show,
 	.dt_node_to_map = pinconf_generic_dt_node_to_map_pin,
-	.dt_free_map = pinctrl_utils_dt_free_map,
+	.dt_free_map = pinctrl_utils_free_map,
 };
 
 static int bcm281xx_pinctrl_get_fcns_count(struct pinctrl_dev *pctldev)
diff --git a/drivers/pinctrl/bcm/pinctrl-cygnus-mux.c b/drivers/pinctrl/bcm/pinctrl-cygnus-mux.c
index 9728f3d..f0184dc 100644
--- a/drivers/pinctrl/bcm/pinctrl-cygnus-mux.c
+++ b/drivers/pinctrl/bcm/pinctrl-cygnus-mux.c
@@ -737,7 +737,7 @@ static const struct pinctrl_ops cygnus_pinctrl_ops = {
 	.get_group_pins = cygnus_get_group_pins,
 	.pin_dbg_show = cygnus_pin_dbg_show,
 	.dt_node_to_map = pinconf_generic_dt_node_to_map_group,
-	.dt_free_map = pinctrl_utils_dt_free_map,
+	.dt_free_map = pinctrl_utils_free_map,
 };
 
 static int cygnus_get_functions_count(struct pinctrl_dev *pctrl_dev)
diff --git a/drivers/pinctrl/bcm/pinctrl-iproc-gpio.c b/drivers/pinctrl/bcm/pinctrl-iproc-gpio.c
index d530ab4..9ed9881 100644
--- a/drivers/pinctrl/bcm/pinctrl-iproc-gpio.c
+++ b/drivers/pinctrl/bcm/pinctrl-iproc-gpio.c
@@ -379,7 +379,7 @@ static const struct pinctrl_ops iproc_pctrl_ops = {
 	.get_groups_count = iproc_get_groups_count,
 	.get_group_name = iproc_get_group_name,
 	.dt_node_to_map = pinconf_generic_dt_node_to_map_pin,
-	.dt_free_map = pinctrl_utils_dt_free_map,
+	.dt_free_map = pinctrl_utils_free_map,
 };
 
 static int iproc_gpio_set_pull(struct iproc_gpio *chip, unsigned gpio,
diff --git a/drivers/pinctrl/bcm/pinctrl-nsp-gpio.c b/drivers/pinctrl/bcm/pinctrl-nsp-gpio.c
index ac90043..6c7d5f5 100644
--- a/drivers/pinctrl/bcm/pinctrl-nsp-gpio.c
+++ b/drivers/pinctrl/bcm/pinctrl-nsp-gpio.c
@@ -363,7 +363,7 @@ static const struct pinctrl_ops nsp_pctrl_ops = {
 	.get_groups_count = nsp_get_groups_count,
 	.get_group_name = nsp_get_group_name,
 	.dt_node_to_map = pinconf_generic_dt_node_to_map_pin,
-	.dt_free_map = pinctrl_utils_dt_free_map,
+	.dt_free_map = pinctrl_utils_free_map,
 };
 
 static int nsp_gpio_set_slew(struct nsp_gpio *chip, unsigned gpio, u16 slew)
diff --git a/drivers/pinctrl/berlin/berlin.c b/drivers/pinctrl/berlin/berlin.c
index 46f2b48..87b17b7 100644
--- a/drivers/pinctrl/berlin/berlin.c
+++ b/drivers/pinctrl/berlin/berlin.c
@@ -104,7 +104,7 @@ static const struct pinctrl_ops berlin_pinctrl_ops = {
 	.get_groups_count	= &berlin_pinctrl_get_group_count,
 	.get_group_name		= &berlin_pinctrl_get_group_name,
 	.dt_node_to_map		= &berlin_pinctrl_dt_node_to_map,
-	.dt_free_map		= &pinctrl_utils_dt_free_map,
+	.dt_free_map		= &pinctrl_utils_free_map,
 };
 
 static int berlin_pinmux_get_functions_count(struct pinctrl_dev *pctrl_dev)
diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
index 2bbe6f7..8ca82c1 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
@@ -605,7 +605,7 @@ static int mtk_pctrl_dt_node_to_map(struct pinctrl_dev *pctldev,
 		ret = mtk_pctrl_dt_subnode_to_map(pctldev, np, map,
 				&reserved_maps, num_maps);
 		if (ret < 0) {
-			pinctrl_utils_dt_free_map(pctldev, *map, *num_maps);
+			pinctrl_utils_free_map(pctldev, *map, *num_maps);
 			of_node_put(np);
 			return ret;
 		}
@@ -644,7 +644,7 @@ static int mtk_pctrl_get_group_pins(struct pinctrl_dev *pctldev,
 
 static const struct pinctrl_ops mtk_pctrl_ops = {
 	.dt_node_to_map		= mtk_pctrl_dt_node_to_map,
-	.dt_free_map		= pinctrl_utils_dt_free_map,
+	.dt_free_map		= pinctrl_utils_free_map,
 	.get_groups_count	= mtk_pctrl_get_groups_count,
 	.get_group_name		= mtk_pctrl_get_group_name,
 	.get_group_pins		= mtk_pctrl_get_group_pins,
diff --git a/drivers/pinctrl/meson/pinctrl-meson.c b/drivers/pinctrl/meson/pinctrl-meson.c
index 0bdb8fd..5bcbd3e 100644
--- a/drivers/pinctrl/meson/pinctrl-meson.c
+++ b/drivers/pinctrl/meson/pinctrl-meson.c
@@ -171,7 +171,7 @@ static const struct pinctrl_ops meson_pctrl_ops = {
 	.get_group_name		= meson_get_group_name,
 	.get_group_pins		= meson_get_group_pins,
 	.dt_node_to_map		= pinconf_generic_dt_node_to_map_all,
-	.dt_free_map		= pinctrl_utils_dt_free_map,
+	.dt_free_map		= pinctrl_utils_free_map,
 	.pin_dbg_show		= meson_pin_dbg_show,
 };
 
diff --git a/drivers/pinctrl/nomadik/pinctrl-abx500.c b/drivers/pinctrl/nomadik/pinctrl-abx500.c
index 1f7469c..5323568 100644
--- a/drivers/pinctrl/nomadik/pinctrl-abx500.c
+++ b/drivers/pinctrl/nomadik/pinctrl-abx500.c
@@ -937,7 +937,7 @@ static int abx500_dt_node_to_map(struct pinctrl_dev *pctldev,
 		ret = abx500_dt_subnode_to_map(pctldev, np, map,
 				&reserved_maps, num_maps);
 		if (ret < 0) {
-			pinctrl_utils_dt_free_map(pctldev, *map, *num_maps);
+			pinctrl_utils_free_map(pctldev, *map, *num_maps);
 			return ret;
 		}
 	}
@@ -951,7 +951,7 @@ static const struct pinctrl_ops abx500_pinctrl_ops = {
 	.get_group_pins = abx500_get_group_pins,
 	.pin_dbg_show = abx500_pin_dbg_show,
 	.dt_node_to_map = abx500_dt_node_to_map,
-	.dt_free_map = pinctrl_utils_dt_free_map,
+	.dt_free_map = pinctrl_utils_free_map,
 };
 
 static int abx500_pin_config_get(struct pinctrl_dev *pctldev,
diff --git a/drivers/pinctrl/nomadik/pinctrl-nomadik.c b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
index 3524061..c9c8c17 100644
--- a/drivers/pinctrl/nomadik/pinctrl-nomadik.c
+++ b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
@@ -1612,7 +1612,7 @@ static int nmk_pinctrl_dt_node_to_map(struct pinctrl_dev *pctldev,
 		ret = nmk_pinctrl_dt_subnode_to_map(pctldev, np, map,
 				&reserved_maps, num_maps);
 		if (ret < 0) {
-			pinctrl_utils_dt_free_map(pctldev, *map, *num_maps);
+			pinctrl_utils_free_map(pctldev, *map, *num_maps);
 			return ret;
 		}
 	}
@@ -1626,7 +1626,7 @@ static const struct pinctrl_ops nmk_pinctrl_ops = {
 	.get_group_pins = nmk_get_group_pins,
 	.pin_dbg_show = nmk_pin_dbg_show,
 	.dt_node_to_map = nmk_pinctrl_dt_node_to_map,
-	.dt_free_map = pinctrl_utils_dt_free_map,
+	.dt_free_map = pinctrl_utils_free_map,
 };
 
 static int nmk_pmx_get_funcs_cnt(struct pinctrl_dev *pctldev)
diff --git a/drivers/pinctrl/pinconf-generic.c b/drivers/pinctrl/pinconf-generic.c
index 79e6159..d5bf9fa 100644
--- a/drivers/pinctrl/pinconf-generic.c
+++ b/drivers/pinctrl/pinconf-generic.c
@@ -386,7 +386,7 @@ int pinconf_generic_dt_node_to_map(struct pinctrl_dev *pctldev,
 	return 0;
 
 exit:
-	pinctrl_utils_dt_free_map(pctldev, *map, *num_maps);
+	pinctrl_utils_free_map(pctldev, *map, *num_maps);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(pinconf_generic_dt_node_to_map);
diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
index 5c025f5..f71a04e 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -580,7 +580,7 @@ static const struct pinctrl_ops amd_pinctrl_ops = {
 	.get_group_pins		= amd_get_group_pins,
 #ifdef CONFIG_OF
 	.dt_node_to_map		= pinconf_generic_dt_node_to_map_group,
-	.dt_free_map		= pinctrl_utils_dt_free_map,
+	.dt_free_map		= pinctrl_utils_free_map,
 #endif
 };
 
diff --git a/drivers/pinctrl/pinctrl-as3722.c b/drivers/pinctrl/pinctrl-as3722.c
index e844fdc..1070bb9 100644
--- a/drivers/pinctrl/pinctrl-as3722.c
+++ b/drivers/pinctrl/pinctrl-as3722.c
@@ -201,7 +201,7 @@ static const struct pinctrl_ops as3722_pinctrl_ops = {
 	.get_group_name = as3722_pinctrl_get_group_name,
 	.get_group_pins = as3722_pinctrl_get_group_pins,
 	.dt_node_to_map = pinconf_generic_dt_node_to_map_pin,
-	.dt_free_map = pinctrl_utils_dt_free_map,
+	.dt_free_map = pinctrl_utils_free_map,
 };
 
 static int as3722_pinctrl_get_funcs_count(struct pinctrl_dev *pctldev)
diff --git a/drivers/pinctrl/pinctrl-at91-pio4.c b/drivers/pinctrl/pinctrl-at91-pio4.c
index 4429312..629b6fe 100644
--- a/drivers/pinctrl/pinctrl-at91-pio4.c
+++ b/drivers/pinctrl/pinctrl-at91-pio4.c
@@ -579,7 +579,7 @@ static int atmel_pctl_dt_node_to_map(struct pinctrl_dev *pctldev,
 	}
 
 	if (ret < 0) {
-		pinctrl_utils_dt_free_map(pctldev, *map, *num_maps);
+		pinctrl_utils_free_map(pctldev, *map, *num_maps);
 		dev_err(pctldev->dev, "can't create maps for node %s\n",
 			np_config->full_name);
 	}
@@ -592,7 +592,7 @@ static const struct pinctrl_ops atmel_pctlops = {
 	.get_group_name		= atmel_pctl_get_group_name,
 	.get_group_pins		= atmel_pctl_get_group_pins,
 	.dt_node_to_map		= atmel_pctl_dt_node_to_map,
-	.dt_free_map		= pinctrl_utils_dt_free_map,
+	.dt_free_map		= pinctrl_utils_free_map,
 };
 
 static int atmel_pmx_get_functions_count(struct pinctrl_dev *pctldev)
diff --git a/drivers/pinctrl/pinctrl-digicolor.c b/drivers/pinctrl/pinctrl-digicolor.c
index f1343d6..b347806 100644
--- a/drivers/pinctrl/pinctrl-digicolor.c
+++ b/drivers/pinctrl/pinctrl-digicolor.c
@@ -84,7 +84,7 @@ static struct pinctrl_ops dc_pinctrl_ops = {
 	.get_group_name		= dc_get_group_name,
 	.get_group_pins		= dc_get_group_pins,
 	.dt_node_to_map		= pinconf_generic_dt_node_to_map_pin,
-	.dt_free_map		= pinctrl_utils_dt_free_map,
+	.dt_free_map		= pinctrl_utils_free_map,
 };
 
 static const char *const dc_functions[] = {
diff --git a/drivers/pinctrl/pinctrl-lpc18xx.c b/drivers/pinctrl/pinctrl-lpc18xx.c
index b1767f7..e897b63 100644
--- a/drivers/pinctrl/pinctrl-lpc18xx.c
+++ b/drivers/pinctrl/pinctrl-lpc18xx.c
@@ -1252,7 +1252,7 @@ static const struct pinctrl_ops lpc18xx_pctl_ops = {
 	.get_group_name		= lpc18xx_pctl_get_group_name,
 	.get_group_pins		= lpc18xx_pctl_get_group_pins,
 	.dt_node_to_map		= pinconf_generic_dt_node_to_map_pin,
-	.dt_free_map		= pinctrl_utils_dt_free_map,
+	.dt_free_map		= pinctrl_utils_free_map,
 };
 
 static struct pinctrl_desc lpc18xx_scu_desc = {
diff --git a/drivers/pinctrl/pinctrl-palmas.c b/drivers/pinctrl/pinctrl-palmas.c
index f7e1680..8f0163f 100644
--- a/drivers/pinctrl/pinctrl-palmas.c
+++ b/drivers/pinctrl/pinctrl-palmas.c
@@ -656,7 +656,7 @@ static const struct pinctrl_ops palmas_pinctrl_ops = {
 	.get_group_name = palmas_pinctrl_get_group_name,
 	.get_group_pins = palmas_pinctrl_get_group_pins,
 	.dt_node_to_map = pinconf_generic_dt_node_to_map_pin,
-	.dt_free_map = pinctrl_utils_dt_free_map,
+	.dt_free_map = pinctrl_utils_free_map,
 };
 
 static int palmas_pinctrl_get_funcs_count(struct pinctrl_dev *pctldev)
diff --git a/drivers/pinctrl/pinctrl-pic32.c b/drivers/pinctrl/pinctrl-pic32.c
index 0b07d4b..87ee1c4 100644
--- a/drivers/pinctrl/pinctrl-pic32.c
+++ b/drivers/pinctrl/pinctrl-pic32.c
@@ -1743,7 +1743,7 @@ static const struct pinctrl_ops pic32_pinctrl_ops = {
 	.get_group_name = pic32_pinctrl_get_group_name,
 	.get_group_pins = pic32_pinctrl_get_group_pins,
 	.dt_node_to_map = pinconf_generic_dt_node_to_map_pin,
-	.dt_free_map = pinctrl_utils_dt_free_map,
+	.dt_free_map = pinctrl_utils_free_map,
 };
 
 static int pic32_pinmux_get_functions_count(struct pinctrl_dev *pctldev)
diff --git a/drivers/pinctrl/pinctrl-pistachio.c b/drivers/pinctrl/pinctrl-pistachio.c
index 2673cd9..65874b5 100644
--- a/drivers/pinctrl/pinctrl-pistachio.c
+++ b/drivers/pinctrl/pinctrl-pistachio.c
@@ -913,7 +913,7 @@ static const struct pinctrl_ops pistachio_pinctrl_ops = {
 	.get_group_name = pistachio_pinctrl_get_group_name,
 	.get_group_pins = pistachio_pinctrl_get_group_pins,
 	.dt_node_to_map = pinconf_generic_dt_node_to_map_pin,
-	.dt_free_map = pinctrl_utils_dt_free_map,
+	.dt_free_map = pinctrl_utils_free_map,
 };
 
 static int pistachio_pinmux_get_functions_count(struct pinctrl_dev *pctldev)
diff --git a/drivers/pinctrl/pinctrl-tb10x.c b/drivers/pinctrl/pinctrl-tb10x.c
index 6546b9b..620af57 100644
--- a/drivers/pinctrl/pinctrl-tb10x.c
+++ b/drivers/pinctrl/pinctrl-tb10x.c
@@ -582,7 +582,7 @@ static struct pinctrl_ops tb10x_pinctrl_ops = {
 	.get_group_name   = tb10x_get_group_name,
 	.get_group_pins   = tb10x_get_group_pins,
 	.dt_node_to_map   = tb10x_dt_node_to_map,
-	.dt_free_map      = pinctrl_utils_dt_free_map,
+	.dt_free_map      = pinctrl_utils_free_map,
 };
 
 static int tb10x_get_functions_count(struct pinctrl_dev *pctl)
diff --git a/drivers/pinctrl/pinctrl-utils.c b/drivers/pinctrl/pinctrl-utils.c
index d77693f..9189fba 100644
--- a/drivers/pinctrl/pinctrl-utils.c
+++ b/drivers/pinctrl/pinctrl-utils.c
@@ -122,7 +122,7 @@ int pinctrl_utils_add_config(struct pinctrl_dev *pctldev,
 }
 EXPORT_SYMBOL_GPL(pinctrl_utils_add_config);
 
-void pinctrl_utils_dt_free_map(struct pinctrl_dev *pctldev,
+void pinctrl_utils_free_map(struct pinctrl_dev *pctldev,
 	      struct pinctrl_map *map, unsigned num_maps)
 {
 	int i;
@@ -139,4 +139,4 @@ void pinctrl_utils_dt_free_map(struct pinctrl_dev *pctldev,
 	}
 	kfree(map);
 }
-EXPORT_SYMBOL_GPL(pinctrl_utils_dt_free_map);
+EXPORT_SYMBOL_GPL(pinctrl_utils_free_map);
diff --git a/drivers/pinctrl/pinctrl-utils.h b/drivers/pinctrl/pinctrl-utils.h
index d0ffe1c..8f9f2d2 100644
--- a/drivers/pinctrl/pinctrl-utils.h
+++ b/drivers/pinctrl/pinctrl-utils.h
@@ -37,7 +37,7 @@ int pinctrl_utils_add_map_configs(struct pinctrl_dev *pctldev,
 int pinctrl_utils_add_config(struct pinctrl_dev *pctldev,
 		unsigned long **configs, unsigned *num_configs,
 		unsigned long config);
-void pinctrl_utils_dt_free_map(struct pinctrl_dev *pctldev,
+void pinctrl_utils_free_map(struct pinctrl_dev *pctldev,
 		struct pinctrl_map *map, unsigned num_maps);
 
 #endif /* __PINCTRL_UTILS_H__ */
diff --git a/drivers/pinctrl/pinctrl-zynq.c b/drivers/pinctrl/pinctrl-zynq.c
index 76f1abd..3f1b55f 100644
--- a/drivers/pinctrl/pinctrl-zynq.c
+++ b/drivers/pinctrl/pinctrl-zynq.c
@@ -862,7 +862,7 @@ static const struct pinctrl_ops zynq_pctrl_ops = {
 	.get_group_name = zynq_pctrl_get_group_name,
 	.get_group_pins = zynq_pctrl_get_group_pins,
 	.dt_node_to_map = pinconf_generic_dt_node_to_map_all,
-	.dt_free_map = pinctrl_utils_dt_free_map,
+	.dt_free_map = pinctrl_utils_free_map,
 };
 
 /* pinmux */
diff --git a/drivers/pinctrl/pxa/pinctrl-pxa2xx.c b/drivers/pinctrl/pxa/pinctrl-pxa2xx.c
index f553313..6098685 100644
--- a/drivers/pinctrl/pxa/pinctrl-pxa2xx.c
+++ b/drivers/pinctrl/pxa/pinctrl-pxa2xx.c
@@ -57,7 +57,7 @@ static int pxa2xx_pctrl_get_group_pins(struct pinctrl_dev *pctldev,
 static const struct pinctrl_ops pxa2xx_pctl_ops = {
 #ifdef CONFIG_OF
 	.dt_node_to_map		= pinconf_generic_dt_node_to_map_all,
-	.dt_free_map		= pinctrl_utils_dt_free_map,
+	.dt_free_map		= pinctrl_utils_free_map,
 #endif
 	.get_groups_count	= pxa2xx_pctrl_get_groups_count,
 	.get_group_name		= pxa2xx_pctrl_get_group_name,
diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index 8777cf0..f9322d4 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -101,7 +101,7 @@ static const struct pinctrl_ops msm_pinctrl_ops = {
 	.get_group_name		= msm_get_group_name,
 	.get_group_pins		= msm_get_group_pins,
 	.dt_node_to_map		= pinconf_generic_dt_node_to_map_group,
-	.dt_free_map		= pinctrl_utils_dt_free_map,
+	.dt_free_map		= pinctrl_utils_free_map,
 };
 
 static int msm_get_functions_count(struct pinctrl_dev *pctldev)
diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
index 4e12ded..857ccfa 100644
--- a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
+++ b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
@@ -212,7 +212,7 @@ static const struct pinctrl_ops pmic_gpio_pinctrl_ops = {
 	.get_group_name		= pmic_gpio_get_group_name,
 	.get_group_pins		= pmic_gpio_get_group_pins,
 	.dt_node_to_map		= pinconf_generic_dt_node_to_map_group,
-	.dt_free_map		= pinctrl_utils_dt_free_map,
+	.dt_free_map		= pinctrl_utils_free_map,
 };
 
 static int pmic_gpio_get_functions_count(struct pinctrl_dev *pctldev)
diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-mpp.c b/drivers/pinctrl/qcom/pinctrl-spmi-mpp.c
index 2a3e549..4696600 100644
--- a/drivers/pinctrl/qcom/pinctrl-spmi-mpp.c
+++ b/drivers/pinctrl/qcom/pinctrl-spmi-mpp.c
@@ -235,7 +235,7 @@ static const struct pinctrl_ops pmic_mpp_pinctrl_ops = {
 	.get_group_name		= pmic_mpp_get_group_name,
 	.get_group_pins		= pmic_mpp_get_group_pins,
 	.dt_node_to_map		= pinconf_generic_dt_node_to_map_group,
-	.dt_free_map		= pinctrl_utils_dt_free_map,
+	.dt_free_map		= pinctrl_utils_free_map,
 };
 
 static int pmic_mpp_get_functions_count(struct pinctrl_dev *pctldev)
diff --git a/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c b/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c
index cd8580d..ecd784b 100644
--- a/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c
+++ b/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c
@@ -200,7 +200,7 @@ static const struct pinctrl_ops pm8xxx_pinctrl_ops = {
 	.get_group_name		= pm8xxx_get_group_name,
 	.get_group_pins         = pm8xxx_get_group_pins,
 	.dt_node_to_map		= pinconf_generic_dt_node_to_map_group,
-	.dt_free_map		= pinctrl_utils_dt_free_map,
+	.dt_free_map		= pinctrl_utils_free_map,
 };
 
 static int pm8xxx_get_functions_count(struct pinctrl_dev *pctldev)
diff --git a/drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c b/drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c
index 54a5402..ac79021 100644
--- a/drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c
+++ b/drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c
@@ -277,7 +277,7 @@ static const struct pinctrl_ops pm8xxx_pinctrl_ops = {
 	.get_group_name		= pm8xxx_get_group_name,
 	.get_group_pins         = pm8xxx_get_group_pins,
 	.dt_node_to_map		= pinconf_generic_dt_node_to_map_group,
-	.dt_free_map		= pinctrl_utils_dt_free_map,
+	.dt_free_map		= pinctrl_utils_free_map,
 };
 
 static int pm8xxx_get_functions_count(struct pinctrl_dev *pctldev)
diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.c b/drivers/pinctrl/stm32/pinctrl-stm32.c
index 8deb566..b97b7c0 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32.c
+++ b/drivers/pinctrl/stm32/pinctrl-stm32.c
@@ -358,7 +358,7 @@ static int stm32_pctrl_dt_node_to_map(struct pinctrl_dev *pctldev,
 		ret = stm32_pctrl_dt_subnode_to_map(pctldev, np, map,
 				&reserved_maps, num_maps);
 		if (ret < 0) {
-			pinctrl_utils_dt_free_map(pctldev, *map, *num_maps);
+			pinctrl_utils_free_map(pctldev, *map, *num_maps);
 			return ret;
 		}
 	}
@@ -396,7 +396,7 @@ static int stm32_pctrl_get_group_pins(struct pinctrl_dev *pctldev,
 
 static const struct pinctrl_ops stm32_pctrl_ops = {
 	.dt_node_to_map		= stm32_pctrl_dt_node_to_map,
-	.dt_free_map		= pinctrl_utils_dt_free_map,
+	.dt_free_map		= pinctrl_utils_free_map,
 	.get_groups_count	= stm32_pctrl_get_groups_count,
 	.get_group_name		= stm32_pctrl_get_group_name,
 	.get_group_pins		= stm32_pctrl_get_group_pins,
diff --git a/drivers/pinctrl/tegra/pinctrl-tegra-xusb.c b/drivers/pinctrl/tegra/pinctrl-tegra-xusb.c
index 2f06029..e58b5f3 100644
--- a/drivers/pinctrl/tegra/pinctrl-tegra-xusb.c
+++ b/drivers/pinctrl/tegra/pinctrl-tegra-xusb.c
@@ -267,7 +267,7 @@ static const struct pinctrl_ops tegra_xusb_padctl_pinctrl_ops = {
 	.get_group_name = tegra_xusb_padctl_get_group_name,
 	.get_group_pins = tegra_xusb_padctl_get_group_pins,
 	.dt_node_to_map = tegra_xusb_padctl_dt_node_to_map,
-	.dt_free_map = pinctrl_utils_dt_free_map,
+	.dt_free_map = pinctrl_utils_free_map,
 };
 
 static int tegra_xusb_padctl_get_functions_count(struct pinctrl_dev *pinctrl)
diff --git a/drivers/pinctrl/tegra/pinctrl-tegra.c b/drivers/pinctrl/tegra/pinctrl-tegra.c
index 4938882..3f7fce9 100644
--- a/drivers/pinctrl/tegra/pinctrl-tegra.c
+++ b/drivers/pinctrl/tegra/pinctrl-tegra.c
@@ -215,7 +215,7 @@ static int tegra_pinctrl_dt_node_to_map(struct pinctrl_dev *pctldev,
 		ret = tegra_pinctrl_dt_subnode_to_map(pctldev, np, map,
 						      &reserved_maps, num_maps);
 		if (ret < 0) {
-			pinctrl_utils_dt_free_map(pctldev, *map,
+			pinctrl_utils_free_map(pctldev, *map,
 				*num_maps);
 			of_node_put(np);
 			return ret;
@@ -233,7 +233,7 @@ static const struct pinctrl_ops tegra_pinctrl_ops = {
 	.pin_dbg_show = tegra_pinctrl_pin_dbg_show,
 #endif
 	.dt_node_to_map = tegra_pinctrl_dt_node_to_map,
-	.dt_free_map = pinctrl_utils_dt_free_map,
+	.dt_free_map = pinctrl_utils_free_map,
 };
 
 static int tegra_pinctrl_get_funcs_count(struct pinctrl_dev *pctldev)
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c
index 589872c..c9e4a85 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c
@@ -115,7 +115,7 @@ static const struct pinctrl_ops uniphier_pctlops = {
 	.pin_dbg_show = uniphier_pctl_pin_dbg_show,
 #endif
 	.dt_node_to_map = pinconf_generic_dt_node_to_map_all,
-	.dt_free_map = pinctrl_utils_dt_free_map,
+	.dt_free_map = pinctrl_utils_free_map,
 };
 
 static int uniphier_conf_pin_bias_get(struct pinctrl_dev *pctldev,
-- 
1.9.1
