From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: [PATCH v6 22/22] of/platform: Defer probes of registered devices
Date: Mon, 21 Sep 2015 16:03:02 +0200
Message-ID: <1442844182-27787-23-git-send-email-tomeu.vizoso@collabora.com>
References: <1442844182-27787-1-git-send-email-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1442844182-27787-1-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>, Stephen Warren <swarren@wwwdotorg.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-arm-kernel@lists.infradead.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, linux-acpi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Tomeu Vizoso <tomeu.vizoso@collabora.com>
List-Id: linux-acpi@vger.kernel.org

Instead of trying to match and probe platform and AMBA devices right
after each is registered, delay their probes until device_initcall_sync.

This means that devices will start probing once all built-in drivers
have registered, and after all platform and AMBA devices from the DT
have been registered already.

This allows us to prevent deferred probes by probing dependencies on
demand.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

Changes in v4:
- Also defer probes of AMBA devices registered from the DT as they can
  also request resources.

 drivers/of/platform.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 408d89f1d124..7b33e0369374 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -164,7 +164,8 @@ static struct platform_device *of_platform_device_create_pdata(
 					struct device_node *np,
 					const char *bus_id,
 					void *platform_data,
-					struct device *parent)
+					struct device *parent,
+					bool probe_late)
 {
 	struct platform_device *dev;
 
@@ -178,6 +179,7 @@ static struct platform_device *of_platform_device_create_pdata(
 
 	dev->dev.bus = &platform_bus_type;
 	dev->dev.platform_data = platform_data;
+	dev->dev.probe_late = probe_late;
 	of_dma_configure(&dev->dev, dev->dev.of_node);
 	of_msi_configure(&dev->dev, dev->dev.of_node);
 
@@ -209,7 +211,8 @@ struct platform_device *of_platform_device_create(struct device_node *np,
 					    const char *bus_id,
 					    struct device *parent)
 {
-	return of_platform_device_create_pdata(np, bus_id, NULL, parent);
+	return of_platform_device_create_pdata(np, bus_id, NULL, parent,
+					       false);
 }
 EXPORT_SYMBOL(of_platform_device_create);
 
@@ -240,6 +243,7 @@ static struct amba_device *of_amba_device_create(struct device_node *node,
 	dev->dev.of_node = of_node_get(node);
 	dev->dev.parent = parent ? : &platform_bus;
 	dev->dev.platform_data = platform_data;
+	dev->dev.probe_late = true;
 	if (bus_id)
 		dev_set_name(&dev->dev, "%s", bus_id);
 	else
@@ -358,7 +362,8 @@ static int of_platform_bus_create(struct device_node *bus,
 		return 0;
 	}
 
-	dev = of_platform_device_create_pdata(bus, bus_id, platform_data, parent);
+	dev = of_platform_device_create_pdata(bus, bus_id, platform_data,
+					      parent, true);
 	if (!dev || !of_match_node(matches, bus))
 		return 0;
 
-- 
2.4.3
