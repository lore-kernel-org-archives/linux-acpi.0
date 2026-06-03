Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2213DB632;
	Wed,  3 Jun 2026 18:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780511188; cv=none; b=WviVpvnBbZfg+b5YdsOZflizFE8403NgwBYIQHtp7tRHCRyn4AAB3cySjg8JLaj0lTMMT/3T3qxaRvYsAxqimLU3gnbQm9VCX7M0LarxDkmclR7t3t7wvR9Ft8NYw4ExJx5gb/krtSgp6VTMqqHTaWdD2zODUtElGkVnf+xtS4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780511188; c=relaxed/simple;
	bh=UMwZYBcTbz/5r53G1b8cOfXAZZyOSbMXdll9+/ycgPo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=j6E0CoVqwVuq+4Sb/FvES7XL6e4mf0FRUBY68tdk6tmyPZIv3nbhLzsuLm0BR1K4eLoPV/VrT11uaK8C/e2l8lVQLpXR9dRQLIyNnCrmCiCHi85Y9NH5ixP5pldVzKbrXxfjKO+nKdw8kWxuA1Rzp2Gs4SgeYNYFZY6M5DiFxLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cBNCRSu0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cBNCRSu0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C62591F00893;
	Wed,  3 Jun 2026 18:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780511187;
	bh=kdm71ve/iHr2YjAi9PX8rgHcvvYgG9iOKX6pzyZX9l4=;
	h=From:To:Cc:Subject:Date;
	b=cBNCRSu0HGVOWN6jE8MU9m091N1C4tqhpD1qhRffNJwI87ggl8AH+BZMkN8xL3RWL
	 BGS2EPjl9tPv2nYZBmCxH+duGECFs2Y2BJYLZh3niXFJqODTN9T7zViZyHq9b7tpXf
	 XLFoi91GHDH6nB8jOCmoBAN9g3CniMEunHkmazOwpKlHleGXK1sY4JwFuqLJ7WqNev
	 uu3jo8sJceIs2aaYExlS78a7dkSQacPQbMncWfLgcYiX7j78NfA1Emf1u4eMIdOVPM
	 1P2O4o1QG/wIg7tu7f3JtyboLVbwKC6bMwc3DufjNdhMdUb4TcMRwO1aWChvOv9DYT
	 A+ETKkMZsL6fQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] ACPI: bus: Clean up devm_acpi_install_notify_handler()
Date: Wed, 03 Jun 2026 20:26:24 +0200
Message-ID: <2841496.mvXUDI8C0e@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Add a pointer to the struct acpi_device used for installing the ACPI
notify handler to struct acpi_notify_handler_devres so it need not
be retrieved from the owner device via ACPI_COMPANION() in
devm_acpi_notify_handler_release().

While at it, drop the function name from one of the messages printed
by devm_acpi_install_notify_handler() for consistency and fix up white
space in its kerneldoc comment.

No intentional functional impact.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

Applies on top of linux-next.

---
 drivers/acpi/bus.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -680,6 +680,7 @@ void acpi_dev_remove_notify_handler(stru
 EXPORT_SYMBOL_GPL(acpi_dev_remove_notify_handler);
 
 struct acpi_notify_handler_devres {
+	struct acpi_device *adev;
 	acpi_notify_handler handler;
 	u32 handler_type;
 };
@@ -688,13 +689,12 @@ static void devm_acpi_notify_handler_rel
 {
 	struct acpi_notify_handler_devres *dr = res;
 
-	acpi_dev_remove_notify_handler(ACPI_COMPANION(dev), dr->handler_type,
-				       dr->handler);
+	acpi_dev_remove_notify_handler(dr->adev, dr->handler_type, dr->handler);
 }
 
 /**
  * devm_acpi_install_notify_handler - Install an ACPI notify handler for a
- * 				      managed device
+ *				      managed device
  * @dev: Device to install a notify handler for
  * @handler_type: Type of the notify handler
  * @handler: Handler function to install
@@ -725,7 +725,7 @@ int devm_acpi_install_notify_handler(str
 
 	adev = ACPI_COMPANION(dev);
 	if (!adev)
-		return dev_err_probe(dev, -ENODEV, "No ACPI companion in %s()\n", __func__);
+		return dev_err_probe(dev, -ENODEV, "No ACPI companion\n");
 
 	dr = devres_alloc(devm_acpi_notify_handler_release, sizeof(*dr), GFP_KERNEL);
 	if (!dr)
@@ -737,6 +737,7 @@ int devm_acpi_install_notify_handler(str
 		return dev_err_probe(dev, ret, "Failed to install an ACPI notify handler\n");
 	}
 
+	dr->adev = adev;
 	dr->handler = handler;
 	dr->handler_type = handler_type;
 	devres_add(dev, dr);



