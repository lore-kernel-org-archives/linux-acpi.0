Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411B923645D;
	Sun,  6 Sep 2026 16:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788710597; cv=none; b=A7bbL8nYzSVPM8te162dBjm6CGoMQwqIKv6ZLVkOakJD4bYrCUMmkNhk4wG8UxNHy6aFa3/4s22EWlDSskAtt9ECWSgIpxCsJAMg5ipWOii9c0nINP9lz8ZSpws5KattwfrecXWItZeXZQYEc/Eq9HSsrZV94UhAGGVmJJ9oimc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788710597; c=relaxed/simple;
	bh=H9wSQTwwn5zSzbJb6NKT53H4T/TYH9k9hjXJbRLKz9A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TwJekHERoBpopB46FqMex2I1h/bsqGpua3bMDYpwUvTTTINodI6XOe8yKGuMkzzwyn2gNUCcDuylRQiOTS1z7e+1Zd3MfcE1vaPt0hyYNZTfH66Qu/JuQE5xWQTSmHBKX3s33lRYbOy69BS6+WdiDOm51kLk2yjscU07NEe3IEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZzkbhI0j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZzkbhI0j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF9BC1F00A3A;
	Sun,  6 Sep 2026 16:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788710595;
	bh=ZAtjL7WCSk5EcdfIRh/y3JmFO05pfZD6T+3jcZ9kk+I=;
	h=From:To:Cc:Subject:Date;
	b=ZzkbhI0jjwGA+RteXtIJU554X3gbo1vP30Fxjbe2oA0jhesYjUPzBNVSnoH4JrgvW
	 G9KayOzjG9eoao8LOJSA5cas6qcOyEfa0mXfRJalldXC6XIpBlMiffNeSrgaUoymgC
	 3ukkbq9AgJwhQwiUfc4lSj5EZi9rColcUTqKGv/NFbAwqHIrNNMNwyMi15PiPjXMEe
	 HImdKK+SW9KC75UUocdbN2cTJdFB5J9Y1IjJ9KA6lsOSElQ2GdUmAbQfd479dVtmJH
	 8ESR6ps9nk+O7dMx3ylRstLG9v1+zpIgaCa3hq48+tZKdE7PWOgwP7jCZkHsfn3D6P
	 woxCacIZYSoXg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Linux Driver Core Development <driver-core@lists.linux.dev>
Subject: [PATCH v1] driver core/ACPI: Introduce companion_bus_register()
Date: Sun, 06 Sep 2026 18:03:12 +0200
Message-ID: <8753121.T7Z3S40VBb@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The ACPI bus type does not allow drivers to be registered, so the sysfs
attributes related to drivers created for it and its devices are
useless, and its drivers/ directory is always empty.  All of that is
confusing and wasteful.

To allow skipping the creation of those sysfs attributes, introduce
the concept of a "companion" bus (as a bus without drivers whose
devices can be bound to other devices and used by their drivers) and
add a special registration function for registering "companion" bus
types, companion_bus_register().

Use that function for registering the ACPI bus type.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/bus.c         |    8 -----
 drivers/base/bus.c         |   66 ++++++++++++++++++++++++++++++++-------------
 include/linux/device/bus.h |    1 
 3 files changed, 49 insertions(+), 26 deletions(-)

--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1120,11 +1120,6 @@ EXPORT_SYMBOL_GPL(acpi_driver_match_devi
                               ACPI Bus operations
    -------------------------------------------------------------------------- */
 
-static int acpi_bus_match(struct device *dev, const struct device_driver *drv)
-{
-	return 0;
-}
-
 static int acpi_device_uevent(const struct device *dev, struct kobj_uevent_env *env)
 {
 	return __acpi_device_uevent_modalias(to_acpi_device(dev), env);
@@ -1132,7 +1127,6 @@ static int acpi_device_uevent(const stru
 
 const struct bus_type acpi_bus_type = {
 	.name		= "acpi",
-	.match		= acpi_bus_match,
 	.uevent		= acpi_device_uevent,
 };
 
@@ -1451,7 +1445,7 @@ static int __init acpi_bus_init(void)
 	 */
 	acpi_root_dir = proc_mkdir(ACPI_BUS_FILE_ROOT, NULL);
 
-	result = bus_register(&acpi_bus_type);
+	result = companion_bus_register(&acpi_bus_type);
 	if (!result)
 		return 0;
 
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -735,7 +735,7 @@ int bus_add_driver(struct device_driver
 	struct driver_private *priv;
 	int error = 0;
 
-	if (!sp)
+	if (!sp || !sp->drivers_kset)
 		return -EINVAL;
 
 	/*
@@ -930,15 +930,7 @@ static ssize_t bus_uevent_store(const st
 static struct bus_attribute bus_attr_uevent = __ATTR(uevent, 0200, NULL,
 						     bus_uevent_store);
 
-/**
- * bus_register - register a driver-core subsystem
- * @bus: bus to register
- *
- * Once we have that, we register the bus with the kobject
- * infrastructure, then register the children subsystems it has:
- * the devices and drivers that belong to the subsystem.
- */
-int bus_register(const struct bus_type *bus)
+static int bus_register_internal(const struct bus_type *bus, bool use_drivers)
 {
 	int retval;
 	struct subsys_private *priv;
@@ -960,7 +952,7 @@ int bus_register(const struct bus_type *
 
 	bus_kobj->kset = bus_kset;
 	bus_kobj->ktype = &bus_ktype;
-	priv->drivers_autoprobe = 1;
+	priv->drivers_autoprobe = use_drivers;
 
 	retval = kset_register(&priv->subsys);
 	if (retval)
@@ -976,10 +968,12 @@ int bus_register(const struct bus_type *
 		goto bus_devices_fail;
 	}
 
-	priv->drivers_kset = kset_create_and_add("drivers", NULL, bus_kobj);
-	if (!priv->drivers_kset) {
-		retval = -ENOMEM;
-		goto bus_drivers_fail;
+	if (use_drivers) {
+		priv->drivers_kset = kset_create_and_add("drivers", NULL, bus_kobj);
+		if (!priv->drivers_kset) {
+			retval = -ENOMEM;
+			goto bus_drivers_fail;
+		}
 	}
 
 	INIT_LIST_HEAD(&priv->interfaces);
@@ -989,9 +983,11 @@ int bus_register(const struct bus_type *
 	klist_init(&priv->klist_devices, klist_devices_get, klist_devices_put);
 	klist_init(&priv->klist_drivers, NULL, NULL);
 
-	retval = add_probe_files(bus);
-	if (retval)
-		goto bus_probe_files_fail;
+	if (use_drivers) {
+		retval = add_probe_files(bus);
+		if (retval)
+			goto bus_probe_files_fail;
+	}
 
 	retval = sysfs_create_groups(bus_kobj, bus->bus_groups);
 	if (retval)
@@ -1016,9 +1012,41 @@ out:
 	kfree(priv);
 	return retval;
 }
+
+/**
+ * bus_register - register a driver-core subsystem
+ * @bus: bus to register
+ *
+ * Once we have that, we register the bus with the kobject
+ * infrastructure, then register the children subsystems it has:
+ * the devices and drivers that belong to the subsystem.
+ */
+int bus_register(const struct bus_type *bus)
+{
+	return bus_register_internal(bus, true);
+}
 EXPORT_SYMBOL_GPL(bus_register);
 
 /**
+ * companion_bus_register - register a companion bus type
+ * @bus: companion bus to register
+ *
+ * A companion bus is a bus without drivers.  Devices that belong to it can be
+ * bound to other devices as their "companions" and represent interfaces that
+ * can be used by the drivers of those other devices.  They may also be used for
+ * the enumeration of those other devices.
+ *
+ * The ACPI bus is a specific example of a companion bus.
+ *
+ * Registering a companion bus is like registering a regular bus except that it
+ * skips the creation of sysfs interfaces related to drivers for @bus.
+ */
+int companion_bus_register(const struct bus_type *bus)
+{
+	return bus_register_internal(bus, false);
+}
+
+/**
  * bus_unregister - remove a bus from the system
  * @bus: bus.
  *
@@ -1412,7 +1440,7 @@ struct device_driver *driver_find(const
 	struct kobject *k;
 	struct driver_private *priv;
 
-	if (!sp)
+	if (!sp || !sp->drivers_kset)
 		return NULL;
 
 	k = kset_find_obj(sp->drivers_kset, name);
--- a/include/linux/device/bus.h
+++ b/include/linux/device/bus.h
@@ -113,6 +113,7 @@ struct bus_type {
 	bool need_parent_lock;
 };
 
+int __must_check companion_bus_register(const struct bus_type *bus);
 int __must_check bus_register(const struct bus_type *bus);
 
 void bus_unregister(const struct bus_type *bus);



