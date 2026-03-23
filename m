Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57BD3BA22C
	for <linux-acpi@vger.kernel.org>; Mon, 23 Mar 2026 15:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774279732; cv=none; b=hgTna+k9VIra1FzCzPsHS7guK2BCVHUuJ+XkMFxfF/3J0a2t5+IgFhj63u5oiJC6mslrjf2xiR2RVic1r8lKqdqwFHRbj+6A8VQKuBBwpPniHG1aolRIrFXXVth9oBmU8XXWXDZlbSNG1AGb6d09Kui/XbqjS6ArhnZTtZC/+Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774279732; c=relaxed/simple;
	bh=IWDr2AzFuesiBMOrzgJX4wQPp9NGolKM7dspV01aC9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tB2KcqIz1/KYT/i4WrwkrAGlMYgiBy0FDWHNzi8UT+zHXRL/BOzswrDkG7wWCnPF0/W/yD7yWGC0rj46xKPOFW1d4vopqh34RwZwOOWQw3GxQ6wo0GWD1K2kj6wrwkHhK9rtdJyMCyL9TCsjEwxaZP7GAdwr1iZhpS+qtqTYqAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r0YiaRoJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r0YiaRoJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9849AC2BCB5
	for <linux-acpi@vger.kernel.org>; Mon, 23 Mar 2026 15:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774279732;
	bh=IWDr2AzFuesiBMOrzgJX4wQPp9NGolKM7dspV01aC9o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=r0YiaRoJDmhsl6QGmGO+bFxgDg1169wOWknkL4GHVkEkkksMIw+X9REekKzaSwH0s
	 e9T0Ei34l+exXpdCJIv/6Ngs5xyqwi1oe91Fe8QpqeloIzH5aD60vTttJFa2UvQ0yu
	 vMmUp0+ujQtf4Phb9r6J0yFNbYOL0OllGoXbcs8+OoafmjHUayIJUsJys8wY5RHTVP
	 itQUkGGPs4Jtmtx1OKC7hxk3rg+vw9tsem472ctY4t3ymnEdVhTHXXyCXAWm6eaHvM
	 t5Ja/ags4IS3FLfuqQWky+8loUH8NtuUW9x+/PNYXnEJOiW44bqgX8kLjAkTpn9fBh
	 JYuTcRfzv2+fg==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-38bcdda57b0so33229581fa.3
        for <linux-acpi@vger.kernel.org>; Mon, 23 Mar 2026 08:28:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVCba8Qa3sGDQ+vr3i3Fh9ou3N0iQYOnbOVc6mIcOEC1v+RY4NlEAaEUKoLwEZ5UPl89jnXxDi+EHvN@vger.kernel.org
X-Gm-Message-State: AOJu0YwhGLDgh966qOWwWPQgRuf/CSRvSgN5e+dgykfCr2T4aR66pmEK
	NTf1HfCYWcpx6hi7laT0utUSRqbaqUdRENdZRvlCg54mJdLBGj+b5NzXt0tFSV4nOQBdu3UGSYg
	QKWPYUKylN21q5Qvpdz9BBfOB8INGuWFuhDSvnIHFmA==
X-Received: by 2002:a2e:be11:0:b0:38a:5584:cea2 with SMTP id
 38308e7fff4ca-38bf95f27admr41174131fa.3.1774279731307; Mon, 23 Mar 2026
 08:28:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260319-baytrail-real-swnode-v1-0-75f2264ae49f@oss.qualcomm.com>
 <20260319-baytrail-real-swnode-v1-2-75f2264ae49f@oss.qualcomm.com> <ab0jmUZGOKSjOa8C@ashevche-desk.local>
In-Reply-To: <ab0jmUZGOKSjOa8C@ashevche-desk.local>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Mon, 23 Mar 2026 16:28:39 +0100
X-Gmail-Original-Message-ID: <CAMRc=MdWxgGftNQgs8d-0xqsfgJSSncfBf+7cmWSSypu2rQrmg@mail.gmail.com>
X-Gm-Features: AaiRm51ic1Qtd8VygdgEg9ggHSh2YPnzIUzs547kDo9m-IYHEE0JkRQaceYSUno
Message-ID: <CAMRc=MdWxgGftNQgs8d-0xqsfgJSSncfBf+7cmWSSypu2rQrmg@mail.gmail.com>
Subject: Re: [PATCH 2/4] pinctrl: intel: expose software nodes for baytrail
 GPIO devices
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Andy Shevchenko <andy@kernel.org>, Linus Walleij <linusw@kernel.org>, Hans de Goede <hansg@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2026 at 11:39=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Mar 19, 2026 at 05:10:55PM +0100, Bartosz Golaszewski wrote:
> > Use the new automatic secondary fwnode API to ensure that when the
> > baytrail pinctrl device is added to the platform bus, the static
> > software node provided for drivers not able to use ACPI will get
> > automatically assigned as the secondary fwnode of the primary ACPI node=
.
> >
> > Create a new header under linux/pinctrl/ containing intel-specific
> > symbols and declare the new variables there.
>
> As I read the code, this doesn't need to be part of drivers/pinctrl/intel=
/.
> I.o.w. I am unable to see why we need to penetrate the certain pinctrl
> driver for this.
>

If old board files were an analogy, the kind of information software
nodes carry would live neither in the provider module nor in the
consumer driver. It would be defined in a third place - the board
file. Do we need something like this or should this logic be invoked
from the x86 platform driver that uses these GPIOs but accesses them
via the swnode lookup?

> ...
>
> >  static int __init byt_gpio_init(void)
> >  {
> > -     return platform_driver_register(&byt_gpio_driver);
> > +     int ret;
> > +
> > +     ret =3D software_node_register_auto_secondary(&byt_auto_secondary=
);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D platform_driver_register(&byt_gpio_driver);
> > +     if (ret)
> > +             software_node_unregister_auto_secondary(&byt_auto_seconda=
ry);
> > +
> > +     return ret;
> >  }
>
> This hack can be done in similar way on how we do ACPI LPSS for those
> platforms, i.e. in drivers/acpi/x86/lpss.c. No?
>

Hey, this is not a hack! I'm coming up with a generic solution here. :)

It already is similar in that it uses a notifier. For v2 howevere, I
want to propose a mechanism for having multiple ways of matching real
fwnodes with software nodes.

Bart
