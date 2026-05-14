Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C96D3DD847;
	Thu, 14 May 2026 15:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778771400; cv=none; b=JnKzDkVtJkECu2gtxqxqZ3Tax0uFj18hIBFA+dpWE01FYN3VyZ1mh+BN+PueKb3kSFh31X/s1AG7lvxXe7374eqfvjPqShEYpGhy31U0DO8ELj9bbggvNlqFlbySndDiT01wvmMd5L6FFkSK2EHAqzzita9ZTAkK55J/w+O/sgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778771400; c=relaxed/simple;
	bh=HTUoneqquTaHhqPUa5kCxkZPw+ky0sQKsSZIjAZkIDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W+1Ow5LtQ+BbTVbiwMNb1axc7Gt/fENYsIZpvjk7kRTSGua2omJ5iT4M9BK6X/AeLv60TVrGvMn0mMpSrYInVc5/Wn0iwHNZxyw09zbSW4x/TA6jEwuQwMKsZ9ZsEekWro4DPS7FJq0w1FsuWJxJk+SRk5QTZg80UDAZBOf1KnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XcyPxnTL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XcyPxnTL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1700C2BCC7;
	Thu, 14 May 2026 15:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778771399;
	bh=HTUoneqquTaHhqPUa5kCxkZPw+ky0sQKsSZIjAZkIDA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XcyPxnTL93T8+lgQhnerH1w/2lJTpn5OcF3Cx/Yk6V1j0ZnfcNq6pI0wiOg4cGv+m
	 GfhMiH04I676xPDlED8vtbKgtkUbBMOtdmI/uMTsrDNPraInGadr/avLjXwP9Tvj9H
	 9KMQAnmYyUd43vQPsWj2Sc+QTESk2XY/PYB/40ycphIMdiGBh7vfZ99Ri7xO14BJEX
	 keuig3LTGmkCMwNG4qro9ckabAGjnkwYNsDJ3iGu+5CfRg4b1gOf2ynD5m0wm2BIic
	 Ab57ZqMbL9F7zU29PERTtUNaprZWycEs8Faku+PZBM8moHyP1GlIW85qCUCbbN9wOf
	 ILP9I6C1XhgaQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1wNXhE-00000002Oqg-1SdD;
	Thu, 14 May 2026 15:09:56 +0000
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
Subject: [PATCH v2 03/17] clocksource/drivers/arm_arch_timer: Default to EL2 virtual timer when running VHE
Date: Thu, 14 May 2026 16:09:31 +0100
Message-ID: <20260514150945.3917510-4-maz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260514150945.3917510-1-maz@kernel.org>
References: <20260514150945.3917510-1-maz@kernel.org>
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
 drivers/clocksource/arm_arch_timer.c | 47 ++++++++++++++++------------
 1 file changed, 27 insertions(+), 20 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 90aeff44a2764..e3eb527650ec7 100644
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
@@ -912,7 +913,8 @@ static void __init arch_counter_register(void)
 	int width;
 
 	if ((IS_ENABLED(CONFIG_ARM64) && !is_hyp_mode_available()) ||
-	    arch_timer_uses_ppi == ARCH_TIMER_VIRT_PPI) {
+	    arch_timer_uses_ppi == ARCH_TIMER_VIRT_PPI ||
+	    arch_timer_uses_ppi == ARCH_TIMER_HYP_VIRT_PPI) {
 		if (arch_timer_counter_has_wa()) {
 			rd = arch_counter_get_cntvct_stable;
 			scr = raw_counter_get_cntvct_stable;
@@ -1023,6 +1025,7 @@ static int __init arch_timer_register(void)
 	ppi = arch_timer_ppi[arch_timer_uses_ppi];
 	switch (arch_timer_uses_ppi) {
 	case ARCH_TIMER_VIRT_PPI:
+	case ARCH_TIMER_HYP_VIRT_PPI:
 		err = request_percpu_irq(ppi, arch_timer_handler_virt,
 					 "arch_timer", arch_timer_evt);
 		break;
@@ -1090,25 +1093,34 @@ static int __init arch_timer_common_init(void)
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
+		pr_warn_once(FW_BUG "VHE-capable CPU without EL2 virtual timer interrupt\n");
 		return ARCH_TIMER_HYP_PPI;
+	}
 
 	if (!is_hyp_mode_available() && arch_timer_ppi[ARCH_TIMER_VIRT_PPI])
 		return ARCH_TIMER_VIRT_PPI;
@@ -1200,14 +1212,9 @@ static int __init arch_timer_acpi_init(struct acpi_table_header *table)
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

