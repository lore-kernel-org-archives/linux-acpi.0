Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3F8513573;
	Fri,  4 Sep 2026 20:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788552731; cv=none; b=gWjjpW26QC7J/rI5zxm7eJRBYwnM+9yBXHWBku8pkLrewa4gXJf3fQC3Dwezozhu0U4UhXl9D8jbL7R6yMlPvMzLc+bMZNxbvxJN5Hd6oQ814RouvVHShkZkpGkQmxGiBn9YbKWdqh4+Nb6/MQlzhbTLBxFT/ufM8C82P3kq4zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788552731; c=relaxed/simple;
	bh=0YYXmV5N0W2pxZNdVpXYKT1de8LKSGeTOZvC9bxhiL8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PCttHGeT1iZk3A14EgCNIqJLWMgbnFd6eaYvrLTtOhvptOAZeo56nBIbwyxjOWeIB+3IFzb50EzhVi5FzD0iXxE/EXdcSnCCXxYTgc6n0eataOFUg0YecttnGAPCj8YS1E5rYzq8K7r3olOsVHuPoyHwNo97P5R/ZnGy+hg1FBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FiPDdWdy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FiPDdWdy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 478841F00A3D;
	Fri,  4 Sep 2026 20:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788552722;
	bh=tiI2plDWeBhwWgqgp0Lt6N026JHuLCwaqyR957rXbKc=;
	h=From:To:Cc:Subject:Date;
	b=FiPDdWdy+ul3c1SV5X5HD2KgZFtJzY6VOU8zzE0x1MLxejiF/uT3NJ2VljrET5DLu
	 mg1GbWnoOMtBbxn/9X3i3FKo+EapLXyBpesC+72RAiNAaWad8a6iTOWBTyql9iSWbr
	 OWeFapliiwBpV5ADMdwBRw02BhgGRjwf3p/5Z5x+FRtZq6RhpLmyzCm4wcmCbbdTsG
	 8/6L9m/g3bOg7EyXG3k1HXGD5m383fzSU+rdFSrVkotp2hyQdGUzFqQAZRzXrrZy7W
	 jPxp/C+ONxrPTbPUXXm6cU+RJLDuKJH2tZvrW3+QXLXqIbXWN2zX3yTwAd4+KVjDh3
	 OgDIoA1NdniRw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3] ACPI: glue: Reduce debug noise from acpi_device_notify()
Date: Fri, 04 Sep 2026 22:11:58 +0200
Message-ID: <6048536.DvuYhMxLoT@rafael.j.wysocki>
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
debug message when there is no matching ACPI companion lookup
method for the given device, which is the case for the vast
majority of devices.

Additionally, make the debug messages that get printed more informative
and adjust the "success" debug message for devices whose ACPI companions
have no ACPI handles (for example, they are fixed event buttons).

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

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
 drivers/acpi/glue.c |   27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

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
@@ -389,13 +394,11 @@ void acpi_device_notify(struct device *d
 		adev->handler->bind(dev);
 
 done:
-	acpi_handle_debug(ACPI_HANDLE(dev), "Bound to device %s\n",
-			  dev_name(dev));
-
-	return;
-
-err:
-	dev_dbg(dev, "No ACPI support\n");
+	if (adev->handle)
+		acpi_handle_debug(adev->handle, "Bound to device %s\n",
+				  dev_name(dev));
+	else
+		dev_dbg(dev, "Bound to ACPI device %s\n", dev_name(&adev->dev));
 }
 
 void acpi_device_notify_remove(struct device *dev)



