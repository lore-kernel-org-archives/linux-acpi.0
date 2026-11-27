Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795789492;
	b=vJahmABbH0lErNAX1Sa+tvZl2uTGIQIzy8lCjuEfGgBIJbAjPMGamEGAIvh28455BLWp
	 GZv0kJtAuM4Di/jjT8+djPT2oBVbzvT1BILSiQxpmXL2GVGpldxs9u8VZIajmp90SBVX5
	 jOerp4vxJ1Oo4jmF62XAgLNEYkxCQHiRMXli3GgZEyS0kCaWhtkt3WsqL393RV9yK91Uk
	 rvbU30uzCvNJEI23zo6uNIBNA9SVjriHpQlGLpqYw71BY7J1K2XyMyaj6W54es1ABslbh
	 5z9NZDfmR1oHHoMWaZOgZMSpRHAfNR8/XWtBssQr/Vx4CXF/ZPNea+ObHsTddWTOscw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795789492;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=j3Jk8VMhYlvD+jXpeN3QQ+oFoR5tWm2Gq7ARIv1WFFs=;
	b=vIste+pEin9tCnR5JrECzeHl05EO+sZ0q2Ri+bVm9CBHYwtFufzJscR9AOcdS16yxIZq
	 smJPlsgkAafC9D4xvlxET5vJQ5uWhdxQr9y7KuusmjkBCx5DpXm4e3lNecBTHy7HczQLm
	 hx2M95matD2vNv3xHMtBtyPG1K3uszMqUZHeIuywzRGCTOiMsNpee9igMP24pNvSiP6z4
	 pTz+kLR5EI83yX0DtAzq/bnmPjD3IeLCcf5GzNKTjp2rvRMu3CI8T20kZn+Fz92ZteccG
	 pkFXltWljd3QpJ7dvBeqUH7Mh2lFeYuV1YAM+53jU6KqA9BDapB+Kdunfx8w6u7iJ6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MyAsj7eC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C950B60A381A
	for <linux-acpi@vger.kernel.org>; Fri, 27 Nov 2026 14:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MyAsj7eC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20E171F02814
	for <linux-acpi@vger.kernel.org>; Fri, 27 Nov 2026 14:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795789492;
	bh=j3Jk8VMhYlvD+jXpeN3QQ+oFoR5tWm2Gq7ARIv1WFFs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=MyAsj7eCjc1vU0Q0ociebOguX1q5rGGhqdwTw2JsNWJmSwAerujACz6MuZaA6fDAZ
	 BGqeLuG8t5snHRfRGzDKr2DJMT+iltDbgCvR90+m3if+QBG/g9zt3fliQgqZmVsn7v
	 vMoqbZdSdujeyePJGlswlDZ9Z0iWhzIsV4cjYufrjseNokImXOob9pCoautmFQN+pt
	 Z0Yk95EJkMxkpZfaiofXvPZtmmeKjc2pTPmuRP9X19Tu83EeRB1FYQoW/i0TfJdFuo
	 oiSq6aVsoUDTn85hsG8aCLtxWbH4QGNtSr31CVLX+d2a8iFB71Cd46lR05tLtkepvX
	 K9MaA+UIRxkNA==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3ab3b29a298so67015651fa.3
        for <linux-acpi@vger.kernel.org>; Fri, 27 Nov 2026 06:24:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGICpHRAgFAPBqvCvHykY2CAlJvu7VkipcH6e31bk3U0R2TBI5ZnPMvCvPT0zBG1JJx/TGIe7D0bBVZ@vger.kernel.org
X-Gm-Message-State: APuU4Z/dciV2ZRJT6dGCWXbjiTv5zo1ILcmWC/CDCO3tgYYzu16BB9fW
	AcmN74nZYBesvWCJECGg5JhljlJJdhLMpMhKMBXGxVmK05erVIc8U8YUVjPnTInn9wcJNr5aDM2
	BUIQIemPyUUKlkDgBfY9EO+qaCv92A5w=
X-Received: by 2002:a05:6512:318d:b0:5c1:4e30:7632 with SMTP id
 2adb3069b0e04-5c1bc864f53mr7631511e87.26.1795789490532; Fri, 27 Nov 2026
 06:24:50 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261120161020.297735-1-paul.cercueil@bootlin.com>
 <20261120161020.297735-2-paul.cercueil@bootlin.com> <CAJZ5v0jeJSx3C8hdU8iAtje-NGNz4DdaVGhE_T3WpVrODuwemg@mail.gmail.com>
 <80b96fc3f728b59b26ebde1378f4222cf4b359b0.camel@bootlin.com>
 <CAJZ5v0g3e26eZG1_yRQzMfPvPYiiv0cHZE70V+_U+NR4kxEpJg@mail.gmail.com> <83bea8441ea9b1fee1ec5144c335b5cd8e2de168.camel@bootlin.com>
In-Reply-To: <83bea8441ea9b1fee1ec5144c335b5cd8e2de168.camel@bootlin.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 27 Nov 2026 15:24:37 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hfoVDgMnRRm1DJHK-EoCrVhrb5bNk5wpZAcPOREpQgLw@mail.gmail.com>
X-Gm-Features: Aa3M54oDq1n-9WHuhbNZ5q7DVE6aj2jRxCGzr8EMzFrU8hWmkD6TpwkTvtvH4YA
Message-ID: <CAJZ5v0hfoVDgMnRRm1DJHK-EoCrVhrb5bNk5wpZAcPOREpQgLw@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] ACPI: platform: Add basic support for ACPI 6.5
 fixed clock resources
To: Paul Cercueil <paul.cercueil@bootlin.com>
Cc: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 27, 2026 at 3:20=E2=80=AFPM Paul Cercueil <paul.cercueil@bootli=
n.com> wrote:
>
> [...]
>
> > > > > +static void acpi_platform_init_clocks(struct acpi_device *adev)
> > > > > +{
> > > > > +       struct device *dev =3D &adev->dev;
> > > >
> > > > Note that &adev->dev is not a real device.  It is a "firmware node"=
,
> > > > quite like a DT one, but I guess it may be used for registering
> > > > clocks.
> > > >
> > > > How is a platform device driver going to use those clocks though?
> > >
> > > They just use clk_get(). It searches the clock by device name, which =
works
> > > here,
> >
> > And they would pass the platform device as dev I suppose?
>
> Yes, I like the fact that it does not change the API - on the driver side=
 you
> just use clk_get(&pdev->dev, NULL) or clk_get(&pdev->dev, "acpi-clk1") li=
ke you
> would do with a clock resource from DT.
>
> > > I guess because the "firmware node" device has the same name as the r=
eal
> > > device.
> >
> > For platform devices created by acpi_create_platform_device(), yes, it
> > does, but if that is going to be relied on, that assumption needs to
> > be documented in a very visible way.
> >
> > Generally speaking though, they should rather pass the ACPI companion
> > of the platform device as dev, in which case that the name equality
> > doesn't matter, and so the clkdev could be created during the struct
> > acpi_device registration (and the corresponding cleanup would occur
> > during the struct acpi_device removal which is rare).
>
> I think I should update clk_get() then.
>
> It gets passed a "struct device" pointer, if it has an ACPI companion, I =
can
> just recurse on the ACPI companion's device struct.
>
> Btw - I'm working on the v6 and I added the cleanup on acpi_device remova=
l. Is
> there a way to test a ACPI device removal from userspace? Looking at
> Documentation/ABI/testing/sysfs-bus-acpi it seems to only be for ACPI dev=
ices
> which have a _AJ0 method?

The only way to remove a struct acpi_device is to unload the table
containing its definition, so you'd need to load a test SSDT via
configfs and then unload it.
