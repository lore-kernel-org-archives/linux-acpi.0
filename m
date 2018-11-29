From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH] ACPI/IORT: Fix iort_get_platform_device_domain()
 uninitialized pointer value
Date: Thu, 29 Nov 2018 09:55:59 +0000
Message-ID: <20181129095559.26007-1-lorenzo.pieralisi@arm.com>
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
To: linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>
List-Id: linux-acpi@vger.kernel.org

Running the Clang static analyzer on IORT code detected the following
error:

Logic error: Branch condition evaluates to a garbage value

in

iort_get_platform_device_domain()

If the named component associated with a given device has no IORT
mappings, iort_get_platform_device_domain() exits its MSI mapping loop
with msi_parent pointer containing garbage, which can lead to erroneous
code path execution.

Initialize the msi_parent pointer, fixing the bug.

Fixes: d4f54a186667 ("ACPI: platform: setup MSI domain for ACPI based
platform device")
Reported-by: Patrick Bellasi <patrick.bellasi@arm.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
---
 drivers/acpi/arm64/iort.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 2a361e22d38d..70f4e80b9246 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -700,7 +700,7 @@ static void iort_set_device_domain(struct device *dev,
  */
 static struct irq_domain *iort_get_platform_device_domain(struct device *dev)
 {
-	struct acpi_iort_node *node, *msi_parent;
+	struct acpi_iort_node *node, *msi_parent = NULL;
 	struct fwnode_handle *iort_fwnode;
 	struct acpi_iort_its_group *its;
 	int i;
-- 
2.19.2
