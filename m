From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: [PATCH v3 09/18] i2c: core: Probe i2c adapters and devices on demand
Date: Thu,  6 Aug 2015 16:11:46 +0200
Message-ID: <1438870315-18689-10-git-send-email-tomeu.vizoso@collabora.com>
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

When looking up an i2c adapter or device through its OF node, probe it
if it hasn't already.

The goal is to reduce deferred probes to a minimum, as it makes it very
cumbersome to find out why a device failed to probe, and can introduce
very big delays in when a critical device is probed.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

Changes in v3: None
Changes in v2: None

 drivers/i2c/i2c-core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index c83e4d13cfc5..9c507b558fa2 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -40,6 +40,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/of_irq.h>
+#include <linux/of_platform.h>
 #include <linux/clk/clk-conf.h>
 #include <linux/completion.h>
 #include <linux/hardirq.h>
@@ -1342,6 +1343,8 @@ struct i2c_client *of_find_i2c_device_by_node(struct device_node *node)
 	struct device *dev;
 	struct i2c_client *client;
 
+	of_platform_probe(node);
+
 	dev = bus_find_device(&i2c_bus_type, NULL, node, of_dev_node_match);
 	if (!dev)
 		return NULL;
@@ -1360,6 +1363,8 @@ struct i2c_adapter *of_find_i2c_adapter_by_node(struct device_node *node)
 	struct device *dev;
 	struct i2c_adapter *adapter;
 
+	of_platform_probe(node);
+
 	dev = bus_find_device(&i2c_bus_type, NULL, node, of_dev_node_match);
 	if (!dev)
 		return NULL;
-- 
2.4.3
