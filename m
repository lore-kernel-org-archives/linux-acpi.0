Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1030B3FBB77;
	Thu,  9 Jul 2026 08:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783586490; cv=none; b=qCqcFfQlrvyFnTeigbQUjsoL/Wa32T2KwQ8ab3MiSvC7uG/jrLOqvlFyqlsdX1Xj/CFRY9PpOznegIYQ+3JRTFgmI7oiXSni4SffnXJyK9W+j4JxRWNpeVtZP6R8IzA2KGHnyWpl3/9DdsZyK1xFsNjHOCDZfDW142oDCQaCeXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783586490; c=relaxed/simple;
	bh=haHz293myOIVZPv24e5lIUUw2/7UyWrs24CniPmdRLI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZOsMWSlDwWKmvgMkqXeu89PIbIoYX/e9gkBFYFAOupeG1l/mBE88ZL+f/tnAz8yGjJLkL4+JrHLy289QUVP2OwkifL6eFr6D06UpsKOiMp6ISsp3uE5v7lw7AakidzGygw0jPiuDNA12+8skboL7QIVMZCZFLs/1NQjspGID5DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fs/bO2Pi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fs/bO2Pi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAA311F000E9;
	Thu,  9 Jul 2026 08:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783586480;
	bh=PU2apTxk26tSxVAvU49sTh6nblByGp9XmHnEaO91aJ0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=fs/bO2PithuhoSyBAkLJAbQ+/f0pHZ7KuDI3ZjKSbYyTCedS99jlrljhCGDlqCIUp
	 x7CHnqlbj/ZMcn0KyZojy55JQNvPdaPfS3qQ/SoAKC/ofprXk3RIEriyHcgUEr722R
	 yiLu21OWcuxR8aiMQ+KCatnGvFhvo++8YEic0CNg+BnaV8GEbuAhI15HNZR/x4E9Mm
	 6XGQuI6isjkJJ+G5JKWAMrNwn4OBGk1vWIMkIT+TryR8jAlm1KDXqMNsFG42xwXSjV
	 0km8NVp6JibxOcXMLVbetfcuXu/elk+9AJYeMfa1oQKR//SvT5+0OGJ+6v6/tZhKaT
	 P8xnKZfyEUF6g==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
Date: Thu, 09 Jul 2026 10:40:14 +0200
Subject: [PATCH v4 4/7] ACPI: RISC-V: Fix riscv_acpi_add_prt_dep() loop
 handling
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-gic-v5-acpi-iwb-probe-deferral-v4-4-48dae790f871@kernel.org>
References: <20260709-gic-v5-acpi-iwb-probe-deferral-v4-0-48dae790f871@kernel.org>
In-Reply-To: <20260709-gic-v5-acpi-iwb-probe-deferral-v4-0-48dae790f871@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Sunil V L <sunilvl@ventanamicro.com>, Marc Zyngier <maz@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, 
 Anup Patel <anup@brainfault.org>, Hanjun Guo <guohanjun@huawei.com>, 
 Sudeep Holla <sudeep.holla@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 loongarch@lists.linux.dev, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
 Sunil V L <sunilvl@oss.qualcomm.com>
X-Mailer: b4 0.15.2

The loop in riscv_acpi_add_prt_dep() includes error conditions that are
handled in a dubious - if not outright wrong - way, by continuining the
loop (which skips and misses the entry pointer update to point to the next
entry).

Rewrite the loop as a for loop (that handles the continuation correctly)
and wrap the condition and update statements using helper functions to make
it cleaner.

Fixes: 1b173cc4bfcd ("ACPI: RISC-V: Implement function to add implicit dependencies")
Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Tested-by: Sunil V L <sunilvl@oss.qualcomm.com>
Reviewed-by: Sunil V L <sunilvl@oss.qualcomm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/acpi/riscv/irq.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/riscv/irq.c b/drivers/acpi/riscv/irq.c
index 75170151c614..0cdec5dd575e 100644
--- a/drivers/acpi/riscv/irq.c
+++ b/drivers/acpi/riscv/irq.c
@@ -319,6 +319,20 @@ static int riscv_acpi_irq_get_dep(acpi_handle handle, unsigned int index, acpi_h
 	return ctx.rc;
 }
 
+static bool acpi_prt_entry_valid(void *prt_entry)
+{
+	struct acpi_pci_routing_table *entry = prt_entry;
+
+	return entry && entry->length > 0;
+}
+
+static void *acpi_prt_next_entry(void *prt_entry)
+{
+	struct acpi_pci_routing_table *entry = prt_entry;
+
+	return prt_entry + entry->length;
+}
+
 static u32 riscv_acpi_add_prt_dep(acpi_handle handle)
 {
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
@@ -337,7 +351,7 @@ static u32 riscv_acpi_add_prt_dep(acpi_handle handle)
 	}
 
 	entry = buffer.pointer;
-	while (entry && (entry->length > 0)) {
+	for (; acpi_prt_entry_valid(entry); entry = acpi_prt_next_entry(entry)) {
 		if (entry->source[0]) {
 			status = acpi_get_handle(handle, entry->source, &link_handle);
 			if (ACPI_FAILURE(status))
@@ -365,9 +379,6 @@ static u32 riscv_acpi_add_prt_dep(acpi_handle handle)
 			dep_devices.handles[0] = gsi_handle;
 			count += acpi_scan_add_dep(handle, &dep_devices);
 		}
-
-		entry = (struct acpi_pci_routing_table *)
-			((unsigned long)entry + entry->length);
 	}
 
 	kfree(buffer.pointer);

-- 
2.34.1

