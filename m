Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343383F20F3;
	Thu,  7 May 2026 12:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778158559; cv=none; b=tXlOxQvLmFbSLrBawFfEdQd21jAtVVtAS1SRChRNCEf/l//m6KflLu93z+fRfn21XLcsX1mGUnJXKOAeUhcHeOV8yrty+VsFXwz1KxgwHeoreXfQEb/U/zQorHzkhnvtNgNvm2X79X3WIjEVrMeuIlZzDqAvbm2S+7eAouoRCmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778158559; c=relaxed/simple;
	bh=jmztYL+cRetID0Id+T0uR/HfaxaSY7cdDgh3n5/jrck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fHNut28csG+evuBFrTDzuzKDjdxeQPHALcuBOB7pBJai3Eo4lfxjKXxJ7IvVk+XedFUYmdydH+ob6Rf6vDtCcU3CcnanWNL7wPR/p+qktoT697rtvvUsVkOVGRQgr6gAJAXDAJAh1k81PzsPapxCMY3BKmq5oJDAFL0GSqSAZYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V4wqzSuw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V4wqzSuw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FD24C4AF51;
	Thu,  7 May 2026 12:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778158558;
	bh=jmztYL+cRetID0Id+T0uR/HfaxaSY7cdDgh3n5/jrck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V4wqzSuwuZmFBP1AYiBi9xtz60JFhzvxqIwimyJTstBjGNuyWtoXnSRRoKFcgz6Y/
	 IuAphYyswgyREfOthSY9wHlNF8qj5EorQwCJK1w2Uk6D9N7FanYAcPHIHcxOo1rcuf
	 44fM07Hm4pygxoKeX4cIYXN+DfWE9S2Nmz+3v4pfMhLNygveV3ZqxiPHnYpOeOQc+L
	 ippHJ0cYkCj99A1K72R87ktEC+Xw7PAMysDGnXSysziLUQtSoAXlUCEWmgUVzmVHXM
	 WdXuDGYFw0WNBCxkhEIpoGcnWjCbEAxCpRJZ0P2IDclexs0jxwsPr6+TYJBBYMqX3D
	 qG+148ZT8lNqQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1wKyGh-00000000d7d-3zVR;
	Thu, 07 May 2026 12:55:56 +0000
From: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Ge Gordon <gordon.ge@bst.ai>,
	BST Linux Kernel Upstream Group <bst-upstream@bstai.top>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Lars Persson <lars.persson@axis.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	=?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
	Heiko Stuebner <heiko@sntech.de>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Michal Simek <michal.simek@amd.com>
Subject: [PATCH 02/16] clocksource/drivers/arm_arch_timer: Default to EL2 virtual timer when running VHE
Date: Thu,  7 May 2026 13:55:30 +0100
Message-ID: <20260507125544.2903406-3-maz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260507125544.2903406-1-maz@kernel.org>
References: <20260507125544.2903406-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, lpieralisi@kernel.org, guohanjun@huawei.com, sudeep.holla@kernel.org, catalin.marinas@arm.com, will@kernel.org, rafael@kernel.org, mark.rutland@arm.com, daniel.lezcano@kernel.org, tglx@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, wens@kernel.org, jernej.skrabec@gmail.com, samuel@sholland.org, neil.armstrong@linaro.org, khilman@baylibre.com, jbrunet@baylibre.com, martin.blumenstingl@googlemail.com, gordon.ge@bst.ai, bst-upstream@bstai.top, jesper.nilsson@axis.com, lars.persson@axis.com, alim.akhtar@samsung.com, ivo.ivanov.ivanov1@gmail.com, Frank.Li@nxp.com, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, dinguyen@kernel.org, matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, thierry.reding@kernel.org, jonathanh@nvidia.com, andersson@kernel.org, konradybcio@kernel.org, afaerber@suse.de, heiko@sntech.de, shawn.lin@rock-chips.com, orsonzhai@gmail.com, baolin.wang@linux.alibaba.com, michal.simek@amd.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

When running with at EL2 with VHE enabled, the architecture provides
two EL2 timer/counters, dubbed physical and virtual. Apart from their
names, they are strictly identical.

However, they don't get virtualised the same way, specially when
it comes to adding arbitrary offsets to the timers. When running as
a guest, the host CNTVOFF_EL2 does apply to the guest's view of
CNTHV*_El2. This is not true for CNTPOFF_EL2 and CNTHP*_EL2, as
the architecture is broken past the first level of virtualisation
(it lacks some essential mechanisms to be usable, despite what
the ARM ARM pretends).

This means that when running as a L2 guest hypervisor, using the
physical timer results in traps to L0, which are then forwarded to
L1 in order to emulate the offset, leading to even worse performance
due to massive trap amplification (the combination of register and
ERET trapping is absolutely lethal).

Switch the arch timer code to using the virtual timer when running
in VHE by default, only using the physical timer if the interrupt
is not correctly described in the firmware tables (which seems
to be an unfortunately common case). This comes as no impact on
bare-metal, and slightly improves the situation in the virtualised
case.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/clocksource/arm_arch_timer.c | 44 ++++++++++++++++------------
 1 file changed, 25 insertions(+), 19 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 90aeff44a2764..eaf276a9b9d28 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -688,6 +688,7 @@ static void __arch_timer_setup(struct clock_event_device *clk)
 	clk->irq = arch_timer_ppi[arch_timer_uses_ppi];
 	switch (arch_timer_uses_ppi) {
 	case ARCH_TIMER_VIRT_PPI:
+	case ARCH_TIMER_HYP_VIRT_PPI:
 		clk->set_state_shutdown = arch_timer_shutdown_virt;
 		clk->set_state_oneshot_stopped = arch_timer_shutdown_virt;
 		sne = erratum_handler(set_next_event_virt);
@@ -879,7 +880,7 @@ static void __init arch_timer_banner(void)
 	pr_info("cp15 timer running at %lu.%02luMHz (%s).\n",
 		(unsigned long)arch_timer_rate / 1000000,
 		(unsigned long)(arch_timer_rate / 10000) % 100,
-		(arch_timer_uses_ppi == ARCH_TIMER_VIRT_PPI) ? "virt" : "phys");
+		arch_timer_ppi_names[arch_timer_uses_ppi]);
 }
 
 u32 arch_timer_get_rate(void)
@@ -1023,6 +1024,7 @@ static int __init arch_timer_register(void)
 	ppi = arch_timer_ppi[arch_timer_uses_ppi];
 	switch (arch_timer_uses_ppi) {
 	case ARCH_TIMER_VIRT_PPI:
+	case ARCH_TIMER_HYP_VIRT_PPI:
 		err = request_percpu_irq(ppi, arch_timer_handler_virt,
 					 "arch_timer", arch_timer_evt);
 		break;
@@ -1090,25 +1092,34 @@ static int __init arch_timer_common_init(void)
 /**
  * arch_timer_select_ppi() - Select suitable PPI for the current system.
  *
- * If HYP mode is available, we know that the physical timer
- * has been configured to be accessible from PL1. Use it, so
- * that a guest can use the virtual timer instead.
+ * On AArch32, if HYP mode is available, we know that the physical
+ * timer has been configured to be accessible from PL1. Use it, so
+ * that a guest can use the virtual timer instead (though KVM host
+ * support has long been removed).
  *
- * On ARMv8.1 with VH extensions, the kernel runs in HYP. VHE
- * accesses to CNTP_*_EL1 registers are silently redirected to
- * their CNTHP_*_EL2 counterparts, and use a different PPI
- * number.
+ * On ARMv8.1 with FEAT_VHE, the kernel runs in EL2. Accesses to
+ * CNTV_*_EL1 registers are silently redirected to their CNTHV_*_EL2
+ * counterparts, and the timer uses a different PPI number. Similar
+ * thing happen when using the EL2 physical timer. Note that a bunch
+ * of DTs out there omit the virtual EL2 timer, so fallback gracefully
+ * on the physical timer.
+ *
+ * Without VHE, if no interrupt provided for virtual timer, we'll have
+ * to stick to the physical timer. It'd better be accessible...
  *
- * If no interrupt provided for virtual timer, we'll have to
- * stick to the physical timer. It'd better be accessible...
  * For arm64 we never use the secure interrupt.
  *
  * Return: a suitable PPI type for the current system.
  */
 static enum arch_timer_ppi_nr __init arch_timer_select_ppi(void)
 {
-	if (is_kernel_in_hyp_mode())
+	if (is_kernel_in_hyp_mode()) {
+		if (arch_timer_ppi[ARCH_TIMER_HYP_VIRT_PPI])
+			return ARCH_TIMER_HYP_VIRT_PPI;
+
+		pr_warn_once("VHE without EL2 virtual timer interrupt, broken firmware\n");
 		return ARCH_TIMER_HYP_PPI;
+	}
 
 	if (!is_hyp_mode_available() && arch_timer_ppi[ARCH_TIMER_VIRT_PPI])
 		return ARCH_TIMER_VIRT_PPI;
@@ -1200,14 +1211,9 @@ static int __init arch_timer_acpi_init(struct acpi_table_header *table)
 	if (ret)
 		return ret;
 
-	arch_timer_ppi[ARCH_TIMER_PHYS_NONSECURE_PPI] =
-		acpi_gtdt_map_ppi(ARCH_TIMER_PHYS_NONSECURE_PPI);
-
-	arch_timer_ppi[ARCH_TIMER_VIRT_PPI] =
-		acpi_gtdt_map_ppi(ARCH_TIMER_VIRT_PPI);
-
-	arch_timer_ppi[ARCH_TIMER_HYP_PPI] =
-		acpi_gtdt_map_ppi(ARCH_TIMER_HYP_PPI);
+	/* The GTDT parser can't be bothered with the secure timer */
+	for (int i = ARCH_TIMER_PHYS_NONSECURE_PPI; i < ARCH_TIMER_MAX_TIMER_PPI; i++)
+		arch_timer_ppi[i] = acpi_gtdt_map_ppi(i);
 
 	arch_timer_populate_kvm_info();
 
-- 
2.47.3

