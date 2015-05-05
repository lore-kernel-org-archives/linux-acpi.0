From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: [RFC PATCH 1/9] ACPICA: Introduce GIC version for arm based system
Date: Tue,  5 May 2015 21:50:49 +0800
Message-ID: <1430833857-30736-2-git-send-email-hanjun.guo@linaro.org>
References: <1430833857-30736-1-git-send-email-hanjun.guo@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1430833857-30736-1-git-send-email-hanjun.guo@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>, Jason Cooper <jason@lakedaemon.net>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Jiang Liu <jiang.liu@linux.intel.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Grant Likely <grant.likely@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, Hanjun Guo <hanjun.guo@linaro.org>
List-Id: linux-acpi@vger.kernel.org

From: Tomasz Nowicki <tomasz.nowicki@linaro.org>

A new field is added in GIC distributor to indication
the GIC version, support it in ACPICA for later use

Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 include/acpi/actbl1.h | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index b80b0e6..b4f0f74 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -819,7 +819,7 @@ struct acpi_madt_generic_interrupt {
 #define ACPI_MADT_PERFORMANCE_IRQ_MODE  (1<<1)	/* 01: Performance Interrupt Mode */
 #define ACPI_MADT_VGIC_IRQ_MODE         (1<<2)	/* 02: VGIC Maintenance Interrupt mode */
 
-/* 12: Generic Distributor (ACPI 5.0) */
+/* 12: Generic Distributor (ACPI 6.0) */
 
 struct acpi_madt_generic_distributor {
 	struct acpi_subtable_header header;
@@ -827,7 +827,20 @@ struct acpi_madt_generic_distributor {
 	u32 gic_id;
 	u64 base_address;
 	u32 global_irq_base;
-	u32 reserved2;		/* reserved - must be zero */
+	u8  gic_version;
+	u8  reserved2[3];	/* reserved - must be zero */
+};
+
+/* Values for gic_version in Generic Distributor  (ACPI 6.0) */
+
+enum acpi_madt_gic_ver_type
+{
+	ACPI_MADT_GIC_VER_UNKNOWN	= 0,
+	ACPI_MADT_GIC_VER_V1		= 1,
+	ACPI_MADT_GIC_VER_V2		= 2,
+	ACPI_MADT_GIC_VER_V3		= 3,
+	ACPI_MADT_GIC_VER_V4		= 4,
+	ACPI_MADT_GIC_VER_RESERVED	= 5	/* 5 and greater are reserved */
 };
 
 /* 13: Generic MSI Frame (ACPI 5.1) */
-- 
1.9.1
