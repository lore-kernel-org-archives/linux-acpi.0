From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH] ACPI/IORT: Fix iort_node_get_id() mapping entries indexing
Date: Thu,  5 Jan 2017 18:29:21 +0000
Message-ID: <20170105182921.8167-1-lorenzo.pieralisi@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, Sinan Kaya <okaya@codeaurora.org>, Tomasz Nowicki <tn@semihalf.com>, Nate Watterson <nwatters@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-acpi@vger.kernel.org

Commit 618f535a6062 ("ACPI/IORT: Add single mapping function")
introduced a function (iort_node_get_id()) to retrieve ids for IORT
named components.

iort_node_get_id() takes an index as input to refer to a specific
mapping entry in the mapping array to retrieve the id at a specific
index provided the index is below the total mapping count; currently the
index is used to retrieve the mapping value from the correct entry but
not to dereference the correct entry while retrieving the mapping
output_reference (ie IORT parent pointer), which consequently always
resolves to the output_reference of the first entry in the mapping
array.

Update the map array entry pointer computation in iort_node_get_id() to
take into account the index value, fixing the issue.

Fixes: 618f535a6062 ("ACPI/IORT: Add single mapping function")
Reported-by: Hanjun Guo <hanjun.guo@linaro.org>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Sinan Kaya <okaya@codeaurora.org>
Cc: Tomasz Nowicki <tn@semihalf.com>
Cc: Nate Watterson <nwatters@codeaurora.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
---
 drivers/acpi/arm64/iort.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index e0d2e6e..ba156c5 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -333,7 +333,7 @@ struct acpi_iort_node *iort_node_get_id(struct acpi_iort_node *node,
 		return NULL;
 
 	map = ACPI_ADD_PTR(struct acpi_iort_id_mapping, node,
-			   node->mapping_offset);
+			   node->mapping_offset + index * sizeof(*map));
 
 	/* Firmware bug! */
 	if (!map->output_reference) {
@@ -348,10 +348,10 @@ struct acpi_iort_node *iort_node_get_id(struct acpi_iort_node *node,
 	if (!(IORT_TYPE_MASK(parent->type) & type_mask))
 		return NULL;
 
-	if (map[index].flags & ACPI_IORT_ID_SINGLE_MAPPING) {
+	if (map->flags & ACPI_IORT_ID_SINGLE_MAPPING) {
 		if (node->type == ACPI_IORT_NODE_NAMED_COMPONENT ||
 		    node->type == ACPI_IORT_NODE_PCI_ROOT_COMPLEX) {
-			*id_out = map[index].output_base;
+			*id_out = map->output_base;
 			return parent;
 		}
 	}
-- 
2.10.0
