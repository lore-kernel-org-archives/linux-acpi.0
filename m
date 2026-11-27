Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795789245;
	b=4ahfjMW3en2VYlwhTH6Kdj6h6eaG6x3/4dy3XiW91toMoCua0qgz6xtS0PJdmn5DsgN1
	 P9wI1YFDR9FP8JSZqvrzCGdjAQvu5sr/6j3F3A+9FTCc6SD1QyDB+Hd7gAJduWOFXo8XV
	 O19KNiQKxkimutAlSa2BS/ocdMnWE3PhJoLUFt1uxlxr4isL8oYtQTtvOBstseiTG478N
	 LjnG4/FXtAgFQpMVS7iyTnT8PoeJoyDSDMruB3rtKOnWJWy4UWM1lLD4MfbpmxJd0VE3Y
	 4LUFX6mVKyZ19jlbByNk7Tbkv1qlJIWQLfVmj+zZ6IuTRufuuLpTsT/TRqRz06ULBeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795789245;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Message-ID:
	 Subject:From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version:
	 X-Last-TLS-Session-Version;
	bh=6RlqKNDJafGcHvmloSCC6w2YY4+OIN/Uqr4hTcsP5MQ=;
	b=Jm+Xb4a9nVdqqbjNahSzS6NSd4yssn8TcMiQtt6k5z8pedpHR0KrDHaMBBUtoVaosftt
	 lglYcs46ki9jtbi/0Wwgj6OaHvqUcRjTx2XglzKYnOT5D7jdam13AQTz2Ax+7P0leFVLk
	 7vIi/cX5Ha3BiqFfblI0kgglo8Uq6FeLcnyqU+g2Vpqs+f2Ji2Fgj8MFa6uZH6DHHtF13
	 CKhJ4qnhBSw0K7RG3JsVMGLvtMkyS2FeKoQrW5+nfFKIAm3K9ktOlBdBpazcVQHZg39bb
	 xdKWg+Dhc/lCoCJ1A6stz4wdh3o4nIxN2fXNnczmxt9vCRoErpIF7MI3m/tQOu2ovuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b="h/ULD6tL";
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179AE606A31E
	for <linux-acpi@vger.kernel.org>; Fri, 27 Nov 2026 14:20:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 179AE606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=h/ULD6tL
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id D5332C2AC4C;
	Fri, 27 Nov 2026 14:20:50 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 121EF6049C;
	Fri, 27 Nov 2026 14:20:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 59AFF11E68FDF;
	Fri, 27 Nov 2026 15:20:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795789237; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=6RlqKNDJafGcHvmloSCC6w2YY4+OIN/Uqr4hTcsP5MQ=;
	b=h/ULD6tLmDGowQqyUTP1aYbbVNWg8QPINu60gPYqefLq1OTI7dUMXXliPCLPLkf+FSmNYz
	kfC88i/bB3lCgcLpzAhVEUrT162zs5PIElTR5dSUCUuTfQIJG7Vz/Ceus5GuanDOrFqb8q
	tIn335ycfv8GqUGyUImBsUKcfLxDq5IRVajoojr+BFhzgmDLPBBxFeofOfigmuF0yKktWM
	L87ZU4nsvBx5CcapclK9bWTVxMeMvlhdZuMucmSEyQnTQYGaS+nbhXBQkFcwiI6kJBPQsa
	LBFnghHAYFLRYF4j8YzMcsDXZGD1UTIrcmPhkXmipvUBv3G6wIoddzv/rCCwRw==
Message-ID: <83bea8441ea9b1fee1ec5144c335b5cd8e2de168.camel@bootlin.com>
Subject: Re: [PATCH v5 1/1] ACPI: platform: Add basic support for ACPI 6.5
 fixed clock resources
From: Paul Cercueil <paul.cercueil@bootlin.com>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Date: Fri, 27 Nov 2026 15:20:33 +0100
In-Reply-To: <CAJZ5v0g3e26eZG1_yRQzMfPvPYiiv0cHZE70V+_U+NR4kxEpJg@mail.gmail.com>
References: <20261120161020.297735-1-paul.cercueil@bootlin.com>
	 <20261120161020.297735-2-paul.cercueil@bootlin.com>
	 <CAJZ5v0jeJSx3C8hdU8iAtje-NGNz4DdaVGhE_T3WpVrODuwemg@mail.gmail.com>
	 <80b96fc3f728b59b26ebde1378f4222cf4b359b0.camel@bootlin.com>
	 <CAJZ5v0g3e26eZG1_yRQzMfPvPYiiv0cHZE70V+_U+NR4kxEpJg@mail.gmail.com>
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

[...]

> > > > +static void acpi_platform_init_clocks(struct acpi_device *adev)
> > > > +{
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct device *dev =3D &adev-=
>dev;
> > >=20
> > > Note that &adev->dev is not a real device.=C2=A0 It is a "firmware no=
de",
> > > quite like a DT one, but I guess it may be used for registering
> > > clocks.
> > >=20
> > > How is a platform device driver going to use those clocks though?
> >=20
> > They just use clk_get(). It searches the clock by device name, which wo=
rks
> > here,
>=20
> And they would pass the platform device as dev I suppose?

Yes, I like the fact that it does not change the API - on the driver side y=
ou
just use clk_get(&pdev->dev, NULL) or clk_get(&pdev->dev, "acpi-clk1") like=
 you
would do with a clock resource from DT.

> > I guess because the "firmware node" device has the same name as the rea=
l
> > device.
>=20
> For platform devices created by acpi_create_platform_device(), yes, it
> does, but if that is going to be relied on, that assumption needs to
> be documented in a very visible way.
>=20
> Generally speaking though, they should rather pass the ACPI companion
> of the platform device as dev, in which case that the name equality
> doesn't matter, and so the clkdev could be created during the struct
> acpi_device registration (and the corresponding cleanup would occur
> during the struct acpi_device removal which is rare).

I think I should update clk_get() then.

It gets passed a "struct device" pointer, if it has an ACPI companion, I ca=
n
just recurse on the ACPI companion's device struct.

Btw - I'm working on the v6 and I added the cleanup on acpi_device removal.=
 Is
there a way to test a ACPI device removal from userspace? Looking at
Documentation/ABI/testing/sysfs-bus-acpi it seems to only be for ACPI devic=
es
which have a _AJ0 method?

Cheers,
-Paul
