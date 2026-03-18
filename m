Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DB43F54AC;
	Wed, 18 Mar 2026 19:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773862921; cv=none; b=NF472L81XlLYy69F3+qgZS6OH1EpDDuCIRLh5D0pHTGoXW1bBXbjdPVteHia90MAOIvtC5XPXPfrit8wRFwReQ/D6K6vqspQoEhgIOuzsK06FPqCRsB+dIcYXzh3B87AIiuwVM5GyayQbVf0Q2QBvvs7+h4dV3w5rp0zh5lk+jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773862921; c=relaxed/simple;
	bh=n7aRXJZVRRxUggb5UrCK4MGfQHNPv/piDBdksKbVGII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D9Px6AI/QPbfWjfc8/rjfUBRWLSi4ydESBxAnrZWfyouO9Kaj4PtYDO//JIoKIQts1qTYyczvYXCNvzCiS6plW1uxXh0HaOTmgC1LPY7YzXi20T/eKl2zRwux6W1ovklBdfcmGDBvdAzR4jQpAzAflmCQ9Q2dxTTBMwH5r89r3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rSmRs1xp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rSmRs1xp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5DCBC19421;
	Wed, 18 Mar 2026 19:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773862921;
	bh=n7aRXJZVRRxUggb5UrCK4MGfQHNPv/piDBdksKbVGII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rSmRs1xpmJnZyddnI4DkNkuFw9bCQ96KRMC9VxvjfYnsWbpIIAy5N1xmjPQZjM9YW
	 uOMMs1qX+dXh7SiKp925/BoE9ZaZvqq435M2t4QjKNMMH6molpw5WjimmOLTAmS9pS
	 9PxhyUQEW9Ld7mR8xhg9Nh7i5DHroFvIYC6dZPb0Rn/IaHNlk8sVpArmq26a8CmsTg
	 reE0m/S8egwlzeeiTl2Q0a4nA8Qorz5QKXQ/KpgMllI9MbCUA9KxJbP6YBjt376+BS
	 oJCgsWuxDvcx/pUEWD1OBpHYBFKDlE4M3dLCSPcrEHNfsZ7sFUf5klPSqqBHMgZneE
	 TNfGCL8PG10bA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Hans de Goede <hansg@kernel.org>,
 platform-driver-x86@vger.kernel.org, Kenneth Chan <kenneth.t.chan@gmail.com>
Subject:
 [PATCH v2 1/4] platform/x86: panasonic-laptop: Fix rollback path in
 acpi_pcc_hotkey_add()
Date: Wed, 18 Mar 2026 20:37:20 +0100
Message-ID: <5060610.GXAFRqVoOG@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <5979471.DvuYhMxLoT@rafael.j.wysocki>
References: <5979471.DvuYhMxLoT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

The rollback ordering in acpi_pcc_hotkey_add() is different from the
cleanup ordering in acpi_pcc_hotkey_remove().  Moreover, the latter
calls pcc_unregister_optd_notifier() unconditionally while the former
never calls it and the OPTD notifier is only registered if pcc->platform
is not NULL.

Address that by:
 * moving the pcc_register_optd_notifier() call after the device_create_file()
   return value check,
 * adding a new label to the acpi_pcc_hotkey_add() rollback code for
   pcc_register_optd_notifier() error handling,
 * moving the pcc_unregister_optd_notifier() call in acpi_pcc_hotkey_remove()
   before the removal of the cdpower sysfs attribute.

Also update pcc_register_optd_notifier() to return an error when
acpi_install_notify_handler() fails.

Fixes: d5a81d8e864b ("platform/x86: panasonic-laptop: Add support for optical driver power in Y and W series")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: New patch

---
 drivers/platform/x86/panasonic-laptop.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/x86/panasonic-laptop.c b/drivers/platform/x86/panasonic-laptop.c
index d923ddaa4849..debab5916782 100644
--- a/drivers/platform/x86/panasonic-laptop.c
+++ b/drivers/platform/x86/panasonic-laptop.c
@@ -897,15 +897,15 @@ static int pcc_register_optd_notifier(struct pcc_acpi *pcc, char *node)
 	acpi_handle handle;
 
 	status = acpi_get_handle(NULL, node, &handle);
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
 
-	if (ACPI_SUCCESS(status)) {
-		status = acpi_install_notify_handler(handle,
-				ACPI_SYSTEM_NOTIFY,
-				pcc_optd_notify, pcc);
-		if (ACPI_FAILURE(status))
-			pr_err("Failed to register notify on %s\n", node);
-	} else
+	status = acpi_install_notify_handler(handle, ACPI_SYSTEM_NOTIFY,
+					     pcc_optd_notify, pcc);
+	if (ACPI_FAILURE(status)) {
+		pr_err("Failed to register notify on %s\n", node);
 		return -ENODEV;
+	}
 
 	return 0;
 }
@@ -1093,9 +1093,12 @@ static int acpi_pcc_hotkey_add(struct acpi_device *device)
 		}
 		result = device_create_file(&pcc->platform->dev,
 			&dev_attr_cdpower);
-		pcc_register_optd_notifier(pcc, "\\_SB.PCI0.EHCI.ERHB.OPTD");
 		if (result)
 			goto out_platform;
+
+		result = pcc_register_optd_notifier(pcc, "\\_SB.PCI0.EHCI.ERHB.OPTD");
+		if (result)
+			goto out_cdpower;
 	} else {
 		pcc->platform = NULL;
 	}
@@ -1103,6 +1106,8 @@ static int acpi_pcc_hotkey_add(struct acpi_device *device)
 	i8042_install_filter(panasonic_i8042_filter, NULL);
 	return 0;
 
+out_cdpower:
+	device_remove_file(&pcc->platform->dev, &dev_attr_cdpower);
 out_platform:
 	platform_device_unregister(pcc->platform);
 out_sysfs:
@@ -1129,10 +1134,10 @@ static void acpi_pcc_hotkey_remove(struct acpi_device *device)
 	i8042_remove_filter(panasonic_i8042_filter);
 
 	if (pcc->platform) {
+		pcc_unregister_optd_notifier(pcc, "\\_SB.PCI0.EHCI.ERHB.OPTD");
 		device_remove_file(&pcc->platform->dev, &dev_attr_cdpower);
 		platform_device_unregister(pcc->platform);
 	}
-	pcc_unregister_optd_notifier(pcc, "\\_SB.PCI0.EHCI.ERHB.OPTD");
 
 	sysfs_remove_group(&device->dev.kobj, &pcc_attr_group);
 
-- 
2.51.0




