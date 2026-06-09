Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DD9313520;
	Tue,  9 Jun 2026 10:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781001332; cv=none; b=ZC4dh1Qg45R6P4T0cj05NfHpHax1IuUgPmIl/l9JEHv7QwGzcJkTZdTMFp7nGYePo209KVH/7hNRwkHLV/NtOqYfvN2GwusNrZgpK2037WbY1PmpGmrpGq/VYa9//z8pHtmxVK0gEiR5z9Rakwmep69tfKnpVTGLqrv2w1FqP6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781001332; c=relaxed/simple;
	bh=TkZGWaSMTpsoKZphJKYFEox7A9aTN2J14I39eUwpfM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=UarFbQTZfsfyKUZ6+NdXmM0MzLquCxySKC2xg80cTR9hYIRpAGPuY5mZs4MsYFOBZ4OSHHx4xJ4EPuzydp6o+gbvOXjU8o4YSfkTbkQvkPGgVBaUxxSsSP1bNCVh5kGawfrrN4qy+NTRfBbDAEt3qqZkIjlLQaKD1AdE9ZLPQuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=uqQ5MZL6; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="uqQ5MZL6"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260609103528euoutp013d288c2fa123fdebeb748e734402df0f~3Y0WXXeaf1159111591euoutp01F;
	Tue,  9 Jun 2026 10:35:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260609103528euoutp013d288c2fa123fdebeb748e734402df0f~3Y0WXXeaf1159111591euoutp01F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1781001328;
	bh=JePwi7lGmk22L2ZvF+HlY3auiYE5qVYyUoJ9xEvdwo4=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=uqQ5MZL6StJuM8hFVb2CNy3r9XJVeTOlky3Nq0KHCVmrWf7sQnMCvsduf/Dc0eogH
	 kOO8JE4vd7HNK7wtukgFBHcoSldIC2uyslzgp8XXmue6mj5Q/YvJPNCzH6KHfiXE+l
	 ajoXf/AA7I1kTJXycD3CKdsUOq9B5DhRhZchI6Qs=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260609103527eucas1p283f7b84555c22cf98e0f014bcb0dde55~3Y0WG7z2a2784927849eucas1p2i;
	Tue,  9 Jun 2026 10:35:27 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260609103525eusmtip28ff34c5b3a0f7565e2286427aae416f9~3Y0UFCurw2983029830eusmtip2X;
	Tue,  9 Jun 2026 10:35:25 +0000 (GMT)
Message-ID: <193cc406-0834-4dee-9b4a-02cdfd85e05c@samsung.com>
Date: Tue, 9 Jun 2026 12:35:24 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v3 03/17] clocksource/drivers/arm_arch_timer: Default to
 EL2 virtual timer when running VHE
To: Marc Zyngier <maz@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla
	<sudeep.holla@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will
	Deacon <will@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Mark
	Rutland <mark.rutland@arm.com>, Daniel Lezcano <daniel.lezcano@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
	Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chen-Yu
	Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel
	Holland <samuel@sholland.org>, Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Ge Gordon
	<gordon.ge@bst.ai>, BST Linux Kernel Upstream Group
	<bst-upstream@bstai.top>, Jesper Nilsson <jesper.nilsson@axis.com>, Lars
	Persson <lars.persson@axis.com>, Alim Akhtar <alim.akhtar@samsung.com>,
	Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Dinh Nguyen
	<dinguyen@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Thierry Reding <thierry.reding@kernel.org>, Jonathan Hunter
	<jonathanh@nvidia.com>, Bjorn Andersson <andersson@kernel.org>, Konrad
	Dybcio <konradybcio@kernel.org>, =?UTF-8?Q?Andreas_F=C3=A4rber?=
	<afaerber@suse.de>, =?UTF-8?B?WXUtQ2h1biBMaW4gW+ael+elkOWQm10=?=
	<eleanor.lin@realtek.com>, Heiko Stuebner <heiko@sntech.de>, Shawn Lin
	<shawn.lin@rock-chips.com>, Orson Zhai <orsonzhai@gmail.com>, Baolin Wang
	<baolin.wang@linux.alibaba.com>, Michal Simek <michal.simek@amd.com>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <86ik7st3nh.wl-maz@kernel.org>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260609103527eucas1p283f7b84555c22cf98e0f014bcb0dde55
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260609100324eucas1p146c5ffe86a104677143baaeca1d3feba
X-EPHeader: CA
X-CMS-RootMailID: 20260609100324eucas1p146c5ffe86a104677143baaeca1d3feba
References: <20260523140242.586031-1-maz@kernel.org>
	<20260523140242.586031-4-maz@kernel.org>
	<CGME20260609100324eucas1p146c5ffe86a104677143baaeca1d3feba@eucas1p1.samsung.com>
	<ea15cce1-b393-43f6-8d58-3d6f90f0c0cd@samsung.com>
	<86ik7st3nh.wl-maz@kernel.org>

On 09.06.2026 12:21, Marc Zyngier wrote:
> On Tue, 09 Jun 2026 11:03:21 +0100,
> Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>> On 23.05.2026 16:02, Marc Zyngier wrote:
>>> When running with at EL2 with VHE enabled, the architecture provides
>>> two EL2 timer/counters, dubbed physical and virtual. Apart from their
>>> names, they are strictly identical.
>>>
>>> However, they don't get virtualised the same way, specially when
>>> it comes to adding arbitrary offsets to the timers. When running as
>>> a guest, the host CNTVOFF_EL2 does apply to the guest's view of
>>> CNTHV*_El2. This is not true for CNTPOFF_EL2 and CNTHP*_EL2, as
>>> the architecture is broken past the first level of virtualisation
>>> (it lacks some essential mechanisms to be usable, despite what
>>> the ARM ARM pretends).
>>>
>>> This means that when running as a L2 guest hypervisor, using the
>>> physical timer results in traps to L0, which are then forwarded to
>>> L1 in order to emulate the offset, leading to even worse performance
>>> due to massive trap amplification (the combination of register and
>>> ERET trapping is absolutely lethal).
>>>
>>> Switch the arch timer code to using the virtual timer when running
>>> in VHE by default, only using the physical timer if the interrupt
>>> is not correctly described in the firmware tables (which seems
>>> to be an unfortunately common case). This comes as no impact on
>>> bare-metal, and slightly improves the situation in the virtualised
>>> case.
>>>
>>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>> This patch landed recently in linux-next as commit d87773de9efe
>> ("clocksource/drivers/arm_arch_timer: Default to EL2 virtual timer when
>> running VHE"). In my tests I found that it breaks booting of RaspberryPi5
>> board. Reverting it on top of linux-next fixes the issue. Here is a boot
>> log:
> Huh.
>
> [...]
>
>> arch_timer: cp15 timer running at 54.00MHz (hyp-virt).
>> clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0xc743ce346, max_idle_ns: 440795203123 ns
>> sched_clock: 56 bits at 54MHz, resolution 18ns, wraps every 4398046511102ns
> The interrupt appears to be advertised in the DT, but doesn't seem to
> fire. That's obviously not going to end well. My suspicion is that
> either the interrupt isn't wired (that'd be hilariously abd), or is
> left as Group-0 by the firmware (copy-paste from RPi4).
>
> Can you try the following hack and let me know if the kernel shouts at
> you?
>
> Thanks,
>
> 	M.
>
> diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
> index ec70c84e9f91d..d05791e6cc0db 100644
> --- a/drivers/irqchip/irq-gic.c
> +++ b/drivers/irqchip/irq-gic.c
> @@ -213,6 +213,7 @@ static void gic_eoimode1_mask_irq(struct irq_data *d)
>  static void gic_unmask_irq(struct irq_data *d)
>  {
>  	gic_poke_irq(d, GIC_DIST_ENABLE_SET);
> +	WARN_ON(!gic_peek_irq(d, GIC_DIST_ENABLE_SET));
>  }
>  
>  static void gic_eoi_irq(struct irq_data *d)

I've applied this change, but it doesn't trigger any warning in the boot log.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

