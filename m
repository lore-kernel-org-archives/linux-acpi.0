From: Agustin Vega-Frias <agustinv@codeaurora.org>
Subject: [PATCH V12 1/3] ACPI: Generic GSI: Do not attempt to map non-GSI IRQs during bus scan
Date: Thu,  2 Feb 2017 18:23:57 -0500
Message-ID: <1486077839-25547-2-git-send-email-agustinv@codeaurora.org>
References: <1486077839-25547-1-git-send-email-agustinv@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1486077839-25547-1-git-send-email-agustinv@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rjw@rjwysocki.net, lenb@kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com
Cc: andy.shevchenko@gmail.com, lorenzo.pieralisi@arm.com, timur@codeaurora.org, cov@codeaurora.org, agross@codeaurora.org, harba@codeaurora.org, jcm@redhat.com, msalter@redhat.com, mlangsdo@redhat.com, ahs3@redhat.com, astone@redhat.com, graeme.gregory@linaro.org, guohanjun@huawei.com, charles.garcia-tobin@arm.com, Agustin Vega-Frias <agustinv@codeaurora.org>
List-Id: linux-acpi@vger.kernel.org

ACPI extended IRQ resources may contain a Resource Source field to specify
an alternate interrupt controller, attempting to map them as GSIs is
incorrect, so just disable the platform resource.

Since this field is currently ignored, we make this change conditional
on CONFIG_ACPI_GENERIC_GSI to keep the current behavior on x86 platforms,
in case some existing ACPI tables are using this incorrectly.

Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Agustin Vega-Frias <agustinv@codeaurora.org>
---
 drivers/acpi/resource.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index cb57962..8b11d6d 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -43,6 +43,19 @@ static inline bool acpi_iospace_resource_valid(struct resource *res)
 acpi_iospace_resource_valid(struct resource *res) { return true; }
 #endif
 
+#if IS_ENABLED(CONFIG_ACPI_GENERIC_GSI)
+static inline bool is_gsi(struct acpi_resource_extended_irq *ext_irq)
+{
+	return ext_irq->resource_source.string_length == 0 &&
+	       ext_irq->producer_consumer == ACPI_CONSUMER;
+}
+#else
+static inline bool is_gsi(struct acpi_resource_extended_irq *ext_irq)
+{
+	return true;
+}
+#endif
+
 static bool acpi_dev_resource_len_valid(u64 start, u64 end, u64 len, bool io)
 {
 	u64 reslen = end - start + 1;
@@ -470,9 +483,12 @@ bool acpi_dev_resource_interrupt(struct acpi_resource *ares, int index,
 			acpi_dev_irqresource_disabled(res, 0);
 			return false;
 		}
-		acpi_dev_get_irqresource(res, ext_irq->interrupts[index],
+		if (is_gsi(ext_irq))
+			acpi_dev_get_irqresource(res, ext_irq->interrupts[index],
 					 ext_irq->triggering, ext_irq->polarity,
 					 ext_irq->sharable, false);
+		else
+			acpi_dev_irqresource_disabled(res, 0);
 		break;
 	default:
 		res->flags = 0;
-- 
Qualcomm Datacenter Technologies, Inc. on behalf of the Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
