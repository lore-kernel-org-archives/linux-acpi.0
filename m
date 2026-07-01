Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DB03403F9;
	Wed,  1 Jul 2026 14:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782916758; cv=none; b=kChvwp6OX5RGwAulXFg46U21bpEUVi4BguVz4oHrIRJKyKWd9TXJ9GR1HANjrOtGIv+wRGnGnUK/idSmTRjCyYvmeWAOQNFsGxYuK2D2gIq2AHkWXWnQKppY/jibuyInsf7tWrhZADHpeimna91uFJx8j24Hw34sT5Vd1nfO8go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782916758; c=relaxed/simple;
	bh=p2TSnQqsQ/qgAsA5Lw1q2zWp0wbPeW+UZsOapQFDbfM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qga/SIKIHGSNDOI63gx/9mhsMHJg7kudULcZBo2ozQ37gBeZvOWAt+PXbIPFc2B7IUhFEdyvjxmnSEW0tiSACHGNgy1jofyTm9VSeIDR8Ao8OP3u/XQpLzbflDIKQHQoBV9dUlfO2h/LgYQeZ4bthXsJaM8AfBwZ1N6+TOETgmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fzBgYTNx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fzBgYTNx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D0911F00A3E;
	Wed,  1 Jul 2026 14:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782916757;
	bh=qsG5euQizl6EykCVTiNXyXX26Cg/4JUOavNuAu0VDOo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=fzBgYTNxT9jMLK6WSe+14coIN4Xw4oJwauwwW21MrbB1KduIZXa/QBCMmYiX9Jyx1
	 mx1ByTx+o7ePtiulB1/u4z2sLTHLKJODoomjrukuj8QJ7jR8Kg5RvmDI0wLcfwJyP5
	 SevZe2dBehgAZjJ0fBhcxrSEV76jksmgeJrdNpleUrAIFg3SZ4qCUKuYjcwut2nGni
	 L4DxGscORAT0XbKdhZd/nd7RUx3iY169Sn9mMxY/pwpog0gJcNd7iE7fhb4VN1c5YF
	 Ks9G0XzoCIvVS0nX5hSPLxrIprs6mNN95MeP/j3S0O1uV7pKoRnC3yYRWAHWUfZRm4
	 /XFik510jE2Nw==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
Date: Wed, 01 Jul 2026 16:38:51 +0200
Subject: [PATCH v3 3/7] ACPI: RISC-V: Check acpi_get_handle() status in
 riscv_acpi_add_prt_dep()
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-gic-v5-acpi-iwb-probe-deferral-v3-3-c5562cf0fe29@kernel.org>
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

