Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76FB1A9F8C;
	Mon, 23 Feb 2026 15:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771862357; cv=none; b=izDNT6oDVj8/wOzFqeyrXtHybkruxv0sKAkzQvnrznE/m+WlNXmoViKmxsNVyef2FfaBWpxpLBtHCl2a22VCj4ghW1aN0PGkwcz0PApbMTQGnRSsemggCCBbN9XDgh0XVqc1BsZFTJ0t4eda86Og8StM8bYn0GL5RxYsMo07FIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771862357; c=relaxed/simple;
	bh=2N/FdQKEE3Szhdo+CUlbRkqeqFLbqMjU46LA0027/Gc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SqDyJpFWuTgbNkFpuU8y+784TPC6iAJ7Tqad2BnJnewq6dOL5/qbjaHjGi27TGdkkJOM4SLeAcWZMCpYBP/QmeYzPIqqt3YpNlE9KnZ9KBrm11c0GLLIFZ/aK0nlbF5X6fosxauy2DzcIAS/3Vz4y5vgnZnY/mkTg5rdvcJtqQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NbykNgGu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NbykNgGu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FB71C116C6;
	Mon, 23 Feb 2026 15:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771862357;
	bh=2N/FdQKEE3Szhdo+CUlbRkqeqFLbqMjU46LA0027/Gc=;
	h=From:To:Cc:Subject:Date:From;
	b=NbykNgGuG73gCO6HKxWqufR7k7K6sdq9m5GUHyp9qfx71Bh1Lrlrt6lFhQiqb3H+R
	 UjbczyuHKpUhjoU3ia0+L1xzrro+pDQzKWh494F+D+IpIYj254GVG80XhXHKJQ3H2T
	 v6vbjiZRuNMd8O83QY4B/1ybB2HtNHCC65GkGeWXMH5EbjS5WXeBLIpt09o/51bM5/
	 k0inMVmWDSbOHUnBrWg53MGIyftbROXVjO++zi+EhUOJKSglvHweMeKFtqPw3Vb5ub
	 sN7hIo8975nixZtPJgsWn8fo0vb064ah5bgrWaG//0mf6EJT2YTrIgEOilpnZEGH6Y
	 6a5AUAwU2mNcg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Mattia Dongili <malattia@linux.it>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Arnd Bergmann <arnd@arndb.de>, platform-driver-x86@vger.kernel.org
Subject: [PATCH v1] sonypi: Convert ACPI driver to a platform one
Date: Mon, 23 Feb 2026 16:59:14 +0100
Message-ID: <2277493.Mh6RI2rZIc@rafael.j.wysocki>
Organization: Linux Kernel Development
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
ACPI companions, so convert the sonypi ACPI driver to a platform one.

While this is not expected to alter functionality, it changes sysfs
layout and so it will be visible to user space.

Link: https://lore.kernel.org/all/2396510.ElGaqSPkdT@rafael.j.wysocki/ [1]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/char/sonypi.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/char/sonypi.c b/drivers/char/sonypi.c
index 677bb5ac950a..ccda997a9098 100644
--- a/drivers/char/sonypi.c
+++ b/drivers/char/sonypi.c
@@ -1115,15 +1115,17 @@ static int sonypi_disable(void)
 }
 
 #ifdef CONFIG_ACPI
-static int sonypi_acpi_add(struct acpi_device *device)
+static int sonypi_acpi_probe(struct platform_device *pdev)
 {
+	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
+
 	sonypi_acpi_device = device;
 	strcpy(acpi_device_name(device), "Sony laptop hotkeys");
 	strcpy(acpi_device_class(device), "sony/hotkey");
 	return 0;
 }
 
-static void sonypi_acpi_remove(struct acpi_device *device)
+static void sonypi_acpi_remove(struct platform_device *pdev)
 {
 	sonypi_acpi_device = NULL;
 }
@@ -1133,13 +1135,12 @@ static const struct acpi_device_id sonypi_device_ids[] = {
 	{"", 0},
 };
 
-static struct acpi_driver sonypi_acpi_driver = {
-	.name           = "sonypi",
-	.class          = "hkey",
-	.ids            = sonypi_device_ids,
-	.ops            = {
-		           .add = sonypi_acpi_add,
-			   .remove = sonypi_acpi_remove,
+static struct platform_driver sonypi_acpi_driver = {
+	.probe = sonypi_acpi_probe,
+	.remove = sonypi_acpi_remove,
+	.driver = {
+		.name = "sonypi_acpi",
+		.acpi_match_table = sonypi_device_ids,
 	},
 };
 #endif
@@ -1518,8 +1519,8 @@ static int __init sonypi_init(void)
 		goto err_free_device;
 
 #ifdef CONFIG_ACPI
-	if (acpi_bus_register_driver(&sonypi_acpi_driver) >= 0)
-		acpi_driver_registered = 1;
+	error = platform_driver_register(&sonypi_acpi_driver);
+	acpi_driver_registered = !error;
 #endif
 
 	return 0;
@@ -1535,7 +1536,7 @@ static void __exit sonypi_exit(void)
 {
 #ifdef CONFIG_ACPI
 	if (acpi_driver_registered)
-		acpi_bus_unregister_driver(&sonypi_acpi_driver);
+		platform_driver_unregister(&sonypi_acpi_driver);
 #endif
 	platform_device_unregister(sonypi_platform_device);
 	platform_driver_unregister(&sonypi_driver);
-- 
2.51.0




