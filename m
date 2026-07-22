Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D2933859A
	for <linux-acpi@vger.kernel.org>; Wed, 22 Jul 2026 09:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784710895; cv=pass; b=cc65luh+hocS60g9oVXMJUwASh0hkHeDutzMQ6pxHMn3qaFI+ld93JH4v/UEtuDe8nqLJqQef9dFVT5eGMx7wQyK45REmdlcLMm5uKsQ0vM7ND0U4+SzyNjH7Cr/3sus1AsznKdqA159cmb+9oRuzGSqgmWEfQS6fUj8R++NM0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784710895; c=relaxed/simple;
	bh=kjMhhSUJeM58LyEBWOqNhoBXbBuuVqDLE8DYLHYzEqE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VMwLMAOgpiLBsjQ2JJnvDkxlcBSnRNFM/2fkl2Fz2wzYkHavgVPlcocSUZjMs8Ukzuld8laGOyxB4uu8BQv/nw1EIJwPWu2rxnig889dfYaSdoeQxbLnvTFHomRDpO5ifFbBPk+FtCsIfxQsjb61Mw7jDxWlktR9wAxDTdBoaok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mXJbWsPe; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mXJbWsPe"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-81e69a2db34so74316987b3.0
        for <linux-acpi@vger.kernel.org>; Wed, 22 Jul 2026 02:01:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784710891; cv=none;
        d=google.com; s=arc-20260327;
        b=ZDOzHLSUbu+NQd4Xq/fpvaJxMSnSbJ6Gf4TK962jOd1iLA40zx8KAzDfNHM9zK/IcL
         m29fVnuR/cyu+B+REUuAahWax7QlkuFvQh+hYqHzjBRQHzO/0IvkH8l2mfn4w2U1cllV
         UGHphmv5ZNdf0HgE7A54Tz4Jss0LrcWea11G+IWArk0yMGAj7q/xhM/PdP4t7fhcB9w/
         HfkJlVtIxE5YsM2hSFhgc/k2g4CoxzuECJQVgD3uCxSWYxPxo9iCvZ82ldyX1JE4/e0r
         h2HenqM+zor+SXObIrKMUT0T2kOQUI80y2fftgmfpjE0fvVk561W7bUgmgckkE8CQ9LW
         sJmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BVQ32j56Dr60NJMwmM+X8AwJaAcbdmT9panK+KSnLpY=;
        fh=RVTNKcLszHkeAHYFpfeiyjfA7ItDSx1hjorJAZUR3DY=;
        b=fxAzDM7HR6LVRbPxhmdnwfDnKpqjF3/bDth6agKbFfNQSlTyMzJqCsvXwYbUqoNQ5P
         VUKvRGB7pOlbrl68PnXUpcwjSe3Mzf1Jg3+ks5DgNmtzp7SdLfCeemvqHvFEyT9VxFzV
         OVpGk2aOiEf3l7Bd+zenRG62Dt2RauSgjmJGlrI+ayK+WyAasY2mMZSgiYQKOtkP8mAE
         ZeeaCJr8KH2hVdyp4GWUG2WX/CsEhsILJS89m2uw3x0aQ2O1bsVw4J90+EVZKGavwOOB
         er/1diZVc/57qMBEAGODH3ZPANt5GCSW79ymEtn5Eokv++862Y60hcYhFKZ6ormyu1/S
         7SPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784710891; x=1785315691; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BVQ32j56Dr60NJMwmM+X8AwJaAcbdmT9panK+KSnLpY=;
        b=mXJbWsPeCO8FslQIu10GK72HjeWHi1GFyymj/tGTDhE5yi1vHwlRPV046PHgZ7VpF6
         NEAxPt8ne/efXzlFDPF3d0AZKJ1AtDazYWogGUm5jeMFvwz4KLohfxv1cU7ZnMbv00OG
         XoBwDO7yJNVGOswjqco0Vgsms2BhEWcHJ8IV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784710891; x=1785315691;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BVQ32j56Dr60NJMwmM+X8AwJaAcbdmT9panK+KSnLpY=;
        b=GhEjGJK9FNqZgfhH5zzAWTOFD2V8hXsgXAOjrdAHlx/WpEb13pNaZiAAtWW+pRBPYU
         xP0P5GU31ur+N3dAqr+sNTSQrAWO3Di/VRI6lIdBvh4utoe118C29eXQZGVNQU5CziSi
         UViB5UHwZWkqxaLaRhfXbP71anAntDEcxWLwPdbc977TcF34n5Cq7dJB6A8UTHDQ7Dz3
         gAZuKVKphotyGcIs0uSagYGlHwfolfnsWbwTEX0ZUYOd20Ovfb1eLseRcXVD5e2CYHDp
         eEfXYpSjus9u1ddQIuVaNUCSFkjJlK/9rcjDlXJZK9KsjDPekxuA9DirSwB6ggWfJIfw
         eSYw==
X-Gm-Message-State: AOJu0Yx+t1WgUzYXwSObH7k/e6moUnTctGUg52QbJbrNsRyiN6UrEHwH
	kqkNp5dYzXZAN1xdmGtVYu8uuDsyfjrgWG2JVv+ve9uhYRPwoKw/60UnUNNZA/5jXcMeNvCOIL0
	YOlf+B4GJLU1HKAVCM4IpH+eOvYNcZSruf1sT7kSQ
X-Gm-Gg: AR+sD11nvyPZMkOCYoXpfTKUT67d0Hj0MZ+Gr2HdMDnwNG9DiuPBoUsivX84WHFR9aA
	1fVsCzczuHNdAHJz2/s+WNdcGIvymqF3kvEjwGiMgcZ80USwT9pDh7EIZJdAtAj9tQABDd+F2WO
	T5XRJNUKvxdiVuMAKzISREfgrE2T9jUBVYIuwGwvhEmSjOmxwOHc6nVzyXYwjLsK967HmpsK6Pd
	2ucmQJWK2cwq/eyBH0N1DXJH0GDyU2BDSeUlME55qk5CyM6QU656BtyzK4Yn16wOzxmdAT6EdBT
	JVHWKIg7/dc9n9YK
X-Received: by 2002:a05:690c:e0c:b0:81e:6a1c:e30b with SMTP id
 00721157ae682-81ef28da7b0mr69266347b3.67.1784710891191; Wed, 22 Jul 2026
 02:01:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721065413.2306137-1-wenst@chromium.org> <20260721065413.2306137-4-wenst@chromium.org>
 <CAMRc=McsCRBxXMj0xC8H0cgdZZ=Z9_4u_DS9b2z0pLE0=gZr+g@mail.gmail.com>
In-Reply-To: <CAMRc=McsCRBxXMj0xC8H0cgdZZ=Z9_4u_DS9b2z0pLE0=gZr+g@mail.gmail.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Wed, 22 Jul 2026 17:01:20 +0800
X-Gm-Features: AUfX_mzymMOrnzz3ZSisQQjvbDECVUbqfaXF7TwtpwvIT3XYymwiPHVmpWvFgt8
Message-ID: <CAGXv+5H_V+J0cvrYjMFdKAQVrPKxPdtimXMc+hwHenwxhb9mDQ@mail.gmail.com>
Subject: Re: [PATCH v6 03/16] power: sequencing: Add pwrseq_power_is_on()
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Manivannan Sadhasivam <mani@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 5:08=E2=80=AFPM Bartosz Golaszewski <brgl@kernel.or=
g> wrote:
>
> On Tue, 21 Jul 2026 08:53:58 +0200, Chen-Yu Tsai <wenst@chromium.org> sai=
d:
> > The power sequencing consumer API already does power on state tracking
> > internally. Expose the state to consumers through pwrseq_power_is_on()
> > so that they don't have to reimplement it locally.
> >
> > Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > ---
> > Changes since v5:
> > - Reverted back to returning -EINVAL if descriptor is NULL
> >
> > Changes since v4:
> > - Make pwrseq_power_is_on() return 1 if descriptor is NULL, i.e. if
> >   the descriptor is optional, matching the other pwrseq consumer APIs
> >
> > Changes since v3:
> > - Added missing stub function for !POWER_SEQUENCING
> >
> > Changes since v2:
> > - New patch
> >
> > Needs to go in with "usb: hub: Power on connected M.2 E-key connectors"
> > as it is a build time dependency. Bartosz wants the change on an
> > immutable branch to pull into the pwrseq tree.
> > ---
> >  drivers/power/sequencing/core.c | 18 ++++++++++++++++++
> >  include/linux/pwrseq/consumer.h |  6 ++++++
> >  2 files changed, 24 insertions(+)
> >
> > diff --git a/drivers/power/sequencing/core.c b/drivers/power/sequencing=
/core.c
> > index 02f42da91598..72b96d36920e 100644
> > --- a/drivers/power/sequencing/core.c
> > +++ b/drivers/power/sequencing/core.c
> > @@ -968,6 +968,24 @@ int pwrseq_power_off(struct pwrseq_desc *desc)
> >  }
> >  EXPORT_SYMBOL_GPL(pwrseq_power_off);
> >
> > +/**
> > + * pwrseq_power_is_on() - Queries the last requested state of the powe=
r sequencer.
> > + * @desc: Descriptor referencing the power sequencer.
> > + *
> > + * This returns the last requested state of the power sequencer.
> > + *
> > + * Returns:
> > + * On success, 1 for on and 0 for off; negative error number on failur=
e.
> > + */
> > +int pwrseq_power_is_on(struct pwrseq_desc *desc)
> > +{
> > +     if (!desc)
> > +             return -EINVAL;
> > +
> > +     return desc->powered_on;
> > +}
> > +EXPORT_SYMBOL_GPL(pwrseq_power_is_on);
> > +
>
> Didn't we agree on introducing an enum to make it future-proof for when w=
e
> also pull in pwrseq_is_controllable() from Loic?

My bad. I misunderstood and thought it wasn't needed yet.

> I think this should work like so:
>
> enum {
>         PWRSEQ_STATE_UNKNOWN,
>         PWRSEQ_STATE_ON,
>         PWRSEQ_STATE_OFF,
> };
>
> int pwrseq_get_state(struct pwrseq_desc *desc)
> {

I think you still want this here?

          if (!desc)
                    return -EINVAL;


>         /* Only once this is upstream. */
>         if (!pwrseq_is_controllable(desc))
>                 return PWRSEQ_STATE_UNKNOWN;
>
>         return desc->powred_on ? PWRSEQ_STATE_ON : PWRSEQ_STATE_OFF;
> }
>
> Bart


Thanks
ChenYu
