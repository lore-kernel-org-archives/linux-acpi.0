From: Len Brown <lenb@kernel.org>
Subject: [PATCH 11/16] eeepc-laptop: disable cpu speed control on EeePC 701
Date: Sat, 16 Jan 2010 02:33:01 -0500
Message-ID: <da8ba01deb98f3dc0558b1f5a37e64f40bba7904.1263627123.git.len.brown@intel.com>
References: <1263627186-21384-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173009pub.verizon.net ([206.46.173.9]:58800 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751898Ab0APHei (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 16 Jan 2010 02:34:38 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KWB00L58X1LW0J1@vms173009.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 16 Jan 2010 01:34:37 -0600 (CST)
In-reply-to: <1263627186-21384-1-git-send-email-lenb@kernel.org>
In-reply-to: <a62e8f1978f49e52f87a711ff6711b323d4b12ff.1263627123.git.len.brown@intel.com>
References: <a62e8f1978f49e52f87a711ff6711b323d4b12ff.1263627123.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alan Jenkins <alan-jenkins@tuffmail.co.uk>, Corentin Chary <corentincj@iksaif.net>, Len Brown <len.brown@intel.com>

From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>

The EeePC 4G ("701") implements CFVS, but it is not supported by the
pre-installed OS, and the original option to change it in the BIOS
setup screen was removed in later versions.  Judging by the lack of
"Super Hybrid Engine" on Asus product pages, this applies to all "701"
models (4G/4G Surf/2G Surf).

So Asus made a deliberate decision not to support it on this model.
We have several reports that using it can cause the system to hang [1].
That said, it does not happen all the time.  Some users do not
experience it at all (and apparently wish to continue "right-clocking").

Check for the EeePC 701 using DMI.  If met, then disable writes to the
"cpufv" sysfs attribute and log an explanatory message.

Add a "cpufv_disabled" attribute which allow users to override this
policy.  Writing to this attribute will log a second message.

The sysfs attribute is more useful than a module option, because it
makes it easier for userspace scripts to provide consistent behaviour
(according to user configuration), regardless of whether the kernel
includes this change.

[1] <http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=559578>

Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Signed-off-by: Corentin Chary <corentincj@iksaif.net>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/eeepc-laptop.c |   87 +++++++++++++++++++++++++++++++++++
 1 files changed, 87 insertions(+), 0 deletions(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index 5838c69..e954f2a 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -35,6 +35,7 @@
 #include <linux/pci.h>
 #include <linux/pci_hotplug.h>
 #include <linux/leds.h>
+#include <linux/dmi.h>
 
 #define EEEPC_LAPTOP_VERSION	"0.1"
 #define EEEPC_LAPTOP_NAME	"Eee PC Hotkey Driver"
@@ -159,6 +160,7 @@ struct eeepc_laptop {
 	acpi_handle handle;		/* the handle of the acpi device */
 	u32 cm_supported;		/* the control methods supported
 					   by this BIOS */
+	bool cpufv_disabled;
 	u16 event_count[128];		/* count for each event */
 
 	struct platform_device *platform_device;
@@ -378,6 +380,8 @@ static ssize_t store_cpufv(struct device *dev,
 	struct eeepc_cpufv c;
 	int rv, value;
 
+	if (eeepc->cpufv_disabled)
+		return -EPERM;
 	if (get_cpufv(eeepc, &c))
 		return -ENODEV;
 	rv = parse_arg(buf, count, &value);
@@ -389,6 +393,41 @@ static ssize_t store_cpufv(struct device *dev,
 	return rv;
 }
 
+static ssize_t show_cpufv_disabled(struct device *dev,
+			  struct device_attribute *attr,
+			  char *buf)
+{
+	struct eeepc_laptop *eeepc = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%d\n", eeepc->cpufv_disabled);
+}
+
+static ssize_t store_cpufv_disabled(struct device *dev,
+			   struct device_attribute *attr,
+			   const char *buf, size_t count)
+{
+	struct eeepc_laptop *eeepc = dev_get_drvdata(dev);
+	int rv, value;
+
+	rv = parse_arg(buf, count, &value);
+	if (rv < 0)
+		return rv;
+
+	switch (value) {
+	case 0:
+		if (eeepc->cpufv_disabled)
+			pr_warning("cpufv enabled (not officially supported "
+				"on this model)\n");
+		eeepc->cpufv_disabled = false;
+		return rv;
+	case 1:
+		return -EPERM;
+	default:
+		return -EINVAL;
+	}
+}
+
+
 static struct device_attribute dev_attr_cpufv = {
 	.attr = {
 		.name = "cpufv",
@@ -404,12 +443,22 @@ static struct device_attribute dev_attr_available_cpufv = {
 	.show   = show_available_cpufv
 };
 
+static struct device_attribute dev_attr_cpufv_disabled = {
+	.attr = {
+		.name = "cpufv_disabled",
+		.mode = 0644 },
+	.show   = show_cpufv_disabled,
+	.store  = store_cpufv_disabled
+};
+
+
 static struct attribute *platform_attributes[] = {
 	&dev_attr_camera.attr,
 	&dev_attr_cardr.attr,
 	&dev_attr_disp.attr,
 	&dev_attr_cpufv.attr,
 	&dev_attr_available_cpufv.attr,
+	&dev_attr_cpufv_disabled.attr,
 	NULL
 };
 
@@ -1261,6 +1310,42 @@ static void eeepc_acpi_notify(struct acpi_device *device, u32 event)
 	}
 }
 
+static void eeepc_dmi_check(struct eeepc_laptop *eeepc)
+{
+	const char *model;
+
+	/*
+	 * Blacklist for setting cpufv (cpu speed).
+	 *
+	 * EeePC 4G ("701") implements CFVS, but it is not supported
+	 * by the pre-installed OS, and the original option to change it
+	 * in the BIOS setup screen was removed in later versions.
+	 *
+	 * Judging by the lack of "Super Hybrid Engine" on Asus product pages,
+	 * this applies to all "701" models (4G/4G Surf/2G Surf).
+	 *
+	 * So Asus made a deliberate decision not to support it on this model.
+	 * We have several reports that using it can cause the system to hang
+	 *
+	 * The hang has also been reported on a "702" (Model name "8G"?).
+	 *
+	 * We avoid dmi_check_system() / dmi_match(), because they use
+	 * substring matching.  We don't want to affect the "701SD"
+	 * and "701SDX" models, because they do support S.H.E.
+	 */
+
+	model = dmi_get_system_info(DMI_PRODUCT_NAME);
+	if (!model)
+		return;
+
+	if (strcmp(model, "701") == 0 || strcmp(model, "702") == 0) {
+		eeepc->cpufv_disabled = true;
+		pr_info("model %s does not officially support setting cpu "
+			"speed\n", model);
+		pr_info("cpufv disabled to avoid instability\n");
+	}
+}
+
 static void cmsg_quirk(struct eeepc_laptop *eeepc, int cm, const char *name)
 {
 	int dummy;
@@ -1342,6 +1427,8 @@ static int __devinit eeepc_acpi_add(struct acpi_device *device)
 	strcpy(acpi_device_class(device), EEEPC_ACPI_CLASS);
 	device->driver_data = eeepc;
 
+	eeepc_dmi_check(eeepc);
+
 	result = eeepc_acpi_init(eeepc, device);
 	if (result)
 		goto fail_platform;
-- 
1.6.0.6

