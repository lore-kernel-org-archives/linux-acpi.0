From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: [PATCH v2 08/22] gpio: Probe pinctrl devices on demand
Date: Tue, 28 Jul 2015 15:19:39 +0200
Message-ID: <1438089593-7696-9-git-send-email-tomeu.vizoso@collabora.com>
References: <1438089593-7696-1-git-send-email-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1438089593-7696-1-git-send-email-tomeu.vizoso@collabora.com>
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
Cc: devicetree@vger.kernel.org, linux-acpi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Stephen Warren <swarren@wwwdotorg.org>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Mark Brown <broonie@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, linux-gpio@vger.kernel.org, Alexandre Courbot <gnurou@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-acpi@vger.kernel.org

When looking up a pin controller through its firmware node, probe it if
it hasn't already.

The goal is to reduce deferred probes to a minimum, as it makes it very
cumbersome to find out why a device failed to probe, and can introduce
very big delays in when a critical device is probed.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

Changes in v2: None

 drivers/gpio/gpiolib-of.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 31a6b18a6542..2a6379c1fea7 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -358,6 +358,8 @@ static int of_gpiochip_add_pin_range(struct gpio_chip *chip)
 		if (ret)
 			break;
 
+		fwnode_ensure_device(&pinspec.np->fwnode);
+
 		pctldev = of_pinctrl_get(pinspec.np);
 		if (!pctldev)
 			return -EPROBE_DEFER;
-- 
2.4.3
