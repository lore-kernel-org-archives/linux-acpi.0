From: Mark Salter <msalter@redhat.com>
Subject: [PATCH] acpi: fix generic acpi_register_gsi() handling of shared interrupts
Date: Tue, 28 Apr 2015 12:51:14 -0400
Message-ID: <1430239874-15928-1-git-send-email-msalter@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49166 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030353AbbD1Qv3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 28 Apr 2015 12:51:29 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Salter <msalter@redhat.com>, Hanjun Guo <hanjun.guo@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Will Deacon <will.deacon@arm.com>

If there are devices sharing an interrupt, acpi_register_gsi() could
be called multiple times for the same gsi. Currently, it just maps
the gsi without checking for a previous mapping. This patch adds a
check for an existing mapping and uses that if found.

Cc: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Mark Salter <msalter@redhat.com>
---
 drivers/acpi/gsi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/gsi.c b/drivers/acpi/gsi.c
index 38208f2..5698c4f 100644
--- a/drivers/acpi/gsi.c
+++ b/drivers/acpi/gsi.c
@@ -76,6 +76,13 @@ int acpi_register_gsi(struct device *dev, u32 gsi, int trigger,
 	unsigned int irq_type = acpi_gsi_get_irq_type(trigger, polarity);
 
 	/*
+	 * The gsi may be shared with other devices, so check for a
+	 * previous mapping and use that if found.
+	 */
+	if (acpi_gsi_to_irq(gsi, &irq) > 0)
+		return irq;
+
+	/*
 	 * There is no way at present to look-up the IRQ domain on ACPI,
 	 * hence always create mapping referring to the default domain
 	 * by passing NULL as irq_domain parameter
-- 
1.8.3.1

