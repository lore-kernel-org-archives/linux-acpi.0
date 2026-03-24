Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1023EB807;
	Tue, 24 Mar 2026 11:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774352006; cv=none; b=OiT+ivJw86OgLGd394LzIWfXaRlaQRlunmR09pwmn/nWxmruQnjjIcz6F9Tsk/Kaw6KzQJqrfE+S3Vs0SlViDJeMInneIajgwD4phQAy3CQ16GAacETVdSl227qePg7BqhPZ6oQLRfVfH4f3wkRrz9qT9SjBv6Fof6Hc6rPlW3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774352006; c=relaxed/simple;
	bh=MGfqxzxnJdb6vcIOXaAzl+POeYgTm7zQWrbaMSRzX/8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RTR6AclKN0/FG35bX3EzRO9kHjQmNfg6JKmWmhnQ7JRJtxTf/jcp8/88v0F37a8Eu5JdkjQ2K0K4DDTic7KIQLpgenUdiAm4cezmit70xmQTAOpN6cpf7stNS3oy8At7LV13S9HZsUXTDybbO8mtfRoW21//50KVne4999m9PE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 70E3E1476;
	Tue, 24 Mar 2026 04:33:17 -0700 (PDT)
Received: from e134344.cambridge.arm.com (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 095083F885;
	Tue, 24 Mar 2026 04:33:20 -0700 (PDT)
From: Ben Horgan <ben.horgan@arm.com>
To: ben.horgan@arm.com
Cc: rafael@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v1] ACPI / PPTT: Remove duplicate structure, acpi_pptt_cache_v1_full
Date: Tue, 24 Mar 2026 11:33:00 +0000
Message-ID: <20260324113300.1002569-1-ben.horgan@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

acpi_pptt_cache_v1_full was initially added as a stop gap until the
equivalent structure imported from ACPICA, acpi_pptt_v1 in actbl2.h,
contained all the fields of the Cache Type Structure. Since, commit :
091c4af3562d ("ACPICA: ACPI 6.4: PPTT: include all fields in subtable
type1"), acpi_pptt_v1 contains all these fields making
acpi_pptt_cache_v1_full redundant.

Remove acpi_pptt_cache_v1_full.

No functional change intended.

Cc: Jeremy Linton <jeremy.linton@arm.com>
Signed-off-by: Ben Horgan <ben.horgan@arm.com>
---
 drivers/acpi/pptt.c | 31 ++++++-------------------------
 1 file changed, 6 insertions(+), 25 deletions(-)

diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
index de5f8c018333..ea28ba61ddd9 100644
--- a/drivers/acpi/pptt.c
+++ b/drivers/acpi/pptt.c
@@ -21,25 +21,6 @@
 #include <linux/cacheinfo.h>
 #include <acpi/processor.h>
 
-/*
- * The acpi_pptt_cache_v1 in actbl2.h, which is imported from acpica,
- * only contains the cache_id field rather than all the fields of the
- * Cache Type Structure. Use this alternative structure until it is
- * resolved in acpica.
- */
-struct acpi_pptt_cache_v1_full {
-	struct acpi_subtable_header header;
-	u16 reserved;
-	u32 flags;
-	u32 next_level_of_cache;
-	u32 size;
-	u32 number_of_sets;
-	u8 associativity;
-	u8 attributes;
-	u16 line_size;
-	u32 cache_id;
-} __packed;
-
 static struct acpi_subtable_header *fetch_pptt_subtable(struct acpi_table_header *table_hdr,
 							u32 pptt_ref)
 {
@@ -75,16 +56,16 @@ static struct acpi_pptt_cache *fetch_pptt_cache(struct acpi_table_header *table_
 	return (struct acpi_pptt_cache *)fetch_pptt_subtable(table_hdr, pptt_ref);
 }
 
-static struct acpi_pptt_cache_v1_full *upgrade_pptt_cache(struct acpi_pptt_cache *cache)
+static struct acpi_pptt_cache_v1 *upgrade_pptt_cache(struct acpi_pptt_cache *cache)
 {
-	if (cache->header.length < sizeof(struct acpi_pptt_cache_v1_full))
+	if (cache->header.length < sizeof(struct acpi_pptt_cache_v1))
 		return NULL;
 
 	/* No use for v1 if the only additional field is invalid */
 	if (!(cache->flags & ACPI_PPTT_CACHE_ID_VALID))
 		return NULL;
 
-	return (struct acpi_pptt_cache_v1_full *)cache;
+	return (struct acpi_pptt_cache_v1 *)cache;
 }
 
 static struct acpi_subtable_header *acpi_get_pptt_resource(struct acpi_table_header *table_hdr,
@@ -397,7 +378,7 @@ static void update_cache_properties(struct cacheinfo *this_leaf,
 				    struct acpi_pptt_cache *found_cache,
 				    struct acpi_pptt_processor *cpu_node)
 {
-	struct acpi_pptt_cache_v1_full *found_cache_v1;
+	struct acpi_pptt_cache_v1 *found_cache_v1;
 
 	this_leaf->fw_token = cpu_node;
 	if (found_cache->flags & ACPI_PPTT_SIZE_PROPERTY_VALID)
@@ -979,7 +960,7 @@ int find_acpi_cache_level_from_id(u32 cache_id)
 
 			empty = true;
 			for (int i = 0; i < ARRAY_SIZE(cache_type); i++) {
-				struct acpi_pptt_cache_v1_full *cache_v1;
+				struct acpi_pptt_cache_v1 *cache_v1;
 
 				cache = acpi_find_cache_node(table, acpi_cpu_id, cache_type[i],
 							     level, &cpu_node);
@@ -1043,7 +1024,7 @@ int acpi_pptt_get_cpumask_from_cache_id(u32 cache_id, cpumask_t *cpus)
 
 			empty = true;
 			for (int i = 0; i < ARRAY_SIZE(cache_type); i++) {
-				struct acpi_pptt_cache_v1_full *cache_v1;
+				struct acpi_pptt_cache_v1 *cache_v1;
 
 				cache = acpi_find_cache_node(table, acpi_cpu_id, cache_type[i],
 							     level, &cpu_node);
-- 
2.43.0

