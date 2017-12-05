From: Sinan Kaya <okaya@codeaurora.org>
Subject: [PATCH V6 2/7] ACPI / bus: Introduce acpi_get_match_data() function
Date: Tue,  5 Dec 2017 12:04:47 -0500
Message-ID: <1512493493-6464-3-git-send-email-okaya@codeaurora.org>
References: <1512493493-6464-1-git-send-email-okaya@codeaurora.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:55950 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752430AbdLERFU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Dec 2017 12:05:20 -0500
In-Reply-To: <1512493493-6464-1-git-send-email-okaya@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: dmaengine@vger.kernel.org, timur@codeaurora.org, devicetree@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sinan Kaya <okaya@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, open list <linux-kernel@vger.kernel.org>

OF has of_device_get_match_data() function to extract driver specific data
structure. Add a similar function for ACPI.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/bus.c   | 12 ++++++++++++
 include/linux/acpi.h |  6 ++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 4d0979e..b271eb1 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -785,6 +785,18 @@ const struct acpi_device_id *acpi_match_device(const struct acpi_device_id *ids,
 }
 EXPORT_SYMBOL_GPL(acpi_match_device);
 
+void *acpi_get_match_data(const struct device *dev)
+{
+	const struct acpi_device_id *match;
+
+	match = acpi_match_device(dev->driver->acpi_match_table, dev);
+	if (!match)
+		return NULL;
+
+	return (void *)match->driver_data;
+}
+EXPORT_SYMBOL_GPL(acpi_get_match_data);
+
 int acpi_match_device_ids(struct acpi_device *device,
 			  const struct acpi_device_id *ids)
 {
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 502af53..a927260 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -584,6 +584,7 @@ extern int acpi_nvs_for_each_region(int (*func)(__u64, __u64, void *),
 const struct acpi_device_id *acpi_match_device(const struct acpi_device_id *ids,
 					       const struct device *dev);
 
+void *acpi_get_match_data(const struct device *dev);
 extern bool acpi_driver_match_device(struct device *dev,
 				     const struct device_driver *drv);
 int acpi_device_uevent_modalias(struct device *, struct kobj_uevent_env *);
@@ -755,6 +756,11 @@ static inline const struct acpi_device_id *acpi_match_device(
 	return NULL;
 }
 
+static inline void *acpi_get_match_data(const struct device *dev)
+{
+	return NULL;
+}
+
 static inline bool acpi_driver_match_device(struct device *dev,
 					    const struct device_driver *drv)
 {
-- 
1.9.1

