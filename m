Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E6556B874;
	Thu, 10 Sep 2026 17:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789063011; cv=none; b=nVNVwn+CZkxshxJPEVOWcA+Rvb2iZ2QxPimRWyIKgKZ/MfWjSPZDkZDzy/S/AGDCCd/j8FdyneldwtVJwiOYmVJJKKUbkYFnDvVLP7A0OhAaqH5O5bxfirC6Cp3tL2Zzy4AtnO+G6Y6Mt1I3tCUWMQxqOh/LOc7YzWmxvYsbQC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789063011; c=relaxed/simple;
	bh=COGoguQ+4f/Y229X96rVq7Z+RqZXzW1k8lHse1LZNIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XOi2UCMwv18lo1PYe7SIieGWLfjMNTtHwI/IPac8KMXbR3p0F8OVpZ6HgX0MPibC5C5ArtkMq+VDSTvGFE0NPc0CsX+/4nJ8zTPo+7cL5mGnhtmpeLBhAlwh0uCWUYuw6C6nrEHeCcEGeDr6g49AbLzIHxm6f+UnRwD4BlesqXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bt0ix5G5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bt0ix5G5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68E531F00893;
	Thu, 10 Sep 2026 17:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789063010;
	bh=wXdEIHa6ugyRxbQcC4gHCUPLfLsfO9sT0qWJ1U9psjI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bt0ix5G5uZy7mPFrwD8Kv/ZFuy5lwXcDsz+sc7edMf91MXhf/ZPWQ7BF0/98ziTy+
	 Ffcnv67aArlqCdagThyH2nWbf+HBDzYO+EbUKRSJJ9hYE1/belpSQdM4//wrT3R2j+
	 zPIqJaf4t9TQMrx7f9UZ8elTHkP3khuv/qzqGQRXizGhBNDRcvgnMYnnC8ZEHy5XZU
	 HlpUmcvL2juQYea0O4oBz5Nx75BLNeZMn/6VZuZJceL0YIrTIETlRAGwPslfO3d15J
	 CPDDCY7aLa2UXBTq9SsypD4xH8S/ZxhDJCdw91HDYneWXSAOAzg1kKOTOqSzBLL/+v
	 B+tITZZDO6irQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 3/4] ACPI: glue: Fix up and adjust acpi_unbind_one()
Date: Thu, 10 Sep 2026 19:56:16 +0200
Message-ID: <10940500.nUPlyArG6x@rafael.j.wysocki>
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

Since none of the acpi_unbind_one() callers check its return value and
it always returns 0 anyway, make it void.

Also notice that unlocking physical_node_lock for the given ACPI device
should be carried out before dropping the reference to it in case that
reference is the last one (highly unlikely), so rearrange the code to
make that happen.

Fixes: 3e3327837c18 ("ACPI: Use list_for_each_entry() in acpi_unbind_one()")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/glue.c     | 10 ++++++----
 include/acpi/acpi_bus.h |  2 +-
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/glue.c b/drivers/acpi/glue.c
index 89336a5fa78b..1981ebfb5ce0 100644
--- a/drivers/acpi/glue.c
+++ b/drivers/acpi/glue.c
@@ -322,13 +322,13 @@ int acpi_bind_one(struct device *dev, struct acpi_device *acpi_dev)
 }
 EXPORT_SYMBOL_GPL(acpi_bind_one);
 
-int acpi_unbind_one(struct device *dev)
+void acpi_unbind_one(struct device *dev)
 {
 	struct acpi_device *acpi_dev = ACPI_COMPANION(dev);
 	struct acpi_device_physical_node *entry;
 
 	if (!acpi_dev)
-		return 0;
+		return;
 
 	mutex_lock(&acpi_dev->physical_node_lock);
 
@@ -343,15 +343,17 @@ int acpi_unbind_one(struct device *dev)
 			sysfs_remove_link(&acpi_dev->dev.kobj, physnode_name);
 			sysfs_remove_link(&dev->kobj, "firmware_node");
 			ACPI_COMPANION_SET(dev, NULL);
+
+			mutex_unlock(&acpi_dev->physical_node_lock);
+
 			/* Drop references taken by acpi_bind_one(). */
 			put_device(dev);
 			acpi_dev_put(acpi_dev);
 			kfree(entry);
-			break;
+			return;
 		}
 
 	mutex_unlock(&acpi_dev->physical_node_lock);
-	return 0;
 }
 EXPORT_SYMBOL_GPL(acpi_unbind_one);
 
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index a10a591c18b2..93b00635ba3d 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -665,7 +665,7 @@ struct acpi_bus_type {
 int register_acpi_bus_type(struct acpi_bus_type *);
 int unregister_acpi_bus_type(struct acpi_bus_type *);
 int acpi_bind_one(struct device *dev, struct acpi_device *adev);
-int acpi_unbind_one(struct device *dev);
+void acpi_unbind_one(struct device *dev);
 
 enum acpi_bridge_type {
 	ACPI_BRIDGE_TYPE_PCIE = 1,
-- 
2.51.0




