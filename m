Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E342E8B6B;
	Tue, 24 Mar 2026 20:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774382602; cv=none; b=pHfurvBQGXsCtQun7srJzU1sy3+cC72SZJqiZGhrflQGPlBjywgUC8xcuwrOpjhqn2YlaOcMJvcGzYvzk7l9IYZ/BmiHd3BCVM2JD/Tg3X28sFZBXtJyEf76c6vZ5mxBl0yVrQJUt4reWymjE/t3PZowofCQ4P5Gj20wZuW/PPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774382602; c=relaxed/simple;
	bh=Rsx5nNxfOiAofUvMRKCqsGaShw3No1jfXPi4X3hNFbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F3T4w6BoII8ogyzm8VqxOzjiYohT8ccTE8IjsuomgnzRhYfbZi+3JsMo12tK6FwvC2MsYiYUaeeBdTrLtcZzSCxJJ7tFXSp1Yi7lD55L5+Flv0VW1mWLsi9Agj4cw25IzgO3Njom6a7UaCEMJH/D76qCM278g8Bq38Rz3J95uGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AyTRZcN1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AyTRZcN1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC5CCC2BCB2;
	Tue, 24 Mar 2026 20:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774382602;
	bh=Rsx5nNxfOiAofUvMRKCqsGaShw3No1jfXPi4X3hNFbM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AyTRZcN17lUtrshz2dfqIQ0YDg63cB1GBsh2O6jcXiXZwzMs3wsLlMGIivWGOQcOJ
	 DRrL7v6K4UBt3z3zj3gt2kHcYC0GWx27Ak/ZfHX/fx9k+V4w43Ia3oqXglC8oB3X9C
	 nixUpLu7hBdvYplzc0VNxdRpzFcXJwrGQpL255Sh+NiNWHbZkxJb4CubI51VHRQNE8
	 7jckh5VNngI18C1xvEKHXRBHubr1nzl6OtzSo+pnDC4KrMWwPfE05gov8t4FoiUqUC
	 tUkh6RK0HWWN9gg2M+87mQwi7sUh8IviXBQ/KME58VeuEWGEcrCnXeISwSscCLMzkz
	 dQHY31hdKP1Wg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Hans de Goede <hansg@kernel.org>,
 platform-driver-x86@vger.kernel.org, Azael Avalos <coproscefalo@gmail.com>
Subject:
 [PATCH v1 6/7] platform/x86: toshiba_haps: Register ACPI notify handler
 directly
Date: Tue, 24 Mar 2026 21:02:14 +0100
Message-ID: <10834562.nUPlyArG6x@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <6262981.lOV4Wx5bFT@rafael.j.wysocki>
References: <6262981.lOV4Wx5bFT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

To facilitate subsequent conversion of the driver to a platform one,
make it install an ACPI notify handler directly instead of using
a .notify() callback in struct acpi_driver.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/platform/x86/toshiba_haps.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/toshiba_haps.c b/drivers/platform/x86/toshiba_haps.c
index e9324bf16aea..6eac306cf92a 100644
--- a/drivers/platform/x86/toshiba_haps.c
+++ b/drivers/platform/x86/toshiba_haps.c
@@ -129,8 +129,10 @@ static const struct attribute_group haps_attr_group = {
 /*
  * ACPI stuff
  */
-static void toshiba_haps_notify(struct acpi_device *device, u32 event)
+static void toshiba_haps_notify(acpi_handle handle, u32 event, void *data)
 {
+	struct acpi_device *device = data;
+
 	pr_debug("Received event: 0x%x\n", event);
 
 	acpi_bus_generate_netlink_event(device->pnp.device_class,
@@ -140,6 +142,9 @@ static void toshiba_haps_notify(struct acpi_device *device, u32 event)
 
 static void toshiba_haps_remove(struct acpi_device *device)
 {
+	acpi_dev_remove_notify_handler(device, ACPI_DEVICE_NOTIFY,
+				       toshiba_haps_notify);
+
 	sysfs_remove_group(&device->dev.kobj, &haps_attr_group);
 
 	if (toshiba_haps)
@@ -201,9 +206,18 @@ static int toshiba_haps_add(struct acpi_device *acpi_dev)
 	if (ret)
 		return ret;
 
+	ret = acpi_dev_install_notify_handler(acpi_dev, ACPI_DEVICE_NOTIFY,
+					      toshiba_haps_notify, acpi_dev);
+	if (ret)
+		goto err;
+
 	toshiba_haps = haps;
 
 	return 0;
+
+err:
+	sysfs_remove_group(&acpi_dev->dev.kobj, &haps_attr_group);
+	return ret;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -256,7 +270,6 @@ static struct acpi_driver toshiba_haps_driver = {
 	.ops = {
 		.add =		toshiba_haps_add,
 		.remove =	toshiba_haps_remove,
-		.notify =	toshiba_haps_notify,
 	},
 	.drv.pm = &toshiba_haps_pm,
 };
-- 
2.51.0




