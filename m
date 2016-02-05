From: Christopher Covington <cov@codeaurora.org>
Subject: [PATCH v2] acpi: pci: QDF2432 32 bit config space accessors
Date: Fri,  5 Feb 2016 11:00:53 -0500
Message-ID: <1454688053-2280-1-git-send-email-cov@codeaurora.org>
References: <1453233259-29562-1-git-send-email-cov@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1453233259-29562-1-git-send-email-cov@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Tomasz Nowicki <tn@semihalf.com>, linux-arm-msm@vger.kernel.org, Timur Tabi <timur@codeaurora.org>, Jon Masters <jcm@redhat.com>, Mark Langsdorf <mlangsdo@redhat.com>, Christopher Covington <cov@codeaurora.org>
List-Id: linux-acpi@vger.kernel.org

Qualcomm Technologies QDF2432 SoCs require 32 bit accessors to be used
for the PCI configuration space. Register the appropriate quirk.

Signed-off-by: Christopher Covington <cov@codeaurora.org>
---
Dependent on Tomasz Nowicki's ACPI support for PCI:
http://lists.infradead.org/pipermail/linux-arm-kernel/2016-February/thread.html#405148

v1 -> v2: Rebase and use full product name

 drivers/acpi/mcfg.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/acpi/mcfg.c b/drivers/acpi/mcfg.c
index 4663f70..18e792b 100644
--- a/drivers/acpi/mcfg.c
+++ b/drivers/acpi/mcfg.c
@@ -78,6 +78,29 @@ static struct pci_ops default_pci_mcfg_ops = {
 	.write = pci_generic_config_write,
 };
 
+static const struct dmi_system_id qcom_qdf2432[] = {
+	{
+		.ident = "Qualcomm Technologies QDF2432",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Qualcomm"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "QDF2432"),
+		},
+	},
+	{ }
+};
+
+static struct pci_ops qcom_qdf2432_pci_mcfg_ops = {
+	.map_bus = pci_mcfg_dev_base,
+	.read = pci_generic_config_read32,
+	.write = pci_generic_config_write32,
+};
+
+DECLARE_ACPI_MCFG_FIXUP(qcom_qdf2432,
+			NULL,
+			&qcom_qdf2432_pci_mcfg_ops,
+			PCI_MCFG_DOMAIN_ANY,
+			PCI_MCFG_BUS_ANY);
+
 struct pci_ops *pci_mcfg_get_ops(struct acpi_pci_root *root)
 {
 	struct pci_ops *pci_mcfg_ops_quirk;
-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
