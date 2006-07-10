From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH] ACPI devices _HID export through sysfs
Date: Sun, 9 Jul 2006 21:32:12 -0600
Message-ID: <200607092132.12818.bjorn.helgaas@hp.com>
References: <200607090024.19776.thermal@o2.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel6.hp.com ([156.153.255.205]:32441 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S1161320AbWGJDcU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 9 Jul 2006 23:32:20 -0400
In-Reply-To: <200607090024.19776.thermal@o2.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: thermal@o2.pl
Cc: linux-acpi@vger.kernel.org

On Saturday 08 July 2006 16:24, thermal@o2.pl wrote:
> I recently thought about using coldplug (/etc/hotplug/*.rc) scripts to 
> automagically load modules responsible for ACPI-controlled devices such 
> as button, battery, laptop extras. To accomplish this I wrote a trivial 
> kernel patch which exports the ACPI device _HID and _CID attributes in 
> the corresponding sysfs node. I also wrote a script for /etc/hotplug 
> which scans the /sys tree and loads modules according to HIDs exported.

Funny, I was just thinking about this, too :-)  I think it's a good
idea to be able to automatically load the correct drivers for ACPI
devices.

But I think it'd be better for the kernel to expose ACPI devices to
user-space as PNP devices, and to use uevents for PNP devices just
like we do for PCI devices.  I don't like the idea of having separate
user-space stuff for PNPBIOS vs PNPACPI devices.

I don't know very much about udev.  Would the following patch, in
combination with CONFIG_PNPACPI, be enough to do what you want?

Index: work-mm7/drivers/pnp/driver.c
===================================================================
--- work-mm7.orig/drivers/pnp/driver.c	2006-07-09 20:51:31.000000000 -0600
+++ work-mm7/drivers/pnp/driver.c	2006-07-09 20:55:09.000000000 -0600
@@ -191,9 +191,56 @@
 	return 0;
 }
 
+static int pnp_uevent(struct device *dev, char **envp, int num_envp,
+		      char *buffer, int buffer_size)
+{
+	struct pnp_dev *pdev;
+	struct pnp_id *pos;
+	int i = 0;
+	int length = 0;
+	int ids = 0;
+	char *id_buffer, *p;
+
+	if (!dev)
+		return -ENODEV;
+
+	pdev = to_pnp_dev(dev);
+	if (!pdev)
+		return -ENODEV;
+
+	for (pos = pdev->id; pos; pos = pos->next)
+		ids++;
+
+	id_buffer = kmalloc(ids * 9, GFP_KERNEL);
+	if (!id_buffer)
+		return -ENOMEM;
+
+	p = id_buffer;
+	for (pos = pdev->id; pos; pos = pos->next)
+		p += scnprintf(p, 9, "%s%c", pos->id, pos->next ? ':' : '\0');
+
+	if (add_uevent_var(envp, num_envp, &i,
+			   buffer, buffer_size, &length,
+			   "PNP_ID=%s", id_buffer)) {
+		kfree(id_buffer);
+		return -ENOMEM;
+	}
+
+	kfree(id_buffer);
+
+	if (add_uevent_var(envp, num_envp, &i,
+			   buffer, buffer_size, &length,
+			   "PNP_DEVICE_NODE=%s", dev->bus_id))
+		return -ENOMEM;
+
+	envp[i] = NULL;
+	return 0;
+}
+
 struct bus_type pnp_bus_type = {
 	.name	= "pnp",
 	.match	= pnp_bus_match,
+	.uevent = pnp_uevent,
 	.probe	= pnp_device_probe,
 	.remove	= pnp_device_remove,
 	.suspend = pnp_bus_suspend,
