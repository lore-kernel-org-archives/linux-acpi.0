Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581DD5867C1
	for <linux-acpi@vger.kernel.org>; Wed,  9 Sep 2026 14:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788965929; cv=none; b=GSquHevsOKRDx6/7iPhfdk8bgVQXZwrs+45ItUKWMCxrq8oKptnp1hgo7Giu0QSxUxNmycgoEPJOu562WXuRujOB369dA7T14QZQDDoYEcHrHE6X1TTHp1x3fzctaTQQoc6O8vQjSyHC727sPBQbcVatbX+BQI5LHfkA8oCoKeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788965929; c=relaxed/simple;
	bh=B7ORsixADnuoEnV1y+wk0R19TAH/p4NoYe9f4Iyx3fg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OTUDwF8cXIOSG3249aRgG3KeZrUexpAfaVfkZfArzpWp31h2fIKqVqI4xje9MmPjDckZabkypvG4V7u4wJlkF4SoGQSJHXJu9NamLKjkXslynigHKVnxfapZVGJIlr0RdCK/OEW34SMhJx9tvw7qLIpRxhH4MjbdMDLOk1K8ZGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZOzAkLWG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZOzAkLWG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F4A51F01558
	for <linux-acpi@vger.kernel.org>; Wed,  9 Sep 2026 14:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788965928;
	bh=5EnwTFIFCw2iLU4TD+HjqWQfN8cIErcK8cG39xcxPCE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ZOzAkLWGO3afPNnywGBT7HTafXTpuhNiFXc5X5x723ppAtWFvVNKfKPFvAZd4Y786
	 NX+43UQvDC6Wfg8Axo2rx4g+QI2/QCJ8+ePabfpoyi5tTvoxwD+WIUTg+2ndBdVP3m
	 pviODkGrGxHs/L4VrWto/aLRtDGi2jdCK98Zz9EbMmCltNEyx/McvNeHpsYxaVm9Cr
	 5zUXkyQ6IYXjf2Hpz8qBEGurylOOvvBci2zlk3D0u/Z4Sn18O12XaUiGmHvNyC/mmi
	 dZBKOoaTGwOXV2Yg8qeSf0tg1VZovf38FPB2U+vQunH9b+g+cOa5f/ah1H0H4d5ajE
	 Bg81tKy97KVVw==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5b8996d65a3so306099e87.2
        for <linux-acpi@vger.kernel.org>; Wed, 09 Sep 2026 07:58:48 -0700 (PDT)
X-Gm-Message-State: AFuF++nzLD53IyXxJ4egOWdMrmsz0hXVDY0BlISTPTgVwCTOu2t6K4bN
	bLEAFaaOhnrVvhE6orFJzBCgMtJnvkfExGuCc7hAFdwAL3bSe1hiKdXw8pDU3jHRBszv3/w7qDk
	nDrgRiKGiciDAMxxEODvAR6VhAer1Z4U=
X-Received: by 2002:a05:6512:b82:b0:5b6:183c:5c84 with SMTP id
 2adb3069b0e04-5b6183c5d18mr6806077e87.34.1788965926539; Wed, 09 Sep 2026
 07:58:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820031253.1636952-1-triet.hoang.dev@gmail.com> <CAJZ5v0hBR1Y+exJN0gg1L5GqjMwxLUPu+GWHHJzbLctoFLFNCA@mail.gmail.com>
In-Reply-To: <CAJZ5v0hBR1Y+exJN0gg1L5GqjMwxLUPu+GWHHJzbLctoFLFNCA@mail.gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 9 Sep 2026 16:57:36 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i0HVptViJ67Uq5V9+NNKbWgVTcnYBA3NBf-7ta84-OVQ@mail.gmail.com>
X-Gm-Features: AcwNN1U9Uyzv8Vp_BBLeUjafqUQ0vnz9aBThd3Q6OIWh8ZjwGLiQZxnlwBT6BpM
Message-ID: <CAJZ5v0i0HVptViJ67Uq5V9+NNKbWgVTcnYBA3NBf-7ta84-OVQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: AC: use DEFINE_SIMPLE_DEV_PM_OPS
To: Triet Hoang <triet.hoang.dev@gmail.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 4:44=E2=80=AFPM Rafael J. Wysocki (Intel)
<rafael@kernel.org> wrote:
>
> On Thu, Aug 20, 2026 at 5:12=E2=80=AFAM Triet Hoang <triet.hoang.dev@gmai=
l.com> wrote:
> >
> > Convert the deprecated SIMPLE_DEV_PM_OPS
> > to DEFINE_SIMPLE_DEV_PM_OPS
> >
> > Also use pm_sleep_ptr() when assigning the ops to the driver.
> > This allows the removal of the ifdef CONFIG_PM_SLEEP.
> >
> > Signed-off-by: Triet Hoang <triet.hoang.dev@gmail.com>
> > ---
> >  drivers/acpi/ac.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
> > index f19d6dd43473..eef0c8e32d73 100644
> > --- a/drivers/acpi/ac.c
> > +++ b/drivers/acpi/ac.c
> > @@ -239,7 +239,6 @@ static int acpi_ac_probe(struct platform_device *pd=
ev)
> >         return 0;
> >  }
> >
> > -#ifdef CONFIG_PM_SLEEP
> >  static int acpi_ac_resume(struct device *dev)
> >  {
> >         struct acpi_ac *ac =3D dev_get_drvdata(dev);
> > @@ -253,9 +252,8 @@ static int acpi_ac_resume(struct device *dev)
> >
> >         return 0;
> >  }
> > -#endif
>
> And the function above is going to be unused when CONFIG_PM_SLEEP is
> unset, causing the compiler to complain AFAICS.

Scratch this, but you should mention in the changelog that the file is
going to contain dead code for CONFIG_PM_SLEEP after this change.

And I'm not really sure if I like that.

> > -static SIMPLE_DEV_PM_OPS(acpi_ac_pm, NULL, acpi_ac_resume);
> > +static DEFINE_SIMPLE_DEV_PM_OPS(acpi_ac_pm, NULL, acpi_ac_resume);
> >
> >  static void acpi_ac_remove(struct platform_device *pdev)
> >  {
> > @@ -270,7 +268,7 @@ static struct platform_driver acpi_ac_driver =3D {
> >         .driver =3D {
> >                 .name =3D "ac",
> >                 .acpi_match_table =3D ac_device_ids,
> > -               .pm =3D &acpi_ac_pm,
> > +               .pm =3D pm_sleep_ptr(&acpi_ac_pm),
> >         },
> >  };
> >
> > --
> > 2.53.0
> >
