Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F7047DD54;
	Fri, 15 May 2026 11:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778844234; cv=none; b=YyP8kKmH0Bkk/mLbhIzzNgYok/jwnFB4fcEIBXVGXM22YqKLYnv+jsfZIienQci/r1/0tX5wWwtiJKujw9fmfYL9Pw8h0OS/Y22HdB0/LEYxh76JvrqKSmvh6q/CfSl+u7xMfLBZkULNROyNSU2zi3OUat4tHJlKi1wr6MH0R8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778844234; c=relaxed/simple;
	bh=RfvEIH27XbfkXelKur8wpmPTV9lL60amly3Ft8vOuPw=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tHj7fTaKsNNiRkUgoIbSliDrF6QrcPbUkdsl0do59BueMvdb+Wl7G7boINqvXqYVnuVOainU66aVOpHjaJQEQEHXOl3YqkBUqXGgyPmTWyKwxp6N7stvpDs7I4BMltIE6hln2A66LDydeCBe3JRIQxWB3qIw99QfbIGN+9ExU0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XfRO/6lp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XfRO/6lp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B346C2BCFB;
	Fri, 15 May 2026 11:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778844234;
	bh=RfvEIH27XbfkXelKur8wpmPTV9lL60amly3Ft8vOuPw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XfRO/6lpxRvh1wj24HKBqCVJd20etFi1V7RGHbFcgIjUPDcvyiBkkSzRNDvfs6QCj
	 KdcpRrVOCwRiAjGC3XZwPafav7UbgN9eh+cxVeDIlH89sLlhxbWoodnhh9fUGgjizI
	 E2aWJObp/4Ch7nenpOLniSdcutNBkmZYdRD9tQwLiyyH3b2aCAg72L5/N26HiNdg/p
	 atrBeb5BnOwl7k6HNQVKoYO/XGoZqvtrmuCUvrEFmfZGDz9JsUikEn+15lE+CencMS
	 KT6KIsa2+OQaSTGbaZwN2qMxqnMEWy50JhhadD/x+lhTDoF9V7MGrDpekj+x276mPP
	 9MT0pJYVmvpLQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1wNqdz-00000002fk3-0CJC;
	Fri, 15 May 2026 11:23:51 +0000
Date: Fri, 15 May 2026 12:23:50 +0100
Message-ID: <864ik8ykzd.wl-maz@kernel.org>
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
Subject: Re: [PATCH v2 01/17] ACPI: GTDT: Account for GTDTv3 size when walking the platform timer descriptors
In-Reply-To: <20260515-prudent-vagabond-beetle-cad34b@sudeepholla>
References: <20260514150945.3917510-1-maz@kernel.org>
	<20260514150945.3917510-2-maz@kernel.org>
	<20260515-prudent-vagabond-beetle-cad34b@sudeepholla>
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
X-SA-Exim-Rcpt-To: sudeep.holla@kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, lpieralisi@kernel.org, guohanjun@huawei.com, catalin.marinas@arm.com, will@kernel.org, rafael@kernel.org, mark.rutland@arm.com, daniel.lezcano@kernel.org, tglx@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, wens@kernel.org, jernej.skrabec@gmail.com, samuel@sholland.org, neil.armstrong@linaro.org, khilman@baylibre.com, jbrunet@baylibre.com, martin.blumenstingl@googlemail.com, gordon.ge@bst.ai, bst-upstream@bstai.top, jesper.nilsson@axis.com, lars.persson@axis.com, alim.akhtar@samsung.com, ivo.ivanov.ivanov1@gmail.com, Frank.Li@nxp.com, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, dinguyen@kernel.org, matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, thierry.reding@kernel.org, jonathanh@nvidia.com, andersson@kernel.org, konradybcio@kernel.org, afaerber@suse.de, heiko@sntech.de, shawn.lin@rock-chips.com, orsonzhai@gmail.com, baolin.wang@linux.alibaba.com, michal.simek@amd.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Fri, 15 May 2026 10:51:52 +0100,
Sudeep Holla <sudeep.holla@kernel.org> wrote:
>=20
> On Thu, May 14, 2026 at 04:09:29PM +0100, Marc Zyngier wrote:
> > Since ARMv8.1, the architecture has grown an EL2-private virtual
> > timer. This has been described in ACPI since ACPI v6.3 and revision
> > 3 of the GTDT table.
> >=20
> > An aditional structure was added in ACPICA, though in a rather
> > bizarre way, and merged in v5.1 as 8f5a14d053100 ("ACPICA: ACPI 6.3:
> > add GTDT Revision 3 support").
> >=20
> > Finally plug the table parsing in GTDT, and correct the parsing of
> > the platform timer subtables to account for the expanded size of
> > the base table.
> >=20
> > Suggested-by: Sudeep Holla <sudeep.holla@kernel.org>
> > Signed-off-by: Marc Zyngier <maz@kernel.org>
> > ---
> >  drivers/acpi/arm64/gtdt.c | 15 ++++++++++++++-
> >  1 file changed, 14 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/acpi/arm64/gtdt.c b/drivers/acpi/arm64/gtdt.c
> > index ffc867bac2d60..b9d9b8edf2df7 100644
> > --- a/drivers/acpi/arm64/gtdt.c
> > +++ b/drivers/acpi/arm64/gtdt.c
> > @@ -32,6 +32,12 @@ struct acpi_gtdt_descriptor {
> >  	struct acpi_table_gtdt *gtdt;
> >  	void *gtdt_end;
> >  	void *platform_timer;
> > +	bool v3;
> > +};
> > +
> > +struct gtdt_v3 {
> > +	struct acpi_table_gtdt	gtdt_v2;
> > +	struct acpi_gtdt_el2	el2_vtimer;
> >  };
> > =20
> >  static struct acpi_gtdt_descriptor acpi_gtdt_desc __initdata;
> > @@ -39,8 +45,14 @@ static struct acpi_gtdt_descriptor acpi_gtdt_desc __=
initdata;
> >  static __init bool platform_timer_valid(void *platform_timer)
> >  {
> >  	struct acpi_gtdt_header *gh =3D platform_timer;
> > +	void *platform_timer_begin;
> > +
> > +	if (acpi_gtdt_desc.v3)
> > +		platform_timer_begin =3D container_of(acpi_gtdt_desc.gtdt, struct gt=
dt_v3, gtdt_v2) + 1;
> > +	else
> > +		platform_timer_begin =3D acpi_gtdt_desc.gtdt + 1;
> >
> > -	return (platform_timer >=3D (void *)(acpi_gtdt_desc.gtdt + 1) &&
> > +	return (platform_timer >=3D platform_timer_begin &&
> >  		platform_timer < acpi_gtdt_desc.gtdt_end &&
> >  		gh->length !=3D 0 &&
> >  		platform_timer + gh->length <=3D acpi_gtdt_desc.gtdt_end);
> > @@ -169,6 +181,7 @@ int __init acpi_gtdt_init(struct acpi_table_header =
*table,
> >  	acpi_gtdt_desc.gtdt =3D gtdt;
> >  	acpi_gtdt_desc.gtdt_end =3D (void *)table + table->length;
> >  	acpi_gtdt_desc.platform_timer =3D NULL;
> > +	acpi_gtdt_desc.v3 =3D gtdt->header.revision >=3D 3 && gtdt->header.le=
ngth >=3D sizeof(struct gtdt_v3);
>=20
> Regarding Sashiko=E2=80=99s comment about the missing length validation f=
or GTDT v2, I
> realised that the current check could cause a malformed v3 table to be
> interpreted as v2 if its length does not match the expected v3
> length.

Yeah, that's overall dodgy. As much as I hate having to write a
validating parser for ACPI, we need to be prepared for the worst.

> It would be better to fail early and return an error rather than allow
> processing to continue with the table incorrectly interpreted as v2.

How about something like the hack below?

Thanks,

	M.

diff --git a/drivers/acpi/arm64/gtdt.c b/drivers/acpi/arm64/gtdt.c
index 12bc8875e95e2..ceec69609f038 100644
--- a/drivers/acpi/arm64/gtdt.c
+++ b/drivers/acpi/arm64/gtdt.c
@@ -202,7 +202,15 @@ int __init acpi_gtdt_init(struct acpi_table_header *ta=
ble,
 	acpi_gtdt_desc.gtdt =3D gtdt;
 	acpi_gtdt_desc.gtdt_end =3D (void *)table + table->length;
 	acpi_gtdt_desc.platform_timer =3D NULL;
-	acpi_gtdt_desc.v3 =3D gtdt->header.revision >=3D 3 && gtdt->header.length=
 >=3D sizeof(struct gtdt_v3);
+
+	if ((gtdt->header.revision >=3D 3 && gtdt->header.length < sizeof(struct =
gtdt_v3)) ||
+	    (gtdt->header.revision =3D=3D 2 && gtdt->header.length < sizeof(*gtdt=
))) {
+		pr_err(FW_BUG "GTDT with invalid size %d\n", gtdt->header.length);
+		return -EINVAL;
+	}
+
+	acpi_gtdt_desc.v3 =3D gtdt->header.revision >=3D 3;
+
 	if (platform_timer_count)
 		*platform_timer_count =3D 0;
=20

--=20
Without deviation from the norm, progress is not possible.
