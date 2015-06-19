From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH v2 2/9] ACPICA: ACPI 6.0: Add values for MADT GIC version field.
Date: Fri, 19 Jun 2015 16:46:05 +0800
Message-ID: <1434703572-26221-3-git-send-email-hanjun.guo@linaro.org>
References: <1434703572-26221-1-git-send-email-hanjun.guo@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1434703572-26221-1-git-send-email-hanjun.guo@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>, Jason Cooper <jason@lakedaemon.net>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jiang Liu <jiang.liu@linux.intel.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Grant Likely <grant.likely@linaro.org>, Olof Johansson <olof@lixom.net>, Wei Huang <wei@redhat.com>, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, Hanjun Guo <hanjun.guo@linaro.org>, Bob Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>
List-Id: linux-acpi@vger.kernel.org

ACPICA commit 4b100dc43e8baee8c8b4891b23bc7ad03eba6a28

Support for the new version field in the generic distributor
subtable. Hanjun Guo <hanjun.guo@linaro.org>

Link: https://github.com/acpica/acpica/commit/4b100dc4
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---

This patch is also for review purpose only, already merged into
ACPICA core and sent out for review for linux ACPICA by Lv Zheng.
(Thank you, Bob and Lv :) )

 include/acpi/actbl1.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index cadf21c..a21bc50 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -834,6 +834,17 @@ struct acpi_madt_generic_distributor {
 	u8 reserved2[3];	/* reserved - must be zero */
 };
 
+/* Values for Version field above */
+
+enum acpi_madt_gic_version {
+	ACPI_MADT_GIC_VERSION_NONE = 0,
+	ACPI_MADT_GIC_VERSION_V1 = 1,
+	ACPI_MADT_GIC_VERSION_V2 = 2,
+	ACPI_MADT_GIC_VERSION_V3 = 3,
+	ACPI_MADT_GIC_VERSION_V4 = 4,
+	ACPI_MADT_GIC_VERSION_RESERVED = 5	/* 5 and greater are reserved */
+};
+
 /* 13: Generic MSI Frame (ACPI 5.1) */
 
 struct acpi_madt_generic_msi_frame {
-- 
1.9.1
