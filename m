Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58EC31D74B;
	Wed, 12 Aug 2026 12:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786538512; cv=none; b=YaGj+7ghVpFlLcC8oUxj11AL4pXzbNqyRsIooGN1oFDOdatYRSmTUAMjeFq5CCyuD6hn0UevMEdqSEC07CZSqiH1zsf4XKF88+q9B0PPgXrcozjOagjWcgkQIluAFV6WAcz3vJwNH9rbH1u4yRAj0bKzzyPezkDFET4P1RCBNI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786538512; c=relaxed/simple;
	bh=3rCMaEdDCu44QUzPF9CVr+IYE/GZBqs6GNyUVzX0wbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L1FCQwo9yjgTtbK0i6SQGn6H6tIcQfW05alWoCdRVVb1VGUCU5RkjtwqxGtG3xJJ4h5MaOfDiUNPRXTgERHGbODXJiTpAUIhWbA8zIK8UAnImUAQL5UCgXix6CPj5haeTrBEUxnzCoXKzUBaiJKsdFNijo0EftTPUAtlDr5hcuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ort7S4j6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ort7S4j6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4EFF1F000E9;
	Wed, 12 Aug 2026 12:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786538508;
	bh=+TMIo/rv2RDjef2HI2QwAHSarWPkQ+VIatfqm4VfSXs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ort7S4j6MOu3ni/BDqtIe1+k2yqvtxJ/efcSX3GT2X3hb0I1G72HxVybEEb9u2KJh
	 Gv+niSVZ2UBUoRgOtAYu+KfrlrxQ9e71WEw82UUK/nGwNFM6gGtI0H07oxmynbnWZS
	 LIkHmprCwY3MLy0YRRvpdrT25SCC8VuokhEnrTVsaC6utA0iywoeT4CIUFIw02wMuP
	 68YsQKnkOMOURONlWL9bx3WulD94iF0RgyJYBIY+8sh/JZ4DiBoUAnj+1irgWM4RnE
	 iWVCs4KJ48Jr9h1QxDxydq3pVsXAZqPlcjVa02Z1sBZ/0ZgqtggF6S02FunnrulA/q
	 CjfaV87Ypc4Rg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v1.1 1/3] ACPI: bus: Introduce acpi_bus_get_primary_device()
Date: Wed, 12 Aug 2026 14:41:44 +0200
Message-ID: <2843318.mvXUDI8C0e@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
In-Reply-To: <2283799.irdbgypaU6@rafael.j.wysocki>
References:
 <4764923.LvFx2qVVIh@rafael.j.wysocki> <2283799.irdbgypaU6@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

The function used for obtaining the first "physical" device for which
the given ACPI one is the ACPI companion, acpi_get_first_physical_node(),
may return a stale device pointer (mostly in theory) because
acpi_unbind_one() may run as a whole after dropping the ACPI device's
physical_node_lock in acpi_get_first_physical_node() and before it
returns.  The last reference to the "physical" device may be dropped
then before the pointer to it is returned to the caller.

If that happens and the acpi_get_first_physical_node() caller invokes
get_device() on the pointer obtained from it, which is done by the
majority of its callers, a use-after-free will occur.

To prepare for addressing this problem, introduce a new function for
getting the first "physical" device associated with the given ACPI one
(the "primary physical device") that will also reference count the
device in question before returning a pointer to it.

Make that new function and acpi_get_first_physical_node() share the
physical node list lookup code.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

v1 -> v1.1:
   * Use list_first_entry_or_null() instead of open-coding it (Andy)
   * Tentatively add a R-by from Andy

---
 drivers/acpi/bus.c      |   54 +++++++++++++++++++++++++++++++++---------------
 include/acpi/acpi_bus.h |    6 +++++
 2 files changed, 44 insertions(+), 16 deletions(-)

--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -774,30 +774,52 @@ static int __init acpi_setup_sb_notify_h
                              Device Matching
    -------------------------------------------------------------------------- */
 
+
+static struct device *primary_physical_device(struct acpi_device *adev)
+{
+	struct acpi_device_physical_node *pn;
+
+	pn = list_first_entry_or_null(&adev->physical_node_list,
+				      struct acpi_device_physical_node, node);
+	if (pn)
+		return pn->dev;
+
+	return NULL;
+}
+
+/**
+ * acpi_bus_get_primary_device - Get first physical device for a given ACPI one
+ * @adev: ACPI device to get the first physical device for.
+ *
+ * Find the first physical device for which @adev is the ACPI companion and
+ * reference count it if present.
+ *
+ * Return: Pointer to the first physical counterpart of @adev or NULL if there
+ * are none.  Callers are responsible for invoking put_device() on the returned
+ * device.
+ */
+struct device *acpi_bus_get_primary_device(struct acpi_device *adev)
+{
+	if (!adev)
+		return NULL;
+
+	guard(mutex)(&adev->physical_node_lock);
+
+	return get_device(primary_physical_device(adev));
+}
+EXPORT_SYMBOL_GPL(acpi_bus_get_primary_device);
+
 /**
- * acpi_get_first_physical_node - Get first physical node of an ACPI device
+ * acpi_get_first_physical_node - Find first physical node of an ACPI device
  * @adev:	ACPI device in question
  *
  * Return: First physical node of ACPI device @adev
  */
 struct device *acpi_get_first_physical_node(struct acpi_device *adev)
 {
-	struct mutex *physical_node_lock = &adev->physical_node_lock;
-	struct device *phys_dev;
+	guard(mutex)(&adev->physical_node_lock);
 
-	mutex_lock(physical_node_lock);
-	if (list_empty(&adev->physical_node_list)) {
-		phys_dev = NULL;
-	} else {
-		const struct acpi_device_physical_node *node;
-
-		node = list_first_entry(&adev->physical_node_list,
-					struct acpi_device_physical_node, node);
-
-		phys_dev = node->dev;
-	}
-	mutex_unlock(physical_node_lock);
-	return phys_dev;
+	return primary_physical_device(adev);
 }
 EXPORT_SYMBOL_GPL(acpi_get_first_physical_node);
 
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -645,6 +645,7 @@ int acpi_scan_add_handler(struct acpi_sc
 int acpi_bus_scan(acpi_handle handle);
 void acpi_bus_trim(struct acpi_device *start);
 acpi_status acpi_bus_get_ejd(acpi_handle handle, acpi_handle * ejd);
+struct device *acpi_bus_get_primary_device(struct acpi_device *adev);
 int acpi_match_device_ids(struct acpi_device *device,
 			  const struct acpi_device_id *ids);
 void acpi_set_modalias(struct acpi_device *adev, const char *default_id,
@@ -947,6 +948,11 @@ int acpi_scan_add_dep(acpi_handle handle
 u32 arch_acpi_add_auto_dep(acpi_handle handle);
 #else	/* CONFIG_ACPI */
 
+static inline struct device *acpi_bus_get_primary_device(struct acpi_device *adev)
+{
+	return NULL;
+}
+
 static inline bool acpi_of_match_device(const struct acpi_device *adev,
 					const struct of_device_id *of_match_table,
 					const struct of_device_id **of_id)



