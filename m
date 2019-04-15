From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4/4 V3] ACPI: Let ACPI know we support Generic Initiator Affinity Structures
Date: Tue, 16 Apr 2019 01:49:07 +0800
Message-ID: <20190415174907.102307-5-Jonathan.Cameron@huawei.com>
References: <20190415174907.102307-1-Jonathan.Cameron@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190415174907.102307-1-Jonathan.Cameron@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mm@kvack.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>, Keith Busch <keith.busch@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linuxarm@huawei.com, Andrew Morton <akpm@linux-foundation.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
List-Id: linux-acpi@vger.kernel.org

Until we tell ACPI that we support generic initiators, it will have
to operate in fall back domain mode and all _PXM entries should
be on existing non GI domains.

This patch sets the relevant OSC bit to make that happen.

Note that this currently doesn't take into account whether we have the relevant
setup code for a given architecture.  Do we want to make this optional, or
should the initial patch set just enable it for all ACPI supporting architectures?

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/acpi/bus.c   | 1 +
 include/linux/acpi.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index eec263c9019e..ef251f454a5b 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -315,6 +315,7 @@ static void acpi_bus_osc_support(void)
 
 	capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_HOTPLUG_OST_SUPPORT;
 	capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_PCLPI_SUPPORT;
+	capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_GENERIC_INITIATOR_SUPPORT;
 
 #ifdef CONFIG_X86
 	if (boot_cpu_has(X86_FEATURE_HWP)) {
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index d5dcebd7aad3..cc68b2ad0630 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -503,6 +503,7 @@ acpi_status acpi_run_osc(acpi_handle handle, struct acpi_osc_context *context);
 #define OSC_SB_PCLPI_SUPPORT			0x00000080
 #define OSC_SB_OSLPI_SUPPORT			0x00000100
 #define OSC_SB_CPC_DIVERSE_HIGH_SUPPORT		0x00001000
+#define OSC_SB_GENERIC_INITIATOR_SUPPORT	0x00002000
 
 extern bool osc_sb_apei_support_acked;
 extern bool osc_pc_lpi_support_confirmed;
-- 
2.19.1
