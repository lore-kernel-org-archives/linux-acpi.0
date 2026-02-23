Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D803537416E
	for <linux-acpi@vger.kernel.org>; Mon, 23 Feb 2026 19:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771875954; cv=none; b=bCf5lWjWZXkXGstESN1w61YWQe37m5fWSfbB/Cfdi0WVzgDVvVIjkuU8ppJjR5VpR/fbjvHKjTsVB1ouzxN9gppz2q1gpWp9Tye3LL8P/+ylRTahCSMrBfX2VCxBEmgeVpv5q1/pRK+tNGFuUUOf2wYl4cerjZxo875kWuifNk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771875954; c=relaxed/simple;
	bh=gl6z+z6JwrPxKtnDC3wFABuTO/xoflGEsD03jhwd1BA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gZqaExOYc/LUUgXUbvvPSEqebKDaYl6Kog1sk7i6OwZ/t3kDhehsr3Qwk3NjjeXzIfb+8VcRem+uSZtPTNZTbrmws9MOO4CcZjS57eXIwOjWLMG/plrCOttrTcX65z1Tvb/F5HlZob7q+1ZwI07av1z9id5Ia0dqPize11nP3k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EjWx1d1l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EjWx1d1l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90CAAC19421
	for <linux-acpi@vger.kernel.org>; Mon, 23 Feb 2026 19:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771875954;
	bh=gl6z+z6JwrPxKtnDC3wFABuTO/xoflGEsD03jhwd1BA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EjWx1d1l2/0A8KwSNkaBb8302dEFoN+c4jFpgRhMef+zPY74+fZocooN2V2giJclZ
	 ot+4/476YQ3on0b3AfADPb8XS2L4fdwovEeMa+STaL0XDDkDsF2LHP4V7nOYYa0gq1
	 H+8hLidMZMUfKX728roAHYEaF//bsQbSAQEylz3vGlSQzpB/SJ21NUTQmCw3Q22b93
	 Ez3IVZRCETfRRUbuGe1PwJZGM1+MtkNumQ4HmKg0WinFPgN5V+3n0Z8wagrz4kA+jI
	 7xQXPQCTM0ElRqLusvbOjr20cOTwKNYHjxkfuUYz8+vmLGJ61h5K+Z25j31cG9tOOi
	 sT+PHTGHr8lDg==
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-662efd1bdd4so2688506eaf.0
        for <linux-acpi@vger.kernel.org>; Mon, 23 Feb 2026 11:45:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUmu4Fq1rVbflfm3x34SjCmLkHtYzV/Hu+2a2k8qNGX3PnSV/qsXziOYsKu8xkVbomM0/fJ6OzUthvj@vger.kernel.org
X-Gm-Message-State: AOJu0YyOmC4amqmokqYJnm8MkXPLD+8ciwo9zucTGyCpRiaGJmii8CZL
	kalikqEnnyXM4P7r3QvMxXDyACzg/vimbdSvl8bTmLXoQsCNzigR2+hdMNlBKeQHz7D0DgxABbH
	U9fx0oJNtt2XPrYyivUXJmfG2OcDiBP4=
X-Received: by 2002:a05:6820:2110:b0:674:d7f:539d with SMTP id
 006d021491bc7-679c4ad378fmr4937902eaf.30.1771875953684; Mon, 23 Feb 2026
 11:45:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223-device-match-secondary-fwnode-v2-0-966c00c9eeeb@oss.qualcomm.com>
 <20260223-device-match-secondary-fwnode-v2-1-966c00c9eeeb@oss.qualcomm.com>
 <aZyUY3ZsmrwHw4X_@smile.fi.intel.com> <CAMRc=MfpzgOPf4pkHd_tNQ4wBNMhfUBOh=ptajhhZwDpFUPGBQ@mail.gmail.com>
 <aZyrVWYQKT-JUYR3@smile.fi.intel.com>
In-Reply-To: <aZyrVWYQKT-JUYR3@smile.fi.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 23 Feb 2026 20:45:42 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0ivGazojW0BfSh7HzWyu+1ij6p=KbpwsmZPJ5YuTSahDw@mail.gmail.com>
X-Gm-Features: AaiRm51TiyeROrSoZppy1lvz6wk5jsAJRmIS3urBZ3TXwW4SfTEsTE7evmxqeHU
Message-ID: <CAJZ5v0ivGazojW0BfSh7HzWyu+1ij6p=KbpwsmZPJ5YuTSahDw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] driver core: make fwnode_is_primary() public
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Linus Walleij <linusw@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Len Brown <lenb@kernel.org>, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2026 at 8:32=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Feb 23, 2026 at 07:28:48PM +0100, Bartosz Golaszewski wrote:
> > On Mon, Feb 23, 2026 at 6:54=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > On Mon, Feb 23, 2026 at 04:40:52PM +0100, Bartosz Golaszewski wrote:
> > > > Export fwnode_is_primary() in fwnode.h for use in driver code.
>
> ...
>
> > > > --- a/include/linux/fwnode.h
> > > > +++ b/include/linux/fwnode.h
> > > > @@ -230,4 +230,9 @@ void fwnode_links_purge(struct fwnode_handle *f=
wnode);
> > > >  void fw_devlink_purge_absent_suppliers(struct fwnode_handle *fwnod=
e);
> > > >  bool fw_devlink_is_strict(void);
> > > >
> > > > +static inline bool fwnode_is_primary(struct fwnode_handle *fwnode)
> > > > +{
> > > > +     return fwnode && !IS_ERR(fwnode->secondary);
> > > > +}
> > >
> > > This is inconsistent. Please, split out fwnode stuff from device.h to
> > > device/fwnode.h and share it there.
> > >
> > > This reminds me to look what I have locally in development...
> > >
> > >
> > > (With your patch it will be in device.h and fwnode.h and in the latte=
r
> > >  it's even not properly grouped with other non-fwdevlink related stuf=
f.)
> >
> > Please rephrase the entire email because I have no idea what you mean. =
:(
>
> The primary/secondary and other device-fwnode related stuff is currently
> exposed via include/linux/device.h. The problem is that device.h is overl=
oaded
> and starves for more splitting, which I'm doing (very slowly, though).
> The idea is to have all device-fwnode  (and maybe of_node) stuff to be ga=
thered in
> include/linux/device/fwnode.h

I don't see "struct device" anywhere in fwnode_is_primary().  This
check is only about whether or not the given fwnode has a valid
secondary fwnode.

> You, guys, missed the keyword 'device' in the pathname for the proposed
> [include/linux/device/]fwnode.h.

Why do you think we missed it?
