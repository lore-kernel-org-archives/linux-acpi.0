Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356F93B3BFA
	for <linux-acpi@vger.kernel.org>; Wed, 18 Mar 2026 12:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773838429; cv=none; b=k+lv3rlKnjBJWFJ61v47MCw8rmzISaatt6l7RNDsBYunKmOl+RwXKFg6rdHTPXhmiediTuuYzQFQ9LJJXtQqiNqNIWvFywguUWt0xYXfBbEGZqfAw0JNE4ELNiILFfLyBATAsz7UEqBxVhwaOuQTstEQneH9Dg5yadHwiXtelrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773838429; c=relaxed/simple;
	bh=fpI8s6BMIIBn66z1Yt8/N7uhsCdDwhagyCfQJ8Nzc5U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sBBe9jl3241C59MfSNDuVFb/noluSxksVKCKrpVbIymdodT3rMP4EMIbLRbD1/egcZYi0QkTyjXci0QZMKV4xbZ6rweEB9CPQmBYzDXc4KanLmSbmkWz7ku586PYa1JUQO4P6ydAoWTNTp54BZ3+OKjFo1659LhB0DJs/AlIbd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XTZgRZzl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XTZgRZzl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAC07C2BCAF
	for <linux-acpi@vger.kernel.org>; Wed, 18 Mar 2026 12:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773838428;
	bh=fpI8s6BMIIBn66z1Yt8/N7uhsCdDwhagyCfQJ8Nzc5U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XTZgRZzlw0NSOIjJGzHW1K+0LpUlU/6vcU66Fwy6pCneBUJUR0x0JBDlO99ZoNvUe
	 nAKY7ASY5zoUVQ+sDydPp+lH0J3T9C/ltfc0cPpZwSXc2J8uU4g2zH3A8WAZSOi2eL
	 ObfPCvIrOBlGWKARrAUc5XLjcmDw1vWp2fdVXommrZ9Fnxlxq1KJFsCmWk0DYC6gXh
	 xR3Fw9ZGsg6n5TXsEkIGuXbvYXm8AUQtszwJ5RNvjgSA1Q3gmTuW8Ff4BGyD0ea77n
	 BSc3hS8COK+IenLPNy3FnNsoLtCMm0moo40XzaP5Uu2YvrFgDSe1XDFwrdA7eYATVF
	 cuRCG79UjQ+uw==
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-67baf20e8c2so2176399eaf.3
        for <linux-acpi@vger.kernel.org>; Wed, 18 Mar 2026 05:53:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVFQ8CtE31AGeFeOjfH/ig5/ik5op49FgNGxuIVnM99i0wZ4/mIlcljkrxzlJbbCN/ypeWo1CajaFly@vger.kernel.org
X-Gm-Message-State: AOJu0YygBL07xpNTPldqdlut1xkOpD7bTbxVvL2WXI2wXbrtrq9OrR/s
	niWz19IVX2XTx9s3Uf2Cu50MX1quEAnh9Y8RbZn0dxRuimU0rHMgo2ZfX1zr6xfQOq/fvY9afaL
	2oGfG6rd+/ztQPbMco3kek551QWdCeQc=
X-Received: by 2002:a05:6820:4513:b0:67b:f775:e5fe with SMTP id
 006d021491bc7-67c0db33831mr1779513eaf.65.1773838427822; Wed, 18 Mar 2026
 05:53:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3616223.QJadu78ljV@rafael.j.wysocki> <4508640.ejJDZkT8p0@rafael.j.wysocki>
 <eb4ccb62-58fc-0d1b-7f74-2b1532448056@linux.intel.com>
In-Reply-To: <eb4ccb62-58fc-0d1b-7f74-2b1532448056@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 18 Mar 2026 13:53:36 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gFpqG7+6v_zu+mo3GVP6MZfp+1QANj8y3=Tgx0WWnrfQ@mail.gmail.com>
X-Gm-Features: AaiRm52vU7DS_lqLR0_tLDdq76IAK5B2x8EVwdqcdS6DPPolDuMGIpKErwEuE9A
Message-ID: <CAJZ5v0gFpqG7+6v_zu+mo3GVP6MZfp+1QANj8y3=Tgx0WWnrfQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] platform/x86: panasonic-laptop: Register ACPI
 notify handler directly
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux ACPI <linux-acpi@vger.kernel.org>, Hans de Goede <hansg@kernel.org>, 
	platform-driver-x86@vger.kernel.org, Kenneth Chan <kenneth.t.chan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2026 at 6:35=E2=80=AFPM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Thu, 12 Mar 2026, Rafael J. Wysocki wrote:
>
> > From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> >
> > To facilitate subsequent conversion of the driver to a platform one,
> > make it install an ACPI notify handler directly instead of using
> > a .notify() callback in struct acpi_driver.
> >
> > No intentional functional impact.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/platform/x86/panasonic-laptop.c | 20 +++++++++++++++-----
> >  1 file changed, 15 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/platform/x86/panasonic-laptop.c b/drivers/platform=
/x86/panasonic-laptop.c
> > index 64195ff0f40e..4bd83b987761 100644
> > --- a/drivers/platform/x86/panasonic-laptop.c
> > +++ b/drivers/platform/x86/panasonic-laptop.c
> > @@ -185,7 +185,7 @@ enum SINF_BITS { SINF_NUM_BATTERIES =3D 0,
> >
> >  static int acpi_pcc_hotkey_add(struct acpi_device *device);
> >  static void acpi_pcc_hotkey_remove(struct acpi_device *device);
> > -static void acpi_pcc_hotkey_notify(struct acpi_device *device, u32 eve=
nt);
> > +static void acpi_pcc_hotkey_notify(acpi_handle handle, u32 event, void=
 *data);
> >
> >  static const struct acpi_device_id pcc_device_ids[] =3D {
> >       { "MAT0012", 0},
> > @@ -208,7 +208,6 @@ static struct acpi_driver acpi_pcc_driver =3D {
> >       .ops =3D          {
> >                               .add =3D          acpi_pcc_hotkey_add,
> >                               .remove =3D       acpi_pcc_hotkey_remove,
> > -                             .notify =3D       acpi_pcc_hotkey_notify,
> >                       },
> >       .drv.pm =3D       &acpi_pcc_hotkey_pm,
> >  };
> > @@ -869,9 +868,9 @@ static void acpi_pcc_generate_keyinput(struct pcc_a=
cpi *pcc)
> >               pr_err("Unknown hotkey event: 0x%04llx\n", result);
> >  }
> >
> > -static void acpi_pcc_hotkey_notify(struct acpi_device *device, u32 eve=
nt)
> > +static void acpi_pcc_hotkey_notify(acpi_handle handle, u32 event, void=
 *data)
> >  {
> > -     struct pcc_acpi *pcc =3D acpi_driver_data(device);
> > +     struct pcc_acpi *pcc =3D data;
> >
> >       switch (event) {
> >       case HKEY_NOTIFY:
> > @@ -1073,13 +1072,18 @@ static int acpi_pcc_hotkey_add(struct acpi_devi=
ce *device)
> >       if (result)
> >               goto out_backlight;
> >
> > +     result =3D acpi_dev_install_notify_handler(device, ACPI_DEVICE_NO=
TIFY,
> > +                                              acpi_pcc_hotkey_notify, =
pcc);
> > +     if (result)
> > +             goto out_sysfs;
> > +
> >       /* optical drive initialization */
> >       if (ACPI_SUCCESS(check_optd_present())) {
> >               pcc->platform =3D platform_device_register_simple("panaso=
nic",
> >                       PLATFORM_DEVID_NONE, NULL, 0);
> >               if (IS_ERR(pcc->platform)) {
> >                       result =3D PTR_ERR(pcc->platform);
> > -                     goto out_sysfs;
> > +                     goto out_notify_handler;
> >               }
> >               result =3D device_create_file(&pcc->platform->dev,
> >                       &dev_attr_cdpower);
> > @@ -1095,6 +1099,9 @@ static int acpi_pcc_hotkey_add(struct acpi_device=
 *device)
> >
> >  out_platform:
> >       platform_device_unregister(pcc->platform);
> > +out_notify_handler:
> > +     acpi_dev_remove_notify_handler(device, ACPI_DEVICE_NOTIFY,
> > +                                    acpi_pcc_hotkey_notify);
> >  out_sysfs:
> >       sysfs_remove_group(&device->dev.kobj, &pcc_attr_group);
> >  out_backlight:
> > @@ -1123,6 +1130,9 @@ static void acpi_pcc_hotkey_remove(struct acpi_de=
vice *device)
> >
> >       sysfs_remove_group(&device->dev.kobj, &pcc_attr_group);
> >
> > +     acpi_dev_remove_notify_handler(device, ACPI_DEVICE_NOTIFY,
> > +                                    acpi_pcc_hotkey_notify);
> > +
>
> This diverges from the setup order. Is that intentional? (I can see the
> current order is not exactly reverse of the setup order but it still
> looks it's possible to place the added remove call better than here.)
>
> This driver also likely has pre-existing rollback problems related to
> pcc_register_optd_notifier/pcc_unregister_optd_notifier().

So it would be good to fix them while at it.

OK, I'll have a look.

> >       backlight_device_unregister(pcc->backlight);
> >
> >       input_unregister_device(pcc->input_dev);
> >
>
> --
>  i.
>
