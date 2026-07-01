Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4BF349CFE;
	Wed,  1 Jul 2026 14:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782916754; cv=none; b=KDaJoz/7LTa7B8efa2xrlwntF0XksFDJjN0cY6APsAIBQD2NbP3W6jUF8CI2Kq6aUVhw213/FFMMElUsLCOWFIDVfmKdoDvsSJdvMO9JfNMKlqeZXjFk0ZHIodk9OA+xdWH3h+8PvasuYAtUowlwzmdtAibcKvoplwklHENnlZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782916754; c=relaxed/simple;
	bh=d1ALCS5u5DmcuGqIZfcZRRjKZAzyTSGX8CcIQ1eNj0Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OYWw12HQ2eMrZMD1CZGp8FqONOlHZMPHbOEb30zkAqUo6VRFPvwfKshWU/tXc/w3NrUobDNggftinvZS6OVmPhgFBsAWthL0L6XcVhFd/xveQMl/eLlNnn5cvu9DFLy9ffLjG7YxCyAMLA5YLLQUEHJO9qkWDp2rutB3TaGNNp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eRncNVWf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eRncNVWf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C34DC1F000E9;
	Wed,  1 Jul 2026 14:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782916753;
	bh=Aezc9O//egGLmPy5XC3coGY0bf/LgusaY72KiGQRYwM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=eRncNVWfF3SYwCxob/YAFldce/QWlteAe5ePPFpM/PnpcFZ6IBh7lYJJwmFP9QWua
	 JRhl2kr8fjGXF0u3qoNGDBlxqdpeopSlW7qivNzyM+3wzg9MiRzbpgmqlVdGo5JSz7
	 3iMK/TV97EU/gUFuNSGMI4GgAj1bc3nEuA2P4CpfQKyiJKmcDvJqW/jbNgjOXHQbte
	 m+gBtUQYMOw6XJgPB4Q92KyFWmMqyn1H9fxVCNTjpSJhLY4DinUxgE1ZaRdZ88JIO9
	 rrSXNwo6Gvizhtq5Sk0NHoSjaRY64rYybqUa3ldcW+5fzaR7ksanJurP9SxyW4QUlt
	 mSQaCs2hBycpg==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
Date: Wed, 01 Jul 2026 16:38:50 +0200
Subject: [PATCH v3 2/7] ACPI: RISC-V: Fix riscv_acpi_irq_get_dep() loop
 termination
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-gic-v5-acpi-iwb-probe-deferral-v3-2-c5562cf0fe29@kernel.org>
References: <20260701-gic-v5-acpi-iwb-probe-deferral-v3-0-c5562cf0fe29@kernel.org>
In-Reply-To: <20260701-gic-v5-acpi-iwb-probe-deferral-v3-0-c5562cf0fe29@kernel.org>
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

In riscv_acpi_add_irq_dep() the main loop condition would currently stop
the loop if an interrupt descriptor contains an interrupt for which the
respective GSI handle is NULL, which is not correct because subsequent
interrupts in the interrupt descriptor might still have a GSI dependency
that must not be skipped.

Rework riscv_acpi_add_irq_dep() and the riscv_acpi_irq_get_dep() call chain
to fix it - by not forcing the loop to stop in order to guarantee
dependency detection for all the interrupt entries in the CRS descriptor.

Fixes: 1b173cc4bfcd ("ACPI: RISC-V: Implement function to add implicit dependencies")
Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Tested-by: Sunil V L <sunilvl@oss.qualcomm.com>
Reviewed-by: Sunil V L <sunilvl@oss.qualcomm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/acpi/riscv/irq.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/riscv/irq.c b/drivers/acpi/riscv/irq.c
index 9b88d0993e88..cd83c3035cf6 100644
--- a/drivers/acpi/riscv/irq.c
+++ b/drivers/acpi/riscv/irq.c
@@ -299,6 +299,7 @@ static acpi_status riscv_acpi_irq_get_parent(struct acpi_resource *ares, void *c
 			return AE_OK;
 
 		ctx->handle = riscv_acpi_get_gsi_handle(eirq->interrupts[ctx->index]);
+		ctx->rc = 0;
 		return AE_CTRL_TERMINATE;
 	}
 
@@ -314,10 +315,8 @@ static int riscv_acpi_irq_get_dep(acpi_handle handle, unsigned int index, acpi_h
 
 	acpi_walk_resources(handle, METHOD_NAME__CRS, riscv_acpi_irq_get_parent, &ctx);
 	*gsi_handle = ctx.handle;
-	if (*gsi_handle)
-		return 1;
 
-	return 0;
+	return ctx.rc;
 }
 
 static u32 riscv_acpi_add_prt_dep(acpi_handle handle)
@@ -381,8 +380,11 @@ static u32 riscv_acpi_add_irq_dep(acpi_handle handle)
 	int i;
 
 	for (i = 0;
-	     riscv_acpi_irq_get_dep(handle, i, &gsi_handle);
+	     !riscv_acpi_irq_get_dep(handle, i, &gsi_handle);
 	     i++) {
+		if (!gsi_handle)
+			continue;
+
 		dep_devices.count = 1;
 		dep_devices.handles = kzalloc_objs(*dep_devices.handles, 1);
 		if (!dep_devices.handles) {

-- 
2.34.1

