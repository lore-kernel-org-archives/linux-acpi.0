Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54E13793CC;
	Sun,  6 Sep 2026 15:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788710069; cv=none; b=NFv1mqZ00cDdQC3tF5ali2jsozlXOAXIT+Gxe7T2aYqE7IewkmjQoUqqe7UGutQIyE7tGs/GYNpUNKPmUFJDNW7pgdWOrLfUKR7fbBGxxkJg7NEdvJeJIkOY+0o6sS3KP1FWWZsu2jYvSwgq28iNqvm7yVFKw3WFGuszDzbddyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788710069; c=relaxed/simple;
	bh=0aJB1hVvfISkHcKh9E0R2u6HQyVv0hO4e0agTlRPHlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GLd6c6AtqgbIzAskltiOWNmvwesMxejoKZv1IF9/Iq9ZOiVX9JbVpi8Ti2F2vmanOJ7vqUHZMbtVyKnRWHLJNSiGFQWGEcPfFd0dL8DrlTZfAmAgwAR6OIBmU+NE2DoEfCwgaz7XK4EyK7gejZ41sYtLRjzeSDTfJ82n9bMEnj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EiHD9VKv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EiHD9VKv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B9841F00ADB;
	Sun,  6 Sep 2026 15:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788710067;
	bh=gMO2fQLakYeAC8pB+UHpwAaY6R+i+i2w74J0EziUom0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EiHD9VKvEFpcs+PLqabV3qTzj/hg4Buh/wUWy110A3yx+61vWq8jmIfn6y/pF49P+
	 bK3y9Jbz2caDDLofKYpZ6lkxmFCkU3JXH77nxAkDhOVOgQfv65hqBbRpBetIL2HJ8u
	 UVvMz08+yu5jCbDKgF3ldbYHoAyj9ggpUpY4A5qeIGuggMjCTgdQPYbgBU4I0whPki
	 OGMQ93p+ePJi+MFHiHEABixjsP4HJ/DwIOW0EfBevr9+G73dVglIQMscezgckXpn4p
	 XMwBUiFGTeasnghMDr0KQFcbY+nHW/4BeNbBIJvnwx/k1bX1Ph1C67QV2cHD48J2Ge
	 bPLiFiuOuYghw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject:
 [PATCH v4 1/2] ACPI: glue: Reduce debug noise from acpi_device_notify()
Date: Sun, 06 Sep 2026 17:51:23 +0200
Message-ID: <6325978.lOV4Wx5bFT@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
In-Reply-To: <12989369.O9o76ZdvQC@rafael.j.wysocki>
References: <12989369.O9o76ZdvQC@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

When debug is enabled in the ACPI glue code that handles binding
devices to ACPI companions, acpi_device_notify() produces a lot of
message noise related to devices that have no ACPI companions.

Reduce that noise by checking the most obvious case, ACPI device
objects, directly and returning from acpi_device_notify() in that
case without printing any debug messages.  Also avoid printing a
debug message when there is no matching ACPI bus type definition for
the given device, which is the case for the vast majority of devices.

Additionally, make the debug messages that get printed more informative.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v3 -> v4:
   * Do not update the "success" message (that will be taken care of
     by a separate patch)

v2 -> v3:
   * Do not change pr_fmt() definition (Sashiko)
   * adjust the "success" debug message for devices whose ACPI companions
     have no ACPI handles
   * Update changelog

v1 -> v2:
   * Do not return early from acpi_device_notify() for devices
     without a bus type (Sashiko)
   * Do not print messages for devices without matching ACPI bus
     type definition (the vast majority)
   * Update changelog

---
 drivers/acpi/glue.c |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

--- a/drivers/acpi/glue.c
+++ b/drivers/acpi/glue.c
@@ -354,22 +354,27 @@ void acpi_device_notify(struct device *d
 	struct acpi_device *adev;
 	int ret;
 
+	/* ACPI devices have no ACPI companions. */
+	if (dev->bus == &acpi_bus_type)
+		return;
+
 	ret = acpi_bind_one(dev, NULL);
 	if (ret) {
 		struct acpi_bus_type *type = acpi_get_bus_type(dev);
 
 		if (!type)
-			goto err;
+			return;
 
 		adev = type->find_companion(dev);
 		if (!adev) {
 			dev_dbg(dev, "ACPI companion not found\n");
-			goto err;
+			return;
 		}
 		ret = acpi_bind_one(dev, adev);
-		if (ret)
-			goto err;
-
+		if (ret) {
+			dev_dbg(dev, "Binding to ACPI companion failed\n");
+			return;
+		}
 		if (type->setup) {
 			type->setup(dev);
 			goto done;
@@ -391,11 +396,6 @@ void acpi_device_notify(struct device *d
 done:
 	acpi_handle_debug(ACPI_HANDLE(dev), "Bound to device %s\n",
 			  dev_name(dev));
-
-	return;
-
-err:
-	dev_dbg(dev, "No ACPI support\n");
 }
 
 void acpi_device_notify_remove(struct device *dev)



