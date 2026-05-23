Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9A63A3808;
	Sat, 23 May 2026 14:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779544984; cv=none; b=TONzax4oBF0U400cpBH7srdmGbenBWvBRnNl2Nnr+WN0SzAVCN8p48qUZPfAvjXlfZ6nI4EKIqzCHV4tD5RzOxOI2amMwYfzKkigg7YRtA4oJLX05nsw2DtESm+jMVuo4dQYaNCTiuU+jHWEjwDrfEH/TY+rTy9Ts+S+dkWPHa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779544984; c=relaxed/simple;
	bh=DrpxD5qHnaE1Vvd/k5+Le8i7HjZdU5uqnh3kmij5rg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IjQYSKGcIvoZ9P63MvguCavrnDKnESsgAdj3g0jWO44B7qAzmjmiP80jlMrGRLoehN2eTZAlMOVDBaeFa1O6WVy3LQJi8I10rMVhtPtRiVHmJENVyAkrKCaB6xBzYHxpFp1s1CrdVx9fy2cZ+zI4sTmhZ3iEmMcV+8Gp0h0YKFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vc4zUcpk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vc4zUcpk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77D5A1F01564;
	Sat, 23 May 2026 14:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779544982;
	bh=FWX7TUqGEicTVQxA2GTttmQpVSfoy/ldj1hTfdnKHgI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Vc4zUcpkYimo1lDe8Ux1B1kIRJxytV1b7YTxsC0iL0vdN/FwY4gdxe5XA2S+dvSKc
	 Y3WWYhmdEPUPwl7DHvk/4lg3PPbCUS+w2YEuVUgv6FTgjjYQE7aKzDPEMa/sjcGdbC
	 G2jwPXn0Z8mXDS+9B2ejSfRYbF2Ej6CKvgnFDPr6c8Zx7WRqSzqFzIEd7WdTvQbZtd
	 c6e4Wjl/XVqddaCNdsJ1xXzDmvyQJl4wnsGP+RC9asIUrifQ6OetbvO3/uoRc38/eL
	 Gc0U8kHQZnoy/PlfvKEiaaogNKIa9Z1P86n/341/WeMbcEjt+7t65cX76K7VhhelrH
	 rMm5rgd/OzTdQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1wQmwO-00000005YFc-2gSK;
	Sat, 23 May 2026 14:03:00 +0000
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
Subject: [PATCH v3 14/17] arm64: dts: realtek: Add EL2 virtual timer interrupt
Date: Sat, 23 May 2026 15:02:39 +0100
Message-ID: <20260523140242.586031-15-maz@kernel.org>
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

The ARMv8.2 based CPUs used in a number of Realtek SoCs are missing
the EL2 virtual timer interrupt. Add it.

Furthermore, the "kent" platform appears to assign PPI9 to both the
EL2 virtual timer and the GIC Maintenance Interrupt, which can't be
right. Attempt a fix by setting the former to PPI12, as PPI9 is
traditionally wired to the GIC itself.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/boot/dts/realtek/kent.dtsi    | 2 +-
 arch/arm64/boot/dts/realtek/rtd16xx.dtsi | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/realtek/kent.dtsi b/arch/arm64/boot/dts/realtek/kent.dtsi
index ae006ce244205..4147e4269247a 100644
--- a/arch/arm64/boot/dts/realtek/kent.dtsi
+++ b/arch/arm64/boot/dts/realtek/kent.dtsi
@@ -23,7 +23,7 @@ timer {
 			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
 			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
 			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>,
-			     <GIC_PPI  9 IRQ_TYPE_LEVEL_HIGH>;
+			     <GIC_PPI 12 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
 	cpus {
diff --git a/arch/arm64/boot/dts/realtek/rtd16xx.dtsi b/arch/arm64/boot/dts/realtek/rtd16xx.dtsi
index 3a7f6e35b7f74..43b13d133c324 100644
--- a/arch/arm64/boot/dts/realtek/rtd16xx.dtsi
+++ b/arch/arm64/boot/dts/realtek/rtd16xx.dtsi
@@ -105,7 +105,8 @@ timer {
 		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
 			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
 			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
-			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 12 IRQ_TYPE_LEVEL_LOW>;
 	};
 
 	arm_pmu: pmu {
-- 
2.47.3

