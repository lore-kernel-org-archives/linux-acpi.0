Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAFC3ECBF9;
	Fri,  8 May 2026 14:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778249727; cv=none; b=Nbg0YGxRWPvdqnD1AhsHm0hULXtLQbvETZ2rZS0rVZU3XiTUhpag/ylsDSPOznRnTRxqjTeuQz5Zg4Hyv8fS4gHsNJO4WhdUoCDgOmK27szSHXZtbwogtbjpaZNfA2LohHqFQrGwDOD/l/dwweVcfHD+x9FPKHTXGMaalzXarFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778249727; c=relaxed/simple;
	bh=CREVdtNhaxbusuRm1+ZihtO0voX7GFpdje5lcx7aLDE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XW6/2ZO6733JEqu+aWzz6+YQZyp9XJgIHnJ7pVzRuRic1bV+4eQ68RjPXkkaiTehIxOX32+hntkXtwZ1VloQ3PbjXpMz3eLg8+1WmxvjVizmJFO/KWzmbgQo1fq1Ov/bQ5BKrO3hkMT8amzEA5VSYU1w6qHtPaZd/zAWBuP2t20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OcUc2Xoy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OcUc2Xoy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0A58C2BCB0;
	Fri,  8 May 2026 14:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778249726;
	bh=CREVdtNhaxbusuRm1+ZihtO0voX7GFpdje5lcx7aLDE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OcUc2XoycrQTQdgp42eDDaKK7hXCGxj976qeAYGV+goYs/Q5XDmSnPoVFmFXEmD8V
	 yg3KuKgthWslbdnBj+I57bzSz3jE4S9zHT3Axj13rhLfu6GqYdRK62Ig9TwKBDK7nU
	 k4bLckDbP7BtuAuFxwKTdRb/85oo3l9erPnl2TT/rLJFlQdi06dUvHBgCinOQzQ9at
	 w3z1YzPjU+CzBog68uo/z4aXL36HV5pNEiB26QQHXd40I/sy0R7q5ugnVjtrM5xXs5
	 Y9rcKRI2QikZ73DcRn09TFAIVamOqHcamjjJnL1urx4sFl9lw0mCtWYdYzsrzhvdVG
	 GQiPUcKzFxOMg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1wLLz9-00000000MRz-40c0;
	Fri, 08 May 2026 14:15:24 +0000
Date: Fri, 08 May 2026 15:15:23 +0100
Message-ID: <86jytexa10.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,	Hanjun Guo
 <guohanjun@huawei.com>,	Sudeep Holla <sudeep.holla@kernel.org>,	Catalin
 Marinas <catalin.marinas@arm.com>,	Will Deacon <will@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,	Mark Rutland
 <mark.rutland@arm.com>,	Daniel Lezcano <daniel.lezcano@kernel.org>,	Thomas
 Gleixner <tglx@kernel.org>,	Rob Herring <robh@kernel.org>,	Krzysztof
 Kozlowski <krzk+dt@kernel.org>,	Conor Dooley <conor+dt@kernel.org>,	Chen-Yu
 Tsai <wens@kernel.org>,	Jernej Skrabec <jernej.skrabec@gmail.com>,	Samuel
 Holland <samuel@sholland.org>,	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,	Ge Gordon
 <gordon.ge@bst.ai>,	BST Linux Kernel Upstream Group
 <bst-upstream@bstai.top>,	Jesper Nilsson <jesper.nilsson@axis.com>,	Lars
 Persson <lars.persson@axis.com>,	Alim Akhtar <alim.akhtar@samsung.com>,
	Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>,	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,	Pengutronix Kernel Team
 <kernel@pengutronix.de>,	Fabio Estevam <festevam@gmail.com>,	Dinh Nguyen
 <dinguyen@kernel.org>,	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Thierry Reding <thierry.reding@kernel.org>,	Jonathan Hunter
 <jonathanh@nvidia.com>,	Bjorn Andersson <andersson@kernel.org>,	Konrad
 Dybcio <konradybcio@kernel.org>,	Andreas =?UTF-8?B?RsOkcmJlcg==?=
 <afaerber@suse.de>,	Heiko Stuebner <heiko@sntech.de>,	Shawn Lin
 <shawn.lin@rock-chips.com>,	Orson Zhai <orsonzhai@gmail.com>,	Baolin Wang
 <baolin.wang@linux.alibaba.com>,	Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH 02/16] clocksource/drivers/arm_arch_timer: Default to EL2 virtual timer when running VHE
In-Reply-To: <20260507125544.2903406-3-maz@kernel.org>
References: <20260507125544.2903406-1-maz@kernel.org>
	<20260507125544.2903406-3-maz@kernel.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/30.1
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, lpieralisi@kernel.org, guohanjun@huawei.com, sudeep.holla@kernel.org, catalin.marinas@arm.com, will@kernel.org, rafael@kernel.org, mark.rutland@arm.com, daniel.lezcano@kernel.org, tglx@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, wens@kernel.org, jernej.skrabec@gmail.com, samuel@sholland.org, neil.armstrong@linaro.org, khilman@baylibre.com, jbrunet@baylibre.com, martin.blumenstingl@googlemail.com, gordon.ge@bst.ai, bst-upstream@bstai.top, jesper.nilsson@axis.com, lars.persson@axis.com, alim.akhtar@samsung.com, ivo.ivanov.ivanov1@gmail.com, Frank.Li@nxp.com, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, dinguyen@kernel.org, matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, thierry.reding@kernel.org, jonathanh@nvidia.com, andersson@kernel.org, konradybcio@kernel.org, afaerber@suse.de, heiko@sntech.de, shawn.lin@rock-chips.com, orsonzhai@gmail.com, baolin.wang@linux.alibaba.com, michal.simek@amd.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Thu, 07 May 2026 13:55:30 +0100,
Marc Zyngier <maz@kernel.org> wrote:
> 
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

One thing I missed in this patch is that although we now use the EL2
virtual timer, we are still using the EL2 physical counter. They both
report the same thing, but this is missing a reasonable optimisation
in the NV case, which is the whole purpose of this patch.

I'll fix that for v2.

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.
