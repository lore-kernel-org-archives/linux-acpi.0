From: Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH 1/2] ACPI: IORT: minor cleanup for iort_match_node_callback()
Date: Wed, 14 Sep 2016 21:49:53 +0800
Message-ID: <1473860994-3996-2-git-send-email-guohanjun@huawei.com>
References: <1473860994-3996-1-git-send-email-guohanjun@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1473860994-3996-1-git-send-email-guohanjun@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Marc Zyngier <marc.zyngier@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Tomasz Nowicki <tn@semihalf.com>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Hanjun Guo <hanjun.guo@linaro.org>
List-Id: linux-acpi@vger.kernel.org

From: Hanjun Guo <hanjun.guo@linaro.org>

Cleanup iort_match_node_callback() a little bit to reduce
some lines of code, aslo fix the indentation in iort_scan_node().

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/acpi/arm64/iort.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 6b81746..2032005 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -132,7 +132,7 @@ static struct acpi_iort_node *iort_scan_node(enum acpi_iort_node_type type,
 
 		if (iort_node->type == type &&
 		    ACPI_SUCCESS(callback(iort_node, context)))
-				return iort_node;
+			return iort_node;
 
 		iort_node = ACPI_ADD_PTR(struct acpi_iort_node, iort_node,
 					 iort_node->length);
@@ -145,17 +145,15 @@ static acpi_status iort_match_node_callback(struct acpi_iort_node *node,
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
@@ -181,8 +179,6 @@ static acpi_status iort_match_node_callback(struct acpi_iort_node *node,
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
