Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCEC34A3AB;
	Wed,  1 Jul 2026 14:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782916749; cv=none; b=ZQtwrwHKZ7gelpOJeAopjJGW9OWtnLAwnktSIb8/39XyIsrly8wsewrV93ZuS/6YT5SUDAuzdiYme/BVP1f2JG6mY1K5zyeXWvjaWyBL/IKDnWUiSiY2aCvnAJtlUgQzyrDB3WcQQhi4CvV6NQPfB5FC2A5K8rtT8JreQGK49y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782916749; c=relaxed/simple;
	bh=K2Fk//qwx10R/Ed2X+QgagasMZak6OcFCcHrjm2Gk10=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=niXjt1IIGEd6U8EmmDPK5MfTpMDvc6w7FifWqgNLrP8BmrVWZdRO1OzQMtB2LNN4bF4tM4NsMwPFL+3MYipv0hyv9C8CTrpUQMa1d5RApXEKTdHnjlc7qUqd60PTvgqmKuE/dPtSg3EVZIngo2hfLAs836hMX0KnEnmy2+JcMZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mgz+Ljps; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mgz+Ljps"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B54F1F00A3A;
	Wed,  1 Jul 2026 14:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782916748;
	bh=vlACwBlkYsz5jXiaB1uBPPwdDHwbTrrlRYMHHMPY2L0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=mgz+Ljps5aVGf6x6W5F7TdknZYM2fx/pL0xEJyyLGiJs6Q4AVv0uFkPD0KfaUyWNv
	 Ur13BMXRFD6fMLNuKuNgLWramyoQQaRIP2yrkvtbeGv72wSQLyN5v95Dk5nRVs+9Hx
	 KtCU6LfjPexTgFU9kTL5CWM6dr27W9/ASrJhB3q7tUTFYPqLH570zfykUpY63dUCUY
	 XdWvX8EShhzQk/fp7wwmg+FJIwTcZhD4G8LYIt7+A83rIX1b7lL4U4HCypoKjOpTcw
	 eV3d+buysa2lXhW+h5zPNHveS3SegmfVcHubnS/qWmpFoozDUg4lUzc1iFoM0GsN51
	 Hcg8xTJT1QI6g==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
Date: Wed, 01 Jul 2026 16:38:49 +0200
Subject: [PATCH v3 1/7] ACPI: Add acpi_device_clear_dep() helper function
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-gic-v5-acpi-iwb-probe-deferral-v3-1-c5562cf0fe29@kernel.org>
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
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
X-Mailer: b4 0.15.2

Code clearing device dependencies in ACPI in drivers through

acpi_dev_clear_dependencies()

requires annoying ifdeffery to make sure it is compiled out on
!CONFIG_ACPI configurations.

Implement a wrapper function to clear device dependencies that can be used
in device drivers without conditional compilation.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
---
 include/linux/acpi.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 10d6c6c11bdf..4f950f5386d7 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -94,6 +94,12 @@ static inline void acpi_preset_companion(struct device *dev,
 	ACPI_COMPANION_SET(dev, acpi_find_child_device(parent, addr, false));
 }
 
+static inline void acpi_device_clear_dep(struct device *dev)
+{
+	if (has_acpi_companion(dev))
+		acpi_dev_clear_dependencies(ACPI_COMPANION(dev));
+}
+
 static inline const char *acpi_dev_name(struct acpi_device *adev)
 {
 	return dev_name(&adev->dev);
@@ -908,6 +914,8 @@ static inline void acpi_preset_companion(struct device *dev,
 {
 }
 
+static inline void acpi_device_clear_dep(struct device *dev) {}
+
 static inline const char *acpi_dev_name(struct acpi_device *adev)
 {
 	return NULL;

-- 
2.34.1

