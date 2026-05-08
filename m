Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BA33D6463
	for <linux-acpi@vger.kernel.org>; Fri,  8 May 2026 19:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778267506; cv=none; b=a56L7wE8d2vJ3jXAL50uXabj440XgYntovNjPHzAFFkqRn17uiYXC2bW0OCZXCp0DMgE47T5ke/EXIOnvLW1rVciR4K2KRJX9da8lwxbAeLZkGphpQAnHK3QVFl3eh7HXCSXq482elc9Gdnm4CE4ki2P/SpqDetdfI3HwV/SYJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778267506; c=relaxed/simple;
	bh=C+pw4yJIPaRlnMdlWTQxxEe0lz+s59e+RZgniBqzs/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lArAtNn4Q5Z2AbXyGBPxxgxxh3S+YRmenbPxfD+XxLVZ7LaNVKr9pvlOJvArpxL76DfaeOO2FTH6faDhcurW/zJUXR46y7J1S07s31yvyWaPvY+zpayZePogri1HrzNnyt21KDfl1OOQhLrxr1IlFFePobAWIwEZZVgDwKvWBgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gl9SOGeF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gl9SOGeF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92C33C4AF09
	for <linux-acpi@vger.kernel.org>; Fri,  8 May 2026 19:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778267506;
	bh=C+pw4yJIPaRlnMdlWTQxxEe0lz+s59e+RZgniBqzs/A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gl9SOGeFoc+wRGOOvsqfLw5oamKlJhMbyeUBTll+soVd0y7dYCynoL2t4mF6mnNVV
	 05qB98rhHZSVD9dfjpkcc7/ITjQIIIN9vZrpyvbABXM1vMWCag4l0E9OF/UwSRLwpt
	 qDZu1XWGTski/lZT+uqtToVwPBz6QccXJbcROD5G9/0ulMuSfpUM2+FO4JjXqK51Lx
	 Vr06IthsGISnsaTrMlyxlBwacbiA+RdocYik1kIoYScdxgucxFACirG5sWd4znAeNw
	 PI+UAhxWxoZKj7EE96ZswVgAb0eOBFuRM2D5RZbIhJXIOu/y8jLu9LxsPWwtu6Y1HH
	 qHlzOyB3ZrVfg==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5a4113ab355so2277301e87.1
        for <linux-acpi@vger.kernel.org>; Fri, 08 May 2026 12:11:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ89dUAHoz10lQOhiHNmsNduXx4DbzXw/dtKjvksOPJcSTt5XzhewSI5J2lXOCgcxwo4FXGpiyBNAKR8@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3lYGYPOMfImzmk01Y8GNNs+999+GPxcNex5fsnFyvn3JiXLUd
	IGGHzkOz4KbXE9Gv6OX27YRMbgmFPdGDJcS4iz7nIE39/SvzC5QqSIZ7HUyKq7e+QMNqGUFDDz7
	sk3KYrmMhGDjbr4DblkffpU8qqJO/cTM=
X-Received: by 2002:a05:6512:23a1:b0:5a7:70f0:a871 with SMTP id
 2adb3069b0e04-5a8a94bc3ddmr1426320e87.25.1778267504910; Fri, 08 May 2026
 12:11:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430013507.46259-1-m32285159@gmail.com> <afL1X3ywCwJRIz1Z@ashevche-desk.local>
In-Reply-To: <afL1X3ywCwJRIz1Z@ashevche-desk.local>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 8 May 2026 21:11:32 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jr+Y784Q7jKL_dKpCKiXFZAfSbU-XS851pG-MGgxiNSQ@mail.gmail.com>
X-Gm-Features: AVHnY4LAHaXN5AoSTYHI_lqUmIvdp0xzkTHOnmiNN6PdbdgFoloNleqZ3KophOY
Message-ID: <CAJZ5v0jr+Y784Q7jKL_dKpCKiXFZAfSbU-XS851pG-MGgxiNSQ@mail.gmail.com>
Subject: Re: [PATCH v5] ACPI: pmic: Replace mutex_lock/unlock() with guard()/scoped_guard()
To: Andy Shevchenko <andriy.shevchenko@intel.com>, Maxwell Doose <m32285159@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, Mika Westerberg <westeri@kernel.org>, 
	"open list:ACPI PMIC DRIVERS" <linux-acpi@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 30, 2026 at 8:23=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Wed, Apr 29, 2026 at 08:35:06PM -0500, Maxwell Doose wrote:
> > Replace mutex_lock() and unlock() macros with the newer guard() and
> > scoped_guard() macros. This will help modernize and clean the code.
>
> ...
>
> > -     mutex_lock(&opregion->lock);
> > -
> > -     if (pmic_thermal_is_temp(address))
> > -             result =3D pmic_thermal_temp(opregion, reg, function, val=
ue64);
> > -     else if (pmic_thermal_is_aux(address))
> > -             result =3D pmic_thermal_aux(opregion, reg, function, valu=
e64);
> > -     else if (pmic_thermal_is_pen(address))
> > -             result =3D pmic_thermal_pen(opregion, reg, bit,
> > -                                             function, value64);
> > -     else
> > -             result =3D -EINVAL;
> > -
> > -     mutex_unlock(&opregion->lock);
> > +     scoped_guard(mutex, &opregion->lock) {
> > +             if (pmic_thermal_is_temp(address))
> > +                     result =3D pmic_thermal_temp(opregion, reg, funct=
ion, value64);
> > +             else if (pmic_thermal_is_aux(address))
> > +                     result =3D pmic_thermal_aux(opregion, reg, functi=
on, value64);
> > +             else if (pmic_thermal_is_pen(address))
> > +                     result =3D pmic_thermal_pen(opregion, reg, bit, f=
unction, value64);
> > +             else
> > +                     result =3D -EINVAL;
> > +     }
>
> >
>
> This blank line is not needed as previous is coupled with this check.
> This is a minor thing, but what takes my attention is the result assignme=
nt for
> last else. While this is correct code it might provoke false positive war=
nings
> from the compiler(s) that can not properly parse scoped_guard() and proof=
 that
> result is always assigned (the warning is something like "uninitialised v=
ariable
> in use"). Let's wait for CIs to be sure we do not enter a such. Otherwise=
, this
> will need a refactoring like
>
>         result =3D -EINVAL;
>         scoped_guard(...) {
>                 ...
>         }
>
> >       if (result < 0) {
> >               if (result =3D=3D -EINVAL)
>
> ...
>
> >       if (d->exec_mipi_pmic_seq_element) {
> > -             ret =3D d->exec_mipi_pmic_seq_element(intel_pmic_opregion=
->regmap,
> > +             return d->exec_mipi_pmic_seq_element(intel_pmic_opregion-=
>regmap,
> >                                                   i2c_address, reg_addr=
ess,
> >                                                   value, mask);
> > -     } else if (d->pmic_i2c_address) {
> > +     }
> > +
> > +     if (d->pmic_i2c_address) {
> >               if (i2c_address =3D=3D d->pmic_i2c_address) {
>
> Maybe we should not touch this either and actually have clean guard()() p=
atch +
> refactoring returns, dunno... My whole concern here is that this code is =
not as
> simple as IIO switch-cases when we replace break:s with return:s mostly
> automatically without breaking readability of anything. Here is different=
 case
> and mixing guard()() with return:s refactoring makes it harder to review =
and
> understand. Also if any regression happens, will be harder to maintain.
>
> ...
>
> I don't want you to waste more time on experimenting, I think we better
> wait for CIs and Rafael, if they all are okay with the change, that will
> work for me.

It's fine by me and sashiko.de hasn't found any issues in it, so
applied as 7.2 material.

Thanks!
