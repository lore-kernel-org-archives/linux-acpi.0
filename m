From: Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Subject: [PATCH v5 04/23] of: add function to allow probing a device from a OF node
Date: Thu, 17 Sep 2015 14:56:58 +0200
Message-ID: <1442494637-3674-5-git-send-email-tomeu.vizoso@collabora.com>
References: <1442494637-3674-1-git-send-email-tomeu.vizoso@collabora.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1442494637-3674-1-git-send-email-tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Walks the OF tree up and finds the closest ancestor that has a struct
device associated with it, probing it if isn't bound to a driver yet.

The above should ensure that the dependency represented by the passed OF
node is available, because probing a device should cause its descendants
to be probed as well (when they get registered).

Subsystems can use this when looking up resources for drivers, to reduce
the chances of deferred probes because of the probing order of devices.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
---

Changes in v5:
- Move the assignment to device_node->device for AMBA devices to another
  commit.
- Hold a reference to the struct device while it's in use in
  of_device_probe().

Changes in v4:
- Rename of_platform_probe to of_device_probe
- Use device_node.device instead of device_node.platform_dev

Changes in v3:
- Set and use device_node.platform_dev instead of reversing the logic to
  find the platform device that encloses a device node.
- Drop the fwnode API to probe firmware nodes and add OF-only API for
  now. I think this same scheme could be used for machines with ACPI,
  but I haven't been able to find one that had to defer its probes because
  of the device probe order.

Changes in v2: None

 drivers/of/device.c       | 61 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/of_device.h |  3 +++
 2 files changed, 64 insertions(+)

diff --git a/drivers/of/device.c b/drivers/of/device.c
index 8b91ea241b10..836be71fc90e 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -286,3 +286,64 @@ int of_device_uevent_modalias(struct device *dev, struct kobj_uevent_env *env)
 
 	return 0;
 }
+
+/**
+ * of_device_probe() - Probe device associated with OF node
+ * @np: node to probe
+ *
+ * Probe the device associated with the passed device node.
+ */
+void of_device_probe(struct device_node *np)
+{
+	struct device_node *target;
+	struct device *dev = NULL;
+
+	if (!of_root || !of_node_check_flag(of_root, OF_POPULATED_BUS))
+		return;
+
+	if (!np)
+		return;
+
+	of_node_get(np);
+
+	/* Find the closest ancestor that has a device associated */
+	for (target = np;
+	     !of_node_is_root(target);
+	     target = of_get_next_parent(target))
+		if (get_device(target->device)) {
+			dev = target->device;
+			break;
+		}
+
+	of_node_put(target);
+
+	if (!dev) {
+		pr_warn("Couldn't find a device for node '%s'\n",
+			of_node_full_name(np));
+		return;
+	}
+
+	/*
+	 * Device is bound or is being probed right now. If we have bad luck
+	 * and the dependency isn't ready when it's needed, deferred probe
+	 * will save us.
+	 */
+	if (dev->driver)
+		goto out;
+
+	/*
+	 * Probing a device should cause its descendants to be probed as
+	 * well, which includes the passed device node.
+	 */
+	if (device_attach(dev) != 1)
+		/*
+		 * This cannot be a warning for now because clock nodes have a
+		 * compatible string but the clock framework doesn't follow
+		 * the device/driver model yet.
+		 */
+		dev_dbg(dev, "Probe failed for %s\n", of_node_full_name(np));
+
+out:
+	put_device(dev);
+}
+EXPORT_SYMBOL_GPL(of_device_probe);
diff --git a/include/linux/of_device.h b/include/linux/of_device.h
index cc7dd687a89d..da8d489e73ad 100644
--- a/include/linux/of_device.h
+++ b/include/linux/of_device.h
@@ -40,6 +40,7 @@ extern ssize_t of_device_get_modalias(struct device *dev,
 
 extern void of_device_uevent(struct device *dev, struct kobj_uevent_env *env);
 extern int of_device_uevent_modalias(struct device *dev, struct kobj_uevent_env *env);
+extern void of_device_probe(struct device_node *np);
 
 static inline void of_device_node_put(struct device *dev)
 {
@@ -84,6 +85,8 @@ static inline int of_device_uevent_modalias(struct device *dev,
 	return -ENODEV;
 }
 
+static inline void of_device_probe(struct device_node *np) { }
+
 static inline void of_device_node_put(struct device *dev) { }
 
 static inline const struct of_device_id *__of_match_device(
-- 
2.4.3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
