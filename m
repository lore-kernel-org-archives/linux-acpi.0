From: Christophe Ricard <christophe.ricard@gmail.com>
Subject: [RFC v2 1/2] acpi: Rename acpi_gsi_get_irq_type to acpi_get_irq_type and export symbol
Date: Mon, 16 Nov 2015 08:36:02 +0100
Message-ID: <1447659363-19847-2-git-send-email-christophe-h.ricard@st.com>
References: <1447659363-19847-1-git-send-email-christophe-h.ricard@st.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:36172 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751102AbbKPHgO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Nov 2015 02:36:14 -0500
Received: by wmww144 with SMTP id w144so97770370wmw.1
        for <linux-acpi@vger.kernel.org>; Sun, 15 Nov 2015 23:36:13 -0800 (PST)
In-Reply-To: <1447659363-19847-1-git-send-email-christophe-h.ricard@st.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Christophe Ricard <christophe-h.ricard@st.com>

acpi_gsi_get_irq_type could be use out of gsi purpose.

Rename and make it available as a utility function.

Signed-off-by: Christophe Ricard <christophe-h.ricard@st.com>
---
 drivers/acpi/gsi.c   | 21 +--------------------
 drivers/acpi/utils.c | 22 ++++++++++++++++++++++
 include/linux/acpi.h |  2 ++
 3 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/drivers/acpi/gsi.c b/drivers/acpi/gsi.c
index fa4585a..2828351 100644
--- a/drivers/acpi/gsi.c
+++ b/drivers/acpi/gsi.c
@@ -17,25 +17,6 @@ enum acpi_irq_model_id acpi_irq_model;
 
 static struct fwnode_handle *acpi_gsi_domain_id;
 
-static unsigned int acpi_gsi_get_irq_type(int trigger, int polarity)
-{
-	switch (polarity) {
-	case ACPI_ACTIVE_LOW:
-		return trigger == ACPI_EDGE_SENSITIVE ?
-		       IRQ_TYPE_EDGE_FALLING :
-		       IRQ_TYPE_LEVEL_LOW;
-	case ACPI_ACTIVE_HIGH:
-		return trigger == ACPI_EDGE_SENSITIVE ?
-		       IRQ_TYPE_EDGE_RISING :
-		       IRQ_TYPE_LEVEL_HIGH;
-	case ACPI_ACTIVE_BOTH:
-		if (trigger == ACPI_EDGE_SENSITIVE)
-			return IRQ_TYPE_EDGE_BOTH;
-	default:
-		return IRQ_TYPE_NONE;
-	}
-}
-
 /**
  * acpi_gsi_to_irq() - Retrieve the linux irq number for a given GSI
  * @gsi: GSI IRQ number to map
@@ -82,7 +63,7 @@ int acpi_register_gsi(struct device *dev, u32 gsi, int trigger,
 
 	fwspec.fwnode = acpi_gsi_domain_id;
 	fwspec.param[0] = gsi;
-	fwspec.param[1] = acpi_gsi_get_irq_type(trigger, polarity);
+	fwspec.param[1] = acpi_get_irq_type(trigger, polarity);
 	fwspec.param_count = 2;
 
 	return irq_create_fwspec_mapping(&fwspec);
diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index 475c907..92840f1 100644
--- a/drivers/acpi/utils.c
+++ b/drivers/acpi/utils.c
@@ -27,12 +27,34 @@
 #include <linux/hardirq.h>
 #include <linux/acpi.h>
 #include <linux/dynamic_debug.h>
+#include <linux/irq.h>
 
 #include "internal.h"
 
 #define _COMPONENT		ACPI_BUS_COMPONENT
 ACPI_MODULE_NAME("utils");
 
+unsigned int acpi_get_irq_type(int trigger, int polarity)
+{
+	switch (polarity) {
+	case ACPI_ACTIVE_LOW:
+		return trigger == ACPI_EDGE_SENSITIVE ?
+		       IRQ_TYPE_EDGE_FALLING :
+		       IRQ_TYPE_LEVEL_LOW;
+	case ACPI_ACTIVE_HIGH:
+		return trigger == ACPI_EDGE_SENSITIVE ?
+		       IRQ_TYPE_EDGE_RISING :
+		       IRQ_TYPE_LEVEL_HIGH;
+	case ACPI_ACTIVE_BOTH:
+		if (trigger == ACPI_EDGE_SENSITIVE)
+			return IRQ_TYPE_EDGE_BOTH;
+	default:
+		return IRQ_TYPE_NONE;
+	}
+}
+EXPORT_SYMBOL_GPL(acpi_get_irq_type);
+
+
 /* --------------------------------------------------------------------------
                             Object Evaluation Helpers
    -------------------------------------------------------------------------- */
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 0548339..9500ce0 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -223,6 +223,8 @@ int acpi_isa_irq_to_gsi (unsigned isa_irq, u32 *gsi);
 void acpi_set_irq_model(enum acpi_irq_model_id model,
 			struct fwnode_handle *fwnode);
 
+unsigned int acpi_get_irq_type(int trigger, int polarity);
+
 #ifdef CONFIG_X86_IO_APIC
 extern int acpi_get_override_irq(u32 gsi, int *trigger, int *polarity);
 #else
-- 
2.5.0

