Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E66F1D5ADE;
	Thu,  7 May 2026 15:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778168018; cv=none; b=FIQv0hpKkjD4w16j3EEMnHtjF3vDJyG8fkqyiUi3OGmqri+Z33V4T69LPewMM0TZ6GrGjsIJJkJWiqM/pbWm0/hlQdoAbEGjyyT3dj5lAyCU55NZJrFpsY6wq2dbZsSIYXNKpDBYldDCNqowrvvtBEQeSFIiw9aAiK7fIcEdlxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778168018; c=relaxed/simple;
	bh=kAu/W2I9QdHDrOLadXDSsFBkTXGezYlr+EnvbY6lPCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZT2IJ/eXwQE2HalefDz9QTIDktMjbW4n2D03wxJLbe4MlO8gfnSev5c1BIdboIkzR0MQjJmgTCqTOE9aUJxD7962ss9fCnZN0cIvsB7Q2FNcZg1DdAO78hGfonFZ/KVJPd3btKbzi/WNNJ47zFl+q6zF99lT8uxtPaBE+b9kjRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=X7UI+Un8; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="X7UI+Un8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=cOD4Np7AR9NQ99u5GpEocII+aaQrDoLEf6upGxDV54s=; b=X7UI+Un8MDFakaAervt8AlG9YA
	razc3PGaN9CtUOxBte23BtvgSjlTX8TakeG+PArz2Q16+JCafKkDHKQ6YvfJLSp1R9XwedlDiHHd5
	JxXNA0h8xZxmHgrrYuub4PD+qFLHbc/bGHDeRv1u3ET6/Ye8CLEQ8lWkTjhS+feBidMqxZJ6abFsc
	EUPRmVjyiJ3xx4InGpIlYe6UzefNt1jJyQIAdg5ymX9AWPNn/2EE2BCKUxFQBqmCyvlNDmzD06qAx
	wnufHN2iYXm9dVnWOK45EUAKuFi4PtWtk73X9Xbp+MEMphjy+AyOuc4gWjbn7IyFWg6ZGFbSJMQVG
	TXord53w==;
From: Heiko Stuebner <heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Marc Zyngier <maz@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Ge Gordon <gordon.ge@bst.ai>,
 BST Linux Kernel Upstream Group <bst-upstream@bstai.top>,
 Jesper Nilsson <jesper.nilsson@axis.com>,
 Lars Persson <lars.persson@axis.com>, Alim Akhtar <alim.akhtar@samsung.com>,
 Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Dinh Nguyen <dinguyen@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Andreas =?UTF-8?B?RsOkcmJlcg==?= <afaerber@suse.de>,
 Shawn Lin <shawn.lin@rock-chips.com>, Orson Zhai <orsonzhai@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Michal Simek <michal.simek@amd.com>
Subject:
 Re: [PATCH 14/16] arm64: dts: rockchip: Add EL2 virtual timer interrupt
Date: Thu, 07 May 2026 17:33:21 +0200
Message-ID: <3690258.8hzESeGDPO@phil>
In-Reply-To: <20260507125544.2903406-15-maz@kernel.org>
References:
 <20260507125544.2903406-1-maz@kernel.org>
 <20260507125544.2903406-15-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi Mark,

Am Donnerstag, 7. Mai 2026, 14:55:42 Mitteleurop=C3=A4ische Sommerzeit schr=
ieb Marc Zyngier:
> The ARMv8.2 based CPUs used in a number of Rockchip SoCs are missing
> the EL2 virtual timer interrupt. Add it.

the message talks about "a number of Rockchip SoCs", but below there are
only the rk3566/rk3568 variants? Or does it just mean the two?

In any case,

Acked-by: Heiko Stuebner <heiko@sntech.de>




>=20
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  arch/arm64/boot/dts/rockchip/rk356x-base.dtsi | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi b/arch/arm64/b=
oot/dts/rockchip/rk356x-base.dtsi
> index 64bdd8b7754b5..a5832895bd392 100644
> --- a/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
> @@ -195,7 +195,8 @@ timer {
>  		interrupts =3D <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH>,
>  			     <GIC_PPI 14 IRQ_TYPE_LEVEL_HIGH>,
>  			     <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH>,
> -			     <GIC_PPI 10 IRQ_TYPE_LEVEL_HIGH>;
> +			     <GIC_PPI 10 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_PPI 12 IRQ_TYPE_LEVEL_HIGH>;
>  		arm,no-tick-in-suspend;
>  	};
> =20
>=20




