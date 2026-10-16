Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAE04E1C7F;
	Fri, 16 Oct 2026 14:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792160094; cv=none; b=QQMgFWUz/P31vaRPsK53VbGp2UCRl04lcuKsmUVy8S6JNBmp4wGoeSExNKSzfyD1MNrU6KAfGXU5zaKtlVM5kJOY9RWsec2y/llaAZCVIJZJpxVBsv/rAOLYQLaW7Ljf6PnLEMk7ZyXjupGB2139jPThpMnQlErrL5sOImZXv2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792160094; c=relaxed/simple;
	bh=Q7PuZdCHhIZHpdnsBA5C7MXBa/Ikv1PFkneA/wFXmkQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rxxWxVTl6fh0+pue4Gh2VK5+WyYaaYwj1Pu5ht/1TfAaLjNv8pAb6fIHt8QLEnum8Esy4/UfbMT0z/f6VxYgxvoEKnFZVXNeVK/fkZKWlLLC1g4nWaq6oPbe4HF0hpKyCAyOqK/awRbTtx0HvIqrx2D+FYGpUFeX4yHyBF6SW4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=B+VNPbFR; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="B+VNPbFR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=fO
	uWWgVjFJqz+6H8lNNzMJceAQ+WE/qQKk554DMd7dE=; b=B+VNPbFRRIQAKA0JM8
	EL7bkWDUrUQHQipva+5yFMT+XTvNEWxih4SX7pectMcTGOTU+YoEM4ne5mc3uIYH
	D8gAimKb2+kFpMSGPWhERde/sIbXbma+t7ZLdj3wF1jK5EU+fTzCZ9vXV5RDJIqe
	muXRZxWbxDetQjxNmKOp+Y20I=
Received: from pc.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgD3n6hSMdJqLevbAA--.28162S2;
	Fri, 16 Oct 2026 22:14:43 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>
Subject: [PATCH] ACPI: processor: validate CPU mapping entries
Date: Fri, 16 Oct 2026 22:14:40 +0800
Message-Id: <20261016141440.2794000-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgD3n6hSMdJqLevbAA--.28162S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXF1kWF4DXFWkur4xZr18Krg_yoW5Cr4rpF
	yUKa4rJw4UWF4agr4fJa1rZrW5Z3y8WF9rXF4fG34fKa17KF15XFW0kFy2qasrAFW0ga1f
	Z3W0vFWUGF48AF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUeq2ZUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC8BOv6WrSMVOuggAA3T

CPU physical ID lookup walks MADT subtables directly and also accepts
records returned by _MAT. Both paths can pass a truncated typed record
to a CPU-specific mapper, and the MADT walker can be stalled or moved
outside the table by an invalid length.

Validate generic record bounds and the minimum size required by each
supported CPU record before dispatching it on both provider paths.

Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/acpi/processor_core.c | 48 ++++++++++++++++++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index 3bf076c150fa..4d5ff53f27ab 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -157,6 +157,47 @@ static int map_core_pic_id(struct acpi_subtable_header *entry,
 	return -EINVAL;
 }
 
+static bool madt_cpu_entry_is_valid(struct acpi_subtable_header *entry,
+				    unsigned long end)
+{
+	unsigned long start = (unsigned long)entry;
+	size_t length, min_length;
+
+	if (start >= end || end - start < sizeof(*entry))
+		return false;
+
+	length = entry->length;
+	if (length < sizeof(*entry) || length > end - start)
+		return false;
+
+	switch (entry->type) {
+	case ACPI_MADT_TYPE_LOCAL_APIC:
+		min_length = sizeof(struct acpi_madt_local_apic);
+		break;
+	case ACPI_MADT_TYPE_LOCAL_X2APIC:
+		min_length = sizeof(struct acpi_madt_local_x2apic);
+		break;
+	case ACPI_MADT_TYPE_LOCAL_SAPIC:
+		min_length = sizeof(struct acpi_madt_local_sapic);
+		break;
+	case ACPI_MADT_TYPE_GENERIC_INTERRUPT:
+		min_length = offsetofend(struct acpi_madt_generic_interrupt,
+					 arm_mpidr);
+		break;
+	case ACPI_MADT_TYPE_RINTC:
+		min_length = offsetofend(struct acpi_madt_rintc, uid);
+		break;
+	case ACPI_MADT_TYPE_CORE_PIC:
+		min_length = sizeof(struct acpi_madt_core_pic);
+		break;
+	default:
+		min_length = sizeof(*entry);
+		break;
+	}
+
+	return length >= min_length;
+}
+
 static phys_cpuid_t map_madt_entry(struct acpi_table_madt *madt,
 				   int type, u32 acpi_id)
 {
@@ -172,7 +213,8 @@ static phys_cpuid_t map_madt_entry(struct acpi_table_madt *madt,
 	/* Parse all entries looking for a match. */
 
 	entry += sizeof(struct acpi_table_madt);
-	while (entry + sizeof(struct acpi_subtable_header) < madt_end) {
+	while (madt_cpu_entry_is_valid((struct acpi_subtable_header *)entry,
+				       madt_end)) {
 		struct acpi_subtable_header *header =
 			(struct acpi_subtable_header *)entry;
 		if (header->type == ACPI_MADT_TYPE_LOCAL_APIC) {
@@ -251,6 +293,10 @@ static phys_cpuid_t map_mat_entry(acpi_handle handle, int type, u32 acpi_id)
 	}
 
 	header = (struct acpi_subtable_header *)obj->buffer.pointer;
+	if (!madt_cpu_entry_is_valid(header,
+			(unsigned long)header + obj->buffer.length))
+		goto exit;
+
 	if (header->type == ACPI_MADT_TYPE_LOCAL_APIC)
 		map_lapic_id(header, acpi_id, &phys_id);
 	else if (header->type == ACPI_MADT_TYPE_LOCAL_SAPIC)
-- 
2.34.1

