Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795543993;
	b=oqmnIEe1eRyGyiPdNkY4J+97BKnli3NZgxe48HN8rPWVdWxj/mHr9Uvut9ZHk3D2gSnQ
	 jKWyNgjce705s6WHP0rwmI3hzHwo/mcz2mDf65X1RLmvr4KqUKDQpQUF1ps1CdZDu4zyw
	 OSxPspf3Jc0Ufau/iw0zm9n/pbuk/IFir8Q3unAAtRImv5PEjvsfqhDgvWoyVe74bOkTF
	 bKYSrsUrdXZ9c3S9yex1ZqTYZ4VW5Sa7zq9k9xczVyd9/YE/lBCMjwW+Vqr3KASq0JKI9
	 eOd91+lPPrKUpM2tuNHtUapwvqzd/OvEZlHqp5ljSEpVyWcbpqBqT0QvqAfRFNAkMng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795543993;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=gosVtrukTW/5/NEwvnr2FcIZlFj6gPLu6QFpdN7L/Gs=;
	b=247d6E8HKec08kG8pLcBhS69IP8PDLhQLBLj+iKlM9BrN0YzCnpzzrrdBzifORgVblYf
	 W4OG6DB1/FpljpZchDUmPPP9gnayonY1Dpnr8AlQD/Lo28dhJQjfOsA9GWkaMg+sMkKUS
	 6Fad5SXuvhRCF744WN5/8gmK9lq+vGNGlzFa/Jr0tRGbtHUtQPYv3EwHxgWYFlZ3hDTSZ
	 lO3kY6rNijGeTMYTkWLhgIEXvr78w7wkzq9iIfQEBhNTZ/KIz0+yxr6G/RMPsYWeYSK2t
	 HqIyoLBX2NdrPJAmLWezXr4HUxYqVx3n1iADYc/wliRKo4KE+DrWay8aZLdFAaJG9Dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=czgyOFVX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD18606A326
	for <linux-acpi@vger.kernel.org>; Tue, 24 Nov 2026 18:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=czgyOFVX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DDD81F00A00
	for <linux-acpi@vger.kernel.org>; Tue, 24 Nov 2026 18:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795543993;
	bh=gosVtrukTW/5/NEwvnr2FcIZlFj6gPLu6QFpdN7L/Gs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=czgyOFVXclfyXfriwv3XxvHNWIroC8qMsR35/jKD+ahI52/ujZFB86IGAAjeoGvKg
	 MTXBAI1pua4EA2V4ykmZJW8fAoZTgP1FuiApGAIdAUW5L4j3C7v4POs1/iv6H9j2Cz
	 UM6XvkVa+XhsKZpyY1dN7eSt6Z/j1rIMn1Fecs9LS2bJ1BJSqcfDvG8jPhBoQzbDQp
	 gRLAY1h4jaDNjHS+35zGpCgzMRhK96F/Ucs/9bNE7iQKWfJvSa3AoN5CDMMFVHd30t
	 ASdgEQNacvhbSLwlKrn0OA0+rsoHaSrmOD9opwNJaD9dd2zJGGi410PdWIqEjuy/e0
	 uk1/FxyEuZU8Q==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3ae25c9f857so51950941fa.1
        for <linux-acpi@vger.kernel.org>; Tue, 24 Nov 2026 10:13:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErER1Vqq/4sa2irB/K6S8ber0hBVmtZ1/0Nof2bE8ZS6GPtzmUb8xpklfTKpcCotmo4YkFpyRhuesN+U@vger.kernel.org
X-Gm-Message-State: APuU4Z9Vjb4KTEJ3qJtH815C8vHMykTnlznwBVRNXroY1XFxdL4u70Ip
	xaR7/kzy6ds71VaH+yx7XHo6CXPb8Wsk9FxAcYzWVjGZ/00uhDimYsIiPcezQa2pO5yRnOyGVxM
	KUrHszpYWQsFrMkkRw+HgczXvP6E2GaI=
X-Received: by 2002:a05:6512:23a0:b0:5c1:5c55:2d2d with SMTP id
 2adb3069b0e04-5c1bc7e68d2mr4651609e87.26.1795543991861; Tue, 24 Nov 2026
 10:13:11 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <3985766.kQq0lBPeGt@rafael.j.wysocki> <6217460.MhkbZ0Pkbq@rafael.j.wysocki>
 <awXGWwlZo0QIFvxA@ashevche-desk.local>
In-Reply-To: <awXGWwlZo0QIFvxA@ashevche-desk.local>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 24 Nov 2026 19:12:59 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0h=FeDNkUaa_25mUeXDLaVgg4YqD_JSwZPUBm9kT8qd1w@mail.gmail.com>
X-Gm-Features: Aa3M54pKSNT-PvjuyC9UUyumgmnt6VFrhDVgupy6P4mQgFud7kbtJ99gVXNmMkk
Message-ID: <CAJZ5v0h=FeDNkUaa_25mUeXDLaVgg4YqD_JSwZPUBm9kT8qd1w@mail.gmail.com>
Subject: Re: [PATCH v1 2/5] ACPI: fan: Stop using driver_data pointer from
 struct acpi_device
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	Linux PM <linux-pm@vger.kernel.org>, Armin Wolf <w_armin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2026 at 6:21=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Nov 24, 2026 at 04:47:12PM +0100, Rafael J. Wysocki wrote:
> >
> > Instead of using the driver_data pointer under struct acpi_device,
> > make the ACPI fan driver use the driver data under the dev member of
> > struct acpi_device and clean it up properly on driver removal and on
> > probe failures.
> >
> > While at it, unify the code ordering of acpi_fan_delete_attributes()
> > with the rollback path in acpi_fan_create_attributes().
>
> ...
>
> >  static ssize_t show_fine_grain_control(struct device *dev, struct devi=
ce_attribute *attr, char *buf)
> >  {
> >       struct acpi_device *acpi_dev =3D container_of(dev, struct acpi_de=
vice, dev);
> > -     struct acpi_fan *fan =3D acpi_driver_data(acpi_dev);
> > +     struct acpi_fan *fan =3D dev_get_drvdata(&acpi_dev->dev);
>
> I'm a bit lost. Is 'dev' parameter embedded into struct acpi_device
> ('acpi_dev') and later we again come to it via dereferencing 'acpi_dev'?
>
> If so, why not use 'dev' directly?

Yeah, good point, it can be done.

> >       return sysfs_emit(buf, "%d\n", fan->fif.fine_grain_ctrl);
> >  }
>
> ...
>
> >  void acpi_fan_delete_attributes(struct acpi_fan *fan)
> >  {
> >       struct acpi_device *device =3D fan->adev;
> > -     int i;
> >
> > -     sysfs_remove_file(&device->dev.kobj, &fan->fst_speed.attr);
> > +     if (fan->acpi4) {
>
> > +             int i;
> >
>
> While at it, ...
>
> > -     if (!fan->acpi4)
> > -             return;
> > +             for (i =3D 0; i < fan->fps_count; ++i)
>
> ...seems the local form can be used
>
>                 for (int i =3D 0; i < fan->fps_count; ++i)

Yes, it can.

> > +                     sysfs_remove_file(&device->dev.kobj, &fan->fps[i]=
.dev_attr.attr);
> >
> > -     for (i =3D 0; i < fan->fps_count; ++i)
> > -             sysfs_remove_file(&device->dev.kobj, &fan->fps[i].dev_att=
r.attr);
> > +             sysfs_remove_file(&device->dev.kobj, &fan->fine_grain_con=
trol.attr);
> > +             dev_set_drvdata(&device->dev, NULL);
> > +     }
> >
> > -     sysfs_remove_file(&device->dev.kobj, &fan->fine_grain_control.att=
r);
> > +     sysfs_remove_file(&device->dev.kobj, &fan->fst_speed.attr);
> >  }
>
> --
