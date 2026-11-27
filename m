Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795788348;
	b=yecFCxmYBKUHdjcihhRubUv1Cy05R+TiA3Yzs3aN2vQiCONFdE+midPV4Ycu+ZHqvA3q
	 LSO0DlTsQhS5Fw5vA9Zka+QLGQ9sK1aY4rJxhTc3VwiDL4pTjnl2+4E3b2Ks+bUwtv9BA
	 MbFKUOI6d4g+m82Px29UMRCO0atB4RNpbmkx6AN2h2Dt6a8cDu+iI93hKQNsKFc6ACcTu
	 r5pOMJcnvZOTGc38rhKWXyBrFL2YiQ9aUgwKBKeyLLbd2XImCFSbxzv1TODWKcYSlvmGv
	 JfyTPOJw3k/JM0zubs8onrwwEU4yAmGQ8x+n70JcKKalPWExOTFOUge2d/6wkEecWKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795788348;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ZChi/V/cBkPXD1LTeyDR+JElxQO43oGSZK3MDyeqdcM=;
	b=OoGlcbOeOaaH31p1MP3DwbYQ/Izt5zItjH0PM9kS9Mqv1k1XVG4GZ390kdphSF+aa1ty
	 jt5cKaOm1lDwTRsYzwzErgjGfJ6FB2+Q0vtFPaaCTOD5EoyZRgZhDDeYNPX98Stn/XKK6
	 +xNRgjNTehUMdLYciejqnGhFYRZAXQc0fxdLoIhgdvjG1XM9cys+UamVIhHspZRo3eess
	 NKMoGj2VtW/nY9HfjozfeJo0rt1FhESFP04KP/JGHy6t2sEL/xeZk4nH4l7yP2sqjp6Lj
	 BuZ7Lk/uTmNYncs/2rvPzgjNXlgMf559CcQp99x99hfPtDgWX9jfy6AdYcQ8pusLwfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cwGcmAnw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67DD606A680
	for <linux-acpi@vger.kernel.org>; Fri, 27 Nov 2026 14:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cwGcmAnw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6831E1F0089A
	for <linux-acpi@vger.kernel.org>; Fri, 27 Nov 2026 14:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795788348;
	bh=ZChi/V/cBkPXD1LTeyDR+JElxQO43oGSZK3MDyeqdcM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=cwGcmAnwFDYuXkp0yV57lAwaoVjNBIf/38pYwOJtioVvn43I1w1G95EYJDblVsaQJ
	 Ghv3OCZ9BOs87yWZ+lTotMpfKg+IaR9qgn/Zv+9CaSZVCzkltxwnBqFGknSE23P3gp
	 J5B5FicZP7Z732ZlJ6ibkHgD0Da2qTv12SKU93Szh8eWsPnw/0Ytra/vgIBNfdKcyH
	 Sl39lOF+mUWGsZyOsDa/Bbe3ZOs0tEtvfSqbUYcDRfCzRAAzNKeUfsrHCzlwl8o/Ym
	 DH1wRbR134+YaM+UD0Sh/dNlNOlIJJsVhijyz7kmlrFTVlrU6YWy0FEJLAUH34CaiT
	 ZiV9qU5ta+7IA==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3ad5529ae64so62737911fa.2
        for <linux-acpi@vger.kernel.org>; Fri, 27 Nov 2026 06:05:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEtCw0pxyZd4OhrgU0Sb3lrUZ4+8qOVlYu5os5us5ndF+iZvM301K0dao33DTc1axc4LjUsxC/kE4a3@vger.kernel.org
X-Gm-Message-State: APuU4Z+WG04ONMkNpZWDhxoHKKDiKJk3K47h3LcXMsgJ/KvZT6hn226R
	a7OkVbmSlI0KQw5NAbOxoJyzxhxgwMnXyERGdsLL3oKPF0h1A4/m6dJFKgZEjSZxbYNy6U+b28/
	D+c9dfbYEnlKtNRcAxcFUYKJIN9xTrys=
X-Received: by 2002:a05:6512:3a94:b0:5bf:b5a1:3c09 with SMTP id
 2adb3069b0e04-5c1bc7d222cmr7698254e87.31.1795788346777; Fri, 27 Nov 2026
 06:05:46 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <3986546.kQq0lBPeGt@rafael.j.wysocki> <2080993.usQuhbGJ8B@rafael.j.wysocki>
 <3659d5f94d83b71df4040f8516000e9be9a9c1b5.camel@linux.intel.com>
In-Reply-To: <3659d5f94d83b71df4040f8516000e9be9a9c1b5.camel@linux.intel.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 27 Nov 2026 15:05:33 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hCxSQHok3t8JHVmb7nUcNzO059BHnm6-Ogu2pWyh6WOw@mail.gmail.com>
X-Gm-Features: Aa3M54p-JnvCjuJdrIlWFlDk59C2fD3iAe3siOzUrYiYTbS-7Fm722hwEh6Mlqk
Message-ID: <CAJZ5v0hCxSQHok3t8JHVmb7nUcNzO059BHnm6-Ogu2pWyh6WOw@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] intel_idle: Allow ACPI _CST to be preferred to
 ACPI _LPI
To: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Linux ACPI <linux-acpi@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 26, 2026 at 10:17=E2=80=AFPM Artem Bityutskiy
<artem.bityutskiy@linux.intel.com> wrote:
>
> All patches look good to me, there is only doc nitpicks below.
>
> Reviewed-by: Artem Bityutskiy <artem.bityutskiy@intel.com>

Thanks!

> So my nitpick is to make it crystal clear this option is not about
> never trying _LPI, it is about trying _CST first (reversing the
> default).

That's what "prefer" means.

> On Wed, 2026-11-25 at 15:20 +0100, Rafael J. Wysocki wrote:
> > +``prefer_cst`` - When using ACPI, prefer idle states coming from ``_CS=
T`` to
> > +idle states coming from ``_LPI`` (which is preferred by default).
>
> ``prefer_cst`` - When using ACPI, try ``_CST`` first and fall back to
> ``_LPI`` only if ``_CST`` does not provide usable idle states (by
> default, ``_LPI`` is tried first and ``_CST`` is the fallback).

This is more precise, so I'll use it, but honestly it doesn't make a
lot of a difference to me.

> > +
> >  The value of the ``states_off`` module parameter (0 by default) repres=
ents a
> >  list of idle states to be disabled by default in the form of a bitmask=
.
> >
> > diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> > index fc0aea26db50..3c07469586f7 100644
> > --- a/drivers/idle/intel_idle.c
> > +++ b/drivers/idle/intel_idle.c
> > @@ -1779,6 +1779,10 @@ static bool no_native __read_mostly; /* No effec=
t if no_acpi is set. */
> >  module_param_named(no_native, no_native, bool, 0444);
> >  MODULE_PARM_DESC(no_native, "Ignore cpu specific (native) idle states =
in lieu of ACPI idle states");
> >
> > +static bool prefer_cst __read_mostly; /* No effect if no_acpi is set. =
*/
> > +module_param(prefer_cst, bool, 0444);
> > +MODULE_PARM_DESC(prefer_cst, "Prefer ACPI _CST idle states to ACPI _LP=
I idle states");
>
> May be even something like this
>
> MODULE_PARM_DESC(prefer_cst, "Try ACPI _CST before ACPI _LPI (default: "
>                              "_LPI first)");
>
> But this is very minor, your call.

I'm going to use mine.
