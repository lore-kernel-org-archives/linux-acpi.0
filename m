From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH] ACPI/IORT: Remove temporary iort_get_id_mapping_index()
 ACPICA guard
Date: Fri,  9 Feb 2018 12:15:10 +0000
Message-ID: <20180209121510.9015-1-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-acpi@vger.kernel.org

In IORT issue C SMMUv3 IORT nodes gained an additional field (DeviceID
mapping index) so that the SMMUv3 can describe its MSI interrupts.

Referring to it in the kernel requires ACPICA changes and in order
to prevent kernel<->ACPICA dependencies kernel code depending on the
SMMUv3 DeviceID mapping index field was guarded with an ACPICA version
conditional.

ACPICA changes introducing DeviceID mapping index in the IORT structs
were integrated in the kernel with:

commit 4c106aa411ee ("ACPICA: iasl: Add SMMUv3 device ID mapping index
support")

so the temporary ACPICA guard has become stale and can be removed.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
---
 drivers/acpi/arm64/iort.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 95255ecfae7c..a84a5787bbd2 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -366,7 +366,6 @@ static struct acpi_iort_node *iort_node_get_id(struct acpi_iort_node *node,
 	return NULL;
 }
 
-#if (ACPI_CA_VERSION > 0x20170929)
 static int iort_get_id_mapping_index(struct acpi_iort_node *node)
 {
 	struct acpi_iort_smmu_v3 *smmu;
@@ -400,12 +399,6 @@ static int iort_get_id_mapping_index(struct acpi_iort_node *node)
 		return -EINVAL;
 	}
 }
-#else
-static inline int iort_get_id_mapping_index(struct acpi_iort_node *node)
-{
-	return -EINVAL;
-}
-#endif
 
 static struct acpi_iort_node *iort_node_map_id(struct acpi_iort_node *node,
 					       u32 id_in, u32 *id_out,
-- 
2.15.0
