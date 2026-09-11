Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17BC43DEAF
	for <linux-acpi@vger.kernel.org>; Fri, 11 Sep 2026 10:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789122333; cv=none; b=BeTqjNfnr37N5IgSbzPWNonOP3dD5IYdgJT/pE+Mos8FnWzKvxbTJ7cn5VzLLT+Qb5UZEHTySKVsv++jDlX8PeF5bB6W56zAf4sNbI1Q8u4C2+upNPgoMEinmwPMEez0bixrAOSEyOe+VpagUUAiWAychWPp0cgLMKBUunIwMr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789122333; c=relaxed/simple;
	bh=BCI3SQ9HU8MK9uLedEhEXlQ0BQwVpJHPndpiy4PqBu4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CuCsKOEfcxhtg8iB7Ei8luyhuqCEQnmw6+WYdWy6M9E9cXpi1qxv0s6gzZi1M8aa9W5WKoFXYTrcKqFBzBET+UWSGZ5Lzhl/tU2DWKrkksMQHKHxV20BaK/TPpkE71tOzpytvuQ6qU7UfA4o+66etnqG+ODNlVxAepxzRVSAIDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ncm+tnV1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ncm+tnV1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76BC31F00898
	for <linux-acpi@vger.kernel.org>; Fri, 11 Sep 2026 10:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789122331;
	bh=zQZs21mxPOyUqBF+HZ8/HQlhwXONKQO6BnIrlCQuQtM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ncm+tnV1Ql8G6yQ5tERj9aafmeENdkoE8yPxORrd6cIQNH55frHXGGwuJv/DV2JzL
	 sIavBbuKRl/72bj9CWM3HOf1U5BBCagYdQItPTYD+8U0uOV27+9rsdxAhsb7Fz/YEK
	 8gG+etdLkEIWeOFkTZnh0svPSRrc7ToF3vHHSWjjre89S3Ivd98BOuHlfsbt7YBN1V
	 qGhNUJWxRl549wnBsRUPRpMffU/u3SErZ3r5RG2xHi2btIUW6D6FHH5VgodeujHBAE
	 duvGoSaB0nRuhsHWpd5nsDNIg6YC1BfubD+chYmlPHQJhzykGFQutCziATB8K2jiSf
	 tH5UI2GnVGbGQ==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-3a4fc78b556so6708461fa.0
        for <linux-acpi@vger.kernel.org>; Fri, 11 Sep 2026 03:25:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByMFWxksCv6DhNTqxjS82x76Lt41AbMx/uzOYbPPi/V2Tcn7rgaMHjgobpuB9N99Huq4GVCFTbwhStZ@vger.kernel.org
X-Gm-Message-State: AFuF++kuI4pnSgiWuDHYnBXXqvxxX6tPbtY4/ekMXnANYO9t8Bj3jeBS
	zx2JWxfdT9JdYENN4idnkSenK+kCiaPeYFRgGv44wF8fmKma0j+AgRg94fM7I61wu/DXhOekv1N
	Y7ALKFhpNFJlH/AiGH02Gsu2XklmYYxQ=
X-Received: by 2002:a05:651c:a202:20b0:3a3:7681:6d74 with SMTP id
 38308e7fff4ca-3a5a52abb09mr2504951fa.29.1789122329799; Fri, 11 Sep 2026
 03:25:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12995802.O9o76ZdvQC@rafael.j.wysocki> <3465482.44csPzL39Z@rafael.j.wysocki>
 <aqOwUynzp3APwfYS@ashevche-desk.local>
In-Reply-To: <aqOwUynzp3APwfYS@ashevche-desk.local>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 11 Sep 2026 12:24:16 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jD4KvoBgcR1gysK1g7y48aM+w0=eNt1oq2QkbbS1vv7Q@mail.gmail.com>
X-Gm-Features: AcwNN1WyiqkHt0l1tukSkkAiOPeIT9X-tiOlzVf1YjANYevP63TLyxB_MkAGtqY
Message-ID: <CAJZ5v0jD4KvoBgcR1gysK1g7y48aM+w0=eNt1oq2QkbbS1vv7Q@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] ACPI: glue: Rearrange acpi_bind_one() to avoid breakage
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 9:40=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Sep 10, 2026 at 07:56:10PM +0200, Rafael J. Wysocki wrote:
>
> > Rearange the code in acpi_bind_one() to avoid situations in which the
> > existing ACPI companion of the given device would be replaced with NULL
> > due to a memory allocation error or because somebody tries to bind a
> > physical device with an ACPI companion to a different ACPI device
> > erroneously.
>
> ...
>
> >  int acpi_bind_one(struct device *dev, struct acpi_device *acpi_dev)
> >  {
> >       struct acpi_device_physical_node *physical_node, *pn;
> > +     struct acpi_device *comp_dev =3D ACPI_COMPANION(dev);
> >       char physical_node_name[PHYSICAL_NODE_NAME_SIZE];
> >       struct list_head *physnode_list;
> >       unsigned int node_id;
> >       int retval =3D -EINVAL;
> >
> > -     if (has_acpi_companion(dev)) {
> > -             if (acpi_dev) {
> > -                     dev_warn(dev, "ACPI companion already set\n");
> > +     if (!acpi_dev) {
> > +             if (!comp_dev)
> >                       return -EINVAL;
> > -             } else {
> > -                     acpi_dev =3D ACPI_COMPANION(dev);
> > -             }
> > -     }
> > -     if (!acpi_dev)
> > -             return -EINVAL;
> >
> > -     acpi_dev_get(acpi_dev);
> > -     get_device(dev);
> > -     physical_node =3D kzalloc_obj(*physical_node);
> > -     if (!physical_node) {
> > -             retval =3D -ENOMEM;
> > -             goto err;
> > +             /* If the companion has been set upfront, pick it up. */
> > +             acpi_dev =3D comp_dev;
> > +     }
> > +     if (comp_dev && comp_dev !=3D acpi_dev) {
> > +             dev_warn(dev, "ACPI companion already set to %s which is =
not %s\n",
> > +                      acpi_dev_name(comp_dev), acpi_dev_name(acpi_dev)=
);
> > +             return -EEXIST;
> >       }
>
> I would rewrite the above to look as following (if I got the logic right)
>
> int acpi_bind_one(struct device *dev, struct acpi_device *acpi_dev)
> {
>         struct acpi_device_physical_node *physical_node, *pn;
>         char physical_node_name[PHYSICAL_NODE_NAME_SIZE];
>         struct list_head *physnode_list;
>         struct acpi_device *comp_dev;
>         unsigned int node_id;
>         int retval =3D -EINVAL;
>
>         comp_dev =3D ACPI_COMPANION(dev);
>         if (comp_dev) {
>                 if (acpi_dev) {
>                         if (comp_dev !=3D acpi_dev) {
>                                 dev_warn(dev, "ACPI companion already set=
 to %s which is not %s\n",
>                                          acpi_dev_name(comp_dev), acpi_de=
v_name(acpi_dev));
>                                 return -EEXIST;
>                 } else {
>                         /* If the companion has been set upfront, pick it=
 up. */
>                         acpi_dev =3D comp_dev;
>                 }
>         } else if (!acpi_dev) {
>                 return -EINVAL;
>         }
>
> The rationale is to avoid assignment and known-to-be-false test later on.=
 Also
> split assignment that is going to be validated and moved it closer to the=
 user
> (this helps with maintenance in a long term). Unfortunately double test o=
f comp_dev
> against NULL just replaced with a double check of acpi_dev against NULL, =
no gain
> here.
>
> TL;DR: original and proposed pieces have their pros and cons.

There are reasons why I prefer the original changes.

There's fewer indentation levels and fewer lines of code there and
!acpi_dev is actually the most common case because acpi_bind_one() is
called with acpi_dev =3D=3D NULL for every device, so it is better to deal
with it upfront.

However, it can be observed that the condition in the second "if ()"
(in the original $subject patch) is obviously false if acpi_dev is
NULL, so it can be moved to an "else" branch in the first "if ()":

if (!acpi_dev) {
    if (!comp_dev)
        return -EINVAL;

    /* If the companion has been set upfront, pick it up. */
    acpi_dev =3D comp_dev;
} else if (acpi_dev !=3D comp_dev && comp_dev) {
    dev_warn(dev, "ACPI companion already set to %s which is not %s\n",
             acpi_dev_name(comp_dev), acpi_dev_name(acpi_dev));
    return -EEXIST;
}

and that avoids a redundant check when acpi_dev is NULL to start with
(and is one code line less even).

I'll make this change, but I'd rather not send a whole v2 of the
series for this, so I'll do it when applying the patch.

Thanks!
