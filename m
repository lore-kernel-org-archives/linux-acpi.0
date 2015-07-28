From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: [PATCH v2 16/22] usb: phy: Probe phy devices on demand
Date: Tue, 28 Jul 2015 15:19:47 +0200
Message-ID: <1438089593-7696-17-git-send-email-tomeu.vizoso@collabora.com>
References: <1438089593-7696-1-git-send-email-tomeu.vizoso@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438089593-7696-1-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Stephen Warren <swarren@wwwdotorg.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Mark Brown <broonie@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-arm-kernel@lists.infradead.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, linux-acpi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, Felipe Balbi <balbi@ti.com>
List-Id: linux-acpi@vger.kernel.org

When looking up a phy through its firmware node, probe it if it hasn't
already.

The goal is to reduce deferred probes to a minimum, as it makes it very
cumbersome to find out why a device failed to probe, and can introduce
very big delays in when a critical device is probed.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

Changes in v2: None

 drivers/usb/phy/phy.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/phy/phy.c b/drivers/usb/phy/phy.c
index 98f75d2842b7..2d51c12d0726 100644
--- a/drivers/usb/phy/phy.c
+++ b/drivers/usb/phy/phy.c
@@ -196,6 +196,8 @@ struct  usb_phy *devm_usb_get_phy_by_node(struct device *dev,
 		goto err0;
 	}
 
+	fwnode_ensure_device(&node->fwnode);
+
 	spin_lock_irqsave(&phy_lock, flags);
 
 	phy = __of_usb_find_phy(node);
-- 
2.4.3
