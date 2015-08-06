From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: [PATCH v3 07/18] drm: Probe panels on demand
Date: Thu,  6 Aug 2015 16:11:44 +0200
Message-ID: <1438870315-18689-8-git-send-email-tomeu.vizoso@collabora.com>
References: <1438870315-18689-1-git-send-email-tomeu.vizoso@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438870315-18689-1-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>, Stephen Warren <swarren@wwwdotorg.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Mark Brown <broonie@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-arm-kernel@lists.infradead.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, linux-acpi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Tomeu Vizoso <tomeu.vizoso@collabora.com>
List-Id: linux-acpi@vger.kernel.org

When looking up a panel through its OF node, probe it if it hasn't
already.

The goal is to reduce deferred probes to a minimum, as it makes it very
cumbersome to find out why a device failed to probe, and can introduce
very big delays in when a critical device is probed.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

Changes in v3: None
Changes in v2: None

 drivers/gpu/drm/drm_panel.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
index 2ef988e037b7..8f01574cabda 100644
--- a/drivers/gpu/drm/drm_panel.c
+++ b/drivers/gpu/drm/drm_panel.c
@@ -23,6 +23,7 @@
 
 #include <linux/err.h>
 #include <linux/module.h>
+#include <linux/of_platform.h>
 
 #include <drm/drm_crtc.h>
 #include <drm/drm_panel.h>
@@ -80,6 +81,8 @@ struct drm_panel *of_drm_find_panel(struct device_node *np)
 {
 	struct drm_panel *panel;
 
+	of_platform_probe(np);
+
 	mutex_lock(&panel_lock);
 
 	list_for_each_entry(panel, &panel_list, list) {
-- 
2.4.3
