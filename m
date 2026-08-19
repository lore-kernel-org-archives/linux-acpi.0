Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD773D6476
	for <linux-acpi@vger.kernel.org>; Wed, 19 Aug 2026 19:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787169251; cv=none; b=pqLXRfvEtjarI+2oVx17CbIxTDWvCjum9xtIRfqrmT+/QYDpn7fIjEwNTWFoe8Xlb2lhIAE2Wz2H0Yw0Yt8WBWNsbFlUUgNfJp56ahOFdmeOZGxjVAzhykJfxlio0vl6B4mpX3KBAbGZXawPWxUHfBp75eofHio/Y0ZXwn7dszE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787169251; c=relaxed/simple;
	bh=aXwgRC1w0nDHn2XY8PIVkmDjVpqm3lDO8yUnLqwO79o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FZe+j5TwpzFZrhEv8J1ghhbT5eZJvhUZJtMwokLyKNuljagEf7c+qqlmDVQ9k4j9PJ6EY63swaxmdEIlAw+gdbT2w6/9zfSlZaIBvNoTPnrIxO+leBhq2y8cg4S98sSDVKaqaGmRW+gokXoqHdQAPsqrlvwT0rr9o0K84SEmS34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bjshCy06; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bjshCy06"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72F511F01558
	for <linux-acpi@vger.kernel.org>; Wed, 19 Aug 2026 19:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787169249;
	bh=vXsmmJ0PeYlY9D1AVjw84jzsQ7K1JZcENXFwbh/3+jM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=bjshCy06zxrg1/eEi2xcS5JgNz+UjOv3wPQTw3EJsXtO+HDlwisA5rgi1FbmpUGPb
	 NqTS69QaCTIe5zTQm2WyNJu6cfIvE3Uzq/PQ+W23OdItHJp/9JO0lS9wv3RaoSdvtj
	 RVh0Ox7nC/M+7IxFXKZJp/rTCsrkPVnrPVJl31UFbYQDz1J9f+mKfCEaUScdVTQ1og
	 vsVH9q8NtplZ14TTf8BGjCqNvAINzpkx+jCOPYNF+c4tmsftFHeB1rNjBAh4kjvjKB
	 suUHDp4+tEtN9oausiXPdSGX2wVolje1SYvHaMgNuxYMBDNTCQer5jgD5vBRsAyjM2
	 51J+TzF7eT4Iw==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-39faf9e2c62so10320321fa.3
        for <linux-acpi@vger.kernel.org>; Wed, 19 Aug 2026 12:54:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrZJhKNX1TkXNW3vJDSpCmlR8aSjXNpmShQpN3L7/IgAsz8wZG9iXXn/turtlfERWJ8/qH/BSoEv9cp@vger.kernel.org
X-Gm-Message-State: AOJu0YxzLC1E8R9ldjpik6kVrofDrOu5Rh+B3PcTr5lAFtKvxZnRxBEq
	5az+guDyz8u/Z7gRSae8cLzKqYnM24GhImYqI0NRyfgja9dZjc5G0FE0jRGi9GcRBTeTWUp1MX/
	BWuTQalADxfB2EMFYZSm+T2CI4lSYtiE=
X-Received: by 2002:a05:651c:19a9:b0:39b:a75:e8da with SMTP id
 38308e7fff4ca-3a189746de6mr18004911fa.3.1787169247885; Wed, 19 Aug 2026
 12:54:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12955541.O9o76ZdvQC@rafael.j.wysocki> <CAJZ5v0j0mgTRjwrHbzTPwycuktDRahoexCdzbcNsRh7f8GKPDw@mail.gmail.com>
 <CAJZ5v0i59XtzNTepjb_hh=93E5Cy6pVZmkssKVOoLZL7nvpW0Q@mail.gmail.com>
 <12952304.O9o76ZdvQC@rafael.j.wysocki> <20260819173157.GB3138944@ax162>
 <CAJZ5v0jpBNEjQqbJq3hrNqCAG_TWkv8SikWB9c8i_V5xZS9Q7Q@mail.gmail.com> <20260819194039.GA3686901@ax162>
In-Reply-To: <20260819194039.GA3686901@ax162>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 19 Aug 2026 21:53:36 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gPmwL2etkQs67u3kpyUvEwG32yGD533pDemWuwaOKn0Q@mail.gmail.com>
X-Gm-Features: AcwNN1WGoqFBVMPBqyGn_AcKYJVzOY6H73-6J-N4BlzHrn57UcmKiRWANOrKpro
Message-ID: <CAJZ5v0gPmwL2etkQs67u3kpyUvEwG32yGD533pDemWuwaOKn0Q@mail.gmail.com>
Subject: Re: [PATCH v3] ACPI: scan: Avoid registering platform devices with
 resource overlaps
To: Nathan Chancellor <nathan@kernel.org>
Cc: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Julien <julien82453@gmail.com>, 
	jarkko@kernel.org, linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2026 at 9:40=E2=80=AFPM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> On Wed, Aug 19, 2026 at 09:00:09PM +0200, Rafael J. Wysocki (Intel) wrote=
:
> > On Wed, Aug 19, 2026 at 7:32=E2=80=AFPM Nathan Chancellor <nathan@kerne=
l.org> wrote:
> > >
> > > On Wed, Aug 19, 2026 at 03:55:43PM +0200, Rafael J. Wysocki wrote:
> > > > And below is one to try.
> > > >
> > > > ---
> > > >  drivers/acpi/acpi_platform.c |    7 ++++++-
> > > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > > >
> > > > --- a/drivers/acpi/acpi_platform.c
> > > > +++ b/drivers/acpi/acpi_platform.c
> > > > @@ -85,7 +85,12 @@ static unsigned int acpi_platform_adjust
> > > >       for (i =3D 0; i < count; ) {
> > > >               struct resource *res =3D &resources[i];
> > > >
> > > > -             if (resource_type(new_res) !=3D resource_type(res) ||
> > > > +             /*
> > > > +              * Look for overlaps of resources of the same type th=
at
> > > > +              * would cause resource insertion to fail.
> > > > +              */
> > > > +             if (__resource_contains_unbound(new_res, res) ||
> > > > +                 resource_type(new_res) !=3D resource_type(res) ||
> > > >                   !resource_union(new_res, res, new_res)) {
> > > >                       i++;
> > > >                       continue;
> > > >
> > > >
> > > >
> > >
> > > This does not appear to resolve the probe failure for me.
> >
> > So can you please try to reverse new_res and res in the
> > __resource_contains_unbound() check in the patch and try again?
>
> Can confirm that
>
> diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
> index fffdd4f011b2..ea3b2e03ebae 100644
> --- a/drivers/acpi/acpi_platform.c
> +++ b/drivers/acpi/acpi_platform.c
> @@ -85,7 +85,12 @@ static unsigned int acpi_platform_adjust_resources(str=
uct acpi_device *adev,
>         for (i =3D 0; i < count; ) {
>                 struct resource *res =3D &resources[i];
>
> -               if (resource_type(new_res) !=3D resource_type(res) ||
> +               /*
> +                * Look for overlaps of resources of the same type that
> +                * would cause resource insertion to fail.
> +                */
> +               if (__resource_contains_unbound(res, new_res) ||
> +                   resource_type(new_res) !=3D resource_type(res) ||
>                     !resource_union(new_res, res, new_res)) {
>                         i++;
>                         continue;
> --
>
> resolves the probe failure for me.

Great, thanks for testing!

I'll send a proper patch tomorrow.
