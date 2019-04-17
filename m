From: Alison Schofield <alison.schofield@intel.com>
Subject: [PATCH] acpi/hmat: Update acpi_hmat_type enum with ACPI_HMAT_TYPE_PROXIMITY
Date: Wed, 17 Apr 2019 11:13:10 -0700
Message-ID: <20190417181310.27613-1-alison.schofield@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net
Cc: Alison Schofield <alison.schofield@intel.com>, robert.moore@intel.com, erik.schmauss@intel.com, keith.busch@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

ACPI 6.3 changed the subtable "Memory Subsystem Address Range Structure"
to "Memory Proximity Domain Attributes Structure".

Updating and renaming of the structure was included in commit:
ACPICA: ACPI 6.3: HMAT updates (9a8d961f1ef835b0d338fbe13da03cb424e87ae5)

Rename the enum type to match the subtable and structure naming.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/acpi/hmat/hmat.c | 4 ++--
 include/acpi/actbl1.h    | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/hmat/hmat.c b/drivers/acpi/hmat/hmat.c
index b7824a0309f7..3e32120e2dab 100644
--- a/drivers/acpi/hmat/hmat.c
+++ b/drivers/acpi/hmat/hmat.c
@@ -411,7 +411,7 @@ static int __init hmat_parse_subtable(union acpi_subtable_headers *header,
 		return -EINVAL;
 
 	switch (hdr->type) {
-	case ACPI_HMAT_TYPE_ADDRESS_RANGE:
+	case ACPI_HMAT_TYPE_PROXIMITY:
 		return hmat_parse_proximity_domain(header, end);
 	case ACPI_HMAT_TYPE_LOCALITY:
 		return hmat_parse_locality(header, end);
@@ -649,7 +649,7 @@ static __init int hmat_init(void)
 		goto out_put;
 	}
 
-	for (i = ACPI_HMAT_TYPE_ADDRESS_RANGE; i < ACPI_HMAT_TYPE_RESERVED; i++) {
+	for (i = ACPI_HMAT_TYPE_PROXIMITY; i < ACPI_HMAT_TYPE_RESERVED; i++) {
 		if (acpi_table_parse_entries(ACPI_SIG_HMAT,
 					     sizeof(struct acpi_table_hmat), i,
 					     hmat_parse_subtable, 0) < 0) {
diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index d14037ddf108..22c039ebc6c5 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -1395,7 +1395,7 @@ struct acpi_table_hmat {
 /* Values for HMAT structure types */
 
 enum acpi_hmat_type {
-	ACPI_HMAT_TYPE_ADDRESS_RANGE = 0,	/* Memory subsystem address range */
+	ACPI_HMAT_TYPE_PROXIMITY = 0,	/* Memory proximity domain attributes */
 	ACPI_HMAT_TYPE_LOCALITY = 1,	/* System locality latency and bandwidth information */
 	ACPI_HMAT_TYPE_CACHE = 2,	/* Memory side cache information */
 	ACPI_HMAT_TYPE_RESERVED = 3	/* 3 and greater are reserved */
-- 
2.14.1
