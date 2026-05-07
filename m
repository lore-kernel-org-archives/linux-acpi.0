Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303331E9B35;
	Thu,  7 May 2026 15:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778169461; cv=none; b=i51AU/VJLH8qmRpy4lMxLmhVVhjayeV33x8pkoyXOc3wBg8O6CXCMS96SZtZk092JmNKlnBxqPYsiTZvFnsxVR0jAunI0xbJ1JdpsTHJC7QWa0Rub3g30MZKRgJwBJi7IV/InUBJDTePXJcDwLwf6WgBZTtjgZlS0NPqFnzL3hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778169461; c=relaxed/simple;
	bh=SRDQGAD1Jdb8rMWAaZJsxwcnVMafxfPILg9InfBnZk8=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=udGbmJ645d7oESv9Hrodsac1BKQV8BacDOAkVEWkQgTlmM0KgrHuIwt0n6RvBzUYjgrvB6rTZmBDXH8bUMM+EQjBx+qVJr6uxy+3gxacvg9xwO96CxHi64xHuaH7LNnzfedOlhAOM/qCRd28fUpLEsp/5wD56CZIqDQzPTq41nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BW6G5dbH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BW6G5dbH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF6DEC2BCB2;
	Thu,  7 May 2026 15:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778169461;
	bh=SRDQGAD1Jdb8rMWAaZJsxwcnVMafxfPILg9InfBnZk8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BW6G5dbHPaISsPWE5mSZF9XcFmisdWcuoAKiW5zf0L3W7E4POAvDn732x84epIMl7
	 nL+2cxtZ7AI1v1hOywTgzUA7IJzucqLN2kWzZf9Cx0+QT5B6ZtuCNa95UNRDmrik37
	 B/MPn/Si4AsLpY1++E4JIWONY2cqBvsXA8rs0mQ+VPruEIU4hnjSJS1/ISetecwSTX
	 ld+uGPWrx3At5c/+y4mURuzcC/wfYlRkgFOyW6rCvT8NC8XOQhy0b7ofpuprvih9eV
	 78U15qZk4aaa7h7v7Cv8VfO7j7RTOrchBruaJiAGEMbeIbKsEvLS++6RtJ1b1Ao3cU
	 uE85PDi3IRH9w==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1wL16U-000000002I0-0wWs;
	Thu, 07 May 2026 15:57:34 +0000
Date: Thu, 07 May 2026 16:57:33 +0100
Message-ID: <86o6irxlea.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>
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
	Andreas =?UTF-8?B?RsOkcmJlcg==?= <afaerber@suse.de>,	Shawn Lin
 <shawn.lin@rock-chips.com>,	Orson Zhai <orsonzhai@gmail.com>,	Baolin Wang
 <baolin.wang@linux.alibaba.com>,	Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH 14/16] arm64: dts: rockchip: Add EL2 virtual timer interrupt
In-Reply-To: <3690258.8hzESeGDPO@phil>
References: <20260507125544.2903406-1-maz@kernel.org>
	<20260507125544.2903406-15-maz@kernel.org>
	<3690258.8hzESeGDPO@phil>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/30.1
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: heiko@sntech.de, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, lpieralisi@kernel.org, guohanjun@huawei.com, sudeep.holla@kernel.org, catalin.marinas@arm.com, will@kernel.org, rafael@kernel.org, mark.rutland@arm.com, daniel.lezcano@kernel.org, tglx@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, wens@kernel.org, jernej.skrabec@gmail.com, samuel@sholland.org, neil.armstrong@linaro.org, khilman@baylibre.com, jbrunet@baylibre.com, martin.blumenstingl@googlemail.com, gordon.ge@bst.ai, bst-upstream@bstai.top, jesper.nilsson@axis.com, lars.persson@axis.com, alim.akhtar@samsung.com, ivo.ivanov.ivanov1@gmail.com, Frank.Li@nxp.com, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, dinguyen@kernel.org, matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, thierry.reding@kernel.org, jonathanh@nvidia.com, andersson@kernel.org, konradybcio@kernel.org, afaerber@suse.de, shawn.lin@rock-chips.com, orsonzhai@gmail.com, baolin.wang@linux.alibaba.com, michal.simek@amd.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Thu, 07 May 2026 16:33:21 +0100,
Heiko Stuebner <heiko@sntech.de> wrote:
>=20
> Hi Mark,

s/k/c/ ;-)

>=20
> Am Donnerstag, 7. Mai 2026, 14:55:42 Mitteleurop=C3=A4ische Sommerzeit sc=
hrieb Marc Zyngier:
> > The ARMv8.2 based CPUs used in a number of Rockchip SoCs are missing
> > the EL2 virtual timer interrupt. Add it.
>=20
> the message talks about "a number of Rockchip SoCs", but below there are
> only the rk3566/rk3568 variants? Or does it just mean the two?

I have no idea how many Socs are covered by the 'x' in the filename,
and I can't say I looked too hard -- I simply checked that whichever
file was including this one was describing CPUs that were guaranteed
to implement this timer.

>=20
> In any case,
>=20
> Acked-by: Heiko Stuebner <heiko@sntech.de>

Thanks!

	M.

--=20
Without deviation from the norm, progress is not possible.
