From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH v2 07/18] ACPI / table: Print GIC information when MADT is parsed
Date: Mon,  4 Aug 2014 23:28:14 +0800
Message-ID: <1407166105-17675-8-git-send-email-hanjun.guo@linaro.org>
References: <1407166105-17675-1-git-send-email-hanjun.guo@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1407166105-17675-1-git-send-email-hanjun.guo@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mark Rutland <mark.rutland@arm.com>
Cc: Graeme Gregory <graeme.gregory@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Grant Likely <grant.likely@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Will Deacon <will.deacon@arm.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Robert Richter <rric@kernel.org>, Lv Zheng <lv.zheng@intel.com>, Robert Moore <robert.moore@intel.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Randy Dunlap <rdunlap@infradead.org>, Charles.Garcia-Tobin@arm.com, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, Hanjun Guo <hanjun.guo@linaro.org>, Tomasz Nowicki <tomasz>
List-Id: linux-acpi@vger.kernel.org

When MADT is parsed, print GIC information to make the boot
log look pretty.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
---
 drivers/acpi/tables.c |   39 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 6d5a6cd..77f8bb1 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -183,6 +183,44 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
 		}
 		break;
 
+	case ACPI_MADT_TYPE_GENERIC_INTERRUPT:
+		{
+			struct acpi_madt_generic_interrupt *p =
+				(struct acpi_madt_generic_interrupt *)header;
+			pr_info("GICC (acpi_id[0x%04x] address[0x%08llx] MPDIR[0x%llx] %s)\n",
+				p->uid, p->base_address, p->arm_mpidr,
+				(p->flags & ACPI_MADT_ENABLED) ? "enabled" : "disabled");
+
+		}
+		break;
+
+	case ACPI_MADT_TYPE_GENERIC_DISTRIBUTOR:
+		{
+			struct acpi_madt_generic_distributor *p =
+				(struct acpi_madt_generic_distributor *)header;
+			pr_info("GIC Distributor (gic_id[0x%04x] address[0x%08llx] gsi_base[%d])\n",
+				p->gic_id, p->base_address, p->global_irq_base);
+		}
+		break;
+
+	case ACPI_MADT_TYPE_GENERIC_MSI_FRAME:
+		{
+			struct acpi_madt_generic_msi_frame *p =
+				(struct acpi_madt_generic_msi_frame *)header;
+			pr_info("GIC MSI Frame (msi_fame_id[%d] address[0x%08llx])\n",
+				p->msi_frame_id, p->base_address);
+		}
+		break;
+
+	case ACPI_MADT_TYPE_GENERIC_REDISTRIBUTOR:
+		{
+			struct acpi_madt_generic_redistributor *p =
+				(struct acpi_madt_generic_redistributor *)header;
+			pr_info("GIC Redistributor (address[0x%08llx] region_size[0x%x])\n",
+				p->base_address, p->length);
+		}
+		break;
+
 	default:
 		pr_warn("Found unsupported MADT entry (type = 0x%x)\n",
 			header->type);
@@ -190,7 +228,6 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
 	}
 }
 
-
 int __init
 acpi_table_parse_entries(char *id,
 			     unsigned long table_size,
-- 
1.7.9.5
