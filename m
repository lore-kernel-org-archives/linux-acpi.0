Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CDA3168FB;
	Sat, 23 May 2026 14:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779544978; cv=none; b=AXvLKcKuBhxQscMKKi4igs9O0I5KlHRWEm3HwOGKiXBSjmlaiTfmePELvpdyE6CiPADU5TxgBfGf4IY59HqH799naO2j8UTeO59IYchGBHbxiqkWWU/xkaHZflr4it9h3vlz37W6xutYHfaq0t+vQeFt5KIWqEhtTSPUk+AyBRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779544978; c=relaxed/simple;
	bh=R4iuGe9YBiY1aYzi0Tisp1FHmSPJtxY4eIU1vjJhsLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JUdjO1d5MxhouFzWY18sfFvBSG81V28dTiTSjh39kVPuDO0ikdO3mArZTlE5xZm1eKxOsvBxWo3il1zKGTq9BG3XjXoMwaiTWZDe6v4stwe84qOhcFMbOz34dxNEykrumBdy9h4XFvQABruqybC8+DUsqbU2yTQZCWHGviuAJ4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=erXfKpK7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="erXfKpK7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0EC91F0155E;
	Sat, 23 May 2026 14:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779544976;
	bh=jRpa4HBTQzdXkNwIHBlxSUXY/+Bd1DIGxFwmhEq5MNs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=erXfKpK7dY9RxXd/poqi266R49oHAcLuBr9maZVCaEFJ6oElzteXijN1wBgLq0lBQ
	 xRART35Nt4eqJ3DMumBtGclRhw1FM6MHKzMPd6oD4PMePXLAtOSmxNy9emHCbGdtLg
	 lErxoqD+SLWqC7vTAler1jzhYA2Xe9uDmKwSyvsvd6wKeZleddGJAU8h5K/ap6E3SR
	 jVjtq67mHUx5rwN2SJ1F7gm+IxX9783FT72S1PSwEO6XB6+aGy/smDWwrQwx6lNw3c
	 uHaLiTqu6CpjTYMcbY4F4FYFXpoxc4qwiBMbBhx6o6uwV0naHBGoatra5mTMq8rix0
	 WnMAOlw+mgbeA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1wQmwH-00000005YFc-48vq;
	Sat, 23 May 2026 14:02:54 +0000
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
	=?UTF-8?q?Yu-Chun=20Lin=20=5B=E6=9E=97=E7=A5=90=E5=90=9B=5D?= <eleanor.lin@realtek.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Michal Simek <michal.simek@amd.com>
Subject: [PATCH v3 02/17] ACPI: GTDT: Parse information related to the EL2 virtual timer
Date: Sat, 23 May 2026 15:02:27 +0100
Message-ID: <20260523140242.586031-3-maz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260523140242.586031-1-maz@kernel.org>
References: <20260523140242.586031-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, lpieralisi@kernel.org, guohanjun@huawei.com, sudeep.holla@kernel.org, catalin.marinas@arm.com, will@kernel.org, rafael@kernel.org, mark.rutland@arm.com, daniel.lezcano@kernel.org, tglx@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, wens@kernel.org, jernej.skrabec@gmail.com, samuel@sholland.org, neil.armstrong@linaro.org, khilman@baylibre.com, jbrunet@baylibre.com, martin.blumenstingl@googlemail.com, gordon.ge@bst.ai, bst-upstream@bstai.top, jesper.nilsson@axis.com, lars.persson@axis.com, alim.akhtar@samsung.com, ivo.ivanov.ivanov1@gmail.com, Frank.Li@nxp.com, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, dinguyen@kernel.org, matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, thierry.reding@kernel.org, jonathanh@nvidia.com, andersson@kernel.org, konradybcio@kernel.org, afaerber@suse.de, 
 eleanor.lin@realtek.com, heiko@sntech.de, shawn.lin@rock-chips.com, orsonzhai@gmail.com, baolin.wang@linux.alibaba.com, michal.simek@amd.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

Now that we have a way to identify GTDTv3, allow the information
related to the EL2 virtual timer to be retrieved by the interface
used by the architected timer driver.

Reviewed-by: Sudeep Holla <sudeep.holla@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/acpi/arm64/gtdt.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/acpi/arm64/gtdt.c b/drivers/acpi/arm64/gtdt.c
index 950d5efdf85ea..00158c8aa6d90 100644
--- a/drivers/acpi/arm64/gtdt.c
+++ b/drivers/acpi/arm64/gtdt.c
@@ -41,6 +41,14 @@ struct gtdt_v3 {
 
 static struct acpi_gtdt_descriptor acpi_gtdt_desc __initdata;
 
+static __init struct acpi_gtdt_el2 *gtdt_to_el2_vtimer(struct acpi_table_gtdt *gtdt)
+{
+	if (gtdt->header.revision < 3)
+		return NULL;
+
+	return &container_of(gtdt, struct gtdt_v3, gtdt_v2)->el2_vtimer;
+}
+
 static __init bool platform_timer_valid(void *platform_timer)
 {
 	struct acpi_gtdt_header *gh = platform_timer;
@@ -112,6 +120,7 @@ static int __init map_gt_gsi(u32 interrupt, u32 flags)
 int __init acpi_gtdt_map_ppi(int type)
 {
 	struct acpi_table_gtdt *gtdt = acpi_gtdt_desc.gtdt;
+	struct acpi_gtdt_el2 *el2_vtimer = gtdt_to_el2_vtimer(gtdt);
 
 	switch (type) {
 	case ARCH_TIMER_PHYS_NONSECURE_PPI:
@@ -124,6 +133,12 @@ int __init acpi_gtdt_map_ppi(int type)
 	case ARCH_TIMER_HYP_PPI:
 		return map_gt_gsi(gtdt->non_secure_el2_interrupt,
 				  gtdt->non_secure_el2_flags);
+	case ARCH_TIMER_HYP_VIRT_PPI:
+		if (el2_vtimer && el2_vtimer->virtual_el2_timer_gsiv)
+			return map_gt_gsi(el2_vtimer->virtual_el2_timer_gsiv,
+					  el2_vtimer->virtual_el2_timer_flags);
+
+		return 0;
 	default:
 		pr_err("Failed to map timer interrupt: invalid type.\n");
 	}
@@ -141,6 +156,7 @@ int __init acpi_gtdt_map_ppi(int type)
 bool __init acpi_gtdt_c3stop(int type)
 {
 	struct acpi_table_gtdt *gtdt = acpi_gtdt_desc.gtdt;
+	struct acpi_gtdt_el2 *el2_vtimer = gtdt_to_el2_vtimer(gtdt);
 
 	switch (type) {
 	case ARCH_TIMER_PHYS_NONSECURE_PPI:
@@ -152,6 +168,10 @@ bool __init acpi_gtdt_c3stop(int type)
 	case ARCH_TIMER_HYP_PPI:
 		return !(gtdt->non_secure_el2_flags & ACPI_GTDT_ALWAYS_ON);
 
+	case ARCH_TIMER_HYP_VIRT_PPI:
+		return el2_vtimer && el2_vtimer->virtual_el2_timer_gsiv &&
+		       !(el2_vtimer->virtual_el2_timer_flags & ACPI_GTDT_ALWAYS_ON);
+
 	default:
 		pr_err("Failed to get c3stop info: invalid type.\n");
 	}
-- 
2.47.3

