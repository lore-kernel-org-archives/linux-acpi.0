Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCFC2FF153;
	Mon, 23 Feb 2026 15:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771861789; cv=none; b=txOUquwRj03E4oF+SMhwO83Lk+7PsIhOMU/YRL91KDa4NUmjS6lbNPlSnJYxYSyWrpAwZjJpuNDIvGt9kwKySrnHuLuVR6umWc80JqmJgRoCvV2BNDbIY7cePGmRNoP6VRg4ZNuJB1OAv3fZhWAQWz6LYzPx7x8HvQQFVjdw+7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771861789; c=relaxed/simple;
	bh=yZQknwqAJdmCVxpWiBb/WN0sIhB1BKMV5F8xZ0A4ucA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ET7BKbKfCOz1scoU41RITmCL/1J/Sl5YP1xL4CxQMbyCAFnIbWSswrsHD3X619WOSbe2svaEKWxOznzzofovW+vFaShtQxMeK93/9cXTHemSrdLgryk2JyiBXaWKxyeOqLdKwZJBb85lj3mySmPT7tfOdFpU3FC+Npvk3UseIxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fvC0B78D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fvC0B78D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EF85C116C6;
	Mon, 23 Feb 2026 15:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771861789;
	bh=yZQknwqAJdmCVxpWiBb/WN0sIhB1BKMV5F8xZ0A4ucA=;
	h=From:To:Cc:Subject:Date:From;
	b=fvC0B78DT33qFG+H3k6gzU+N/lyyEHD9VjhBdi6bYMQsEhJK6kFKCFJqs/fr146WE
	 3tU6ted+Xxd0wNTDIYKezLf+ZfKb6011G4QvOoahYJAzZJb15c1oyL8MumdX4Dx6H8
	 iHO6Ei1AlWHwBATaNxnla9XxYMX6j4xPfnZ/EbWWwSroT5YJOOidFqsy9tF1Yzxt08
	 XSbdXDe7nNDw4x0L5IPlsi6a5gnlCVtnmT9MqLADfQgLO5D2xclDNUQGALSCX766xH
	 Epl3eNhuDsG3yIFmcwDTlBcVAgTw6ckz3E3stBi1nYoePoe4jTE3H/JcA95g2p0g5/
	 ngw09lyvN9vkg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Clemens Ladisch <clemens@ladisch.de>, Arnd Bergmann <arnd@arndb.de>,
 LKML <linux-kernel@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v1] hpet: Convert ACPI driver to a platform one
Date: Mon, 23 Feb 2026 16:49:45 +0100
Message-ID: <3611505.QJadu78ljV@rafael.j.wysocki>
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
ACPI companions, so convert the HPET ACPI driver to a platform one.

While this is not expected to alter functionality, it changes sysfs
layout and so it will be visible to user space.

Link: https://lore.kernel.org/all/2396510.ElGaqSPkdT@rafael.j.wysocki/ [1]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/char/hpet.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/char/hpet.c b/drivers/char/hpet.c
index 60dd09a56f50..d396823e5e64 100644
--- a/drivers/char/hpet.c
+++ b/drivers/char/hpet.c
@@ -34,6 +34,7 @@
 #include <linux/io.h>
 #include <linux/acpi.h>
 #include <linux/hpet.h>
+#include <linux/platform_device.h>
 #include <asm/current.h>
 #include <asm/irq.h>
 #include <asm/div64.h>
@@ -971,8 +972,9 @@ static acpi_status hpet_resources(struct acpi_resource *res, void *data)
 	return AE_OK;
 }
 
-static int hpet_acpi_add(struct acpi_device *device)
+static int hpet_acpi_probe(struct platform_device *pdev)
 {
+	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
 	acpi_status result;
 	struct hpet_data data;
 
@@ -1000,12 +1002,12 @@ static const struct acpi_device_id hpet_device_ids[] = {
 	{"", 0},
 };
 
-static struct acpi_driver hpet_acpi_driver = {
-	.name = "hpet",
-	.ids = hpet_device_ids,
-	.ops = {
-		.add = hpet_acpi_add,
-		},
+static struct platform_driver hpet_acpi_driver = {
+	.probe = hpet_acpi_probe,
+	.driver = {
+		.name = "hpet_acpi",
+		.acpi_match_table = hpet_device_ids,
+	},
 };
 
 static struct miscdevice hpet_misc = { HPET_MINOR, "hpet", &hpet_fops };
@@ -1020,7 +1022,7 @@ static int __init hpet_init(void)
 
 	sysctl_header = register_sysctl("dev/hpet", hpet_table);
 
-	result = acpi_bus_register_driver(&hpet_acpi_driver);
+	result = platform_driver_register(&hpet_acpi_driver);
 	if (result < 0) {
 		unregister_sysctl_table(sysctl_header);
 		misc_deregister(&hpet_misc);
-- 
2.51.0




