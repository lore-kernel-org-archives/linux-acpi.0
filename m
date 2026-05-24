Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A96C30E0F5;
	Sun, 24 May 2026 19:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779652748; cv=none; b=uIG0nGQyzOGBFnCDI52Dq4KUUOsZgfPP6f3zzyNdZKOmyxOnK8FZyzjCa0hr3Um2BMgjD/IMcwgWDtcA9A27RMLzxiIQ3fcfsazcVjce5dTji0/AXUhE2eKZu91Qtq5dq7pZ5huKR3TROuYsznWnG+dOBMdAsYk+yCgU5vtFe10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779652748; c=relaxed/simple;
	bh=XBewFHcm7Sdai5I5k4rx8abTbAFcsQcuZ4F3TeZN+4g=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FX0HO0YrhQddZbMD2Zd+nvMdPWJdXRGZWKiMlQ9NvauaWeIjnqHhII2I5O3iIoiMLeJwyXAevO5TuGDSxyIN6sYu8eC2vIqbwyXT61a8wnOqy185Wg5DmeL2CXieW/zYPm8LMZd/zj5mFk2TngGEhD9kMezva3k3FLC1KHPxkMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PsdL+h/E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PsdL+h/E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E17CA1F000E9;
	Sun, 24 May 2026 19:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779652747;
	bh=6PQW8i/7ZkrkS/T182d40h7fn7wC9G9prkK1aEwDBOU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=PsdL+h/EV4ND6B7eqoBcJIrCsJHpTpg7DdDCc7HttUxD6t/menmaqOU+4g0Zi/rH5
	 DicJLCPHj/tHF85z+75i9Yk4Dl0xeYzY32ECtBecqtVySEWb+/DdVPjUqEfQ3EfNMP
	 hNtwPXxbFNBdeg+WFjoxk9ierxRtKSKEMIbZuoS1JdkfseZrwPiwAWTOsTl3qzSSv1
	 9yGtxf5CXY+ijj3o8CkSfLJNvxdaS2Pc6MzWu8CAm9sZ29Hg9jSpuOLd207RIsXl+r
	 y9cXD06aT60SP+odRj6M0yXstJRUIIjq0G4UA5z5qY43LLHNHBavd87AdVDko2HD2P
	 X/ExX/6zWwg0w==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1wREyV-00000005lyw-38xX;
	Sun, 24 May 2026 19:59:03 +0000
Date: Sun, 24 May 2026 20:59:02 +0100
Message-ID: <86y0h8vat5.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,	devicetree@vger.kernel.org,	Lorenzo Pieralisi
 <lpieralisi@kernel.org>,	Hanjun Guo <guohanjun@huawei.com>,	Sudeep Holla
 <sudeep.holla@kernel.org>,	Catalin Marinas <catalin.marinas@arm.com>,	Will
 Deacon <will@kernel.org>,	"Rafael J. Wysocki" <rafael@kernel.org>,	Mark
 Rutland <mark.rutland@arm.com>,	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,	Conor Dooley
 <conor+dt@kernel.org>,	Chen-Yu Tsai <wens@kernel.org>,	Jernej Skrabec
 <jernej.skrabec@gmail.com>,	Samuel Holland <samuel@sholland.org>,	Neil
 Armstrong <neil.armstrong@linaro.org>,	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,	Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>,	Ge Gordon <gordon.ge@bst.ai>,	BST
 Linux Kernel Upstream Group <bst-upstream@bstai.top>,	Jesper Nilsson
 <jesper.nilsson@axis.com>,	Lars Persson <lars.persson@axis.com>,	Alim
 Akhtar <alim.akhtar@samsung.com>,	Ivaylo Ivanov
 <ivo.ivanov.ivanov1@gmail.com>,	Frank Li <Frank.Li@nxp.com>,	Sascha Hauer
 <s.hauer@pengutronix.de>,	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,	Dinh Nguyen <dinguyen@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,	AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>,	Thierry Reding
 <thierry.reding@kernel.org>,	Jonathan Hunter <jonathanh@nvidia.com>,	Bjorn
 Andersson <andersson@kernel.org>,	Konrad Dybcio <konradybcio@kernel.org>,
	Andreas =?UTF-8?B?RsOkcmJlcg==?= <afaerber@suse.de>,	=?UTF-8?B?Ill1LUNo?=
 =?UTF-8?B?dW4gTGluIFvmnpfnpZDlkJtdIg==?= <eleanor.lin@realtek.com>,	Heiko
 Stuebner <heiko@sntech.de>,	Shawn Lin <shawn.lin@rock-chips.com>,	Orson
 Zhai <orsonzhai@gmail.com>,	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH v3 00/17] arm64: Use EL2 virtual timer when running VHE
In-Reply-To: <f519372e-139c-4530-98bb-dbec56af373a@kernel.org>
References: <20260523140242.586031-1-maz@kernel.org>
	<f519372e-139c-4530-98bb-dbec56af373a@kernel.org>
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
X-SA-Exim-Rcpt-To: krzk@kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, lpieralisi@kernel.org, guohanjun@huawei.com, sudeep.holla@kernel.org, catalin.marinas@arm.com, will@kernel.org, rafael@kernel.org, mark.rutland@arm.com, daniel.lezcano@kernel.org, tglx@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, wens@kernel.org, jernej.skrabec@gmail.com, samuel@sholland.org, neil.armstrong@linaro.org, khilman@baylibre.com, jbrunet@baylibre.com, martin.blumenstingl@googlemail.com, gordon.ge@bst.ai, bst-upstream@bstai.top, jesper.nilsson@axis.com, lars.persson@axis.com, alim.akhtar@samsung.com, ivo.ivanov.ivanov1@gmail.com, Frank.Li@nxp.com, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, dinguyen@kernel.org, matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, thierry.reding@kernel.org, jonathanh@nvidia.com, andersson@kernel.org, konradybcio@kernel.org, a
 faerber@suse.de, eleanor.lin@realtek.com, heiko@sntech.de, shawn.lin@rock-chips.com, orsonzhai@gmail.com, baolin.wang@linux.alibaba.com, michal.simek@amd.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Sun, 24 May 2026 19:17:05 +0100,
Krzysztof Kozlowski <krzk@kernel.org> wrote:
> 
> On 23/05/2026 16:02, Marc Zyngier wrote:
> > This is the third version of the series initially posted at [1],
> > which
> > 
> > - updates the ACPI GTDT parsing to deal the v3 layout and the EL2
> >   virtual timer,
> > - moves the architected timer driver to use it when running VHE,
> > - fixes a number of DTs to reflect the reality of the HW.
> > 
> 
> Please mention here what do you expect SoC maintainer to do with this -
> apply individual patches, wait for dependencies, ack etc.

I only care about the first 3 patches (ACPI enablement, arm64 timer
code), and don't have any expectation for the rest, as pointed out in
the cover letter for v1.

These are all bug fixes for DTs that do not correctly describe the HW.
There is therefore no dependency on anything. The patches can either
be cherry picked by the individual SoC maintainers, applied globally
by one of the DT maintainers, or be completely ignored.

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.
