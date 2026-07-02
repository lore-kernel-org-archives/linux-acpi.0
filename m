Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF873B3C1F;
	Thu,  2 Jul 2026 21:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783029404; cv=none; b=YsHaP6c/1uWNQ4vQ4Q4KvjwE9tx06SfVlGMIK7l9H58QL2InqhxwtYpkIIsU67qxZewVAXMlDVsrgYjtJjJ725WfiIQbGYtY/AyTG02EmnlCrVLLVzszqSsL+6Vq4dj3ktlR8I/vJlrw+EumBq+UWxP+OwWnGKY2LvRVL5pQ3bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783029404; c=relaxed/simple;
	bh=d1O9A+0MyPDityKYvRib0cobH5u7ug+oiIww1XDgpps=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lYCeGZI9POB4KkHOCgBCCRqNfNqk3zDbLly3U6zzZnnkqt7hv+4pbX83LIhM94JYdmq1YMJFE2FABUXBPyDvcCHV66SzThjd3VPsw6QWgfyIkeiUD/xNHRn4wCbt3zo0YgylqxZbylG+iKyJXE9xhX2oeb+wQBAFAtC+CNjNBfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bIVNZuWy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bIVNZuWy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DACB71F00A3A;
	Thu,  2 Jul 2026 21:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783029403;
	bh=d1O9A+0MyPDityKYvRib0cobH5u7ug+oiIww1XDgpps=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=bIVNZuWyWeP2V4+bwBK9HSvNdv6ystQNIZT6kCx4+bJgWYju9hEdaH2Ztvv/ErNZC
	 Ogbcyuxt9U0x/uPQJ0SOIaC21crm/2VsxR+qxOLpAcid/9GDkCTVA6qxzLEifSe2Hg
	 7v1DZllsIXmqFokVi2GrV1HFUNz+JcL3QQKeEWR/aXuy1hXJELtFQCMMpiZsnFL+/E
	 2q0iMDea5oKQrPFRhyu/BtPNSh/oLNCte1OJ7G85y/sap4h3j53W+KaU5zh9LVfW1M
	 i8Cp1y4c/hFDryD/rGM7/xyBtpIl/GZlVslF0CxQ4mm/0nUcY/dKrYQlujnf1yfeMw
	 bLU9R05z8xB0Q==
From: Thomas Gleixner <tglx@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Sunil V L
 <sunilvl@ventanamicro.com>, Marc Zyngier <maz@kernel.org>, Huacai Chen
 <chenhuacai@kernel.org>, Anup Patel <anup@brainfault.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@kernel.org>, Catalin
 Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v3 7/7] irqchip/gic-v5: Enable GICv5 IWB ACPI probe
 ordering detection
In-Reply-To: <878q7tnjj2.ffs@fw13>
References: <20260701-gic-v5-acpi-iwb-probe-deferral-v3-0-c5562cf0fe29@kernel.org>
 <20260701-gic-v5-acpi-iwb-probe-deferral-v3-7-c5562cf0fe29@kernel.org>
 <878q7tnjj2.ffs@fw13>
Date: Thu, 02 Jul 2026 23:56:40 +0200
Message-ID: <875x2xnjhj.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jul 02 2026 at 23:55, Thomas Gleixner wrote:

> On Wed, Jul 01 2026 at 16:38, Lorenzo Pieralisi wrote:
>> Register an ACPI hook in the ACPI interrupt management code for GICv5 to
>> retrieve the ACPI interrupt controller handle (if any) of the controller
>> handling a specific GSI, by updating the acpi_set_irq_model() call with
>> the gic_v5_get_gsi_handle() function pointer parameter.
>>
>> gicv5_get_gsi_handle() allows ACPI core to detect the ACPI handle
>> of the controller that manages a specific GSI interrupt.
>>
>> Update the IWB driver to clear device dependencies in ACPI core once the
>> IWB driver has probed.
>>
>> Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
>> Cc: Thomas Gleixner <tglx@kernel.org>
>
> Assuming this goes through the ACPI tree:
>
> Acked-by: Thomas Gleixner <tglx@kernel.org>

If that's not the plan, let me know and I pick it up.
