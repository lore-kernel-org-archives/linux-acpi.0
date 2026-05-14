Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0353F428477;
	Thu, 14 May 2026 15:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778771401; cv=none; b=aftpL9m41iM9a02PWF8O9+xo+4WrSf6L48m9BvGQdmVrkeEyMk0ewY7GKF4ZIkeJnLr2xOKLbVseItY3JoclUb8p0LhWOb2Phn6BiZlNf5FThEkEf3GaFFI1owtBHDOCvDupp5tJu4gTYxXuGBuernLImJpdHS4eRVV92u31NA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778771401; c=relaxed/simple;
	bh=VLsh85YozgAjTbaFo7luW5wp3AU+M3q21SDYWi9Ryio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PQASTbH9hLSKlUbS9pafCi0ZDxYD/+/TreA/wv4Lt/AVsT/vHXGIMruxMbL474Oyx2AyUeAimevREq9djim2/KPvGVS78x+KpaJXZM4rNZzZeorDendbUuiTmw6Ec8TXyrW2ifNAv5NLSda9Oj/6Z3V/tmnGVQPi6+ji3gDvkek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hra1rIgT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hra1rIgT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D25EC2BCC9;
	Thu, 14 May 2026 15:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778771400;
	bh=VLsh85YozgAjTbaFo7luW5wp3AU+M3q21SDYWi9Ryio=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hra1rIgTVjLoK89QNBtxCGTHEOp77RpndXa3zBDfmIMiJ4El0BRCuyYMGw5myO3Hi
	 P8g2YLwxBwT/aFPMBVKnkUEPOnsT90n0ZFN/9iq41ruLTghTM/opNsu3ZyoLbvpVqB
	 +kwv9B470AVwMmEs/jVDx7Y1nEb9jt9RduiPZ+V9T1KJRF56jzt9n3NmsD6wCtgZ45
	 WhrHmYTwZzQYPN+MG67FatZdV4wXeVV0bCRVs0mNeP6hXyKPq6ijcLRvBAISszbbnA
	 yRwTbfsGUl4A0pNt7njsME+mH0yB5t3+mtFWuX25Fb5QHJBtdQ/oHt2Ne0oRFQMybp
	 Agdk0uNz9MgDg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1wNXhG-00000002Oqg-2kxF;
	Thu, 14 May 2026 15:09:58 +0000
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
Subject: [PATCH v2 07/17] arm64: dts: bst: Add EL2 virtual timer interrupt
Date: Thu, 14 May 2026 16:09:35 +0100
Message-ID: <20260514150945.3917510-8-maz@kernel.org>
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

The ARMv8.2 based CPUs used in the bst c1200 SoC are missing the EL2
virtual timer interrupt. Add it.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/boot/dts/bst/bstc1200.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/bst/bstc1200.dtsi b/arch/arm64/boot/dts/bst/bstc1200.dtsi
index dd13c6bfc3c89..104ecf76ced10 100644
--- a/arch/arm64/boot/dts/bst/bstc1200.dtsi
+++ b/arch/arm64/boot/dts/bst/bstc1200.dtsi
@@ -92,6 +92,7 @@ timer {
 		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
 			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
 			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
-			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 12 IRQ_TYPE_LEVEL_LOW>;
 	};
 };
-- 
2.47.3

