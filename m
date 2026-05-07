Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232C83F1655;
	Thu,  7 May 2026 12:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778158558; cv=none; b=V0wUb6QS93LNxNo+qYYxm7VPB5e+kdtD6CtU69dyB6EQ8F7RGeHLpTuSBwZ/IW0fADC0xjRHAp3/nSgU19ntXRO2qiO4QNAuf0DY8rAxU7VVB3Q3kQJe/Vhodz0iOu/k5NMGJ++o60uioqe/28RNwOUEvH+QnIPCYOSLkUS8EFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778158558; c=relaxed/simple;
	bh=QU+EV71M3RfDkpd2j74yk/F9jJAx6XKKcfHyhMO6vL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YxJefz7Tk0vnb01KaUvShNVm9Y6QqoIOVe6UhJQjogq0njaDKM62YWzhcU3x0tum9ECHqCLYqrBz6HWFasUc2rZrXT3ZfsB19n9jne4gJRN2f3qzq+QIq24HYV2ht4Lw72CUqLdzV0XWcNT5HjoB5urcuVpTYz0bjM522fowNzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZODJHxeP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZODJHxeP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0E22C2BCC4;
	Thu,  7 May 2026 12:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778158558;
	bh=QU+EV71M3RfDkpd2j74yk/F9jJAx6XKKcfHyhMO6vL0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZODJHxeP8OtPRJz+rU1Fk8V0mWl85x/N5CZIgJJcHKnCOPwPWNdQPLcOCw3CCB7Ag
	 9PEiBca50PwkbMGS6FWHN+04iWY67+lP/1VsZwdp6gCw53hlkzt/TN7BUFXanxkiR3
	 Wd1dhZe4FvvVu8UOkzfkhHk0+L+qJS8GG9mqo/GGxw9/Xjh93MCPSRtJsS93HTEaR8
	 l1muivG7li21sxb12peSOYVrePhJJKmizEniiSy80LFa6apjkzc5WD+7BseYl3Pnsv
	 o+oWwJL0As9ziwfWuBKksF1aeWvsxkplEjO3gYPJ3uvp60YYos9YjFyX2CBIJOOsnI
	 y25edkYZiYulw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1wKyGh-00000000d7d-1jcY;
	Thu, 07 May 2026 12:55:55 +0000
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
Subject: [PATCH 01/16] ACPI: GTDT: Parse information related to the EL2 virtual timer
Date: Thu,  7 May 2026 13:55:29 +0100
Message-ID: <20260507125544.2903406-2-maz@kernel.org>
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

Since ARMv8.1, the architecture has grown an EL2-private virtual
timer. This has been described in ACPI since ACPI v6.3 and revision
3 of the GTDT table.

An aditional structure was added in ACPICA, though in a rather
bizarre way, and merged in v5.1 as 8f5a14d053100 ("ACPICA: ACPI 6.3:
add GTDT Revision 3 support").

Finally plug the table parsing in GTDT, and allow it to be eventually
presented to the architected timer driver.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/acpi/arm64/gtdt.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/acpi/arm64/gtdt.c b/drivers/acpi/arm64/gtdt.c
index ffc867bac2d60..1a58007fccf0a 100644
--- a/drivers/acpi/arm64/gtdt.c
+++ b/drivers/acpi/arm64/gtdt.c
@@ -88,6 +88,19 @@ static int __init map_gt_gsi(u32 interrupt, u32 flags)
 	return acpi_register_gsi(NULL, interrupt, trigger, polarity);
 }
 
+struct gtdt_v3 {
+	struct acpi_table_gtdt	gtdt_v2;
+	struct acpi_gtdt_el2	el2_vtimer;
+};
+
+static struct acpi_gtdt_el2 *gtdt_to_el2_vtimer(struct acpi_table_gtdt *gtdt)
+{
+	if (gtdt->header.revision < 3)
+		return NULL;
+
+	return &container_of(gtdt, struct gtdt_v3, gtdt_v2)->el2_vtimer;
+}
+
 /**
  * acpi_gtdt_map_ppi() - Map the PPIs of per-cpu arch_timer.
  * @type:	the type of PPI.
@@ -101,6 +114,7 @@ static int __init map_gt_gsi(u32 interrupt, u32 flags)
 int __init acpi_gtdt_map_ppi(int type)
 {
 	struct acpi_table_gtdt *gtdt = acpi_gtdt_desc.gtdt;
+	struct acpi_gtdt_el2 *el2_vtimer = gtdt_to_el2_vtimer(gtdt);
 
 	switch (type) {
 	case ARCH_TIMER_PHYS_NONSECURE_PPI:
@@ -113,6 +127,12 @@ int __init acpi_gtdt_map_ppi(int type)
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
@@ -130,6 +150,7 @@ int __init acpi_gtdt_map_ppi(int type)
 bool __init acpi_gtdt_c3stop(int type)
 {
 	struct acpi_table_gtdt *gtdt = acpi_gtdt_desc.gtdt;
+	struct acpi_gtdt_el2 *el2_vtimer = gtdt_to_el2_vtimer(gtdt);
 
 	switch (type) {
 	case ARCH_TIMER_PHYS_NONSECURE_PPI:
@@ -141,6 +162,10 @@ bool __init acpi_gtdt_c3stop(int type)
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

