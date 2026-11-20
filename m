Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795187689;
	b=i8Ko2YhJBRv2Khli4BqfM9rytPvYjhWdey1dUN96vLUOYZlG3ZQ3TXPJKm5e0X6RofH0
	 aP2lSYbuFqVPxZOYITtY/bHeTHZiLeA6GIZzevi2gbY4VAvoMAfGdvIg1BYSSWFAlhPNR
	 GqathTZ7fni7tslexGan+6M90XNOEeCUDdZ1Yi3Yfvsfk1AkNnTwUUxbmYgF0GcdTQMfp
	 SVI7S9dfhO5PCEyGdZkqcVZmpnKYJbroX4soIPWWaoCLKbSN6/ItOiBft8nrgZKKNYyC0
	 WTuyhtdEQXp8rNA/zqPuFyQC5L8RQbzWOVOjogWH4b0zgGtItKz8fLFb4toAguf90rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795187689;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Message-ID:
	 Subject:From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version:
	 X-Last-TLS-Session-Version;
	bh=c4Z9yGuax/8NR1BznxmdHxIivPIjV06ghC9n97sXVMc=;
	b=KyyDYQsH07GrgOTSGdXnwJ6vDWUE8u/OH+5/y+9t9SroTV7lzC7ZvkJ5ybqeHudKmapf
	 2dzHYVTHltkvmuFpcWLmXtcZfD9BAhnzRKV5ENIMzJoO45UPmwdb8uQJhBDkAl1AcDDM2
	 /ygkokcPsNYQDZrWyM6YYrmFND9kS+E8/MsnuyNO+tZvcDQCshhDWOGgVMeYN/zla6jaI
	 gFjLqKEUR4Jq20STGzpTLeOytaPnzdJwArF8BawwXIJdacOA5E3lMTyDswRO61taE6C1f
	 Er4iMKvkPGR6v4MfERyRlesLm4AOXIH/23YV47UVidt3tMj84Atw2fWLQXXrnHPpiWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=qP3K5iFW;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3981D606A32A;
	Fri, 20 Nov 2026 15:14:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3981D606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=qP3K5iFW
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 95F0E1A1739;
	Fri, 20 Nov 2026 15:14:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 64637601B9;
	Fri, 20 Nov 2026 15:14:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7CCA511BC0335;
	Fri, 20 Nov 2026 16:14:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795187682; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=c4Z9yGuax/8NR1BznxmdHxIivPIjV06ghC9n97sXVMc=;
	b=qP3K5iFWwUKZwIQKOP9+wMMMEfmEjshq5oP054+bmu2JyLKtD0QR5NC9lf76y0NiPFLWU0
	TsiGBvknc+ag9cbrXCdGHc8nz8bJR05lx2uwRZ/kO9z2xqN0bm6a1QmYB4NlMr4mYD/uSW
	KNDEUD8rdlrSbKndfYWTzHmqqyVAMAVHwHqGe9gphJOclw39r9N0owsORjQIlNZ1f5oVei
	Y3LsPlEHRvrsdUvcoBnzzQI/RhNLKqfSGdt0Ps4UTbBfjSb1+XB3QsP+MklkVt9oBH5cuA
	NaKMNA0k7flFUWpx3vKHLltVcYo4Xqr94UFfw0L94GMe6MRtZ+YjmnytNfBlrQ==
Message-ID: <fa5f43740321588aad8a5125eafd947c27a2f613.camel@bootlin.com>
Subject: Re: [PATCH v4 0/2] ACPI: platform: ACPI 6.5 fixed clock support
From: Paul Cercueil <paul.cercueil@bootlin.com>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, Russell King <linux@armlinux.org.uk>, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Thomas Petazzoni
	 <thomas.petazzoni@bootlin.com>
Date: Fri, 20 Nov 2026 16:14:37 +0100
In-Reply-To: <CAJZ5v0i4ybwsOKfj_LS_m7EL-AYAhPQJmLNWBm8gdZ5uvfcJug@mail.gmail.com>
References: <20261120125722.209609-1-paul.cercueil@bootlin.com>
	 <CAJZ5v0i4ybwsOKfj_LS_m7EL-AYAhPQJmLNWBm8gdZ5uvfcJug@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3

Hi Rafael,

Le vendredi 20 novembre 2026 =C3=A0 15:31 +0100, Rafael J. Wysocki (Intel) =
a =C3=A9crit=C2=A0:
> On Fri, Nov 20, 2026 at 1:57=E2=80=AFPM Paul Cercueil <paul.cercueil@boot=
lin.com>
> wrote:
> >=20
> > Hi Rafael, Russell,
> >=20
> > Here's the v4 of my patchset that adds partial support for ACPI 6.5
> > clock resources.
> >=20
> > Sashiko complained about the clock names being too long still, as
> > ACPI device names can be up to 17 characters and the limit of clock
> > names is 16 characters; so I now name them "acpi-clkX".
> >=20
> > Note that I expect warnings from Sashiko that I got on my v3 and didn't
> > correct, because they are bogus.
> >=20
> > On the clkdev patch:
> > "When clk_find(dev_id, NULL) is called, does incrementing match here
> > give a (dev_id, con_id) entry a higher score than an exact
> > (dev_id, NULL) entry?"
> >=20
> > My answer is that you call clk_find(dev_id, NULL) when you know you onl=
y
> > have one clock provided, so you don't need to care about matching
> > priorities.
>=20
> Sashiko has a new comment on the first patch though:
>=20
> https://sashiko.dev/#/patchset/20261120125722.209609-1-paul.cercueil%40bo=
otlin.com

Yes, Sashiko came back to the charge with better arguments this time.

Sadly it seems to be correct, if I change the behaviour of clk_get(NULL) I =
will
break some drivers that rely on it not finding named clocks.

I can pass NULL as the con_id to clk_hw_register_clkdev() and then I can dr=
op
the first patch. Then, I guess register any other clock for the same device=
 with
the "acpi-clkX" con_id.

> > On the ACPI patch:
> > "Should the con_id argument to devm_clk_hw_register_clkdev() be NULL
> > instead of name? [...] Setting con_id to "<dev_name>-<idx>" instead of
> > NULL prevents wildcard connection matching in clk_find(), so any
> > consumer driver calling clk_get(dev, con_id) with a non-NULL con_id
> > fails with -ENOENT."
>=20
> This time Sashiko complains about something else in this patch AFAICS
> (link above).

It looks like I need identifying names for devm_clk_hw_register_fixed_rate(=
),
and those don't need to be 16-chars long (that's only for clkdev) - so I'll
restore my "<ACPI_ID>-clkX" naming scheme there.

Cheers,
-Paul
