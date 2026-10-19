Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792422579;
	b=rRRe/g7nlPg78gBMPsPEnE3oGtsWBLOrtTClnBjcv4t+qkriADH/uzjAM3Gb+xQr9ege
	 24FYTxher0jaEa32FmIHxHxk9KBthmUQBsck4BI1XjTqOllylPJAWRcnyYpKdKoXEnMWg
	 UREEbQt5YnJVpXcPrjU/5Si5U0YOXFuOheXtAIDjq+wqxriW3b7rcvQ+TlIaqC7/IgQSF
	 /pkMiC6BXRt8rerubenlupErYPlHZsQaHw4ja77Gxrxtv5rIrYAINBtNcuGdwLklIRCd0
	 yUh+UQ9P5E0mMrG4yyRMMrP0vBusX8qyAoGn4TFpUWZQf0dUVJM3mRH2xpYaXizaoQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792422579;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=DcaRX8WmJPVt0V9NBQwfZlgs6OPdeiawbVeR4WtEcD4=;
	b=yXs24a6gPYd4cuR56duLm+uBiqJS74xnrrFhcCohcC6ZbBZpi03EcuI8zeGN9WgJvMGR
	 ApGnFTz0HirSbAijRuDUsfuOFRawOf7JGamp5v9KO95FQ6ZwCKe9ToNXBInEPBA0S0VPZ
	 qgF2iMCysh8p5NJBKPgaBFFm0xwORqlPb5aMi3sJFvnmPUkqbrWmBGIM3iHYDF+TmMM66
	 5bdLUrI3qKOF+pDULQuC09NzowqbxWsvVQPE+A50xv5oTltP5omfYSKkoEqpzUlx1T9Hu
	 iNEkG2eVWpuEdzkqCei6j2G6m+PA8FsPBb1PEwFC27XThlF1fNY7CFr9rzoullLLB0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JL3nPFns;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0436087497
	for <linux-acpi@vger.kernel.org>; Mon, 19 Oct 2026 15:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JL3nPFns
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B59F01F000C7
	for <linux-acpi@vger.kernel.org>; Mon, 19 Oct 2026 15:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792422578;
	bh=DcaRX8WmJPVt0V9NBQwfZlgs6OPdeiawbVeR4WtEcD4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=JL3nPFnsx5fj0TdOFUuVKt2df9puKuJ+bt6fE2dWfhS9Y6hgRyaruYXJb1aM89Ugk
	 uoJw4NLTu+GodxZ/OfdRwTY7oJpJuAvPMhJvD8ZpjdSYLQsfR4baXIhMAj0sba8R9l
	 DObaXWyjhJLZuzG6mAo05cHmiJx1p/KTjmtn/pmzicdX4H4JOI6fKb68plUvdFwbNS
	 eFbYmtSJ7T82yJV7Hu3mVz6nbAzM/dUSGEHnojp9501IJv1XZR8/39U9CtCsjXVGYt
	 kyXKqCD84eSx/dNUHFsx2+d2MY4uY64aVgniO4j1L32y/wuE4ScFghX/skBYyWarep
	 UGn6Bb4NJp82Q==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5be3d5927ceso1775242e87.3
        for <linux-acpi@vger.kernel.org>; Mon, 19 Oct 2026 08:09:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBy+wpUJ5v1mDf6uhGqcY/Mlfya5rYQ5KUxv1rRf1S0UIEQ4ozNwNb2B52/jzajSzlO3EnEOcX2NoZNg@vger.kernel.org
X-Gm-Message-State: AFq9FYJ66/qIkhoKWaKWstVZtBlfr05vPjGsVuqa7pM/oo0dJd86Zwze
	KTasUAKxCzXeRTis/zSaT9aRLo9KwvaoJVzC2tjtY6Vc5ZdS+l96mnZ0UjZbMMyAI/f54uw6SEk
	34JUdfsbBfZ7yqgSimjYeoWTf2uuxIiwl1mbwXVvaiQ==
X-Received: by 2002:a05:6512:b95:b0:5be:52d8:f70a with SMTP id
 2adb3069b0e04-5be52d8f89emr2639653e87.34.1792422577308; Mon, 19 Oct 2026
 08:09:37 -0700 (PDT)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261007120944.1705014-1-abduvaliy.hbai@gmail.com>
 <179239686600.5748.7808377662325552771.b4-ty@oss.qualcomm.com> <atYbJ4ByzDb1mlOQ@ashevche-desk.local>
In-Reply-To: <atYbJ4ByzDb1mlOQ@ashevche-desk.local>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Mon, 19 Oct 2026 17:09:25 +0200
X-Gmail-Original-Message-ID: <CAMRc=MfOf7MYAYr=xJXn2vcYJs0sYt2VGr_F1vP-4p+28xz8YA@mail.gmail.com>
X-Gm-Features: AclHuK_RRJ5XU_fvS1zUiO3BR-YUAl9UaAuV9O5438UByi52Rf9gHtwIqajdDvA
Message-ID: <CAMRc=MfOf7MYAYr=xJXn2vcYJs0sYt2VGr_F1vP-4p+28xz8YA@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: acpi: Ignore GPIO 11 interrupt on Acer Nitro 16S AI
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Mika Westerberg <westeri@kernel.org>, Abduvaliy Abdulazizov <abduvaliy.hbai@gmail.com>, 
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, 
	Linus Walleij <linusw@kernel.org>, linux-kernel@vger.kernel.org, 
	Trijan Koju <trijankoju11@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 3:30=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Oct 19, 2026 at 10:01:08AM +0200, Bartosz Golaszewski wrote:
> > On Wed, 07 Oct 2026 17:09:44 +0500, Abduvaliy Abdulazizov wrote:
> > > The Acer Nitro 16S AI (AN16S-61) has the same problem as the Acer Nit=
ro
> > > V 16S AI: the firmware powers the internal USB camera (0408:4059)
> > > through GPIO 11 of AMDI0030, but also lists that pin in _AEI. Request=
ing
> > > it as an input cuts the power, so the camera never enumerates. On thi=
s
> > > model the same rail also powers the internal microphones, so they do
> > > not work either.
>
> [...]
>
> > Applied, thanks!
> >
> > [1/1] gpiolib: acpi: Ignore GPIO 11 interrupt on Acer Nitro 16S AI
> >       https://git.kernel.org/brgl/c/5a088d1b7266249e7701a94fc90fc829d1a=
d5ba1
>
> You actually applied my PT to for-next instead of for-current...
>

Yes, by mistake but I sent out the PR anyway and it'll get upstream
all the same (faster in fact. No worries.

Bart
