Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D222DC792
	for <linux-acpi@vger.kernel.org>; Sat, 12 Sep 2026 13:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789220989; cv=none; b=KPAPI+bdI+lrifsw27i4c2SuOIJSRrRJKPGMJzYVigCjYJzaC8eCA/pqBAsmWvA6bpG6u7A+BS0xAx6ZztJ8vcp4Blb3FSil+mTY2VmXmlY5DHbz8V7ZADCmOYVbSQcB9hDD/X9a5gRb3/86093pnBc7IliyWw8DoRAnvTs1uaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789220989; c=relaxed/simple;
	bh=zHff7ojdq2sTvHmVbmv1SvpCrqoWCLfFjCYi9fVj9rQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SczLVmdxXUpbXMJ5YWDOpTTNiym9DaZGrM98IO617H1/BZ1nKRzVdwBkw7z+tR+1RZlix/owh4GUVkb01WP9jwC2WXJsPbPN7qVTdT/WZq3slv3LQI4RevSiaWbrM7R568PZEireqDK1hwa7cFJAqYJeg8LJW1CotNKclxE0CcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a6z2gYUz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a6z2gYUz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D96E1F00898
	for <linux-acpi@vger.kernel.org>; Sat, 12 Sep 2026 13:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789220988;
	bh=14JGNhJ9pFK51pgf/wGsG4+Juf1Yiur3FvqT3KPXWmA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=a6z2gYUzAE7zUjqQGicLNmnv/c4QAmA5/DOFmaOA0/3Eg4yB7NBwpfOsyMG1IyNOq
	 Cm4tDKAdLHVdA/ozFmnKhv1q2v09a8Xn2TywoKl3GjE/Yl3ur8WP/gQ/zJJaMpXgS1
	 W8KgsnKIsN0s+uegeBDlA/yN0O6ghVZfHQ3Nh3DlaUuMR4NVEb9QaPKSJM+2Nh09eR
	 eYykvapgFNAKPMNXs90cOBpAdn/BNOdcZyvr8VLpU4tbFew88XyJRBuk8aUKsVzKNv
	 yPyOKtLg8mOWhw0Z9tlr8gthesBtyqpBUO39UYHsPxiHcjwGs5uQc+fOIm6+n+iB1u
	 U0irhzrZUcD+w==
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a318299b93so3881121fa.0
        for <linux-acpi@vger.kernel.org>; Sat, 12 Sep 2026 06:49:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxnHAlD7Drm2xUY59veGCevQAOjf/8+eRzIrjeTnv1GHDNTbrt1hhFohvB0x+O0gKf6kR9wvrB8PINB@vger.kernel.org
X-Gm-Message-State: AFuF++kpb3c9MCDrW6R/i+lRbFNs2rbe2Fi1wlFsjebbWiseMsLyyA/h
	HjTAwUz4qFv7C/dYTySQY2BDZ0s/LHKRhyce6cXT5PIgD5z7U20vmRprDUTCvgLkkYvCeLsNgA0
	CIsqOh8UpRVkJ7vLBuDR7Ru9XdBgnq64=
X-Received: by 2002:a05:6512:304c:b0:5b6:1883:d604 with SMTP id
 2adb3069b0e04-5b8a8f01711mr492268e87.67.1789220986489; Sat, 12 Sep 2026
 06:49:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1965933.tdWV9SEqCh@rafael.j.wysocki> <14089663.uLZWGnKmhe@rafael.j.wysocki>
 <aqQsac65eDbHV_I_@ashevche-desk.local>
In-Reply-To: <aqQsac65eDbHV_I_@ashevche-desk.local>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Sat, 12 Sep 2026 15:48:31 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gBn9+a9hJfyOuES2bpnpv6HfriUadkeMTaFEfFGxhkeQ@mail.gmail.com>
X-Gm-Features: AcwNN1UHNmhXOxcuTakqbwbQhHo2aCZ6fkDTYWUzrL2OK_kaaUVrw3RcEBpr7YY
Message-ID: <CAJZ5v0gBn9+a9hJfyOuES2bpnpv6HfriUadkeMTaFEfFGxhkeQ@mail.gmail.com>
Subject: Re: [PATCH v1 01/10] ACPI: fan: Fix memory leak due to leftover
 devm_kcalloc() argument
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Hans de Goede <hansg@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Lukasz Luba <lukasz.luba@arm.com>, Armin Wolf <w_armin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 6:29=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Sep 11, 2026 at 03:00:51PM +0200, Rafael J. Wysocki wrote:
>
> > An ACPI device object's dev field in passed as the first argument to
> > devm_kcalloc() in acpi_fan_get_fps() which is incorrect and leads to
> > a memory leak on driver probe errors and removal because the driver
> > is not bound to that ACPI device.
> >
> > Address this by replacing that pointer with a pointer to the device the
> > driver is actually bound to.
> >
> > While at it, drop a redundant error message after a memory allocation
> > failure (that also gets printed relative to the ACPI device).
>
> ...
>
> >       fan->fps_count =3D obj->package.count - 1; /* minus revision fiel=
d */
> > -     fan->fps =3D devm_kcalloc(&device->dev,
> > -                             fan->fps_count, sizeof(struct acpi_fan_fp=
s),
> > -                             GFP_KERNEL);
> > +     fan->fps =3D devm_kcalloc(dev, fan->fps_count, sizeof(*fan->fps),=
 GFP_KERNEL);
> >       if (!fan->fps) {
> > -             dev_err(&device->dev, "Not enough memory\n");
> >               status =3D -ENOMEM;
> >               goto err;
>
> I was about ranting on goto after devm_*(), but looking at the context,
> I understand why it's not a problem. While at it, a side note: perhaps it=
 makes
> sense to use ACPI_FREE(obj) instead of kfree()?

It should be ACPI_FREE() strictly speaking.

> Or even better to have __free() version of it, so we can declare the obje=
ct with autoclean.

That one is a bit tricky, but I think I have an idea how to do it.
I'll post something next week.
