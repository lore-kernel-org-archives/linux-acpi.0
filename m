Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D9A3CE481;
	Wed, 15 Jul 2026 08:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784104387; cv=none; b=DX7t8qr3+1MeZBkYwiE+JpBllmtFNDx7ng1MzVKseBarziwZCMl+PxslNYoBJVLaZwbi8ujTqzTnpH8cACsXLSKt+lfhgy9mTxaxth9u9Z7eDicbD10iTpUZ5pylxzLM+iQ0mssPV8Llg1+Cysm0zFsVGVj+NLDLv23eBrkWQM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784104387; c=relaxed/simple;
	bh=VSzAyQH2D6kC9aNH/suxC+bk5/+5gtTn6i8cR4CiMgw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jTz8zozSfk3jjZMjDjITos5dCoXvGC9k0RUH35dog3dl3uDIxo+g58f4fEhTG8xY7fcxWT1lKzSGulq6/6cu8Uloh4FrwmVFMXiW5LiuejHPLY6G5sUoWaPkr9k9/SX+ekGrK9u1pUQw44Kwa1kpJ6WSD5xZrzzJbB10r/mVIMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-05 (Coremail) with SMTP id zQCowAD3bfG1RVdqmTlHGA--.32047S2;
	Wed, 15 Jul 2026 16:32:54 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH] ACPI: validate MADT IOAPIC entry bounds
Date: Wed, 15 Jul 2026 16:32:53 +0800
Message-ID: <20260715083253.22831-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAD3bfG1RVdqmTlHGA--.32047S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuryrWryxAFW3AF4kAryUGFg_yoW5ZryUpF
	WUKa4rKFW8KF47Xw4fAr45XrW5u3yxuFy7XFZ7G3sYkanxXFyrXFZ5K342qry3AFWvga17
	Za4rtas8Ca1xArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUjuHq7UUUU
	U==
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

The IOAPIC hotplug lookup parses both MADT and _MAT records directly.
The MADT walk previously used a subtable's declared length to advance the
cursor after only locating a generic header.  The _MAT path likewise passed
a generic header to the IOAPIC helper.

Validate that a current record has a complete generic header, that its
declared length is contained in the available record range, and that a
typed IOAPIC record contains the full fixed IOAPIC body before reading its
fields.  Use the same relation for both MADT and _MAT provider paths.

Fixes: ecf5636dcd59 ("ACPI: Add interfaces to parse IOAPIC ID for IOAPIC hotplug")
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/acpi/processor_core.c | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index a4498357bd16..3bf076c150fa 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -336,11 +336,26 @@ int acpi_get_cpuid(acpi_handle handle, int type, u32 acpi_id)
 EXPORT_SYMBOL_GPL(acpi_get_cpuid);
 
 #ifdef CONFIG_ACPI_HOTPLUG_IOAPIC
-static int get_ioapic_id(struct acpi_subtable_header *entry, u32 gsi_base,
+static bool madt_entry_is_valid(struct acpi_subtable_header *entry,
+				unsigned long end)
+{
+	unsigned long start = (unsigned long)entry;
+
+	if (start >= end || end - start < sizeof(*entry))
+		return false;
+
+	return entry->length >= sizeof(*entry) && entry->length <= end - start;
+}
+
+static int get_ioapic_id(struct acpi_subtable_header *entry,
+			 const unsigned long end, u32 gsi_base,
 			 u64 *phys_addr, int *ioapic_id)
 {
 	struct acpi_madt_io_apic *ioapic = (struct acpi_madt_io_apic *)entry;
 
+	if (!madt_entry_is_valid(entry, end) || BAD_MADT_ENTRY(ioapic, end))
+		return 0;
+
 	if (ioapic->global_irq_base != gsi_base)
 		return 0;
 
@@ -361,17 +376,19 @@ static int parse_madt_ioapic_entry(u32 gsi_base, u64 *phys_addr)
 		return apic_id;
 
 	entry = (unsigned long)madt;
+	if (madt->header.length < sizeof(*madt))
+		return apic_id;
 	madt_end = entry + madt->header.length;
 
 	/* Parse all entries looking for a match. */
 	entry += sizeof(struct acpi_table_madt);
-	while (entry + sizeof(struct acpi_subtable_header) < madt_end) {
+	while (madt_entry_is_valid((struct acpi_subtable_header *)entry,
+				   madt_end)) {
 		hdr = (struct acpi_subtable_header *)entry;
 		if (hdr->type == ACPI_MADT_TYPE_IO_APIC &&
-		    get_ioapic_id(hdr, gsi_base, phys_addr, &apic_id))
+		    get_ioapic_id(hdr, madt_end, gsi_base, phys_addr, &apic_id))
 			break;
-		else
-			entry += hdr->length;
+		entry += hdr->length;
 	}
 
 	return apic_id;
@@ -398,7 +415,9 @@ static int parse_mat_ioapic_entry(acpi_handle handle, u32 gsi_base,
 
 	header = (struct acpi_subtable_header *)obj->buffer.pointer;
 	if (header->type == ACPI_MADT_TYPE_IO_APIC)
-		get_ioapic_id(header, gsi_base, phys_addr, &apic_id);
+		get_ioapic_id(header,
+			      (unsigned long)header + obj->buffer.length,
+			      gsi_base, phys_addr, &apic_id);
 
 exit:
 	kfree(buffer.pointer);
-- 
2.43.0

