From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v4 11/16] of: No need to include linux/property.h, linux/fwnode.h is sufficient
Date: Mon,  6 Mar 2017 16:19:25 +0200
Message-ID: <1488809970-25568-12-git-send-email-sakari.ailus@linux.intel.com>
References: <1488809970-25568-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:52282 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932325AbdCFOT7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 6 Mar 2017 09:19:59 -0500
In-Reply-To: <1488809970-25568-1-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
Cc: sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, mika.westerberg@linux.intel.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com

of.h requires a definition of struct fwnode_handle, and for that it
includes linux/property.h. struct fwnode_handle, however, is defined in
linux/fwnode.h. Include linux/fwnode.h directly.

A number of users were however depending on linux/property.h, thus fix
them by including that header directly as well.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/base/core.c                       | 1 +
 drivers/input/keyboard/gpio_keys.c        | 1 +
 drivers/input/misc/drv260x.c              | 1 +
 drivers/input/misc/gpio_decoder.c         | 1 +
 drivers/input/touchscreen/ad7879.c        | 1 +
 drivers/input/touchscreen/edt-ft5x06.c    | 1 +
 drivers/input/touchscreen/tsc200x-core.c  | 2 +-
 drivers/net/ethernet/faraday/ftgmac100.c  | 1 +
 drivers/net/ethernet/smsc/smc91x.c        | 1 +
 drivers/phy/phy-tusb1210.c                | 1 +
 drivers/power/supply/bq24735-charger.c    | 1 +
 drivers/usb/common/common.c               | 1 +
 drivers/usb/dwc2/debugfs.c                | 3 ++-
 drivers/usb/dwc2/params.c                 | 1 +
 drivers/usb/dwc2/pci.c                    | 3 ++-
 drivers/usb/dwc3/host.c                   | 1 +
 include/linux/of.h                        | 2 +-
 sound/soc/codecs/rt5514.c                 | 1 +
 sound/soc/codecs/ts3a227e.c               | 1 +
 sound/soc/mediatek/mt8173/mt8173-rt5650.c | 1 +
 sound/soc/rockchip/rk3399_gru_sound.c     | 1 +
 21 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index fde2c7c..92e7d80 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -24,6 +24,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/property.h>
 #include <linux/sched/signal.h>
 #include <linux/slab.h>
 #include <linux/string.h>
diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index da3d362..a5509aa 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -20,6 +20,7 @@
 #include <linux/slab.h>
 #include <linux/sysctl.h>
 #include <linux/proc_fs.h>
+#include <linux/property.h>
 #include <linux/delay.h>
 #include <linux/platform_device.h>
 #include <linux/input.h>
diff --git a/drivers/input/misc/drv260x.c b/drivers/input/misc/drv260x.c
index fb089d3..a3972df 100644
--- a/drivers/input/misc/drv260x.c
+++ b/drivers/input/misc/drv260x.c
@@ -22,6 +22,7 @@
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
+#include <linux/property.h>
 #include <linux/regulator/consumer.h>
 
 #include <dt-bindings/input/ti-drv260x.h>
diff --git a/drivers/input/misc/gpio_decoder.c b/drivers/input/misc/gpio_decoder.c
index 1dca526..10bc109 100644
--- a/drivers/input/misc/gpio_decoder.c
+++ b/drivers/input/misc/gpio_decoder.c
@@ -22,6 +22,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 
 struct gpio_decoder {
 	struct input_polled_dev *poll_dev;
diff --git a/drivers/input/touchscreen/ad7879.c b/drivers/input/touchscreen/ad7879.c
index e16a446..38ad365 100644
--- a/drivers/input/touchscreen/ad7879.c
+++ b/drivers/input/touchscreen/ad7879.c
@@ -34,6 +34,7 @@
 #include <linux/input/touchscreen.h>
 #include <linux/platform_data/ad7879.h>
 #include <linux/module.h>
+#include <linux/property.h>
 #include "ad7879.h"
 
 #define AD7879_REG_ZEROS		0
diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index 8cf8d8d..3beaea2 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -39,6 +39,7 @@
 #include <linux/input/mt.h>
 #include <linux/input/touchscreen.h>
 #include <linux/of_device.h>
+#include <linux/property.h>
 
 #define WORK_REGISTER_THRESHOLD		0x00
 #define WORK_REGISTER_REPORT_RATE	0x08
diff --git a/drivers/input/touchscreen/tsc200x-core.c b/drivers/input/touchscreen/tsc200x-core.c
index 88ea5e1..3964d67 100644
--- a/drivers/input/touchscreen/tsc200x-core.c
+++ b/drivers/input/touchscreen/tsc200x-core.c
@@ -25,10 +25,10 @@
 #include <linux/input/touchscreen.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
-#include <linux/pm.h>
 #include <linux/of.h>
 #include <linux/regulator/consumer.h>
 #include <linux/regmap.h>
+#include <linux/property.h>
 #include <linux/gpio/consumer.h>
 #include "tsc200x-core.h"
 
diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index 928b0df..f3eaa5f 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -30,6 +30,7 @@
 #include <linux/netdevice.h>
 #include <linux/phy.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <net/ip.h>
 #include <net/ncsi.h>
 
diff --git a/drivers/net/ethernet/smsc/smc91x.c b/drivers/net/ethernet/smsc/smc91x.c
index 65077c7..5352a08 100644
--- a/drivers/net/ethernet/smsc/smc91x.c
+++ b/drivers/net/ethernet/smsc/smc91x.c
@@ -75,6 +75,7 @@ static const char version[] =
 #include <linux/ioport.h>
 #include <linux/crc32.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/spinlock.h>
 #include <linux/ethtool.h>
 #include <linux/mii.h>
diff --git a/drivers/phy/phy-tusb1210.c b/drivers/phy/phy-tusb1210.c
index 4f6d5e7..f7dd21aa 100644
--- a/drivers/phy/phy-tusb1210.c
+++ b/drivers/phy/phy-tusb1210.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/ulpi/driver.h>
 #include <linux/gpio/consumer.h>
+#include <linux/property.h>
 
 #include "ulpi_phy.h"
 
diff --git a/drivers/power/supply/bq24735-charger.c b/drivers/power/supply/bq24735-charger.c
index eb01453..690bb4d 100644
--- a/drivers/power/supply/bq24735-charger.c
+++ b/drivers/power/supply/bq24735-charger.c
@@ -27,6 +27,7 @@
 #include <linux/of.h>
 #include <linux/gpio/consumer.h>
 #include <linux/power_supply.h>
+#include <linux/property.h>
 #include <linux/slab.h>
 
 #include <linux/power/bq24735-charger.h>
diff --git a/drivers/usb/common/common.c b/drivers/usb/common/common.c
index 5ef8da6..534a498 100644
--- a/drivers/usb/common/common.c
+++ b/drivers/usb/common/common.c
@@ -14,6 +14,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/property.h>
 #include <linux/usb/ch9.h>
 #include <linux/usb/of.h>
 #include <linux/usb/otg.h>
diff --git a/drivers/usb/dwc2/debugfs.c b/drivers/usb/dwc2/debugfs.c
index 794b959..10217cd 100644
--- a/drivers/usb/dwc2/debugfs.c
+++ b/drivers/usb/dwc2/debugfs.c
@@ -14,9 +14,10 @@
  * GNU General Public License for more details.
  */
 
-#include <linux/spinlock.h>
 #include <linux/debugfs.h>
+#include <linux/property.h>
 #include <linux/seq_file.h>
+#include <linux/spinlock.h>
 #include <linux/uaccess.h>
 
 #include "core.h"
diff --git a/drivers/usb/dwc2/params.c b/drivers/usb/dwc2/params.c
index 2990c34..0fe39ce 100644
--- a/drivers/usb/dwc2/params.c
+++ b/drivers/usb/dwc2/params.c
@@ -35,6 +35,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
+#include <linux/property.h>
 
 #include "core.h"
 
diff --git a/drivers/usb/dwc2/pci.c b/drivers/usb/dwc2/pci.c
index fdeb8c7..333a5cb 100644
--- a/drivers/usb/dwc2/pci.c
+++ b/drivers/usb/dwc2/pci.c
@@ -44,8 +44,9 @@
 #include <linux/spinlock.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
-#include <linux/slab.h>
 #include <linux/pci.h>
+#include <linux/property.h>
+#include <linux/slab.h>
 #include <linux/usb.h>
 
 #include <linux/usb/hcd.h>
diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
index 76f0b0d..563b1df 100644
--- a/drivers/usb/dwc3/host.c
+++ b/drivers/usb/dwc3/host.c
@@ -16,6 +16,7 @@
  */
 
 #include <linux/platform_device.h>
+#include <linux/property.h>
 
 #include "core.h"
 
diff --git a/include/linux/of.h b/include/linux/of.h
index e5d4225f..d48e225 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -23,7 +23,7 @@
 #include <linux/spinlock.h>
 #include <linux/topology.h>
 #include <linux/notifier.h>
-#include <linux/property.h>
+#include <linux/fwnode.h>
 #include <linux/list.h>
 
 #include <asm/byteorder.h>
diff --git a/sound/soc/codecs/rt5514.c b/sound/soc/codecs/rt5514.c
index b281a46..0749219 100644
--- a/sound/soc/codecs/rt5514.c
+++ b/sound/soc/codecs/rt5514.c
@@ -15,6 +15,7 @@
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/pm.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/i2c.h>
 #include <linux/platform_device.h>
diff --git a/sound/soc/codecs/ts3a227e.c b/sound/soc/codecs/ts3a227e.c
index 4356843..e80b28b 100644
--- a/sound/soc/codecs/ts3a227e.c
+++ b/sound/soc/codecs/ts3a227e.c
@@ -14,6 +14,7 @@
 #include <linux/input.h>
 #include <linux/module.h>
 #include <linux/of_gpio.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 
 #include <sound/core.h>
diff --git a/sound/soc/mediatek/mt8173/mt8173-rt5650.c b/sound/soc/mediatek/mt8173/mt8173-rt5650.c
index ba65f41..433ae4f 100644
--- a/sound/soc/mediatek/mt8173/mt8173-rt5650.c
+++ b/sound/soc/mediatek/mt8173/mt8173-rt5650.c
@@ -17,6 +17,7 @@
 #include <linux/module.h>
 #include <linux/gpio.h>
 #include <linux/of_gpio.h>
+#include <linux/property.h>
 #include <sound/soc.h>
 #include <sound/jack.h>
 #include "../../codecs/rt5645.h"
diff --git a/sound/soc/rockchip/rk3399_gru_sound.c b/sound/soc/rockchip/rk3399_gru_sound.c
index 3475c61..9134b46 100644
--- a/sound/soc/rockchip/rk3399_gru_sound.c
+++ b/sound/soc/rockchip/rk3399_gru_sound.c
@@ -22,6 +22,7 @@
 #include <linux/gpio.h>
 #include <linux/of_gpio.h>
 #include <linux/delay.h>
+#include <linux/property.h>
 #include <linux/spi/spi.h>
 #include <linux/input.h>
 #include <sound/core.h>
-- 
2.7.4

