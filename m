Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2B73803D9;
	Tue, 17 Mar 2026 19:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773776715; cv=none; b=XG2eTtSrXU6A7vM046+ccZgJFT0B2pRgBwhoZHcOsxUriJ9QN5wK7OzDY0Nh8RPAKMBR4AuhViLT4G1bLjy9eXvVvbZOUN76fhOvBOZr4iWonWhKFYm0Hyalhmp0Bqgpn67/nxPE8r2gbOpLzOWurO424v7dZBwBYEIBnymLYbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773776715; c=relaxed/simple;
	bh=frRiu3aK9HzEGIyV/6ViwpxHuCBhCOqkxFZTmoekibE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uIR5rOZ3VrfdhX8BwgHyQuOfHJzam557pcZ9LfEVt5khzdO0i1y9rv335ehVYiNprnTuXP9YVuKlfdUOCdHuDejlAq+2ZW7MvfGhr1iZzh3SLUAyQsafJQCPhyWW0a44yNdKybhQKM0xTkjsjZ5bVCDbPLNETbFAgdyKEKnwuFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R2DKSPr+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R2DKSPr+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96193C4CEF7;
	Tue, 17 Mar 2026 19:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773776715;
	bh=frRiu3aK9HzEGIyV/6ViwpxHuCBhCOqkxFZTmoekibE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R2DKSPr+nIRb6qANTgOC3JLpS57aN3Ug+IyYDD9IBauX8AYQ2Y1uJXIH+GkztStE8
	 g/ZX6ZdKh4f5lOwSgBPdIw4FHd1yzVyYeFXIJuLSNkw9CFZXYaLyfp4xMB4khcERlJ
	 SMxo5LXTkDdS9C3FsYCXI142uMBeQ2Ojg5PRuSdzRvPmoYnlbQn8wEJ+eUjfRm+fkU
	 QKYdC0vvwqJcBGRWxg5/QPM84ZcpAp6ywy56qgIk3KQ2lGqi77CXsk+VpHAepkH1Vu
	 IbM5BepHQA5Qp+66FfPs7eE2V/KxCV/T913mAP06uHfzopt4I/tqw9XNKptVVzzK7q
	 OpZpF9DlLWxKA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Robert Gerlach <khnz@gmx.de>, Hans de Goede <hansg@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>,
 platform-driver-x86@vger.kernel.org, Jonathan Woithe <jwoithe@just42.net>
Subject:
 [PATCH v3 1/5] platform/x86: fujitsu-tablet: Convert ACPI driver to a
 platform one
Date: Tue, 17 Mar 2026 20:39:07 +0100
Message-ID: <2403432.ElGaqSPkdT@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <5085647.31r3eYUQgx@rafael.j.wysocki>
References: <5085647.31r3eYUQgx@rafael.j.wysocki>
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
ACPI companions, so convert the fujitsu-tablet ACPI driver to a platform
one.

After this change, the subordinate input device will be registered under
the platform device used for driver binding instead of its ACPI companion.

While this is not expected to alter functionality, it changes sysfs
layout and so it will be visible to user space.

Link: https://lore.kernel.org/all/2396510.ElGaqSPkdT@rafael.j.wysocki/ [1]
Acked-by: Jonathan Woithe <jwoithe@just42.net>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v3: No changes

---
 drivers/platform/x86/fujitsu-tablet.c | 30 +++++++++++++--------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/platform/x86/fujitsu-tablet.c b/drivers/platform/x86/fujitsu-tablet.c
index 17f08ce7552d..8319df28e9b8 100644
--- a/drivers/platform/x86/fujitsu-tablet.c
+++ b/drivers/platform/x86/fujitsu-tablet.c
@@ -18,6 +18,7 @@
 #include <linux/input.h>
 #include <linux/delay.h>
 #include <linux/dmi.h>
+#include <linux/platform_device.h>
 
 #define MODULENAME "fujitsu-tablet"
 
@@ -442,14 +443,12 @@ static acpi_status fujitsu_walk_resources(struct acpi_resource *res, void *data)
 	}
 }
 
-static int acpi_fujitsu_add(struct acpi_device *adev)
+static int acpi_fujitsu_probe(struct platform_device *pdev)
 {
+	struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
 	acpi_status status;
 	int error;
 
-	if (!adev)
-		return -EINVAL;
-
 	status = acpi_walk_resources(adev->handle, METHOD_NAME__CRS,
 			fujitsu_walk_resources, NULL);
 	if (ACPI_FAILURE(status) || !fujitsu.irq || !fujitsu.io_base)
@@ -461,7 +460,7 @@ static int acpi_fujitsu_add(struct acpi_device *adev)
 	snprintf(fujitsu.phys, sizeof(fujitsu.phys),
 			"%s/input0", acpi_device_hid(adev));
 
-	error = input_fujitsu_setup(&adev->dev,
+	error = input_fujitsu_setup(&pdev->dev,
 		acpi_device_name(adev), fujitsu.phys);
 	if (error)
 		return error;
@@ -484,7 +483,7 @@ static int acpi_fujitsu_add(struct acpi_device *adev)
 	return 0;
 }
 
-static void acpi_fujitsu_remove(struct acpi_device *adev)
+static void acpi_fujitsu_remove(struct platform_device *pdev)
 {
 	free_irq(fujitsu.irq, fujitsu_interrupt);
 	release_region(fujitsu.io_base, fujitsu.io_length);
@@ -501,15 +500,14 @@ static int acpi_fujitsu_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(acpi_fujitsu_pm, NULL, acpi_fujitsu_resume);
 
-static struct acpi_driver acpi_fujitsu_driver = {
-	.name  = MODULENAME,
-	.class = "hotkey",
-	.ids   = fujitsu_ids,
-	.ops   = {
-		.add    = acpi_fujitsu_add,
-		.remove	= acpi_fujitsu_remove,
+static struct platform_driver acpi_fujitsu_driver = {
+	.probe = acpi_fujitsu_probe,
+	.remove = acpi_fujitsu_remove,
+	.driver = {
+		.name = MODULENAME,
+		.acpi_match_table = fujitsu_ids,
+		.pm = &acpi_fujitsu_pm,
 	},
-	.drv.pm = &acpi_fujitsu_pm,
 };
 
 static int __init fujitsu_module_init(void)
@@ -518,7 +516,7 @@ static int __init fujitsu_module_init(void)
 
 	dmi_check_system(dmi_ids);
 
-	error = acpi_bus_register_driver(&acpi_fujitsu_driver);
+	error = platform_driver_register(&acpi_fujitsu_driver);
 	if (error)
 		return error;
 
@@ -527,7 +525,7 @@ static int __init fujitsu_module_init(void)
 
 static void __exit fujitsu_module_exit(void)
 {
-	acpi_bus_unregister_driver(&acpi_fujitsu_driver);
+	platform_driver_unregister(&acpi_fujitsu_driver);
 }
 
 module_init(fujitsu_module_init);
-- 
2.51.0




