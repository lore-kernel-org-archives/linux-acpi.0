Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA54426EA7;
	Thu, 14 May 2026 15:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778771399; cv=none; b=mtA4QErR1ig68SK6yyU2+/ttzf/jERtjTcdxjso1imGCTQg9xvk/VhfyONrkoRkKHYPuw8OFIYxdVuAC8p3Z4FRtfIdpkk0FVIBQ8rJ1vpJY0sAjh+Ev5LZ+jfcGdc+OgGYQxStkFpY3s3MFKfCzcmZKoUNWu1+UzE3zTosOmlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778771399; c=relaxed/simple;
	bh=+Y/GGoTKNCM3giuKbq04aPtsbFnmhL9znjR/JyKh7Js=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DqeWh4GHe+zijGcwBIC3eVd6VkZVlM5jxBknM9Z2b293YJgEgdJa8KJe3nBskVXyyjJu070138+41DRi2eS2Nd28rmrstXnOy7SDK9fFlaUMTjS7StRC4rD9I1k8Sl27Zs1TlQPjZuEwlsD7DhCcZPeIS28X/AqPrEOYFz4j4To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LDMDAMzG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LDMDAMzG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEF8CC2BD05;
	Thu, 14 May 2026 15:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778771397;
	bh=+Y/GGoTKNCM3giuKbq04aPtsbFnmhL9znjR/JyKh7Js=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LDMDAMzGaA9jC172A8eLW/Cb0mO2TltTn8gVbgo/Zu4q/jYWo3Znc+RhmuMsC2Rdk
	 DrE+eWcdwRjhRlKy+13DyVwe+uR8xaRCv5XUpspSMep1T5jwIatMHujwLSLo7576cC
	 L3Um7uOf+i/wLipca02Vku6OO8ANsm+A3eJxH3UaQnYAQPchqQcgD31ZiOAhpkkEHz
	 EPHtwH0GL63NCZpCykOs/slBb6U1UmYrMDI+19mYOAvy1dxm3QwXEcpHMRYq1EIX/y
	 ssmif1ajBeDmtTW9NAqTcP3eT7QDd2biSGD0+EQKLI8uXI2FEodphCyZ2k6k3hR6JG
	 wAdkXRHD52M8g==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1wNXhD-00000002Oqg-3KQ6;
	Thu, 14 May 2026 15:09:55 +0000
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
Subject: [PATCH v2 02/17] ACPI: GTDT: Parse information related to the EL2 virtual timer
Date: Thu, 14 May 2026 16:09:30 +0100
Message-ID: <20260514150945.3917510-3-maz@kernel.org>
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

Now that we have a way to identify GTDTv3, allow the information
related to the EL2 virtual timer to be retrieved by the interface
used by the architected timer driver.

Reviewed-by: Sudeep Holla <sudeep.holla@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/acpi/arm64/gtdt.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/acpi/arm64/gtdt.c b/drivers/acpi/arm64/gtdt.c
index b9d9b8edf2df7..d9b43592c22cd 100644
--- a/drivers/acpi/arm64/gtdt.c
+++ b/drivers/acpi/arm64/gtdt.c
@@ -42,6 +42,14 @@ struct gtdt_v3 {
 
 static struct acpi_gtdt_descriptor acpi_gtdt_desc __initdata;
 
+static __init struct acpi_gtdt_el2 *gtdt_to_el2_vtimer(struct acpi_table_gtdt *gtdt)
+{
+	if (!acpi_gtdt_desc.v3)
+		return NULL;
+
+	return &container_of(gtdt, struct gtdt_v3, gtdt_v2)->el2_vtimer;
+}
+
 static __init bool platform_timer_valid(void *platform_timer)
 {
 	struct acpi_gtdt_header *gh = platform_timer;
@@ -113,6 +121,7 @@ static int __init map_gt_gsi(u32 interrupt, u32 flags)
 int __init acpi_gtdt_map_ppi(int type)
 {
 	struct acpi_table_gtdt *gtdt = acpi_gtdt_desc.gtdt;
+	struct acpi_gtdt_el2 *el2_vtimer = gtdt_to_el2_vtimer(gtdt);
 
 	switch (type) {
 	case ARCH_TIMER_PHYS_NONSECURE_PPI:
@@ -125,6 +134,12 @@ int __init acpi_gtdt_map_ppi(int type)
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
@@ -142,6 +157,7 @@ int __init acpi_gtdt_map_ppi(int type)
 bool __init acpi_gtdt_c3stop(int type)
 {
 	struct acpi_table_gtdt *gtdt = acpi_gtdt_desc.gtdt;
+	struct acpi_gtdt_el2 *el2_vtimer = gtdt_to_el2_vtimer(gtdt);
 
 	switch (type) {
 	case ARCH_TIMER_PHYS_NONSECURE_PPI:
@@ -153,6 +169,10 @@ bool __init acpi_gtdt_c3stop(int type)
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

