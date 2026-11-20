Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795176345;
	b=R7QpL4HsVyvCAzQalv9ck1vyga9ZqCTarN4BSwHux5chDVXNJdtITMkjUUmuBjbgjOVp
	 HL4bmDVuPKGiL9f2GIR3Kbl5+c8QaMSBuZ+KMfbamJd4TjJwhydIwdLg9zAiezyVBQBoD
	 jX9kdhEHRxZ+TTbAOSjdYNqYpJxhgTgmKyxTfJY9wFkfakdY6OFrIaSf3h9/6d81FKvdv
	 VfLMXVQhbNIsDrBtPgnYlv2j/Hg9zLoJtkOHr41wHegUgjNRJe34e6J4CzGxBgCf9nTwe
	 gFZ3Ny7slwgeM+Sy5vT68AWOkMoUH6i5dR2oT3MTJYBPpDwO39F6L9to31es/c6+ndA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795176345;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=F2ADQgxmR4hRxuMeNH4ldps8kF/PbXvPt+C5LEtKi8M=;
	b=F517xTVuat0AQbB9VWS/BI15Q4TaJ5omugn0RwVqTh6DJI2pDCTXKMzF7V3k0C5Y7mHW
	 0eufrw+KmF4PSsk8oz3jpF9fQNailUk4TS8DzBxnAu1wbd8SRDsAyhUvcOuFXcfRH6+Va
	 1kpTA+7nBAq8MlPB9Zp2UAhoVpVyNTQK1T1thCyiG/oIQF8tFyxUJR6eYKLDzfSoUTUfO
	 pBybHhOW4Wmz3H/C8D4EO2edynnGIRbn+1Dqjj0eGyS38sn3tmACouUUeWZHmVunaLZm2
	 Ct3cvxr5uhA6L3HMeVwCxRD9rsXTh3w2JnpR+lE0SnqlpYiq2MBO3ByL2Hn3HG0MzlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UCzO3vXY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874E1606A325
	for <linux-acpi@vger.kernel.org>; Fri, 20 Nov 2026 12:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UCzO3vXY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C92431F000D4
	for <linux-acpi@vger.kernel.org>; Fri, 20 Nov 2026 12:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795176344;
	bh=F2ADQgxmR4hRxuMeNH4ldps8kF/PbXvPt+C5LEtKi8M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=UCzO3vXYjInn+KDjMIDHdXqee61ABzWHnOObViLG89mIAn2RmZ0ZasPZDaT6hvGmK
	 zCEKC/7CjUEihLss1tyXQQTZIk3DJQaIuSbIRW8L3WVeNFUwXUstvwen0upU5uk745
	 VcbqZ0j7il1dETv03TB5m1m8wXRzWOIOPAEIXzmF1zRqEQke22VFTlv6fqap5Fyya0
	 hjSiMTix8R30v/wIQGPbaHZsligMbGPLAEV/gBpeuwCRtNtWHxUTIhUPskIPgs8Y+H
	 s+mBgXDub7d+RADvnv8gZvy8SRCLDpjNHgMwwZzDi/QP3JZccY/Rczgp85spmTt+Ds
	 v/7Nboh7da50A==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3acef9307c7so6433031fa.2
        for <linux-acpi@vger.kernel.org>; Fri, 20 Nov 2026 04:05:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHuR4+NaAyoIPmN1Q1e0mSUY4rs/H0ol7s3KWP0W5S51n/dgB6w93+guA/0jIMEivS8nkCv2Ao+Em9v@vger.kernel.org
X-Gm-Message-State: APuU4Z/yYMcPxSMCxxdrK2gFU8hw4rXzJ3NNgje4lZ0OmCqEYARB58xP
	uuxrB6jQsF03fipA7EoBR7cFNw2qPTMMGPspyvj37lilGO/wSg9Z5Ssxfw+HUlcLEdYbNKb5zCJ
	xWxHZM2KTWfN9NN+4mHLZGw4+D3bzh+M=
X-Received: by 2002:a05:6512:3f27:b0:5bf:b952:e57f with SMTP id
 2adb3069b0e04-5c1bc84e24emr931001e87.59.1795176343212; Fri, 20 Nov 2026
 04:05:43 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <6052490.DvuYhMxLoT@rafael.j.wysocki> <av9wpJqw6D1m_izi@google.com>
In-Reply-To: <av9wpJqw6D1m_izi@google.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 20 Nov 2026 13:05:30 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gGWzAzyVu8qCSJ2Jc7JkQUR+gU7QNJ8iQxe_pH1r1zpg@mail.gmail.com>
X-Gm-Features: Aa3M54rrwOpbkVwhO1pV4aPkc1yC_cHbTV1SJUjM2PI7hVT00bcAQf5eBQ5cDxw
Message-ID: <CAJZ5v0gGWzAzyVu8qCSJ2Jc7JkQUR+gU7QNJ8iQxe_pH1r1zpg@mail.gmail.com>
Subject: Re: [PATCH v1] ACPI: TAD: Improve runtime PM handling during driver removal
To: Brian Norris <briannorris@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 19, 2026 at 10:56=E2=80=AFPM Brian Norris <briannorris@chromium=
.org> wrote:
>
> On Thu, Nov 19, 2026 at 08:58:26PM +0100, Rafael J. Wysocki wrote:
> > From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> >
> > In acpi_tad_remove(), instead of attempting a runtime suspend of the
> > device which may be blocked by user space via "power/control", change
> > the device's runtime PM status to "suspended" after disabling runtime
> > PM for it to potentially unblock the runtime suspend of its parent and
> > suppliers (if any).
> >
> > Since pm_runtime_suspend() is not called in acpi_tad_remove() any more,
> > the latter need not drop the runtime PM reference to the device held by
> > it, so make it use guard()() instead of scoped_guard() for acquiring
> > that reference and reduce the indentation level.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/acpi/acpi_tad.c |   22 ++++++++++++----------
> >  1 file changed, 12 insertions(+), 10 deletions(-)
> >
> > --- a/drivers/acpi/acpi_tad.c
> > +++ b/drivers/acpi/acpi_tad.c
> > @@ -850,19 +850,21 @@ static void acpi_tad_remove(void *data)
> >
> >       device_init_wakeup(dev, false);
> >
> > -     scoped_guard(pm_runtime_noresume, dev) {
> > -             if (dd->capabilities & ACPI_TAD_AC_WAKE) {
> > -                     acpi_tad_disable_timer(dev, ACPI_TAD_AC_TIMER);
> > -                     acpi_tad_clear_status(dev, ACPI_TAD_AC_TIMER);
> > -             }
> > -             if (dd->capabilities & ACPI_TAD_DC_WAKE) {
> > -                     acpi_tad_disable_timer(dev, ACPI_TAD_DC_TIMER);
> > -                     acpi_tad_clear_status(dev, ACPI_TAD_DC_TIMER);
> > -             }
> > +     guard(pm_runtime_noresume)(dev);
> > +
> > +     if (dd->capabilities & ACPI_TAD_AC_WAKE) {
> > +             acpi_tad_disable_timer(dev, ACPI_TAD_AC_TIMER);
> > +             acpi_tad_clear_status(dev, ACPI_TAD_AC_TIMER);
> > +     }
> > +     if (dd->capabilities & ACPI_TAD_DC_WAKE) {
> > +             acpi_tad_disable_timer(dev, ACPI_TAD_DC_TIMER);
> > +             acpi_tad_clear_status(dev, ACPI_TAD_DC_TIMER);
> >       }
> >
> > -     pm_runtime_suspend(dev);
> >       pm_runtime_disable(dev);
> > +     /* Allow the parent and suppliers (if any) to suspend. */
> > +     pm_runtime_set_suspended(dev);
> > +     /* No need to power down, the PM domain detach will take care of =
it. */
>
> Personally, I think it's a little odd to require coding patterns like
> this (and comments, because it's admittedly subtle!) that assume
> .runtime_suspend() is a no-op. But it works for simple drivers like
> this, where the real work is done by others.
>
> Anyway, that's just a general observation, and more of a framework
> thing. This patch looks fine:
>
> Reviewed-by: Brian Norris <briannorris@chromium.org>

Thanks!

> BTW, should we drop pm_runtime_suspend() from probe() too? It's
> susceptible to the same sort of problem, although it's a benign one
> there. It's also a bit redundant, since there will be a post-probe()
> idle request anyway.

Right, it is redundant.

Thanks for pointing this out to me!
