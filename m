Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55693F1AA6;
	Thu,  9 Jul 2026 08:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783586483; cv=none; b=SZy+qY3gK5FnwQOB+iM70z5PaJkjH2x40Vz8Jz1dUw69UwfF86Kyvy1nmp4huRLEAmpkERc+8s2YGWbWQnVKymxIpKkdHBmNlpbDNWk34sFzINdZu3HFujX2hh+W/KT+r8P+qvyaIUCSFc/7N6fU70lqd6LnzTLsdNfWa8MNKsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783586483; c=relaxed/simple;
	bh=p2TSnQqsQ/qgAsA5Lw1q2zWp0wbPeW+UZsOapQFDbfM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gq8nFLd85zcq60H7hmnA/nIETSkQy7EF9JxkLGw4cBXCvkUE83wwvHX5AqrqzRiYCAqfOsDSvPPU/JP4BduiZot5jJpsTLQ5rcofXdoqXVHVspPHwnbYp13S6gg0tPCYfWwOe3DNPO1N2fCm870dVmdzDJzicyHQLNpSmZ59BdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UkBIbx0S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UkBIbx0S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E78F01F00A3F;
	Thu,  9 Jul 2026 08:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783586476;
	bh=qsG5euQizl6EykCVTiNXyXX26Cg/4JUOavNuAu0VDOo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=UkBIbx0Si1jtMXEu5WTm/aUb+fhGLVJaaNVPmQ/LpOfxlV4lesWQDvJ7A5OkIYdkz
	 Qt0vV59V7I6z2judkBQ7YJECbKCrNzD1DJYAktyRVuMek1QjexXhGn4x9eQLIKzBv2
	 cZhsmATuv6YMIOgtfbUj7Dxii83fNesVyVp+P3a16BhXzZVsLYJc9BcW2dmSvJTp13
	 HdCgeSp1m3H9ywop4TE7K9O69MYAuWPk+Ys30NPeW3IOPGHS+igqHl7/m1IZMji6aZ
	 DlgaxvrzPFgYn6INvwiaJiTy8qF9xpUHd38Z1Bk2nYTiKJIlyHOb/0wOmp2/iePN2T
	 lj+ihhng2juZA==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
Date: Thu, 09 Jul 2026 10:40:13 +0200
Subject: [PATCH v4 3/7] ACPI: RISC-V: Check acpi_get_handle() status in
 riscv_acpi_add_prt_dep()
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-gic-v5-acpi-iwb-probe-deferral-v4-3-48dae790f871@kernel.org>
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

In riscv_acpi_add_prt_dep(), the acpi_get_handle() call can fail which
would leave link_handle uninitialized.

Fix it by checking the acpi_get_handle() return status and skip the entry
if it fails.

Fixes: 1b173cc4bfcd ("ACPI: RISC-V: Implement function to add implicit dependencies")
Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Tested-by: Sunil V L <sunilvl@oss.qualcomm.com>
Reviewed-by: Sunil V L <sunilvl@oss.qualcomm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/acpi/riscv/irq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/riscv/irq.c b/drivers/acpi/riscv/irq.c
index cd83c3035cf6..75170151c614 100644
--- a/drivers/acpi/riscv/irq.c
+++ b/drivers/acpi/riscv/irq.c
@@ -339,7 +339,9 @@ static u32 riscv_acpi_add_prt_dep(acpi_handle handle)
 	entry = buffer.pointer;
 	while (entry && (entry->length > 0)) {
 		if (entry->source[0]) {
-			acpi_get_handle(handle, entry->source, &link_handle);
+			status = acpi_get_handle(handle, entry->source, &link_handle);
+			if (ACPI_FAILURE(status))
+				continue;
 			dep_devices.count = 1;
 			dep_devices.handles = kzalloc_objs(*dep_devices.handles,
 							   1);

-- 
2.34.1

