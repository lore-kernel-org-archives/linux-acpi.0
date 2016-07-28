From: Lukas Wunner <lukas@wunner.de>
Subject: [PATCH 2/6] ACPI / bus: Make acpi_get_first_physical_node() public
Date: Thu, 28 Jul 2016 02:25:41 +0200
Message-ID: <a0bb3346635e3bd8caf6cf735ceba684e3fde2fa.1469616641.git.lukas__19309.3228307136$1469665591$gmane$org@wunner.de>
References: <cover.1469616641.git.lukas@wunner.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailout1.hostsharing.net ([83.223.95.204]:41989 "EHLO
	mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1162468AbcG1A0S (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Jul 2016 20:26:18 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mailout1.hostsharing.net (Postfix) with ESMTPS id 749CB10154ACA
	for <linux-acpi@vger.kernel.org>; Thu, 28 Jul 2016 02:26:16 +0200 (CEST)
Received: from localhost (4-38-90-81.adsl.cmo.de [81.90.38.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by h08.hostsharing.net (Postfix) with ESMTPSA id 306CA6097A6C
	for <linux-acpi@vger.kernel.org>; Thu, 28 Jul 2016 02:26:15 +0200 (CEST)
In-Reply-To: <cover.1469616641.git.lukas@wunner.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-efi@vger.kernel.org, Matt Fleming <matt@codeblueprint.co.uk>, linux-kernel@vger.kernel.org
Cc: Andreas Noever <andreas.noever@gmail.com>, Pierre Moreau <pierre.morrow@free.fr>, Aleksey Makarov <aleksey.makarov@linaro.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org

Following the fwnode of a device is currently a one-way road: We provide
ACPI_COMPANION() to obtain the fwnode but there's no (public) method to
do the reverse. Granted, there may be multiple physical_nodes, but often
the first one in the list is sufficient.

A handy function to obtain it was introduced with commit 3b95bd160547
("ACPI: introduce a function to find the first physical device"), but
currently it's only available internally.

We're about to add an EFI Device Path parser which needs this function.
Consider the following device path: ACPI(PNP0A03,0)/PCI(28,2)/PCI(0,0)
The PCI root is encoded as an ACPI device in the path, so the parser
has to find the corresponding ACPI device, then find its physical node,
find the PCI bridge in slot 1c (decimal 28), function 2 below it and
finally find the PCI device in slot 0, function 0.

To this end, make acpi_get_first_physical_node() public.

Cc: Aleksey Makarov <aleksey.makarov@linaro.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/acpi/internal.h | 1 -
 include/linux/acpi.h    | 7 +++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 27cc7fe..48e718e 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -113,7 +113,6 @@ bool acpi_device_is_present(struct acpi_device *adev);
 bool acpi_device_is_battery(struct acpi_device *adev);
 bool acpi_device_is_first_physical_node(struct acpi_device *adev,
 					const struct device *dev);
-struct device *acpi_get_first_physical_node(struct acpi_device *adev);
 
 /* --------------------------------------------------------------------------
                      Device Matching and Notification
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 288fac5..8ab6a95 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -85,6 +85,8 @@ static inline const char *acpi_dev_name(struct acpi_device *adev)
 	return dev_name(&adev->dev);
 }
 
+struct device *acpi_get_first_physical_node(struct acpi_device *adev);
+
 enum acpi_irq_model_id {
 	ACPI_IRQ_MODEL_PIC = 0,
 	ACPI_IRQ_MODEL_IOAPIC,
@@ -588,6 +590,11 @@ static inline const char *acpi_dev_name(struct acpi_device *adev)
 	return NULL;
 }
 
+static inline struct device *acpi_get_first_physical_node(struct acpi_device *adev)
+{
+	return NULL;
+}
+
 static inline void early_acpi_table_init(void *data, size_t size) { }
 static inline void acpi_early_init(void) { }
 static inline void acpi_subsystem_init(void) { }
-- 
2.8.1

