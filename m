Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE6B44682F;
	Fri,  4 Sep 2026 12:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788526508; cv=none; b=SGtk4ec5bHEa5Nu4lfAg5LExf7P0SpMw1wO0e276FZdmgvyD2zXlfm7/j70mCg4qT8yyCFdF1IHKy1T36XBZjqjNNtV0xmNVdkYauPWHgq5W827e6wbVana/c+rtnjyYq5hlXRoxBIPb7ivB/mmlGBQWG8a7uUrVAed01d3/iyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788526508; c=relaxed/simple;
	bh=TfD52jOzf+a1JoDQPQQivlY/fszqgwWGK2WVitDtjIw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Tcvd2TAeE+MsHlQ8BdU6qUXM9JnUJ/oq8i4vJPJI68gj5v2tDXyTTh7qVmCSWijWucS2suAvMbtHM7yjozQzUnRc6nbwa4vy6PKq9gBV3Juma97pwOaIX0/QUyBOc3869qHqMr7TAt0DNhZq+hNfd5uG6njOuyul32K2SyiCzSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NgdrKgO3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NgdrKgO3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 041F31F00A3D;
	Fri,  4 Sep 2026 12:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788526506;
	bh=+jAa/+gW4uJqMlBI4roLSbcXFG/6ATTWTZkTBgaLylU=;
	h=From:To:Cc:Subject:Date;
	b=NgdrKgO3pYOaTZTNkfrAnZN17U54JyRhb4gYeRM1VQUwfFHOL7ypUm94UGF8PdCLb
	 VdP9JlTRZw5Nv1sxN0netJ+uzxVN8DYKA28mKvvXqbg4KpuE/ZApE63HNeHtt2HBIq
	 ycqPZg7mcWFEcKfWdBmx7d9gcjRfIUI19VRBPpntkrtS0XFyWaYDjCmIUTQ+IOkQhE
	 evGFgKm2IL/lxYdXl3j8eMbaUPdmgVqNbP2V+gytI/90fWDHfUlKVGycB8XVH8dCgI
	 IbSCdJU4YQa1H5sFJsT28bQOW7IqcAI/BhIfhiuEbxPv6HASMT4mktx74rjlTlOXfW
	 JmwiENSxD1ldw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] ACPI: glue: Reduce debug noise from acpi_device_notify()
Date: Fri, 04 Sep 2026 14:55:03 +0200
Message-ID: <2868233.mvXUDI8C0e@rafael.j.wysocki>
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

Reduce that noise by checking the most obvious cases, ACPI device
objects and devices without a bus type, directly and returning from
acpi_device_notify() in these cases without printing any debug
messages.

Also make the debug messages that get printed more informative and
change the format prefix to "ACPI/glue", so it is easier to filter
these messages.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/glue.c |   34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

--- a/drivers/acpi/glue.c
+++ b/drivers/acpi/glue.c
@@ -6,7 +6,7 @@
  * Copyright (c) 2005 Intel Corp.
  */
 
-#define pr_fmt(fmt) "ACPI: " fmt
+#define pr_fmt(fmt) "ACPI/glue: " fmt
 
 #include <linux/acpi_iort.h>
 #include <linux/export.h>
@@ -354,22 +354,33 @@ void acpi_device_notify(struct device *d
 	struct acpi_device *adev;
 	int ret;
 
+	/* ACPI devices have no ACPI companions. */
+	if (dev->bus == &acpi_bus_type)
+		return;
+
 	ret = acpi_bind_one(dev, NULL);
 	if (ret) {
-		struct acpi_bus_type *type = acpi_get_bus_type(dev);
-
-		if (!type)
-			goto err;
+		struct acpi_bus_type *type;
 
+		/* Skip devices without bus types. */
+		if (!dev->bus)
+			return;
+
+		type = acpi_get_bus_type(dev);
+		if (!type) {
+			dev_dbg(dev, "No matching ACPI bus type description\n");
+			return;
+		}
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
@@ -391,11 +402,6 @@ void acpi_device_notify(struct device *d
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



