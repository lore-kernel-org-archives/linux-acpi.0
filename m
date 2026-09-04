Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEE84CA788;
	Fri,  4 Sep 2026 15:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788536700; cv=none; b=gFWnwHaAodIJT4VndtXsnPO3R4kb9T0MVGrmbt80DFLkWl4/3yrcxJp6WhJRYcrhGyfYonbgBDxnuP65MNAqzaXg22zSU+ftRf6PggYRYMDYVfAGlHXVG8f4g5zBHCYirz4UcULCFcLIOTatXlKw/4muzT5L2c9paFbcakkKYb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788536700; c=relaxed/simple;
	bh=nD+MBnsNWQMTnEdYY6pJAJGFC9Thf3mwQsiiKI19l5M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JKgt0f56qNv4yywXErlo3zeWYAe6apFeLAj2A5RdJ9gdjclLYszVAwiIQAPpDF8oePtFQpHjnSjhI0wc57o9pAzvjyx4mFqWf5J7XId2fUez/Q8OLAtDjjARQOm9bZX3y17CBBcoISKFOJCs1O9h6jiN0TLv9c8cOlGZlL2vrpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FHNeSWA8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FHNeSWA8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F3621F00A3D;
	Fri,  4 Sep 2026 15:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788536698;
	bh=gVrFRUwdXOyKStFcN4EZ/7BKFWSDHX6pMewFaI2mh1E=;
	h=From:To:Cc:Subject:Date;
	b=FHNeSWA8SrTBDoWKwXv1nzQjoWRDfAWXb+dlZB6Ti6e9QYU7CcpgDdgKlou4jCuJt
	 448wYK6NWfE750syYqXTm1G/Tu3njn2+EesiSGic7b78PF0U2iRfk9gXtcbvjC2H2l
	 7BMoFnIB7nRIIfNFxrDAfpA8qRB03whY38o3JIqWmrinlzBpVZYcUJwUnMt70SjqPN
	 CE40uqfgnzsRMx6ZenaFyGZfX9IllBhc/UnOpLkY7PxlNb5QX3QeNemH5b1PqKSYZV
	 hneaNuzqHPcWiCj/9Ead5EWOQKSLmrOifS9cv/INaQ32BCFLV8CWErRfavr5UZ9hRk
	 mYkFFPBzozQGg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2] ACPI: glue: Reduce debug noise from acpi_device_notify()
Date: Fri, 04 Sep 2026 17:44:55 +0200
Message-ID: <2869083.mvXUDI8C0e@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
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

Additionally, make the debug messages that get printed more informative
and change the format prefix to "ACPI/glue", so it is easier to filter
these messages.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2:
   * Do not return early from acpi_device_notify() for devices
     without a bus type (Sashiko)
   * Do not print messages for devices without matching ACPI bus
     type definition (the vast majority)
   * Update changelog

---
 drivers/acpi/glue.c |   22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

--- a/drivers/acpi/glue.c
+++ b/drivers/acpi/glue.c
@@ -6,7 +6,7 @@
  * Copyright (c) 2005 Intel Corp.
  */
 
-#define pr_fmt(fmt) "ACPI: " fmt
+#define pr_fmt(fmt) "ACPI/glue: " fmt
 
 #include <linux/acpi_iort.h>
 #include <linux/export.h>
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



