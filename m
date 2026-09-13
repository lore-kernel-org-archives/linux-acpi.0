Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5693039E17E;
	Sun, 13 Sep 2026 12:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789303900; cv=none; b=f3CKk3lD1CaK/1Z2p0aVJca6FCJ/lzF5m7HjkGryOqCoKIjkKMtwW9V46D6tYZp7QoKhlsCSzqy83sTfR73GAAWx9bj8ycRxHQwi3qqLyKLyaObaTqwmYa2B4gDco0QPx9CfO5aAS2CbT8drF2PhOMAik+Bgdy7y9l+KpKqtG2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789303900; c=relaxed/simple;
	bh=syCPE5FCkavE2uJxe8NucoJAuB3bh2GL1yNpsDMqPAU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=o24+0pUaTYcgVHrTwFord6h+4N2SWtXcBC48u/0VF7lhLAQQbUrhHEwIUl7ngrq2ALdjbwR19koth9sfT3Ucbd4BnnGO6EYe9fmL7wllF+M7pYFD6un1v8phYi9hko+1C4o7ajChL5zMug+D4rluLzVMcwdHdVrtgeqxzSvAbKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=nNH6gPcR; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="nNH6gPcR"
Received: from seu.edu.cn (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4d907a3d1;
	Sun, 13 Sep 2026 20:51:25 +0800 (GMT+08:00)
From: Slavin Liu <bolin.liu@seu.edu.cn>
To: rafael@kernel.org
Cc: lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bolin.liu@seu.edu.cn
Subject: [PATCH] ACPI: tables: handle failed initrd override mappings
Date: Sun, 13 Sep 2026 20:51:23 +0800
Message-Id: <20260913125123.109803-1-bolin.liu@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa09ad28bb103a1kunm708b45eb251152
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCTxpDVk8fTkkeSRhIS0NCTFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhOQ0
	NVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=nNH6gPcR3u0fpuro3OXgZnVlYRQFX1utcsyNwlO39hvl30dbalKqm5IFrXt6yp9RhTs78gVPFAqpLAbTMDTBJnJyrYcbMbxxid9SAJKFoOcBPvaSsCB1UEY5J1vmLN6PdnebVsk592uVonkvd7VlhKZ47XEeFM9WOqftmFO0Gkc=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=8Bsicwui7R4YtTJ3arv7LIYh+GUCamktxtkrH+3J9JM=;
	h=date:mime-version:subject:message-id:from;

The runtime AML table-loading path can invoke initrd override after
permanent mappings are enabled. Mapping bookkeeping can then fail.
Return AE_NO_MEMORY before reading the candidate header through NULL.

Detected by static analysis and reviewed with AI-assisted source auditing.

Fixes: b2a35003dfbc ("ACPI: Implement physical address table override")
Assisted-by: LLM
Signed-off-by: Slavin Liu <bolin.liu@seu.edu.cn>
---
 drivers/acpi/tables.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index eb93c060426f..749a128a889c 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -560,6 +560,8 @@ acpi_table_initrd_override(struct acpi_table_header *existing_table,
 	while (table_offset + ACPI_HEADER_SIZE <= all_tables_size) {
 		table = acpi_os_map_memory(acpi_tables_addr + table_offset,
 					   ACPI_HEADER_SIZE);
+		if (!table)
+			return AE_NO_MEMORY;
 		if (table_offset + table->length > all_tables_size) {
 			acpi_os_unmap_memory(table, ACPI_HEADER_SIZE);
 			WARN_ON(1);
