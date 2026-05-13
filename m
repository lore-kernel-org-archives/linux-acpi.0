Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927E93909AC;
	Wed, 13 May 2026 12:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778674800; cv=none; b=cHDp5h65hlETAnxMMhIXRGMC+EYG6Z2MrWJz2Faxb40zh09cy/3aRYaqFvwDE3z17QfW/iB832jejdhPD+ALg00YAGLaNzMwjNGCtxNZMKYvisDI23cczl0HsrH+V3wUmnsaVaEXhdWAOglNK5YhI39AbH7Qgh2OvQhCIlO1ivQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778674800; c=relaxed/simple;
	bh=RwG6QV1m/Cl64DkSBJyEOa248vAgjawUEC0CfydbuI0=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VFpqn59A63UaGFME4YyfVQURyJQWtthaFYSHTaOz3TdzugA+zBfBjmGbnnmUbcwMPqJ4zN+qNfwGewD2NMgzTMC/nLUx7v/Fu70lJmhPfGLHhbhfnR/NJnwIwWuUXQtIsC3BtfvhRb84etqE86ABnVAK5ulsDuy1rglraIE2FkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RbIBiMeD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RbIBiMeD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24EC3C2BCB7;
	Wed, 13 May 2026 12:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778674800;
	bh=RwG6QV1m/Cl64DkSBJyEOa248vAgjawUEC0CfydbuI0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RbIBiMeDhOnccxwTUphmUO35kX6bx6hVsB/D5hQK8aesbu38+fuMnEByBng/Hyxbo
	 O3b8p5Z9rVFjJ4hvL17uP5wCBNxDHUDcpNGT6BVXfwQ0gQXh+GSETlOy3tJsBjiK3x
	 e+mHiKWDlmUyzc050Z8A6sYCu9oV73L9eLZ8JLhj/1zvMBloVEKiUqEYlFzIe6u83v
	 wpOVMnXk099JAcxBkZkjTK5so6CLwmkzKbOjb86U+TbaKTSkQk3P6j2ByniLE+Ji7s
	 ZYNJX6wYCZ6qbQmDfwzaML1fxzCmiIlh5MoABEB9HOvIcWtX1IqUmSIa8QSzFKzpfO
	 7VM5juEM6Qa9g==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1wN8ZB-00000001y2O-1eZP;
	Wed, 13 May 2026 12:19:57 +0000
Date: Wed, 13 May 2026 13:19:56 +0100
Message-ID: <86ecjfy00j.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Sudeep Holla <sudeep.holla@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,	devicetree@vger.kernel.org,	Lorenzo Pieralisi
 <lpieralisi@kernel.org>,	Hanjun Guo <guohanjun@huawei.com>,	Catalin
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
Subject: Re: [PATCH 01/16] ACPI: GTDT: Parse information related to the EL2 virtual timer
In-Reply-To: <20260513-crouching-stirring-pigeon-6e46bf@sudeepholla>
References: <20260507125544.2903406-1-maz@kernel.org>
	<20260507125544.2903406-2-maz@kernel.org>
	<20260513-crouching-stirring-pigeon-6e46bf@sudeepholla>
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
X-SA-Exim-Rcpt-To: sudeep.holla@kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, lpieralisi@kernel.org, guohanjun@huawei.com, catalin.marinas@arm.com, will@kernel.org, rafael@kernel.org, mark.rutland@arm.com, daniel.lezcano@kernel.org, tglx@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, wens@kernel.org, jernej.skrabec@gmail.com, samuel@sholland.org, neil.armstrong@linaro.org, khilman@baylibre.com, jbrunet@baylibre.com, martin.blumenstingl@googlemail.com, gordon.ge@bst.ai, bst-upstream@bstai.top, jesper.nilsson@axis.com, lars.persson@axis.com, alim.akhtar@samsung.com, ivo.ivanov.ivanov1@gmail.com, Frank.Li@nxp.com, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, dinguyen@kernel.org, matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, thierry.reding@kernel.org, jonathanh@nvidia.com, andersson@kernel.org, konradybcio@kernel.org, afaerber@suse.de, heiko@sntech.de, shawn.lin@rock-chips.com, orsonzhai@gmail.com, baolin.wang@linux.alibaba.com, michal.simek@amd.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

Hi Sudeep,

On Wed, 13 May 2026 10:41:51 +0100,
Sudeep Holla <sudeep.holla@kernel.org> wrote:
> 
> On Thu, May 07, 2026 at 01:55:29PM +0100, Marc Zyngier wrote:
> > Since ARMv8.1, the architecture has grown an EL2-private virtual
> > timer. This has been described in ACPI since ACPI v6.3 and revision
> > 3 of the GTDT table.
> > 
> > An aditional structure was added in ACPICA, though in a rather
> > bizarre way, and merged in v5.1 as 8f5a14d053100 ("ACPICA: ACPI 6.3:
> > add GTDT Revision 3 support").
> > 
> > Finally plug the table parsing in GTDT, and allow it to be eventually
> > presented to the architected timer driver.
> > 
> > Signed-off-by: Marc Zyngier <maz@kernel.org>
> > ---
> >  drivers/acpi/arm64/gtdt.c | 25 +++++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> > 
> > diff --git a/drivers/acpi/arm64/gtdt.c b/drivers/acpi/arm64/gtdt.c
> > index ffc867bac2d60..1a58007fccf0a 100644
> > --- a/drivers/acpi/arm64/gtdt.c
> > +++ b/drivers/acpi/arm64/gtdt.c
> > @@ -88,6 +88,19 @@ static int __init map_gt_gsi(u32 interrupt, u32 flags)
> >  	return acpi_register_gsi(NULL, interrupt, trigger, polarity);
> >  }
> >  
> > +struct gtdt_v3 {
> > +	struct acpi_table_gtdt	gtdt_v2;
> > +	struct acpi_gtdt_el2	el2_vtimer;
> > +};
> > +
> > +static struct acpi_gtdt_el2 *gtdt_to_el2_vtimer(struct acpi_table_gtdt *gtdt)
> > +{
> > +	if (gtdt->header.revision < 3)
> > +		return NULL;
> > +
> 
> We should validate the length as well just in case some platform bumped version
> but didn't add these fields. Again it is problem if the platform timers are
> also missing. We can just add the check in acpi_gtdt_init() if the version >=3
> perhaps? If (gtdt->header.length < sizeof(struct gtdt_v3) invalid table or
> something.

Yeah, that seems like a valuable thing to do.
>
> Also we have in platform_timer_valid()
> 	platform_timer >= (void *)(acpi_gtdt_desc.gtdt + 1)
> which is still valid, but again if someone messes up in v3 keeping
> offset where virtual EL2 timer GSI should be present as they just copied
> it from v2, then we might allow it as valid.
> 
> Do it make sense to add that check as well in acpi_gtdt_init()? I mean
> the offset should be >= sizeof(struct gtdt_v3).
> 
> Both checks can be added to acpi_gtdt_init() to avoid checking for each
> platform timer instance may be ?

That makes some sense to me.

What I'll do is introduce gtdt_v3 in a first patch, making sure that
the parser is correctly handling the difference (pointer arithmetic
and such), and then add the virtual timer interrupt handling in a
subsequent change.

> 
> Other than this couple of minor nit, this patch looks fine.
> 
> Reviewed-by: Sudeep Holla <sudeep.holla@kernel.org>

Thanks for having had a look!

	M.

-- 
Without deviation from the norm, progress is not possible.
