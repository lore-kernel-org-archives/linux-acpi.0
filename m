Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D829F2F6184
	for <linux-acpi@vger.kernel.org>; Tue, 21 Jul 2026 13:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784640638; cv=none; b=oS5N/0bw7biq+SsrXAopvB3VkZ628p9zSCbf/KjlNwXq2RSNpz+QBkut1rI0rRGkRm1PReWUAyHELFNy9it2I6cRQWN/PqgamXVe6NyjU4KQUl0f40/KZ/NyomnCF50xCroWmWUQUNEsMLkaRh/MGR7aeAhJn3Za4AycdDQ0j40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784640638; c=relaxed/simple;
	bh=lOgNrObHDnfmm5oFitCT08LmlrhhOLN4XZnnVCZm+50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FpW8oGRqwvkV05PvqqkHr+rrfyzfCFBiLMuTyC5u32RkwtVtZ0uFWchN/c5nm4FQDZ+IySVCjfkOh8Tv6v56K8H1rw0xNREGbcpLOGwI1XwM1OTk+8kAOVrqA3gej9pAT+d14A0RzFEfiC+luiajVGqJz5NsWZRh74jBfEs7v/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nRVoyO/R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nRVoyO/R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CA931F00A3D
	for <linux-acpi@vger.kernel.org>; Tue, 21 Jul 2026 13:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784640637;
	bh=PpdxDaFiWvdVHkOGM0kYQROhWLkjSCDZq4CoFxQFTqM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=nRVoyO/RLfpbPSeDKX86K+DZ+563I+qtOAdpRyquQ/lVRz7Y3RKrYfN6s53H/+B9d
	 Rl6TAPZ7+LQhl5NhFA9UC9F3EdxmrN4lrbEHJvkJwc5BPcONNcefxgaXPf2l+bgpxb
	 lwLgfjjn2qokexelA50p+8kVCDCr6NHYDnUiiNG6m8C5j3KJ1vPzggeDcyOU4r27Xe
	 9w+apL4dSAFUN6WmVsot2SAgLqg73Nfs1zwDEz94Zcf15d5j4ClOEeE4Six4ZUp4G6
	 Or30Dwi5Pyd4OPP0sFgquR+CdCxzV2VCvX1RtDdTmY6qs75LkZng3Y+lDL1wCdNbRJ
	 CBJOBc9tBqfkg==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-39c7ac9b8c3so74634881fa.0
        for <linux-acpi@vger.kernel.org>; Tue, 21 Jul 2026 06:30:37 -0700 (PDT)
X-Gm-Message-State: AOJu0Yx+tPjqO3M5aOzL30S+DvkdV5YQT14n3ZVi0FdHJmsF/hfk6B7b
	kLvUF+euVfLjWT/9kKjqNveKSevN8ABMujCbtNDY+kLacSw9GcsJTPH2C3mDMhYr06zjD7amSoy
	KDz0N96VwJqo0F22NB2JhAO25+S4whd8=
X-Received: by 2002:a05:6512:668c:10b0:5ae:b86b:71f4 with SMTP id
 2adb3069b0e04-5b28f9aa296mr2276655e87.39.1784640635993; Tue, 21 Jul 2026
 06:30:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710125122.1621877-1-hpa@redhat.com> <630c82a7-438d-4a71-872a-575eb65d4004@app.fastmail.com>
In-Reply-To: <630c82a7-438d-4a71-872a-575eb65d4004@app.fastmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 21 Jul 2026 15:30:23 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iKFu7S2cnEaxNnPM90MYeziec4Rkiywo6uSsTCTJPh-g@mail.gmail.com>
X-Gm-Features: AUfX_mwgGfI5KDkrzoEuyFG2MtBf8sDwFuUivb4nW-SiY8g6A5s16pf4zhyJaKQ
Message-ID: <CAJZ5v0iKFu7S2cnEaxNnPM90MYeziec4Rkiywo6uSsTCTJPh-g@mail.gmail.com>
Subject: Re: [PATCH v2] acpi: battery: Sanitise model_number by dropping
 unprintable characters
To: Mark Pearson <mpearson-lenovo@squebb.ca>, Kate Hsuan <hpa@redhat.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2026 at 5:36=E2=80=AFPM Mark Pearson <mpearson-lenovo@squeb=
b.ca> wrote:
>
> On Fri, Jul 10, 2026, at 8:51 AM, Kate Hsuan wrote:
> > The battery Embedded Controller (EC) may return the model name with
> > trailing unprintable or non-ASCII characters. For example, on some syst=
ems:
> >
> > $ cat /sys/class/power_supply/BAT0/model_name
> > LNV-5B10W51864=EF=BF=BD=EF=BF=BD
> >
> > If a non-ASCII or an unprintable character is found, it will be replace=
d
> > with '\0' to ensure the model_number is a valid string. If left intact,
> > the malformed string prevents udev rules and hwdb working correctly.
> >
> > Link: https://gitlab.freedesktop.org/upower/upower/-/work_items/345
> >
> > Signed-off-by: Kate Hsuan <hpa@redhat.com>
> > ---
> >  drivers/acpi/battery.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> > index f5e0eb299610..4409fb95b988 100644
> > --- a/drivers/acpi/battery.c
> > +++ b/drivers/acpi/battery.c
> > @@ -10,6 +10,7 @@
> >
> >  #define pr_fmt(fmt) "ACPI: battery: " fmt
> >
> > +#include <linux/ctype.h>
> >  #include <linux/delay.h>
> >  #include <linux/dmi.h>
> >  #include <linux/jiffies.h>
> > @@ -483,6 +484,15 @@ static int acpi_battery_get_status(struct
> > acpi_battery *battery)
> >       return 0;
> >  }
> >
> > +static void acpi_battery_clean_unprintable_chars(char *str, size_t len=
gth)
> > +{
> > +     for (unsigned int i =3D 0; i < length; i++) {
> > +             if (!isascii(str[i]) || !isprint(str[i])) {
> > +                     str[i] =3D '\0';
> > +                     break;
> > +             }
> > +     }
> > +}
> >
> >  static int extract_battery_info(const int use_bix,
> >                        struct acpi_battery *battery,
> > @@ -524,6 +534,10 @@ static int extract_battery_info(const int use_bix,
> >           battery->capacity_now > battery->full_charge_capacity)
> >               battery->capacity_now =3D battery->full_charge_capacity;
> >
> > +     if (!result)
> > +             acpi_battery_clean_unprintable_chars(battery->model_numbe=
r,
> > +                                     ARRAY_SIZE(battery->model_number)=
);
> > +
> >       return result;
> >  }
> >
> > --
> > 2.55.0
>
> Thanks Kate - I know this impacts a few of our platforms and it will be g=
reat to have this fix.
>
> Implementation looks good to me.
> Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>

Applied as 7.3 material, thanks!
