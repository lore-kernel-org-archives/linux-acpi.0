From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: [PATCH v4 20/22] driver core: Allow deferring probes until late init
Date: Mon,  7 Sep 2015 14:23:45 +0200
Message-ID: <1441628627-5143-21-git-send-email-tomeu.vizoso@collabora.com>
References: <1441628627-5143-1-git-send-email-tomeu.vizoso@collabora.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:34165 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752149AbbIGMYo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Sep 2015 08:24:44 -0400
In-Reply-To: <1441628627-5143-1-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>, Stephen Warren <swarren@wwwdotorg.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Mark Brown <broonie@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-arm-kernel@lists.infradead.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, linux-acpi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Add a field to struct device that instructs the device-driver core to
defer the probe of this device until the late_initcall level.

By letting all built-in drivers to register before starting to probe, we
can avoid any deferred probes by probing dependencies on demand.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>

---

Changes in v4:
- Add Kconfig DELAY_DEVICE_PROBES to allow disabling delayed probing in
  machines with initcalls that depend on devices probing at a given time.

Changes in v3: None
Changes in v2: None

 drivers/base/Kconfig   | 18 ++++++++++++++++++
 drivers/base/dd.c      |  7 +++++++
 include/linux/device.h |  2 ++
 3 files changed, 27 insertions(+)

diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
index 98504ec99c7d..44b5d33b1f49 100644
--- a/drivers/base/Kconfig
+++ b/drivers/base/Kconfig
@@ -324,4 +324,22 @@ config CMA_ALIGNMENT
 
 endif
 
+config DELAY_DEVICE_PROBES
+	bool "Allow delaying the probe of some devices"
+	default y
+	help
+	  Devices can be matched to a driver and probed from the moment they
+	  are registered, but early during boot their probes are likely to be
+	  deferred because some dependency isn't available yet because most
+	  drivers haven't been registered yet.
+
+	  Enabling this option allows the device registration code to delay the
+	  probing of a specific device until device_initcall_sync, when all
+	  built-in drivers have been registered already.
+
+	  In some platforms there may be implicit assumptions about when some
+	  devices are probed, so enabling this option could cause problems there.
+
+	  If unsure, say Y here.
+
 endmenu
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index faf60bfc46b3..0654fb771a53 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -417,6 +417,13 @@ int driver_probe_device(struct device_driver *drv, struct device *dev)
 	if (!device_is_registered(dev))
 		return -ENODEV;
 
+#if IS_ENABLED(CONFIG_DELAY_DEVICE_PROBES)
+	if (!driver_deferred_probe_enable && dev->probe_late) {
+		driver_deferred_probe_add(dev);
+		return 0;
+	}
+#endif
+
 	pr_debug("bus: '%s': %s: matched device %s with driver %s\n",
 		 drv->bus->name, __func__, dev_name(dev), drv->name);
 
diff --git a/include/linux/device.h b/include/linux/device.h
index d8be07bc9c3f..fe5c50ffd7d3 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -748,6 +748,7 @@ struct device_dma_parameters {
  *
  * @offline_disabled: If set, the device is permanently online.
  * @offline:	Set after successful invocation of bus type's .offline().
+ * @probe_late:	If set, device will be probed in the late initcall level.
  *
  * At the lowest level, every device in a Linux system is represented by an
  * instance of struct device. The device structure contains the information
@@ -832,6 +833,7 @@ struct device {
 
 	bool			offline_disabled:1;
 	bool			offline:1;
+	bool			probe_late:1;
 };
 
 static inline struct device *kobj_to_dev(struct kobject *kobj)
-- 
2.4.3

