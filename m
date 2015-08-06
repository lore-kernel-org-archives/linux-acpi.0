From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: [PATCH v3 15/18] phy: core: Probe phy providers on demand
Date: Thu,  6 Aug 2015 16:11:52 +0200
Message-ID: <1438870315-18689-16-git-send-email-tomeu.vizoso@collabora.com>
References: <1438870315-18689-1-git-send-email-tomeu.vizoso@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438870315-18689-1-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>, Stephen Warren <swarren@wwwdotorg.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Mark Brown <broonie@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-arm-kernel@lists.infradead.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, linux-acpi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Tomeu Vizoso <tomeu.vizoso@collabora.com>
List-Id: linux-acpi@vger.kernel.org

When looking up a phy provider through its OF node, probe it if it
hasn't already.

The goal is to reduce deferred probes to a minimum, as it makes it very
cumbersome to find out why a device failed to probe, and can introduce
very big delays in when a critical device is probed.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

Changes in v3: None
Changes in v2: None

 drivers/phy/phy-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index fc48fac003a6..1ba55fc8cce4 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -18,6 +18,7 @@
 #include <linux/device.h>
 #include <linux/slab.h>
 #include <linux/of.h>
+#include <linux/of_platform.h>
 #include <linux/phy/phy.h>
 #include <linux/idr.h>
 #include <linux/pm_runtime.h>
@@ -363,6 +364,8 @@ static struct phy *_of_phy_get(struct device_node *np, int index)
 	if (ret)
 		return ERR_PTR(-ENODEV);
 
+	of_platform_probe(args.np);
+
 	mutex_lock(&phy_provider_mutex);
 	phy_provider = of_phy_provider_lookup(args.np);
 	if (IS_ERR(phy_provider) || !try_module_get(phy_provider->owner)) {
-- 
2.4.3
