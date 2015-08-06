From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: [PATCH v3 03/18] gpio: Probe GPIO drivers on demand
Date: Thu,  6 Aug 2015 16:11:40 +0200
Message-ID: <1438870315-18689-4-git-send-email-tomeu.vizoso@collabora.com>
References: <1438870315-18689-1-git-send-email-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1438870315-18689-1-git-send-email-tomeu.vizoso@collabora.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, devicetree@vger.kernel.org, linux-acpi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Stephen Warren <swarren@wwwdotorg.org>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Mark Brown <broonie@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-acpi@vger.kernel.org

When looking up a gpiochip through its firmware node, probe it if it
hasn't already.

The goal is to reduce deferred probes to a minimum, as it makes it very
cumbersome to find out why a device failed to probe, and can introduce
very big delays in when a critical device is probed.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

Changes in v3: None
Changes in v2: None

 drivers/gpio/gpiolib-of.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index fa6e3c8823d6..d8c617c34c85 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -20,6 +20,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_gpio.h>
+#include <linux/of_platform.h>
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/slab.h>
 #include <linux/gpio/machine.h>
@@ -95,6 +96,8 @@ struct gpio_desc *of_get_named_gpiod_flags(struct device_node *np,
 		return ERR_PTR(ret);
 	}
 
+	of_platform_probe(gg_data.gpiospec.np);
+
 	gpiochip_find(&gg_data, of_gpiochip_find_and_xlate);
 
 	of_node_put(gg_data.gpiospec.np);
-- 
2.4.3
