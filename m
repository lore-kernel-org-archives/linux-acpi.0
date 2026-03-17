Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8FA3876A2
	for <linux-acpi@vger.kernel.org>; Tue, 17 Mar 2026 20:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773780289; cv=none; b=irIl7a02NxQsu0+0jSAnOYlibS0bwU26y5nkc5e/X7HF7yN3bD00PGcpClh776Ez4+FolGubqhjgacFZdeslwpAcIf1aRkniKlWSD/wldbRaj3+iNjR8OMaVKzSSH54vtEKcye4kCeRv0FpWTNWHsFdgqU4ri9JF9FOhmFWSD4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773780289; c=relaxed/simple;
	bh=xjGBIgZLlUlQ1hOLfDsSsuLb/HJydiwHrPwmlSEs6qk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UK1jzKWzbGAMu4lsjIJ98tpSDth8+Hbi3nv4xKgOPNQSPZTvV1YjfuBq/E0rhMFOQDU0wXYKfk1rkf4sLlCDLHLePUpHXbBYZyJr3PiGiGQy5VjXGRKB+f0GZEszVCeN6/p+6M21232xLrsvDfcllsXyfSs+p3KlhHUcrdYMNG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mwc21Ptd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mwc21Ptd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FBA9C2BCAF
	for <linux-acpi@vger.kernel.org>; Tue, 17 Mar 2026 20:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773780289;
	bh=xjGBIgZLlUlQ1hOLfDsSsuLb/HJydiwHrPwmlSEs6qk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Mwc21PtdJ/T00Dl9ApyBVG+f+Hmz4Be1j6yDCWdKQioa/wNXJ4AlVJYguK9zI+Ihd
	 tuvrqdAKklX6ExlS6du+Y/BmiF8xiM/PQag4g3H4O9PweyZQiwaLuDUdIUS2CkYfj9
	 3sKuJkh52Aleyk2xbt8AzkfV735ACSXePhU/pSvnY2ovdZiG4EIDagxpja22yS2tQz
	 mn+svDLJVDx79+pJl/eKcYY7Lu/5jW6Zi+p4fT6d2LL7/WbuseM4hSFydZy+md0YEK
	 8EeYmgSAko9oFsNuBRHmGgR9fQTpmaAbJ/ksvAIXow3oYf7heccTERCOk0IPIirWP+
	 u0/YQAZWqwubw==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-40f387a688dso97999fac.0
        for <linux-acpi@vger.kernel.org>; Tue, 17 Mar 2026 13:44:49 -0700 (PDT)
X-Gm-Message-State: AOJu0YyZ/d8tYmJ7kXZUxcXjRa40vjZilGRRybK9NBsI8H0W84NRhmlD
	nTf1iA0rn1Yml3AOoSPkWCtc/Gl8qW/2aAN6hZpSokCS5N1F6mR9GnIUPbMEHWAcXSQQNLuAjoA
	zusO3A1Donc73hirb+gzU4FS7dw31bf4=
X-Received: by 2002:a05:6870:ac22:b0:3f5:5af:c9de with SMTP id
 586e51a60fabf-41bd4156623mr622846fac.51.1773780288251; Tue, 17 Mar 2026
 13:44:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12822121.O9o76ZdvQC@rafael.j.wysocki> <3030574.e9J7NaK4W3@rafael.j.wysocki>
 <a0ef8b7a-ced8-4384-9d88-e98629596a3b@roeck-us.net>
In-Reply-To: <a0ef8b7a-ced8-4384-9d88-e98629596a3b@roeck-us.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 17 Mar 2026 21:44:36 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gWZmppLYZRu56s1FtBm5eZ15V1EkvT-T-Vrfo2WNWPDw@mail.gmail.com>
X-Gm-Features: AaiRm53uK7-B7SXL8bFe5vfPJNhhY4WL5m2vWYFzFdf9jl7mYVQBDdKnwpZ3LBw
Message-ID: <CAJZ5v0gWZmppLYZRu56s1FtBm5eZ15V1EkvT-T-Vrfo2WNWPDw@mail.gmail.com>
Subject: Re: [PATCH v1 05/26] ACPICA: Fix NULL pointer dereference in acpi_ev_address_space_dispatch()
To: Guenter Roeck <linux@roeck-us.net>, "Dumbre, Saket" <saket.dumbre@intel.com>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Pawel Chmielewski <pawel.chmielewski@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2026 at 6:46=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> =
wrote:
>
> Hi,
>
> On Wed, Jan 14, 2026 at 01:20:17PM +0100, Rafael J. Wysocki wrote:
> > From: Alexey Simakov <bigalex934@gmail.com>
> >
> > Cover a missed execution path with a new check.
> >
> > Fixes: 0acf24ad7e10 ("ACPICA: Add support for PCC Opregion special cont=
ext data")
> > Link: https://github.com/acpica/acpica/commit/f421dd9dd897
> > Signed-off-by: Alexey Simakov <bigalex934@gmail.com>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/acpi/acpica/evregion.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/acpi/acpica/evregion.c b/drivers/acpi/acpica/evreg=
ion.c
> > index fa3475da7ea9..b6198f73c81d 100644
> > --- a/drivers/acpi/acpica/evregion.c
> > +++ b/drivers/acpi/acpica/evregion.c
> > @@ -163,7 +163,9 @@ acpi_ev_address_space_dispatch(union acpi_operand_o=
bject *region_obj,
> >                       return_ACPI_STATUS(AE_NOT_EXIST);
> >               }
> >
> > -             if (region_obj->region.space_id =3D=3D ACPI_ADR_SPACE_PLA=
TFORM_COMM) {
> > +             if (field_obj
> > +                 && region_obj->region.space_id =3D=3D
> > +                 ACPI_ADR_SPACE_PLATFORM_COMM) {
> >                       struct acpi_pcc_info *ctx =3D
> >                           handler_desc->address_space.context;
> >
> Google's experimental AI review agent provided the following feedback:
>
>  If this setup block is executed with a NULL `field_obj`, it will skip
>  initializing `ctx->length` and `ctx->subspace_id` even though they do no=
t
>  depend on `field_obj`.
>
>  Additionally, because this initialization is part of the
>  `!(region_obj->region.flags & AOPOBJ_SETUP_COMPLETE)` block, the setup f=
lag
>  will be set shortly after this. Does this mean that if the first call ha=
s a
>  NULL `field_obj`, the region will be marked as setup complete, and a
>  subsequent call with a valid `field_obj` will never initialize
>  `ctx->internal_buffer`? Should the `field_obj` check only guard the
>  assignment of `ctx->internal_buffer`?

Thanks for the report!

> Please let me know if this is a real concern or not to help improve the a=
gent.

Saket, Pawel, can you please have a look at this?
