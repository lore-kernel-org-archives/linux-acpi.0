Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59916410D16;
	Wed,  3 Jun 2026 08:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780474901; cv=none; b=CrloN3ED09gWmBmgq1U+36sAqWKOrUMd88wbpPfBKncA073p3T3y+THMWyL7Xwe9yzqPm/8ZnM1sPe8AIyYC+cP5ehcuWIFsmjOknCvi0ofOAeNifFsv0yiOwln9uxuJLivCMnncMbM6YX+kTxQrF4+BJKuLQumyf33AmEUkczI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780474901; c=relaxed/simple;
	bh=Yl974pojDpKqEpnSLuagZUOwMHghmNN3zNAM92cuaec=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CUUIQ9t1/VVhTfY5nceXtKU1rc/nyN83qGGnLzut6in8giFSB+tvSZ8yxte37ckhWQWMyDs6WcoooDJGw+ny+4QKQfgS01OWQ3ibiRu6naGgx4wWS24BbaMdvIvztgF0nnhkDYag8gaM9VBAKkEHzE0rppq+dh18SOlaT6pTLCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UV7+otxr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UV7+otxr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F8421F00893;
	Wed,  3 Jun 2026 08:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780474899;
	bh=G3J6B2wwZ8nlMNmtNYnVu0NFww9ipBOtwt+oR1HOegI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=UV7+otxrRpsGFCIT5jwSzDvpOuUbknuas3TVVTutaGY5qRF950r5oSoxcsT2s3sky
	 jeN00ChBJ0TYcBIpvW+l2jUft6/5oe06Ttw7lMuqRdKwhYPAop6cYI4HMSfk7HDegy
	 4T3As6/69X/TDI4Zg5Qmi+iBWaeDZDO3Cjevd9NM89obHjUGLwexu00Egcmb5ZCMm9
	 mCBVxdE7uATNtHCrxUJO6HpL+cU7hs2VP+iDNoY9x3QRqoc2cT5pv16zOtiy83J8C6
	 W0Uxo4mlI3LfrLGfSI6QJ0s2zTcUPmEB/Dp075SZu1xstFtYddmBdlxocXC2JBmjS4
	 cVT0FwyBfIrcQ==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
Date: Wed, 03 Jun 2026 10:20:58 +0200
Subject: [PATCH v2 2/6] ACPI: RISC-V: Check acpi_get_handle() status in
 riscv_acpi_add_prt_dep()
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-gic-v5-acpi-iwb-probe-deferral-v2-2-23ffa16b6ebb@kernel.org>
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

In riscv_acpi_add_prt_dep(), the acpi_get_handle() call can fail which
would leave link_handle uninitialized.

Fix it by checking the acpi_get_handle() return status and skip the entry
if it fails.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
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
2.54.0

