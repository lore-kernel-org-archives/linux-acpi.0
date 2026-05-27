Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B155E3B5847;
	Wed, 27 May 2026 07:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779865551; cv=none; b=S3ky3GgbBepybKPR3iEgtkNinBWBHgn6rcU6nLmqOofqFbyecc64TrhzJ8TQPaWpZ1HvwrIbU8nORqPkkaYS1HqOSDCypHEq1vJDbtIsR2+7F9E1R3xrnxC4pTTyhKypiYPi3G4NsioeZwzVVibHoB176bxJxFBi9ooTo7j8GOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779865551; c=relaxed/simple;
	bh=3ttHPNyVPUXisL9InocA5CVFySlyMeRG6gV4SdFU9kg=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Be3oAXroQ6TJF98TfEvBRhYN8rraC+TYLP+9oXhLkR++tToZSxIXctLgRxm/TVTu0sr5tX5J2dhPjXIBGsVZeoRSzhsm/L55JLAjIbgjjtZGTumsKz1eBujJbw9zP0iLama5cUfQdOlDKgGuzg1dUDVKs61ze76PGrxQnZrKvGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YVqCMYTj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YVqCMYTj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 884AE1F000E9;
	Wed, 27 May 2026 07:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779865550;
	bh=oRExL8R0TDTPZxJJpPqHUXVby4f6YAO2qb7hjquP+p8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YVqCMYTjN4Kox1nNd46c71wRvFF8zrujxrCB8TVd3N+Eziybit+gOrLgjrkps811s
	 mQq2yh4z5MmvoM0jSyYYXe17MJM7Oieu5HQquF6K4RdlZQMkLs1OmJ0i4JMAKHhTIQ
	 4ouLpKjNBpRzju2+FmEHCxKQi/50WGOr3T8xYa3K1ax3OQLtYrPf4keaXrGuSV3HIL
	 1bARg1krjZ542hrl0dznJwrFSFzKIcKBdrbxBrypYQdHOlaqMSZairU758KsOUC0ay
	 clGsEG6pzeyVyrhI8q7wAG/2QC6F8xbvqjX85BF1w9l501TyZEmP54YtDaiI8RrFiz
	 I0m3LXNfWbgmA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1wS8Kp-00000006Z4t-3NSY;
	Wed, 27 May 2026 07:05:47 +0000
Date: Wed, 27 May 2026 08:05:46 +0100
Message-ID: <86tsrtuyb9.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: =?UTF-8?B?Ill1LUNodW4gTGluIFvmnpfnpZDlkJtdIg==?=
 <eleanor.lin@realtek.com>
Cc: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,	"linux-acpi@vger.kernel.org"
 <linux-acpi@vger.kernel.org>,	"linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>,	"devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>,	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,	Sudeep Holla <sudeep.holla@kernel.org>,
	"Catalin\ Marinas" <catalin.marinas@arm.com>,	Will Deacon
 <will@kernel.org>,	"Rafael J.\ Wysocki" <rafael@kernel.org>,	Mark Rutland
 <mark.rutland@arm.com>,	"Daniel\ Lezcano" <daniel.lezcano@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,	"Rob\ Herring" <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,	"Conor\ Dooley"
 <conor+dt@kernel.org>,	Chen-Yu Tsai <wens@kernel.org>,	Jernej Skrabec
 <jernej.skrabec@gmail.com>,	Samuel Holland <samuel@sholland.org>,
	"Neil\ Armstrong" <neil.armstrong@linaro.org>,	Kevin Hilman
 <khilman@baylibre.com>,	Jerome Brunet <jbrunet@baylibre.com>,	Martin
 Blumenstingl <martin.blumenstingl@googlemail.com>,	Ge Gordon
 <gordon.ge@bst.ai>,	"BST\ Linux Kernel Upstream Group"
 <bst-upstream@bstai.top>,	Jesper Nilsson <jesper.nilsson@axis.com>,	Lars
 Persson <lars.persson@axis.com>,	Alim Akhtar <alim.akhtar@samsung.com>,
	Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>,	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,	Pengutronix Kernel Team
 <kernel@pengutronix.de>,	Fabio Estevam <festevam@gmail.com>,	Dinh Nguyen
 <dinguyen@kernel.org>,	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Thierry Reding <thierry.reding@kernel.org>,	Jonathan Hunter
 <jonathanh@nvidia.com>,	"Bjorn\ Andersson" <andersson@kernel.org>,	Konrad
 Dybcio <konradybcio@kernel.org>,	Andreas =?UTF-8?B?RsOkcmJlcg==?=
 <afaerber@suse.de>,	Heiko Stuebner <heiko@sntech.de>,	Shawn Lin
 <shawn.lin@rock-chips.com>,	Orson Zhai <orsonzhai@gmail.com>,	Baolin Wang
 <baolin.wang@linux.alibaba.com>,	"Michal\ Simek" <michal.simek@amd.com>
Subject: Re: [PATCH v3 14/17] arm64: dts: realtek: Add EL2 virtual timer interrupt
In-Reply-To: <6fe3e828f8724424bc6aef818ae0aa0f@realtek.com>
References: <20260523140242.586031-1-maz@kernel.org>
	<20260523140242.586031-15-maz@kernel.org>
	<6fe3e828f8724424bc6aef818ae0aa0f@realtek.com>
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
X-SA-Exim-Rcpt-To: eleanor.lin@realtek.com, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, lpieralisi@kernel.org, guohanjun@huawei.com, sudeep.holla@kernel.org, catalin.marinas@arm.com, will@kernel.org, rafael@kernel.org, mark.rutland@arm.com, daniel.lezcano@kernel.org, tglx@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, wens@kernel.org, jernej.skrabec@gmail.com, samuel@sholland.org, neil.armstrong@linaro.org, khilman@baylibre.com, jbrunet@baylibre.com, martin.blumenstingl@googlemail.com, gordon.ge@bst.ai, bst-upstream@bstai.top, jesper.nilsson@axis.com, lars.persson@axis.com, alim.akhtar@samsung.com, ivo.ivanov.ivanov1@gmail.com, Frank.Li@nxp.com, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, dinguyen@kernel.org, matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, thierry.reding@kernel.org, jonathanh@nvidia.com, andersson@kernel.org, konradybcio@kerne
 l.org, afaerber@suse.de, heiko@sntech.de, shawn.lin@rock-chips.com, orsonzhai@gmail.com, baolin.wang@linux.alibaba.com, michal.simek@amd.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Wed, 27 May 2026 07:36:18 +0100,
"Yu-Chun Lin [=E6=9E=97=E7=A5=90=E5=90=9B]" <eleanor.lin@realtek.com> wrote:
>=20
> > Subject: [PATCH v3 14/17] arm64: dts: realtek: Add EL2 virtual timer in=
terrupt
> >=20
> > The ARMv8.2 based CPUs used in a number of Realtek SoCs are missing the
> > EL2 virtual timer interrupt. Add it.
> >=20
> > Furthermore, the "kent" platform appears to assign PPI9 to both the
> > EL2 virtual timer and the GIC Maintenance Interrupt, which can't be rig=
ht.
> > Attempt a fix by setting the former to PPI12, as PPI9 is traditionally =
wired to
> > the GIC itself.
> >=20
> > Signed-off-by: Marc Zyngier <maz@kernel.org>
> > ---
> >  arch/arm64/boot/dts/realtek/kent.dtsi    | 2 +-
> >  arch/arm64/boot/dts/realtek/rtd16xx.dtsi | 3 ++-
> >  2 files changed, 3 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/arch/arm64/boot/dts/realtek/kent.dtsi
> > b/arch/arm64/boot/dts/realtek/kent.dtsi
> > index ae006ce244205..4147e4269247a 100644
> > --- a/arch/arm64/boot/dts/realtek/kent.dtsi
> > +++ b/arch/arm64/boot/dts/realtek/kent.dtsi
> > @@ -23,7 +23,7 @@ timer {
> >                              <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
> >                              <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
> >                              <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>,
> > -                            <GIC_PPI  9 IRQ_TYPE_LEVEL_HIGH>;
> > +                            <GIC_PPI 12 IRQ_TYPE_LEVEL_HIGH>;
>=20
> Thanks for this patch. However, the 5th interrupt should be
>=20
> <GIC_PPI 12 IRQ_TYPE_LEVEL_LOW>;

I suspected as much, but it was hard to know exactly how wrong the
original descriptor was, so I decided to change as little as
possible. It has no material impact on the interrupt, as the GIC has
no way to distinguish LEVEL_HIGH from LEVEL_LOW (it only distinguishes
between LEVEL and EDGE). So this only serves as documentation.

>=20
> If you are ok with it, I will amend it when applying.

Please go ahead.

Thanks,

	M.

--=20
Without deviation from the norm, progress is not possible.
