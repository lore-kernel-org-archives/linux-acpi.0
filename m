From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: [PATCH v2 01/22] platform: delay device-driver matches until
 late_initcall
Date: Tue, 28 Jul 2015 15:19:32 +0200
Message-ID: <1438089593-7696-2-git-send-email-tomeu.vizoso@collabora.com>
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
Cc: devicetree@vger.kernel.org, linux-acpi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Stephen Warren <swarren@wwwdotorg.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Mark Brown <broonie@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-acpi@vger.kernel.org

Delay matches of platform devices until late_initcall, when we are sure
that all built-in drivers have been registered already.  This is needed
to prevent deferred probes because of some drivers not having registered
yet.

The reason why only platform devices are delayed is that some other
devices are expected to be probed earlier than late_initcall, for
example, the system PNP driver needs to probe its devices in
fs_initcall.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

Changes in v2:
- Move delay to platform.c

 drivers/base/platform.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 063f0ab15259..fcf654678e27 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -33,6 +33,8 @@
 /* For automatically allocated device IDs */
 static DEFINE_IDA(platform_devid_ida);
 
+static bool enable_matches;
+
 struct device platform_bus = {
 	.init_name	= "platform",
 };
@@ -839,6 +841,15 @@ static int platform_match(struct device *dev, struct device_driver *drv)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct platform_driver *pdrv = to_platform_driver(drv);
 
+	/*
+	 * Delay matches of platform devices until late_initcall, when we are
+	 * sure that all built-in drivers have been registered already. This
+	 * is needed to prevent deferred probes because of some drivers
+	 * not having registered yet.
+	 */
+	if (!enable_matches)
+		return false;
+
 	/* When driver_override is set, only bind to the matching driver */
 	if (pdev->driver_override)
 		return !strcmp(pdev->driver_override, drv->name);
@@ -859,6 +870,23 @@ static int platform_match(struct device *dev, struct device_driver *drv)
 	return (strcmp(pdev->name, drv->name) == 0);
 }
 
+static int __probe_device(struct device *dev, void *data)
+{
+	device_initial_probe(dev);
+
+	return 0;
+}
+
+static int probe_delayed_matches_initcall(void)
+{
+	enable_matches = true;
+
+	bus_for_each_dev(&platform_bus_type, NULL, NULL, __probe_device);
+
+	return 0;
+}
+late_initcall(probe_delayed_matches_initcall);
+
 #ifdef CONFIG_PM_SLEEP
 
 static int platform_legacy_suspend(struct device *dev, pm_message_t mesg)
-- 
2.4.3
