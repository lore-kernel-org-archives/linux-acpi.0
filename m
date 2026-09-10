Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA9A57D211;
	Thu, 10 Sep 2026 17:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789063014; cv=none; b=YBCAhY0R4CwhHD/SXdJpiHXtRA2QBRG4+PTlDeMTmbwxKPDmfKdbzJHwM258vLyhoXQcYIh5aqaO96XakNPRz9Ypd1kk8fsrqp8+mSc5Fa5Wpc8PP2m3+2pEQ5ttWqLXQnx3NVda86fOr12yGICbutEdBGNrVn8HG5ojvq1ffdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789063014; c=relaxed/simple;
	bh=+45I3UcQ709+waIgzSvnoYVOZE6rlZwZM/7TZNfF1AU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vFAdeW2hw+7kCSr94oWcJDMkzmRQDA5EBqXlqCsIO5OhITZ+3lLhxLkr0apV/ZRN8fK3Q/Kda+EeHVoS2A6HNrVa+X4bEkvSwgejoxpYA7RA7Sbu7lLhzbvtILAJrdwfmIV6lQlvysyQ+RUNaL7MCgzpQNT7oyLalMODLg/Hr0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KKxJRuen; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KKxJRuen"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 611711F000FF;
	Thu, 10 Sep 2026 17:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789063013;
	bh=+dT++UdcLLyYMd/MIDRViEa0LlSjC/iYIqmAJEfDZnM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KKxJRuencMpkUR6A5TiGtDNpc2akxun1kD2nb88roaHKIIjzrH3T7/Wad9Z7Mnti5
	 TvUOF+wz3H2RPDIyeOyLEHxjJHKi00ubhqiXw8qnxTqRV8MRN+LtRHlNToJhjBXubg
	 E9Tj7SZJiIrwRtaDmBHfbp2rYMKw1N37kKntQoh2yBmiaM5aBHy1GAPH0xVFPvL+SF
	 1FEkEpOz9q793NHOsMu7CYlCDdxpMOZRt9IH7jM2k6vkX+7KKqRq1/6IusstQki9ER
	 WO33eLVMbvWz6vDSicOrFek0yjZvtWt40p4tlKj6i6yMi0bjVAd7VRmW2jAow+w9ti
	 1I2eiDn29n3Mw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject:
 [PATCH v1 2/4] ACPI: glue: Rearrange acpi_bind_one() to avoid breakage
Date: Thu, 10 Sep 2026 19:56:10 +0200
Message-ID: <3465482.44csPzL39Z@rafael.j.wysocki>
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

Rearange the code in acpi_bind_one() to avoid situations in which the
existing ACPI companion of the given device would be replaced with NULL
due to a memory allocation error or because somebody tries to bind a
physical device with an ACPI companion to a different ACPI device
erroneously.

Fixes: 7b1998116bbb ("ACPI / driver core: Store an ACPI device pointer in struct acpi_dev_node")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/glue.c | 59 +++++++++++++++++++--------------------------
 1 file changed, 25 insertions(+), 34 deletions(-)

diff --git a/drivers/acpi/glue.c b/drivers/acpi/glue.c
index 40e6513a9942..89336a5fa78b 100644
--- a/drivers/acpi/glue.c
+++ b/drivers/acpi/glue.c
@@ -243,31 +243,26 @@ static void acpi_physnode_link_name(char *buf, unsigned int node_id)
 int acpi_bind_one(struct device *dev, struct acpi_device *acpi_dev)
 {
 	struct acpi_device_physical_node *physical_node, *pn;
+	struct acpi_device *comp_dev = ACPI_COMPANION(dev);
 	char physical_node_name[PHYSICAL_NODE_NAME_SIZE];
 	struct list_head *physnode_list;
 	unsigned int node_id;
 	int retval = -EINVAL;
 
-	if (has_acpi_companion(dev)) {
-		if (acpi_dev) {
-			dev_warn(dev, "ACPI companion already set\n");
+	if (!acpi_dev) {
+		if (!comp_dev)
 			return -EINVAL;
-		} else {
-			acpi_dev = ACPI_COMPANION(dev);
-		}
-	}
-	if (!acpi_dev)
-		return -EINVAL;
 
-	acpi_dev_get(acpi_dev);
-	get_device(dev);
-	physical_node = kzalloc_obj(*physical_node);
-	if (!physical_node) {
-		retval = -ENOMEM;
-		goto err;
+		/* If the companion has been set upfront, pick it up. */
+		acpi_dev = comp_dev;
+	}
+	if (comp_dev && comp_dev != acpi_dev) {
+		dev_warn(dev, "ACPI companion already set to %s which is not %s\n",
+			 acpi_dev_name(comp_dev), acpi_dev_name(acpi_dev));
+		return -EEXIST;
 	}
 
-	mutex_lock(&acpi_dev->physical_node_lock);
+	guard(mutex)(&acpi_dev->physical_node_lock);
 
 	/*
 	 * Keep the list sorted by node_id so that the IDs of removed nodes can
@@ -278,15 +273,12 @@ int acpi_bind_one(struct device *dev, struct acpi_device *acpi_dev)
 	list_for_each_entry(pn, &acpi_dev->physical_node_list, node) {
 		/* Sanity check. */
 		if (pn->dev == dev) {
-			mutex_unlock(&acpi_dev->physical_node_lock);
-
-			dev_warn(dev, "Already associated with ACPI node\n");
-			kfree(physical_node);
-			if (ACPI_COMPANION(dev) != acpi_dev)
-				goto err;
-
-			put_device(dev);
-			acpi_dev_put(acpi_dev);
+			if (!comp_dev) {
+				/* Really unexpected. */
+				ACPI_COMPANION_SET(dev, acpi_dev);
+				dev_warn(&acpi_dev->dev,
+					 "Physical device list corruption fixed up\n");
+			}
 			return 0;
 		}
 		if (pn->node_id == node_id) {
@@ -295,12 +287,19 @@ int acpi_bind_one(struct device *dev, struct acpi_device *acpi_dev)
 		}
 	}
 
+	physical_node = kzalloc_obj(*physical_node);
+	if (!physical_node)
+		return -ENOMEM;
+
+	acpi_dev_get(acpi_dev);
+	get_device(dev);
+
 	physical_node->node_id = node_id;
 	physical_node->dev = dev;
 	list_add(&physical_node->node, physnode_list);
 	acpi_dev->physical_node_count++;
 
-	if (!has_acpi_companion(dev))
+	if (!comp_dev)
 		ACPI_COMPANION_SET(dev, acpi_dev);
 
 	acpi_physnode_link_name(physical_node_name, node_id);
@@ -316,18 +315,10 @@ int acpi_bind_one(struct device *dev, struct acpi_device *acpi_dev)
 		dev_err(dev, "Failed to create link firmware_node (%d)\n",
 			retval);
 
-	mutex_unlock(&acpi_dev->physical_node_lock);
-
 	if (acpi_dev->wakeup.flags.valid)
 		device_set_wakeup_capable(dev, true);
 
 	return 0;
-
- err:
-	ACPI_COMPANION_SET(dev, NULL);
-	put_device(dev);
-	acpi_dev_put(acpi_dev);
-	return retval;
 }
 EXPORT_SYMBOL_GPL(acpi_bind_one);
 
-- 
2.51.0




