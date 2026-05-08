Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FCA26C3BD;
	Fri,  8 May 2026 18:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778263322; cv=none; b=alFOYrjNrgUlSN9CcxKTGz+sm+9gQaYLVbUWGmm1nn481tHQ4BPu3ZoFgLStKlHx2csZN9XAhEEbbrYlqiATKylnjoeuCmeQIBb8avk7vdjPTWmvIMfqolJXE5yt8AaoPv5yuqC4dbrF9HS4f2dQBcAXk2jsVeyFRY7bgNeXqLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778263322; c=relaxed/simple;
	bh=2UTX+oSgmlBMtFGj1aMaqy3ncGGdOHIRs9SnJwMGgw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dq2qU7Xa5vIGmXWf75PfRia68am9BL9G+eakEru4h6uKT8jo8rqM5CEhuUIaOfvuRVUX6z2qkdnL7jDG0jY0UCVTR9pv/nrhH8b84LkDY0dnDH1N5Ol0AG1U1vxRoGCZqkiUHpw01nnGLn9QqvVDQdn1B8lWwSuF47zSoheBCjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J7oZIzc3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J7oZIzc3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A47AC2BCB0;
	Fri,  8 May 2026 18:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778263322;
	bh=2UTX+oSgmlBMtFGj1aMaqy3ncGGdOHIRs9SnJwMGgw8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J7oZIzc38FgE8khPzRvptbE1v7bObMscsDMtFuQSqS15uWkD96lk9/tV5m0aKhPWf
	 Jd2+hH/TROGAXiCWRroFWUGxyTUMfHPjqwQblQTNibMqkh7+xAq1/W+mOIAV0GbRQh
	 nPxgrmN3JDESnz/j1SWACzxfos9WyVJ9j03cZa7RVrrEGkIYj7l4P+RCyH8GVCzMxr
	 bOEO1Qo9TOIzL+5Yoa/vTCCiptMSTltX/qjugn0lbY4EncGlWPPBwyDkhIUZlKtQvM
	 ZeNeWHQIYtDrrt+R5EoZz0SF1vP9SBjDlsZzcA4IP77b1tjDw3U5iYTSCCC4n7Qadu
	 qKODqYT2vh8Kw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: x86 Maintainers <x86@kernel.org>
Cc: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Hans de Goede <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, platform-driver-x86@vger.kernel.org,
 Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
 Dave Hansen <dave.hansen@linux.intel.com>
Subject:
 [PATCH v1 2/2] x86/platform/olpc: xo15: Convert ACPI driver to a platform one
Date: Fri, 08 May 2026 20:01:41 +0200
Message-ID: <1970421.CQOukoFCf9@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <1868425.VLH7GnMWUR@rafael.j.wysocki>
References: <1868425.VLH7GnMWUR@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

In all cases in which a struct acpi_driver is used for binding a driver
to an ACPI device object, a corresponding platform device is created by
the ACPI core and that device is regarded as a proper representation of
underlying hardware.  Accordingly, a struct platform_driver should be
used by driver code to bind to that device.  There are multiple reasons
why drivers should not bind directly to ACPI device objects [1].

Overall, it is better to bind drivers to platform devices than to their
ACPI companions, so convert the olpc-xo15-sci ACPI driver to a platform
one.

After this change, the wakeup source added by the driver will appear
under the platform device used for driver binding, but the sysfs
attribute added by the driver under the ACPI companion of that device
will stay there in case there are utilities in user space expecting it
to be there.

While this is not expected to alter functionality, it changes sysfs
layout and so it will be visible to user space.

Link: https://lore.kernel.org/all/2396510.ElGaqSPkdT@rafael.j.wysocki/ [1]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 arch/x86/platform/olpc/olpc-xo15-sci.c | 34 ++++++++++++++------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/arch/x86/platform/olpc/olpc-xo15-sci.c b/arch/x86/platform/olpc/olpc-xo15-sci.c
index 276caf756a9c..e486109e88c8 100644
--- a/arch/x86/platform/olpc/olpc-xo15-sci.c
+++ b/arch/x86/platform/olpc/olpc-xo15-sci.c
@@ -9,6 +9,7 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/workqueue.h>
+#include <linux/platform_device.h>
 #include <linux/power_supply.h>
 #include <linux/olpc-ec.h>
 
@@ -136,14 +137,16 @@ static u32 xo15_sci_gpe_handler(acpi_handle gpe_device, u32 gpe, void *context)
 	return ACPI_INTERRUPT_HANDLED | ACPI_REENABLE_GPE;
 }
 
-static int xo15_sci_add(struct acpi_device *device)
+static int xo15_sci_probe(struct platform_device *pdev)
 {
+	struct acpi_device *device;
 	unsigned long long tmp;
 	acpi_status status;
 	int r;
 
+	device = ACPI_COMPANION(&pdev->dev);
 	if (!device)
-		return -EINVAL;
+		return -ENODEV;
 
 	strscpy(acpi_device_name(device), XO15_SCI_DEVICE_NAME);
 	strscpy(acpi_device_class(device), XO15_SCI_CLASS);
@@ -160,7 +163,7 @@ static int xo15_sci_add(struct acpi_device *device)
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
 
-	dev_info(&device->dev, "Initialized, GPE = 0x%lx\n", xo15_sci_gpe);
+	dev_info(&pdev->dev, "Initialized, GPE = 0x%lx\n", xo15_sci_gpe);
 
 	r = sysfs_create_file(&device->dev.kobj, &lid_wake_on_close_attr.attr);
 	if (r)
@@ -174,7 +177,7 @@ static int xo15_sci_add(struct acpi_device *device)
 
 	/* Enable wake-on-EC */
 	if (device->wakeup.flags.valid)
-		device_init_wakeup(&device->dev, true);
+		device_init_wakeup(&pdev->dev, true);
 
 	return 0;
 
@@ -184,9 +187,11 @@ static int xo15_sci_add(struct acpi_device *device)
 	return r;
 }
 
-static void xo15_sci_remove(struct acpi_device *device)
+static void xo15_sci_remove(struct platform_device *pdev)
 {
-	device_init_wakeup(&device->dev, false);
+	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
+
+	device_init_wakeup(&pdev->dev, false);
 	acpi_disable_gpe(NULL, xo15_sci_gpe);
 	acpi_remove_gpe_handler(NULL, xo15_sci_gpe, xo15_sci_gpe_handler);
 	cancel_work_sync(&sci_work);
@@ -214,19 +219,18 @@ static const struct acpi_device_id xo15_sci_device_ids[] = {
 	{"", 0},
 };
 
-static struct acpi_driver xo15_sci_drv = {
-	.name = DRV_NAME,
-	.class = XO15_SCI_CLASS,
-	.ids = xo15_sci_device_ids,
-	.ops = {
-		.add = xo15_sci_add,
-		.remove = xo15_sci_remove,
+static struct platform_driver xo15_sci_drv = {
+	.probe = xo15_sci_probe,
+	.remove = xo15_sci_remove,
+	.driver = {
+		.name = DRV_NAME,
+		.acpi_match_table = xo15_sci_device_ids,
+		.pm = &xo15_sci_pm,
 	},
-	.drv.pm = &xo15_sci_pm,
 };
 
 static int __init xo15_sci_init(void)
 {
-	return acpi_bus_register_driver(&xo15_sci_drv);
+	return platform_driver_register(&xo15_sci_drv);
 }
 device_initcall(xo15_sci_init);
-- 
2.51.0




