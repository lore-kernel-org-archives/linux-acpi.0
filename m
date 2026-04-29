Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643B93FF889;
	Wed, 29 Apr 2026 14:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777472083; cv=none; b=p8gBN7Yy/VFl8sMMIyR2gHAjAd52BjfSZMvzJNe3XKHuP17r2Gh3N5OJkxxeWdxY5DxgD4Zxm+EJ7FoYZx1bcAG8LdJjZAY3mg+mpA3EklReqOBy5spI6Awu9GRWA72oWh2x5R+13G+RUjlLbU4Ylnxv+Jd6xoDPoxwhqEbjOcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777472083; c=relaxed/simple;
	bh=yvBaaJHq522R7D0U8dJahKsXz9SdJpbI8YiKIMevLTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NnyEa8IQncg4GqfwMrXtNlBu+SHqcN/cL5CajLkltJg09+IoQntaG2GqJe93VyAYCP/Aqypyi+eWfRkQgXC4vflN6egJE3P9cBnM1/ulZslzfU1rxJMWKH9bQnTCq4+hIxtt0CIuUc6MfN6AYGvIFvN3/C9nMndJsvpwSkagEvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=bDSkAv4g; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="bDSkAv4g"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A12B1C01;
	Wed, 29 Apr 2026 07:14:35 -0700 (PDT)
Received: from e142021.munich.arm.com (e142021.arm.com [10.41.150.154])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 914243F62B;
	Wed, 29 Apr 2026 07:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1777472080; bh=yvBaaJHq522R7D0U8dJahKsXz9SdJpbI8YiKIMevLTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bDSkAv4gBRD21z928LWVL7herJEw20WwQKKy2yVkSeORAhO4XAosQrlSH3MK5syYY
	 o7MLfevklKx1B3dCnPMHmzjjYhQubd/GT8jseG2KizVKStcAhTCytpPmjNHaowoiEk
	 Uy5qFK1Jt2eKpsdTbYui1Y08fHzrRQdmjALSxEFg=
From: Andre Przywara <andre.przywara@arm.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	James Morse <james.morse@arm.com>,
	Ben Horgan <ben.horgan@arm.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Fenghua Yu <fenghuay@nvidia.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] arm_mpam: Parse the rest of the ACPI table
Date: Wed, 29 Apr 2026 16:13:35 +0200
Message-ID: <20260429141339.3171205-2-andre.przywara@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429141339.3171205-1-andre.przywara@arm.com>
References: <20260429141339.3171205-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: James Morse <james.morse@arm.com>

The MPAM ACPI table lists the MPAM MSCs and indicates which resources
in the system they control. Not everything this table can describe is
supported by resctrl, e.g. memory-side-caches.

Add the additional table parsing to avoid reporting these as 'unknown'
to the MPAM driver. This allows class+component hierarchys to be built.

Until resctrl has support for any of these resources, users would be
in-kernel managers of a resource/PARTID or perf to query bandwidth
counters on a resource resctrl is unaware of.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/acpi/arm64/mpam.c | 91 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 88 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/arm64/mpam.c b/drivers/acpi/arm64/mpam.c
index 84963a20c3e7..99c2bdbb3314 100644
--- a/drivers/acpi/arm64/mpam.c
+++ b/drivers/acpi/arm64/mpam.c
@@ -95,17 +95,51 @@ static void acpi_mpam_parse_irqs(struct platform_device *pdev,
 		res[(*res_idx)++] = DEFINE_RES_IRQ_NAMED(irq, "error");
 }
 
-static int acpi_mpam_parse_resource(struct mpam_msc *msc,
+#define UUID_MPAM_INTERCONNECT_TABLE		"fe2bd645-033b-49e6-9479-2e0b8b21d1cd"
+
+struct acpi_mpam_interconnect_descriptor_table {
+	u8	type_uuid[16];
+	u32	num_descriptors;
+};
+
+struct acpi_mpam_interconnect_descriptor {
+	u32	source_id;
+	u32	destination_id;
+	u8	link_type;
+	u8	reserved[3];
+};
+
+static int acpi_mpam_parse_resource(struct acpi_mpam_msc_node *tbl_msc,
+				    struct mpam_msc *msc,
 				    struct acpi_mpam_resource_node *res)
 {
+	struct acpi_mpam_interconnect_descriptor_table *tbl_int_tbl;
+	struct acpi_mpam_interconnect_descriptor *tbl_int;
+	guid_t int_tbl_uuid, spec_uuid;
 	int level, nid;
 	u32 cache_id;
+	off_t offset;
 
+	/*
+	 * Class IDs are somewhat arbitrary, but need to be co-ordinated.
+	 * 0-N are caches,
+	 * 64, 65: Interconnect, but ideally these would appear between the
+	 *     classes the controls are adjacent to.
+	 * 128: SMMU,
+	 * 192-192+level: Memory Side Caches, nothing checks that N is a
+	 *                small number.
+	 * 255: Memory Controllers
+	 *
+	 * ACPI devices would need a class id allocated based on the _HID.
+	 *
+	 * Classes that the mpam driver can't currently plumb into resctrl
+	 * are registered as UNKNOWN.
+	 */
 	switch (res->locator_type) {
 	case ACPI_MPAM_LOCATION_TYPE_PROCESSOR_CACHE:
 		cache_id = res->locator.cache_locator.cache_reference;
 		level = find_acpi_cache_level_from_id(cache_id);
-		if (level <= 0) {
+		if (level <= 0 || level >= 64) {
 			pr_err_once("Bad level (%d) for cache with id %u\n", level, cache_id);
 			return -EINVAL;
 		}
@@ -120,6 +154,57 @@ static int acpi_mpam_parse_resource(struct mpam_msc *msc,
 		}
 		return mpam_ris_create(msc, res->ris_index, MPAM_CLASS_MEMORY,
 				       MPAM_CLASS_ID_DEFAULT, nid);
+	case ACPI_MPAM_LOCATION_TYPE_SMMU:
+		return mpam_ris_create(msc, res->ris_index, MPAM_CLASS_UNKNOWN,
+				       128, res->locator.smmu_locator.smmu_interface);
+	case ACPI_MPAM_LOCATION_TYPE_MEMORY_CACHE:
+		cache_id = res->locator.mem_cache_locator.reference;
+		level = res->locator.mem_cache_locator.level;
+		if (192 + level >= 255) {
+			pr_err_once("Bad level for memory side cache with reference %u\n",
+				    cache_id);
+			return -EINVAL;
+		}
+
+		return mpam_ris_create(msc, res->ris_index, MPAM_CLASS_CACHE,
+				       192 + level, cache_id);
+
+	case ACPI_MPAM_LOCATION_TYPE_INTERCONNECT:
+		/* Find the descriptor table, and check it lands in the parent msc */
+		offset = res->locator.interconnect_ifc_locator.inter_connect_desc_tbl_off;
+		if (offset >= tbl_msc->length) {
+			pr_err_once("Bad offset for interconnect descriptor on msc %u\n",
+				    tbl_msc->identifier);
+			return -EINVAL;
+		}
+		tbl_int_tbl = ACPI_ADD_PTR(struct acpi_mpam_interconnect_descriptor_table,
+					   tbl_msc, offset);
+		guid_parse(UUID_MPAM_INTERCONNECT_TABLE, &spec_uuid);
+		import_guid(&int_tbl_uuid, tbl_int_tbl->type_uuid);
+		if (guid_equal(&spec_uuid, &int_tbl_uuid)) {
+			pr_err_once("Bad UUID for interconnect descriptor on msc %u\n",
+				    tbl_msc->identifier);
+			return -EINVAL;
+		}
+
+		offset += sizeof(*tbl_int_tbl);
+		offset += tbl_int_tbl->num_descriptors * sizeof(*tbl_int);
+		if (offset >= tbl_msc->length) {
+			pr_err_once("Bad num_descriptors for interconnect descriptor on msc %u\n",
+				    tbl_msc->identifier);
+			return -EINVAL;
+		}
+
+		tbl_int = ACPI_ADD_PTR(struct acpi_mpam_interconnect_descriptor,
+				       tbl_int_tbl, sizeof(*tbl_int_tbl));
+		cache_id = tbl_int->source_id;
+
+		/* Unknown link type? */
+		if (tbl_int->link_type != 0 && tbl_int->link_type == 1)
+			return 0;
+
+		return mpam_ris_create(msc, res->ris_index, MPAM_CLASS_UNKNOWN,
+				       64 + tbl_int->link_type, cache_id);
 	default:
 		/* These get discovered later and are treated as unknown */
 		return 0;
@@ -150,7 +235,7 @@ int acpi_mpam_parse_resources(struct mpam_msc *msc,
 			return -EINVAL;
 		}
 
-		err = acpi_mpam_parse_resource(msc, resource);
+		err = acpi_mpam_parse_resource(tbl_msc, msc, resource);
 		if (err)
 			return err;
 
-- 
2.43.0

