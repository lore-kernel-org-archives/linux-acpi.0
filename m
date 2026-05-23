Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454913A3E72;
	Sat, 23 May 2026 14:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779544986; cv=none; b=ooVKnI0uhWTNByDNZeJHRMqnXUx4SsRZ14P4cEAiIACaIMMefICl9LvuM4UjNsrThpnXV4L2QjEMvoy/TbUpEmNHmddCKQNQk7v91pKpbb83LXfxK09wfbU1Fv1gvWHl3ZMH1c33ZopKIZ3KWIoetfxcQhpv4YIqPC3tgEvyFnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779544986; c=relaxed/simple;
	bh=MJi7t5TPt89sDo4VGxfAxl6xMQMyA0A0mhskuAXvJcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rxm4TQv/wQ9jQB3ZX0+A9DteCoKaXOO6Csq4ddRSnwDZFbKGwYIHNwBDFXF6kWZy8ZFsHGdKAtpJGlYWLLwe2FE/7rd+x+gi67dqVAJkhCjDAdZXuKdG7B0fCpB4pDBD6m6QK4Xy+RuyID6r19DQ1OkQtc9l37Btn1LKNZLMLwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JmFA7TXc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JmFA7TXc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10E0F1F00A3D;
	Sat, 23 May 2026 14:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779544983;
	bh=d7T6wzUDec4336BxIngLV82kCrrKAPX2+jfs+nI48nk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JmFA7TXcey2gVl0iVsPynxQdFDOSOHzpg7+Dl3BLFTboKL2xypLyPczHO+YOv9ajQ
	 oZFCfnLClKfspIjuJ8ULldvHrZm6vjarfWFP6IsU2HS+O4XFcXZM3f1lXLop3NdCOB
	 bB44fYcO05fTVXXNzXBTh4TpmauP4ce4DGkU5nzzZ3HEeRgQ16sS+5WkM7hrMFsjSu
	 OHrfXjasenTs6UEl0BDXfZDeQ2JoCVfx2m2P/Tutvy9MKSymMYH1/JJit8nmQF8EYL
	 fFOrhTT70cLhwEDXHDicmU8P+T3NVCVtW+WdIzqB9KAeUJHwLJMFZzzULJHTIDoDLK
	 LjfVUsE0M6uRQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1wQmwP-00000005YFc-11D1;
	Sat, 23 May 2026 14:03:01 +0000
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
Subject: [PATCH v3 15/17] arm64: dts: rockchip: Add EL2 virtual timer interrupt
Date: Sat, 23 May 2026 15:02:40 +0100
Message-ID: <20260523140242.586031-16-maz@kernel.org>
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

The ARMv8.2 based CPUs used in a number of Rockchip SoCs are missing
the EL2 virtual timer interrupt. Add it.

Acked-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/boot/dts/rockchip/rk356x-base.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi b/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
index 64bdd8b7754b5..a5832895bd392 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
@@ -195,7 +195,8 @@ timer {
 		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_PPI 14 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_PPI 10 IRQ_TYPE_LEVEL_HIGH>;
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_PPI 12 IRQ_TYPE_LEVEL_HIGH>;
 		arm,no-tick-in-suspend;
 	};
 
-- 
2.47.3

