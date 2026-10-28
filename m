Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793176250;
	b=dQa+T0fVGtVJCySOP9dbgSY6CsN1FrHl3WJuEMvSJEIl3DuOAdGdDnxiLDY+E3mliPH5
	 Rl2kKXnZo5t/fU9f8oewmYswqqMrzi7zobQKIzmE6Mycr0VkHmNTea2dZVWCQ7OpjVQL5
	 NNEOQ73iVKNQSro2pu1BC3ZQMn22dG/F8noqbfQdKvcUcpGEXh0eiuSqolUWHw/XAq+MI
	 jIlfAI2Q2GVjYOnpx6pQrwx6UXMGUw9hBMfFzzelfJfmT/e1c5y8G2Wsg3UyZleUCMfo+
	 c+FF/CgRGnR/fM777hgKxTEzc29UNz8XrsyHK41PX7kLPwlKU1OsJn5hZLNhuEyL6xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793176250;
	h=Received:DKIM-Signature:Received:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 X-SA-Exim-Connect-IP:X-SA-Exim-Rcpt-To:X-SA-Exim-Mail-From:
	 X-SA-Exim-Scanned;
	bh=deVCSELJSTG0pd+EM+rjRQ7hOaUOrSc78SkOky98FUc=;
	b=fGnku3jvzzeENEJ16vSyKptwHpJoEW+FSX5yHx+NOLf9D3qRr7lu0AqBi5Wl6Cr7PfdK
	 w0AHw0CiM7zbTH2IC26I1PPhp0H8ubz8xDBQzy4x/P3lJ1NkuSIR3fK0CFycNZd5Of1Tv
	 gdeNezTvnxy1P2V/SlRLxAVk1SCVcTyXnIdtS7eHnvg/qvp77kOHHKX0SpO927BXh3bPc
	 CJnZ7ZC8uLRQfh2c+nQ9DabEOxF/5xh49+2Hd59O5etgBe9SAY9tOI4jffQp9RdeVN1H4
	 EBF/yuSEAuQjwzxz8kwoWuz6fmsKOdoX7wiBN0Z7K+qfgPGCiiGfj9kDT7thMZ6ALYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TNjTyPJg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02498606A322;
	Wed, 28 Oct 2026 08:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TNjTyPJg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73F001F01828;
	Wed, 28 Oct 2026 08:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793176249;
	bh=deVCSELJSTG0pd+EM+rjRQ7hOaUOrSc78SkOky98FUc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=TNjTyPJg3lci+OUjJyMViGgrE20q+380VaIi/CjYpQC5o1z374RZYPIPJ2yqfkmlc
	 wd/5pegliCO7WJEuzx92GR+l88DrtSYp2dHqxji4fSBDa2DOPlIVoYfkdFljJsGsGj
	 RauydhoVuFTnr+U8undTXnS4ooc7PY3Y4V2QKYYb1Km7ZBiEu/3KILlqZXx8h9SBUa
	 wqncL/Ifbwn8+UH6GK6tJZT4Y5ykMs96wfQ5GziCl9AQh8mD82ULk1rdaeiBezH82v
	 ajMWCuPnQgnTkxrFULW89bBYV6JBAMb3m5I8Gn/Gstgx/2ZralIoODEG18z5Mnbes5
	 j7dlsBVrO1IfQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1xLz3X-0000000827d-0FRF;
	Wed, 28 Oct 2026 08:30:47 +0000
Date: Wed, 28 Oct 2026 08:30:46 +0000
Message-ID: <86pkwuxm4p.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Tim Pambor <timpambor@gmail.com>
Cc: Frank.Li@nxp.com,
	afaerber@suse.de,
	alim.akhtar@samsung.com,
	andersson@kernel.org,
	angelogioacchino.delregno@collabora.com,
	baolin.wang@linux.alibaba.com,
	bst-upstream@bstai.top,
	catalin.marinas@arm.com,
	conor+dt@kernel.org,
	daniel.lezcano@kernel.org,
	devicetree@vger.kernel.org,
	dinguyen@kernel.org,
	eleanor.lin@realtek.com,
	festevam@gmail.com,
	gordon.ge@bst.ai,
	guohanjun@huawei.com,
	heiko@sntech.de,
	ivo.ivanov.ivanov1@gmail.com,
	jbrunet@baylibre.com,
	jernej.skrabec@gmail.com,
	jesper.nilsson@axis.com,
	jonathanh@nvidia.com,
	kernel@pengutronix.de,
	khilman@baylibre.com,
	konradybcio@kernel.org,
	krzk+dt@kernel.org,
	lars.persson@axis.com,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	lpieralisi@kernel.org,
	mark.rutland@arm.com,
	martin.blumenstingl@googlemail.com,
	matthias.bgg@gmail.com,
	michal.simek@amd.com,
	neil.armstrong@linaro.org,
	orsonzhai@gmail.com,
	rafael@kernel.org,
	robh@kernel.org,
	s.hauer@pengutronix.de,
	samuel@sholland.org,
	shawn.lin@rock-chips.com,
	sudeep.holla@kernel.org,
	tglx@kernel.org,
	thierry.reding@kernel.org,
	wens@kernel.org,
	will@kernel.org
Subject: Re: [PATCH v3 11/17] arm64: dts: mediatek: Add EL2 virtual timer interrupt
In-Reply-To: <20261028081716.75598-1-timpambor@gmail.com>
References: <20260523140242.586031-12-maz@kernel.org>
	<20261028081716.75598-1-timpambor@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/30.1
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: timpambor@gmail.com, Frank.Li@nxp.com, afaerber@suse.de, alim.akhtar@samsung.com, andersson@kernel.org, angelogioacchino.delregno@collabora.com, baolin.wang@linux.alibaba.com, bst-upstream@bstai.top, catalin.marinas@arm.com, conor+dt@kernel.org, daniel.lezcano@kernel.org, devicetree@vger.kernel.org, dinguyen@kernel.org, eleanor.lin@realtek.com, festevam@gmail.com, gordon.ge@bst.ai, guohanjun@huawei.com, heiko@sntech.de, ivo.ivanov.ivanov1@gmail.com, jbrunet@baylibre.com, jernej.skrabec@gmail.com, jesper.nilsson@axis.com, jonathanh@nvidia.com, kernel@pengutronix.de, khilman@baylibre.com, konradybcio@kernel.org, krzk+dt@kernel.org, lars.persson@axis.com, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, lpieralisi@kernel.org, mark.rutland@arm.com, martin.blumenstingl@googlemail.com, matthias.bgg@gmail.com, michal.simek@amd.com, neil.armstrong@linaro.org, orsonzhai@gmail.com, rafael@kernel.org, robh@kernel.org, s.hauer@pen
 gutronix.de, samuel@sholland.org, shawn.lin@rock-chips.com, sudeep.holla@kernel.org, tglx@kernel.org, thierry.reding@kernel.org, wens@kernel.org, will@kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Wed, 28 Oct 2026 08:17:16 +0000,
Tim Pambor <timpambor@gmail.com> wrote:
> 
> On Sat, 23 May 2026 15:02:36 +0100, Marc Zyngier wrote:
> > The ARMv8.1+ based CPUs used in a number of Mediatek SoCs are missing
> > the EL2 virtual timer interrupt. Add it.
> 
> This patch doesn't seem to have been applied along with the rest of
> the series.

That's the SoC maintainers' responsibility. I only look after the
driver code, and rely on people spotting the warning! ;-) The fact
that this has been there for two kernel releases show you how deeply
these maintainers care.

> After updating to v7.2.11 on an MT8195 board I see:
> 
>   arch_timer: [Firmware Bug]: VHE-capable CPU without EL2 virtual timer interrupt
> 
> With this patch applied, the warning is gone and the EL2 virtual timer
> is used as expected:
> 
>   arch_timer: cp15 timer running at 13.00MHz (hyp-virt).
> 
> Reviewed-by: Tim Pambor <timpambor@gmail.com>
> Tested-by: Tim Pambor <timpambor@gmail.com>

Thanks!

	M.

-- 
Without deviation from the norm, progress is not possible.
