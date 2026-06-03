Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E90B410D16;
	Wed,  3 Jun 2026 08:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780474905; cv=none; b=akge1VqoJI4Vsrh+MmNS2Lf0IWCNUTTweYcb/SVUtjtiI0+4U2KsVW69Damzlswduj5mmPAwbUp7t/lkPuoUuhbDNCi0jyYrbNbzczUjQlrVd5V4ScP21nJNhIUCELfVgqgXR37cUDjA7qQ03P4P36+12+tHgGAS4GldM1h+zWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780474905; c=relaxed/simple;
	bh=Zirg5zLISuUGrrZvV/HeyIlS4z8UH5EkGvwvdimhiWs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qWRrB/hRRPkUl3dRkyIxmuusXnmL/QHADukkdmbLSPMwDHMQZhzzRcJik82vU37s70g/xLgxmFG4Epe+GUuMtZ0QEIkQ++w2JWivT+gltab29Wwa6YSNSn3SGqhv6H/tTM2cGQHRIA/ilGz1Ji1BnLEhX8C/BlD82PPvxQGzwSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fS750F7T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fS750F7T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6295E1F00898;
	Wed,  3 Jun 2026 08:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780474904;
	bh=Pamo4jTIx9z4Xf6mq2Ox//K3gj7hfSbjLsah6wBCtzc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=fS750F7TFs/HKsUEE1WJvRe800uTXJ+WBlUN3gohTW06px4gbGfVc5plSSa3Ug4qD
	 68TcWoVkKWcWiYkY4W5a83z46yA96TzsbwfRhsBxsDRiabwQkWns/Tif8yiaS6gKL6
	 A/7d7E0N43yTcUZVyIGSyzY65ASgvfB6Z5RjtduLCL+hVMiQk4gdZYnvheIlDcS7QX
	 R4djuzdFmUEX6fxvHS+FyNqDYvCURwcZeps3YwrHy88ZagnuyleM1tL3kJIK30DByL
	 YwjOeO69BVtUNRPMBdiM3PgfdZMhDZlXyx9pwU7s4tlEHkwL3frYSNef6rIkZu7rmK
	 2ocvGnzUFW+Xg==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
Date: Wed, 03 Jun 2026 10:20:59 +0200
Subject: [PATCH v2 3/6] ACPI: RISC-V: Fix riscv_acpi_add_prt_dep() loop
 handling
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-gic-v5-acpi-iwb-probe-deferral-v2-3-23ffa16b6ebb@kernel.org>
References: <20260603-gic-v5-acpi-iwb-probe-deferral-v2-0-23ffa16b6ebb@kernel.org>
In-Reply-To: <20260603-gic-v5-acpi-iwb-probe-deferral-v2-0-23ffa16b6ebb@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Sunil V L <sunilvl@ventanamicro.com>, Marc Zyngier <maz@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, 
 Anup Patel <anup@brainfault.org>, Hanjun Guo <guohanjun@huawei.com>, 
 Sudeep Holla <sudeep.holla@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 loongarch@lists.linux.dev, Lorenzo Pieralisi <lpieralisi@kernel.org>
X-Mailer: b4 0.15.2

The loop in riscv_acpi_add_prt_dep() includes error conditions that are
handled in a dubious - if not outright wrong - way, by continuining the
loop (which skips and misses the entry pointer update to point to the next
entry).

Rewrite the loop as a for loop (that handles the continuation correctly)
and wrap the condition and update statements using helper functions to make
it cleaner.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
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
2.54.0

