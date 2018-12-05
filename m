From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 112/123] ACPI/IORT: Fix iort_get_platform_device_domain() uninitialized pointer value
Date: Wed,  5 Dec 2018 04:35:44 -0500
Message-ID: <20181205093555.5386-112-sashal@kernel.org>
References: <20181205093555.5386-1-sashal@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181205093555.5386-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Catalin Marinas <catalin.marinas@arm.com>, Sasha Levin <sashal@kernel.org>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

[ Upstream commit ea2412dc21cc790335d319181dddc43682aef164 ]

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
Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>
Acked-by: Will Deacon <will.deacon@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/arm64/iort.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 08f26db2da7e..e938576e58cb 100644
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
2.17.1
