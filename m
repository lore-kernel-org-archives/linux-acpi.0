Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDBB568540;
	Thu, 10 Sep 2026 17:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789063017; cv=none; b=pmHqhs/vR9zo1dxF1qVolPpsP2ubLTIwonCU8RgCv98Fg7xyeFN9rIa49Z3Ee6sv67Er9aDDLXswIPZZjvOVYTd9GhF4WW37al3IuBSqSN7Enta2IJmIw6vIM4LdI9AYwCfnWc9dbU0f+OvHpRGMMieEhaqDJagqU8rlDYskQRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789063017; c=relaxed/simple;
	bh=CudccC1wyqIyS2pqjtPFOjk5mc4P05Dq6Qgaps63Wjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K7C6Avi50J85ODVhzaBxuHvilMISa3HJzEw4ftfJbkd4+v1wp2HjOGiqDSA+1Ks27BQyG6j9gl6akadhl3+fdS912HHGgYY0DV6D/iGlSCu2ejs+2dqrRNSqzUo3EEnsX09ONLMlJn57QTzAYavUGMQcoXJJV4aZo1TFYikBJmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ksbJ5F8z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ksbJ5F8z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 736821F000FF;
	Thu, 10 Sep 2026 17:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789063016;
	bh=TZMgRK2vyjQ4pL/vF3m6KY07gj9BRl++KeIfdYzNkaM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ksbJ5F8z81XiunBLxzP/0hqz9Lt3JQ0TiqGZ6MJMxoM+qXpgdwJhtjZKZVqcyOQ5i
	 ri69bBy96OBqB3kOv0/qZ8ElfNFGbBxj+GzqtjJ6CJONXXXw8d4giWr+5k3fh/6Hmw
	 J7Qb5tquxwDNPBs33mqvblRmK6pMPsjk1/zBcKOO8JMqEfA0rSdLLirQGkG06Oe2az
	 6ST4+ZOvgEJzWfsIivw0yd38CT9f1dTsFtVQhNlEvgzabK/xvOK6a//eETNV1q3Zig
	 g+YEPw3DN8WkAZv1hONlS5f/iXJmgtAXoWf2xlkP2OgD1EzHJL11IB/HCDvWtfqWml
	 XCywVuuKDNlMA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject:
 [PATCH v1 1/4] ACPI: glue: Carry out companion lookup under bus_type_sem
Date: Thu, 10 Sep 2026 19:56:04 +0200
Message-ID: <3089807.e9J7NaK4W3@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
In-Reply-To: <12995802.O9o76ZdvQC@rafael.j.wysocki>
References: <12995802.O9o76ZdvQC@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

When acpi_device_notify() looks up an ACPI companion for the given
device, it invokes callbacks from struct acpi_bus_type() without
synchronization which may lead to a use-after-free if the driver
module containing those callbacks is unloaded at the same time.

Address this by holding bus_type_sem throughout the entire ACPI
companion lookup and the execution of the .setup() callback in
struct acpi_bus_type (if present) instead of dropping the semaphore
(prematurely) after finding a matching struct acpi_bus_type.

For this purpose, rename acpi_get_bus_type() to acpi_companion_lookup(),
make it return a struct acpi_device pointer, and move the relevant code
from acpi_device_notify() to it.

Also notice that the only case in which the .bind() callback from an
ACPI scan handler may need to be invoked is when the given device is
a platform one, so adjust acpi_device_notify() accordingly and drop
the "done" label that is not used any more from it.

Fixes: 2ef5236660b6 ("ACPI: glue: Look for ACPI bus type only if ACPI companion is not known")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

Applies on top of

https://lore.kernel.org/linux-acpi/12989369.O9o76ZdvQC@rafael.j.wysocki/

which is in linux-pm.git/linux-next now.

Thanks!

---
 drivers/acpi/glue.c | 61 +++++++++++++++++++++------------------------
 1 file changed, 29 insertions(+), 32 deletions(-)

diff --git a/drivers/acpi/glue.c b/drivers/acpi/glue.c
index a47cccc4efd3..40e6513a9942 100644
--- a/drivers/acpi/glue.c
+++ b/drivers/acpi/glue.c
@@ -59,19 +59,34 @@ int unregister_acpi_bus_type(struct acpi_bus_type *type)
 }
 EXPORT_SYMBOL_GPL(unregister_acpi_bus_type);
 
-static struct acpi_bus_type *acpi_get_bus_type(struct device *dev)
+static struct acpi_device *acpi_companion_lookup(struct device *dev)
 {
-	struct acpi_bus_type *tmp, *ret = NULL;
+	struct acpi_bus_type *type;
 
-	down_read(&bus_type_sem);
-	list_for_each_entry(tmp, &bus_type_list, list) {
-		if (tmp->match(dev)) {
-			ret = tmp;
-			break;
+	guard(rwsem_read)(&bus_type_sem);
+
+	list_for_each_entry(type, &bus_type_list, list) {
+		struct acpi_device *adev;
+
+		if (!type->match(dev))
+			continue;
+
+		adev = type->find_companion(dev);
+		if (!adev) {
+			dev_dbg(dev, "ACPI companion not found\n");
+			return NULL;
 		}
+		if (acpi_bind_one(dev, adev)) {
+			dev_dbg(dev, "Binding to ACPI companion failed\n");
+			return NULL;
+		}
+		if (type->setup)
+			type->setup(dev);
+
+		return adev;
 	}
-	up_read(&bus_type_sem);
-	return ret;
+
+	return NULL;
 }
 
 #define FIND_CHILD_MIN_SCORE	1
@@ -360,40 +375,22 @@ void acpi_device_notify(struct device *dev)
 
 	ret = acpi_bind_one(dev, NULL);
 	if (ret) {
-		struct acpi_bus_type *type = acpi_get_bus_type(dev);
-
-		if (!type)
+		adev = acpi_companion_lookup(dev);
+		if (!adev)
 			return;
-
-		adev = type->find_companion(dev);
-		if (!adev) {
-			dev_dbg(dev, "ACPI companion not found\n");
-			return;
-		}
-		ret = acpi_bind_one(dev, adev);
-		if (ret) {
-			dev_dbg(dev, "Binding to ACPI companion failed\n");
-			return;
-		}
-		if (type->setup) {
-			type->setup(dev);
-			goto done;
-		}
 	} else {
 		adev = ACPI_COMPANION(dev);
 
 		if (dev_is_pci(dev)) {
 			pci_acpi_setup(dev, adev);
-			goto done;
 		} else if (dev_is_platform(dev)) {
 			acpi_configure_pmsi_domain(dev);
+
+			if (adev->handler && adev->handler->bind)
+				adev->handler->bind(dev);
 		}
 	}
 
-	if (adev->handler && adev->handler->bind)
-		adev->handler->bind(dev);
-
-done:
 	dev_dbg(dev, "Bound to ACPI device %s\n", acpi_dev_name(adev));
 }
 
-- 
2.51.0




