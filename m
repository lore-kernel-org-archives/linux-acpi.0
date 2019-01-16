From: Keith Busch <keith.busch@intel.com>
Subject: [PATCHv4 12/13] acpi/hmat: Register memory side cache attributes
Date: Wed, 16 Jan 2019 10:58:03 -0700
Message-ID: <20190116175804.30196-13-keith.busch@intel.com>
References: <20190116175804.30196-1-keith.busch@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190116175804.30196-1-keith.busch@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-mm@kvack.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael Wysocki <rafael@kernel.org>, Dave Hansen <dave.hansen@intel.com>, Dan Williams <dan.j.williams@intel.com>, Keith Busch <keith.busch@intel.com>
List-Id: linux-acpi@vger.kernel.org

Register memory side cache attributes with the memory's node if HMAT
provides the side cache iniformation table.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/acpi/hmat/hmat.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/acpi/hmat/hmat.c b/drivers/acpi/hmat/hmat.c
index 45e20dc677f9..9efdd0a63a79 100644
--- a/drivers/acpi/hmat/hmat.c
+++ b/drivers/acpi/hmat/hmat.c
@@ -206,6 +206,7 @@ static __init int hmat_parse_cache(union acpi_subtable_headers *header,
 				   const unsigned long end)
 {
 	struct acpi_hmat_cache *cache = (void *)header;
+	struct node_cache_attrs cache_attrs;
 	u32 attrs;
 
 	if (cache->header.length < sizeof(*cache)) {
@@ -219,6 +220,37 @@ static __init int hmat_parse_cache(union acpi_subtable_headers *header,
 		cache->memory_PD, cache->cache_size, attrs,
 		cache->number_of_SMBIOShandles);
 
+	cache_attrs.size = cache->cache_size;
+	cache_attrs.level = (attrs & ACPI_HMAT_CACHE_LEVEL) >> 4;
+	cache_attrs.line_size = (attrs & ACPI_HMAT_CACHE_LINE_SIZE) >> 16;
+
+	switch ((attrs & ACPI_HMAT_CACHE_ASSOCIATIVITY) >> 8) {
+	case ACPI_HMAT_CA_DIRECT_MAPPED:
+		cache_attrs.associativity = NODE_CACHE_DIRECT_MAP;
+		break;
+	case ACPI_HMAT_CA_COMPLEX_CACHE_INDEXING:
+		cache_attrs.associativity = NODE_CACHE_INDEXED;
+		break;
+	case ACPI_HMAT_CA_NONE:
+	default:
+		cache_attrs.associativity = NODE_CACHE_OTHER;
+		break;
+	}
+
+	switch ((attrs & ACPI_HMAT_WRITE_POLICY) >> 12) {
+	case ACPI_HMAT_CP_WB:
+		cache_attrs.write_policy = NODE_CACHE_WRITE_BACK;
+		break;
+	case ACPI_HMAT_CP_WT:
+		cache_attrs.write_policy = NODE_CACHE_WRITE_THROUGH;
+		break;
+	case ACPI_HMAT_CP_NONE:
+	default:
+		cache_attrs.write_policy = NODE_CACHE_WRITE_OTHER;
+		break;
+	}
+
+	node_add_cache(pxm_to_node(cache->memory_PD), &cache_attrs);
 	return 0;
 }
 
-- 
2.14.4
