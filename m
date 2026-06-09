Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6BD3AC0CE;
	Tue,  9 Jun 2026 10:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780999415; cv=none; b=iixhLYfMdicjGtZ3/HpdOPJ+VOwHTd+TnNdDSIgzRWWmpD5Q1CciHIUVJpgm+RT6dEBg9vE97dI33FjgOEO5/ks8o6baJ5vROp401VrPImkFcNrHiC+YlSdmZlkiVe75V0ZBGah7KVeFJG5dXOMfV3MSltPGGq6JQWWnFXeoWto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780999415; c=relaxed/simple;
	bh=3dGekdtUe9CYkSH4/o5EVrEA2L2BJQpzeKesf2EsFV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=CloqqzRzEktoO70V7plwKg9lCeguwN9rmOdyHZvRqNl1livjIsz29sxQ2ISHjVOeqEIwR7A6VV4OghTEBbLcNBdQzvKLrrFqBl1CG6XHvo6gOor0F+adQdyPc/Eyfdnkpt4PeIN3DOTbcNH+iF/6L2XQdpma5g2QjFtjMs/PjgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=rZQkB/eC; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rZQkB/eC"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260609100324euoutp0124335f0bc6d7dd690854a1af7dbd8092~3YYXIOJSv0480804808euoutp01x;
	Tue,  9 Jun 2026 10:03:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260609100324euoutp0124335f0bc6d7dd690854a1af7dbd8092~3YYXIOJSv0480804808euoutp01x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1780999404;
	bh=yhPOV9UkuFO0jipoP9B62gDohsRZF5KNAjcRdyNILf4=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=rZQkB/eCR8lze3GEcOO99teXB6Xzity/GMg/vwtPA83ezAddGNI0UvciFBRWO2rMf
	 zh8LQgVcBuGrnF7S1JM3ZrnKpFncVoDrBjTBgHJmk/eIxHme8TVgXoNzMXRssaTfo/
	 cSWJUYZTyhrNAb54YKGSDIX5sHsfORjXuJX2GH8I=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260609100324eucas1p146c5ffe86a104677143baaeca1d3feba~3YYW5JhGK2065420654eucas1p1_;
	Tue,  9 Jun 2026 10:03:24 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260609100322eusmtip1fcb431a41bbc894a89969b8c7079b11a~3YYU2lJBw0107101071eusmtip1X;
	Tue,  9 Jun 2026 10:03:22 +0000 (GMT)
Message-ID: <ea15cce1-b393-43f6-8d58-3d6f90f0c0cd@samsung.com>
Date: Tue, 9 Jun 2026 12:03:21 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v3 03/17] clocksource/drivers/arm_arch_timer: Default to
 EL2 virtual timer when running VHE
To: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
	<guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@kernel.org>, Catalin
	Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Daniel
	Lezcano <daniel.lezcano@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Rob
	Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
	Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec
	<jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, Neil
	Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>, Martin Blumenstingl
	<martin.blumenstingl@googlemail.com>, Ge Gordon <gordon.ge@bst.ai>, BST
	Linux Kernel Upstream Group <bst-upstream@bstai.top>, Jesper Nilsson
	<jesper.nilsson@axis.com>, Lars Persson <lars.persson@axis.com>, Alim Akhtar
	<alim.akhtar@samsung.com>, Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>,
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
	<festevam@gmail.com>, Dinh Nguyen <dinguyen@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Thierry Reding
	<thierry.reding@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, Bjorn
	Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
	=?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
	=?UTF-8?B?WXUtQ2h1biBMaW4gW+ael+elkOWQm10=?= <eleanor.lin@realtek.com>,
	Heiko Stuebner <heiko@sntech.de>, Shawn Lin <shawn.lin@rock-chips.com>,
	Orson Zhai <orsonzhai@gmail.com>, Baolin Wang
	<baolin.wang@linux.alibaba.com>, Michal Simek <michal.simek@amd.com>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20260523140242.586031-4-maz@kernel.org>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260609100324eucas1p146c5ffe86a104677143baaeca1d3feba
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260609100324eucas1p146c5ffe86a104677143baaeca1d3feba
X-EPHeader: CA
X-CMS-RootMailID: 20260609100324eucas1p146c5ffe86a104677143baaeca1d3feba
References: <20260523140242.586031-1-maz@kernel.org>
	<20260523140242.586031-4-maz@kernel.org>
	<CGME20260609100324eucas1p146c5ffe86a104677143baaeca1d3feba@eucas1p1.samsung.com>

Dear All,

On 23.05.2026 16:02, Marc Zyngier wrote:
> When running with at EL2 with VHE enabled, the architecture provides
> two EL2 timer/counters, dubbed physical and virtual. Apart from their
> names, they are strictly identical.
>
> However, they don't get virtualised the same way, specially when
> it comes to adding arbitrary offsets to the timers. When running as
> a guest, the host CNTVOFF_EL2 does apply to the guest's view of
> CNTHV*_El2. This is not true for CNTPOFF_EL2 and CNTHP*_EL2, as
> the architecture is broken past the first level of virtualisation
> (it lacks some essential mechanisms to be usable, despite what
> the ARM ARM pretends).
>
> This means that when running as a L2 guest hypervisor, using the
> physical timer results in traps to L0, which are then forwarded to
> L1 in order to emulate the offset, leading to even worse performance
> due to massive trap amplification (the combination of register and
> ERET trapping is absolutely lethal).
>
> Switch the arch timer code to using the virtual timer when running
> in VHE by default, only using the physical timer if the interrupt
> is not correctly described in the firmware tables (which seems
> to be an unfortunately common case). This comes as no impact on
> bare-metal, and slightly improves the situation in the virtualised
> case.
>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
This patch landed recently in linux-next as commit d87773de9efe
("clocksource/drivers/arm_arch_timer: Default to EL2 virtual timer when
running VHE"). In my tests I found that it breaks booting of RaspberryPi5
board. Reverting it on top of linux-next fixes the issue. Here is a boot
log:

Booting Linux on physical CPU 0x0000000000 [0x414fd0b1]
Linux version 7.0.0+ (m.szyprowski@AMDC4653) (aarch64-linux-gnu-gcc (Ubuntu 11.4.0-1ubuntu1~22.04.3) 11.4.0, GNU ld (GNU Binutils for Ubuntu) 2.38) #16769 SMP PREEMPT Tue Jun  9 11:57:24 CEST 2026
KASLR enabled
Machine model: Raspberry Pi 5 Model B Rev 1.0
earlycon: pl11 at MMIO 0x000000107d001000 (options '115200n8')
printk: legacy bootconsole [pl11] enabled
Reserved memory: created CMA memory pool at 0x000000003bc00000, size 64 MiB
OF: reserved mem: initialized node linux,cma, compatible id shared-dma-pool
OF: reserved mem: 0x000000003bc00000..0x000000003fbfffff (65536 KiB) map reusable linux,cma
OF: reserved mem: 0x0000000000000000..0x000000000007ffff (512 KiB) nomap non-reusable atf@0
NUMA: Faking a node at [mem 0x0000000000000000-0x00000001ffffffff]
NODE_DATA(0) allocated [mem 0x1fefe0480-0x1fefe313f]
psci: probing for conduit method from DT.
psci: PSCIv1.1 detected in firmware.
psci: Using standard PSCI v0.2 function IDs
psci: MIGRATE_INFO_TYPE not supported.
psci: SMC Calling Convention v1.2
Zone ranges:
  DMA      [mem 0x0000000000000000-0x00000000ffffffff]
  DMA32    empty
  Normal   [mem 0x0000000100000000-0x00000001ffffffff]
Movable zone start for each node
Early memory node ranges
  node   0: [mem 0x0000000000000000-0x000000000007ffff]
  node   0: [mem 0x0000000000080000-0x000000003fbfffff]
  node   0: [mem 0x0000000040000000-0x00000001ffffffff]
Initmem setup node 0 [mem 0x0000000000000000-0x00000001ffffffff]
On node 0, zone DMA: 1024 pages in unavailable ranges
percpu: Embedded 36 pages/cpu s109456 r8192 d29808 u147456
Detected PIPT I-cache on CPU0
CPU features: detected: Virtualization Host Extensions
CPU features: detected: Spectre-v4
CPU features: detected: Spectre-BHB
CPU features: kernel page table isolation forced ON by KASLR
CPU features: detected: Kernel page table isolation (KPTI)
CPU features: detected: SSBS not fully self-synchronizing
alternatives: applying boot alternatives
Kernel command line: console=ttyAMA10,115200n8 earlycon root=PARTUUID=11111111-03 rw clk_ignore_unused rootdelay=2 retain_initrd
printk: log buffer data + meta data: 131072 + 458752 = 589824 bytes
Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes, linear)
software IO TLB: area num 4.
software IO TLB: mapped [mem 0x00000000fbfff000-0x00000000fffff000] (64MB)
Fallback order for Node 0: 0
Built 1 zonelists, mobility grouping on.  Total pages: 2096128
Policy zone: Normal
mem auto-init: stack:off, heap alloc:off, heap free:off
SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
Running RCU self tests
Running RCU synchronous self tests
rcu: Preemptible hierarchical RCU implementation.
rcu:     RCU event tracing is enabled.
rcu:     RCU lockdep checking is enabled.
rcu:     RCU restricting CPUs from NR_CPUS=512 to nr_cpu_ids=4.
 Trampoline variant of Tasks RCU enabled.
 Tracing variant of Tasks RCU enabled.
rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
Running RCU synchronous self tests
RCU Tasks: Setting shift to 2 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=4.
NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
Root IRQ handler: gic_handle_irq
GIC: Using split EOI/Deactivate mode
rcu: srcu_init: Setting srcu_struct sizes based on contention.
arch_timer: cp15 timer running at 54.00MHz (hyp-virt).
clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0xc743ce346, max_idle_ns: 440795203123 ns
sched_clock: 56 bits at 54MHz, resolution 18ns, wraps every 4398046511102ns
Console: colour dummy device 80x25
Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
... MAX_LOCKDEP_SUBCLASSES:  8
... MAX_LOCK_DEPTH:          48
... MAX_LOCKDEP_KEYS:        8192
... CLASSHASH_SIZE:          4096
... MAX_LOCKDEP_ENTRIES:     32768
... MAX_LOCKDEP_CHAINS:      65536
... CHAINHASH_SIZE:          32768
 memory used by lock dependency info: 6429 kB
 memory used for stack traces: 4224 kB
 per task-struct memory footprint: 1920 bytes
Calibrating delay loop (skipped), value calculated using timer frequency.. 108.00 BogoMIPS (lpj=216000)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 16384 (order: 5, 131072 bytes, linear)
Mountpoint-cache hash table entries: 16384 (order: 5, 131072 bytes, linear)
VFS: Finished mounting rootfs on nullfs
Running RCU synchronous self tests
Running RCU synchronous self tests

(booting freezes)


> ---
>  drivers/clocksource/arm_arch_timer.c | 55 +++++++++++++++++-----------
>  1 file changed, 33 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index 90aeff44a2764..4adf756423de9 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -688,6 +688,7 @@ static void __arch_timer_setup(struct clock_event_device *clk)
>  	clk->irq = arch_timer_ppi[arch_timer_uses_ppi];
>  	switch (arch_timer_uses_ppi) {
>  	case ARCH_TIMER_VIRT_PPI:
> +	case ARCH_TIMER_HYP_VIRT_PPI:
>  		clk->set_state_shutdown = arch_timer_shutdown_virt;
>  		clk->set_state_oneshot_stopped = arch_timer_shutdown_virt;
>  		sne = erratum_handler(set_next_event_virt);
> @@ -879,7 +880,7 @@ static void __init arch_timer_banner(void)
>  	pr_info("cp15 timer running at %lu.%02luMHz (%s).\n",
>  		(unsigned long)arch_timer_rate / 1000000,
>  		(unsigned long)(arch_timer_rate / 10000) % 100,
> -		(arch_timer_uses_ppi == ARCH_TIMER_VIRT_PPI) ? "virt" : "phys");
> +		arch_timer_ppi_names[arch_timer_uses_ppi]);
>  }
>  
>  u32 arch_timer_get_rate(void)
> @@ -912,7 +913,8 @@ static void __init arch_counter_register(void)
>  	int width;
>  
>  	if ((IS_ENABLED(CONFIG_ARM64) && !is_hyp_mode_available()) ||
> -	    arch_timer_uses_ppi == ARCH_TIMER_VIRT_PPI) {
> +	    arch_timer_uses_ppi == ARCH_TIMER_VIRT_PPI ||
> +	    arch_timer_uses_ppi == ARCH_TIMER_HYP_VIRT_PPI) {
>  		if (arch_timer_counter_has_wa()) {
>  			rd = arch_counter_get_cntvct_stable;
>  			scr = raw_counter_get_cntvct_stable;
> @@ -1023,6 +1025,7 @@ static int __init arch_timer_register(void)
>  	ppi = arch_timer_ppi[arch_timer_uses_ppi];
>  	switch (arch_timer_uses_ppi) {
>  	case ARCH_TIMER_VIRT_PPI:
> +	case ARCH_TIMER_HYP_VIRT_PPI:
>  		err = request_percpu_irq(ppi, arch_timer_handler_virt,
>  					 "arch_timer", arch_timer_evt);
>  		break;
> @@ -1090,25 +1093,34 @@ static int __init arch_timer_common_init(void)
>  /**
>   * arch_timer_select_ppi() - Select suitable PPI for the current system.
>   *
> - * If HYP mode is available, we know that the physical timer
> - * has been configured to be accessible from PL1. Use it, so
> - * that a guest can use the virtual timer instead.
> + * On AArch32, if HYP mode is available, we know that the physical
> + * timer has been configured to be accessible from PL1. Use it, so
> + * that a guest can use the virtual timer instead (though KVM host
> + * support has long been removed).
>   *
> - * On ARMv8.1 with VH extensions, the kernel runs in HYP. VHE
> - * accesses to CNTP_*_EL1 registers are silently redirected to
> - * their CNTHP_*_EL2 counterparts, and use a different PPI
> - * number.
> + * On ARMv8.1 with FEAT_VHE, the kernel runs in EL2. Accesses to
> + * CNTV_*_EL1 registers are silently redirected to their CNTHV_*_EL2
> + * counterparts, and the timer uses a different PPI number. Similar
> + * thing happen when using the EL2 physical timer. Note that a bunch
> + * of DTs out there omit the virtual EL2 timer, so fallback gracefully
> + * on the physical timer.
> + *
> + * Without VHE, if no interrupt provided for virtual timer, we'll have
> + * to stick to the physical timer. It'd better be accessible...
>   *
> - * If no interrupt provided for virtual timer, we'll have to
> - * stick to the physical timer. It'd better be accessible...
>   * For arm64 we never use the secure interrupt.
>   *
>   * Return: a suitable PPI type for the current system.
>   */
>  static enum arch_timer_ppi_nr __init arch_timer_select_ppi(void)
>  {
> -	if (is_kernel_in_hyp_mode())
> +	if (is_kernel_in_hyp_mode()) {
> +		if (arch_timer_ppi[ARCH_TIMER_HYP_VIRT_PPI])
> +			return ARCH_TIMER_HYP_VIRT_PPI;
> +
> +		pr_warn_once(FW_BUG "VHE-capable CPU without EL2 virtual timer interrupt\n");
>  		return ARCH_TIMER_HYP_PPI;
> +	}
>  
>  	if (!is_hyp_mode_available() && arch_timer_ppi[ARCH_TIMER_VIRT_PPI])
>  		return ARCH_TIMER_VIRT_PPI;
> @@ -1200,14 +1212,9 @@ static int __init arch_timer_acpi_init(struct acpi_table_header *table)
>  	if (ret)
>  		return ret;
>  
> -	arch_timer_ppi[ARCH_TIMER_PHYS_NONSECURE_PPI] =
> -		acpi_gtdt_map_ppi(ARCH_TIMER_PHYS_NONSECURE_PPI);
> -
> -	arch_timer_ppi[ARCH_TIMER_VIRT_PPI] =
> -		acpi_gtdt_map_ppi(ARCH_TIMER_VIRT_PPI);
> -
> -	arch_timer_ppi[ARCH_TIMER_HYP_PPI] =
> -		acpi_gtdt_map_ppi(ARCH_TIMER_HYP_PPI);
> +	/* The GTDT parser can't be bothered with the secure timer */
> +	for (int i = ARCH_TIMER_PHYS_NONSECURE_PPI; i < ARCH_TIMER_MAX_TIMER_PPI; i++)
> +		arch_timer_ppi[i] = acpi_gtdt_map_ppi(i);
>  
>  	arch_timer_populate_kvm_info();
>  
> @@ -1253,10 +1260,14 @@ int kvm_arch_ptp_get_crosststamp(u64 *cycle, struct timespec64 *ts,
>  	if (!IS_ENABLED(CONFIG_HAVE_ARM_SMCCC_DISCOVERY))
>  		return -EOPNOTSUPP;
>  
> -	if (arch_timer_uses_ppi == ARCH_TIMER_VIRT_PPI)
> +	switch (arch_timer_uses_ppi) {
> +	case ARCH_TIMER_VIRT_PPI:
> +	case ARCH_TIMER_HYP_VIRT_PPI:
>  		ptp_counter = KVM_PTP_VIRT_COUNTER;
> -	else
> +		break;
> +	default:
>  		ptp_counter = KVM_PTP_PHYS_COUNTER;
> +	}
>  
>  	arm_smccc_1_1_invoke(ARM_SMCCC_VENDOR_HYP_KVM_PTP_FUNC_ID,
>  			     ptp_counter, &hvc_res);

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

