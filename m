From: Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH v8 03/15] ACPI: IORT: minor cleanup for iort_match_node_callback()
Date: Wed, 18 Jan 2017 20:54:53 +0800
Message-ID: <1484744105-53140-4-git-send-email-guohanjun@huawei.com>
References: <1484744105-53140-1-git-send-email-guohanjun@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1484744105-53140-1-git-send-email-guohanjun@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Greg KH <gregkh@linuxfoundation.org>, Tomasz Nowicki <tn@semihalf.com>, Ma Jun <majun258@huawei.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Agustin Vega-Frias <agustinv@codeaurora.org>, Sinan Kaya <okaya@codeaurora.org>, huxinwei@huawei.com, yimin@huawei.com, linuxarm@huawei.com, Matthias Brugger <mbrugger@suse.com>, Wei Xu <xuwei5@hisilicon.com>, Ming Lei <tom.leiming@gmail.com>, Hanjun Guo <hanjun.guo@linaro.org>
List-Id: linux-acpi@vger.kernel.org

From: Hanjun Guo <hanjun.guo@linaro.org>

Cleanup iort_match_node_callback() a little bit to reduce
some lines of code.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
Tested-by: Ming Lei <ming.lei@canonical.com>
Tested-by: Wei Xu <xuwei5@hisilicon.com>
Tested-by: Sinan Kaya <okaya@codeaurora.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Tomasz Nowicki <tn@semihalf.com>
---
 drivers/acpi/arm64/iort.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 15f32bf..208eac9 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -253,17 +253,15 @@ static acpi_status iort_match_node_callback(struct acpi_iort_node *node,
 					    void *context)
 {
 	struct device *dev = context;
-	acpi_status status;
+	acpi_status status = AE_NOT_FOUND;
 
 	if (node->type == ACPI_IORT_NODE_NAMED_COMPONENT) {
 		struct acpi_buffer buf = { ACPI_ALLOCATE_BUFFER, NULL };
 		struct acpi_device *adev = to_acpi_device_node(dev->fwnode);
 		struct acpi_iort_named_component *ncomp;
 
-		if (!adev) {
-			status = AE_NOT_FOUND;
+		if (!adev)
 			goto out;
-		}
 
 		status = acpi_get_name(adev->handle, ACPI_FULL_PATHNAME, &buf);
 		if (ACPI_FAILURE(status)) {
@@ -289,8 +287,6 @@ static acpi_status iort_match_node_callback(struct acpi_iort_node *node,
 		 */
 		status = pci_rc->pci_segment_number == pci_domain_nr(bus) ?
 							AE_OK : AE_NOT_FOUND;
-	} else {
-		status = AE_NOT_FOUND;
 	}
 out:
 	return status;
-- 
1.7.12.4
