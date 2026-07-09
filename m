Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417133E47B;
	Thu,  9 Jul 2026 08:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783586476; cv=none; b=LBJeWiJZyvbu4QVw+guorO9aPhHRVmSQGROUl+vxwyF/YD4ZXuYUdDh7KcOs3ve82kmz03vDHDDwrFkrLKHgQVSQm3J/6YX7Iw6Cd08evW9rQmUaXh1YDyS017TAZSJ4PR63auE74EcGchdeIUdBlKuphmEsNGucr5+ScWi3fok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783586476; c=relaxed/simple;
	bh=HqAQMU2fOBK40xbc7kCcYJsFl1etRS+WXPSntXNOXDY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sue12Twld+p4Q5Xf4esYpEZUBFnN3jMPqH/idZwKvaSleQLhBUOQNytcOSzWMxxI6sBabwetsad8wEge7aGRantbD8GuyRZ5d13r8xVWVpdAJbJoGsIsfloKSs74YNTegZQAqfwchUBMWevJA2lAAESnsx52CHXay/Q1rx5J8Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WtkY6cm9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WtkY6cm9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0DE51F00A3A;
	Thu,  9 Jul 2026 08:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783586466;
	bh=paEgN7uylb3MjPzYxx4sYj/GW05ur0v9WVl+yqk3VkI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=WtkY6cm9kiy4LRdViNMmkPIhGIpEM52jaswuUuBxHI1evkMr+fUwjNdSQccQvdOhT
	 I8o3n3cqfR5iDuCEkzJivOAl5rdyLPCd+BxmcmXPF6EoNhYirGXhUtYzg2YhVn6kdo
	 77pElt2iimKvwXnopkeGrGtQqCl0sh4A5YYpmnIwyJHiNRUUV/pRanj024b7jfjY1f
	 gJgxKgFtxkL4Z0K4Yb32YE6E2VluCfKS99AyAKMag0LN/A3BR//12bFD/DGvBEJnxy
	 o/ZOuE+c8I7RdDAtgzMCrt06IEhMEbsifYH7rZa+ouzWb+cyzqdyIM4LmGMDoivoqF
	 n923u8GPLOgdg==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
Date: Thu, 09 Jul 2026 10:40:11 +0200
Subject: [PATCH v4 1/7] ACPI: Add acpi_device_clear_deps() helper function
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-gic-v5-acpi-iwb-probe-deferral-v4-1-48dae790f871@kernel.org>
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
index 10d6c6c11bdf..3d7a49523135 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -94,6 +94,12 @@ static inline void acpi_preset_companion(struct device *dev,
 	ACPI_COMPANION_SET(dev, acpi_find_child_device(parent, addr, false));
 }
 
+static inline void acpi_device_clear_deps(struct device *dev)
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
 
+static inline void acpi_device_clear_deps(struct device *dev) {}
+
 static inline const char *acpi_dev_name(struct acpi_device *adev)
 {
 	return NULL;

-- 
2.34.1

