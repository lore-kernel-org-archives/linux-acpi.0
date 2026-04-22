Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB184C6C
	for <linux-acpi@vger.kernel.org>; Wed, 22 Apr 2026 19:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776886897; cv=none; b=KdG6yRd8f4wFXZJsqeeXTyKK4+dPGPARIAFxGVjfPCuHQqQ7yTioIInE/48yGvcKDNXsEO229do2Boz/nqSUskN8ybaLRQaoM0ZFtwfoYe4FNzseWM1mKDEEAaeV9XMVWyl0QlMjOXgoPHjkQJy+/pfOxRpfDcyAO1OAH+iZyQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776886897; c=relaxed/simple;
	bh=1jDHS3//SVF2/A/vC8oT6/lwq+kdzpM3dPjKRF+cWNI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AoIrDOCsDgYpJ8BXL8VJNZ//kRDKJJY0UXEIxNFWU56/BM1/2L/WTSy626xzhykzknJtiPZef4kXC+mREDox39VULnFksbJV02KoR17s14hhxcK7pZK8ve9EF4oukTOn7Jcsuy2dtgHCRGh5FbTYKpW1KccAw2WKOkMZwn11D/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VzMcOC72; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VzMcOC72"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-671dad7cac8so8693596a12.0
        for <linux-acpi@vger.kernel.org>; Wed, 22 Apr 2026 12:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1776886894; x=1777491694; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A8JHz3Efp15Ndyc9pOP3Ax7qZyPD4IXnQM3cK5pq58E=;
        b=VzMcOC72GQBJ1VndPdHvVBSrVCXd6WVvELmA41mrEb7HxrfGPmxJ2wX8TkT3WWx7xD
         4xtfbziUBw0MlgLKhqtfh7+aKHg9sWd174kREH9hkk/GxNWhUyqX9xAJl35cr44BZZMm
         eSViiRaNf6AIINTkl/iTEXmP1oHSvmw9HKemQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776886894; x=1777491694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A8JHz3Efp15Ndyc9pOP3Ax7qZyPD4IXnQM3cK5pq58E=;
        b=ZvL47eMS56kgmkoCbfm/UxuVD3Qi8k6lbmSI/3PAVHpjFTxbk/+ArWgKfvpbloUeUg
         xjlEROyZ00Z19vk3fl9EI7GLNOaRRfXEPn85D+Ko338Zm/Ts4Z8uk8EFLL0/sRggwhJ+
         J2Q1WwSE6eZxDuc6J0SftvxxwDUS3u7xNin1i7l49mQrdYJlvKUfEs/b7HSydYTTWOnB
         I6TPMUPJRETOTBHNp3fMvllVLmljohmnHTz7wRWIrqePyeBjnruAQSVSDXzsnC5KI7Sw
         blASGM3LOY6FWvFKWWxEHGucQ2Q2mLTwynwfypySzR+ZBu6hpJMXTdD2fpMrm+rqKA7A
         ac3w==
X-Forwarded-Encrypted: i=1; AFNElJ83ycWmXcPh7IjDJag0avS+JKUdyCp+9lKfL5eFwBhvG3zVA1AWu3S6mjMVzMAO3VM07lMdX1ZrVocV@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9zoIbkXj0vdbI9D2s9g2b9nHZv8Ld4mpZSIZyGaDi7p/WIXEc
	exNbMgLzy5q1YlYjEBGh5qeWDeNkGP/lDpsArIewU+j+xTnzUCkyB/ZFcFW87h5UieEGS6GX1y4
	lIcqb2NXS
X-Gm-Gg: AeBDieu9jh8iPln67bJYBYwQ1KbH8L6AtvbCOc6Vq6KFyu1rA8rm68vum3D3/lhtagp
	xmDHkmQe7u5jDBBpJkKCzC0ka9qnnmqGRv6CFME5prAG4VZkqBlaqb0jVnJPjdAlL6gG8mxdRlH
	nzsTvQjE5kBFs1f1bzq0GMPNc+n+21tvqAGlGJ0booZfT4iN1nhQLS4MKIj0pxmct26P/zEJW9i
	5H/FWKAQ4JIxZk00ZwcTVZQnyRzxqPsklPY3DdyLlmDtHENJdZZ0W2jrsFC8tIqX8Mg6uR1Jl7V
	Z99v/+Hm7wjN68MPg7J3b+SBMysp9LalvIUNfOCkz0w861/sEPU9w44dyEjrlUkFBpNQPEL1w2/
	7Og68B+kaKDtjKyj78MUhVu/iRtVsDvsYZlrQHvEjwdj2vvK289aAk2U+WZ/PBOcJ8S5ZqGh9jt
	GsC9LZoQJmTqqpwB3puDuZBb5IDRGmT0qonQuBiTD61qUwcigBHsWkvENq9KVy5jhXxbHW4J97
X-Received: by 2002:a05:6402:4610:10b0:676:9c6d:7448 with SMTP id 4fb4d7f45d1cf-6769c6d752amr3652835a12.22.1776886893914;
        Wed, 22 Apr 2026 12:41:33 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-672c47fe951sm3691558a12.2.2026.04.22.12.41.33
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 12:41:33 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-671c5eb7fb0so7326398a12.3
        for <linux-acpi@vger.kernel.org>; Wed, 22 Apr 2026 12:41:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+RNS/bJUkGdzpelEIPSMDPBoxx6iJqSvJub9Raab3z7qJhHmpqZy4zdr4MDIonYCMPGvQpmQQQF3Y+@vger.kernel.org
X-Received: by 2002:a05:600c:4714:b0:48a:5574:3a5b with SMTP id
 5b1f17b1804b1-48a55743d05mr122645615e9.27.1776886533988; Wed, 22 Apr 2026
 12:35:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325143555.451852-1-herve.codina@bootlin.com>
 <20260325143555.451852-3-herve.codina@bootlin.com> <CAMuHMdU7x7LWFkD9xiq+wyOqnn0bdzr+JLfvbBexoiWyv8kftA@mail.gmail.com>
 <CAD=FV=UK3NQKQN7FXyG4nGdDKO=LQYhnL4ZweomQ_4R9-EAYag@mail.gmail.com> <aekg_IELc65BFrWp@ashevche-desk.local>
In-Reply-To: <aekg_IELc65BFrWp@ashevche-desk.local>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 22 Apr 2026 12:35:22 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XTvvq11y7kxmrfBe3dZsKro7N9=i-Hj9aqsLBay2Q9Rw@mail.gmail.com>
X-Gm-Features: AQROBzBA2DSdR2HBaIYSKp4MrG-iWYSiPDxUw6OYCOPyJYNxN20LzPXgyZNheJI
Message-ID: <CAD=FV=XTvvq11y7kxmrfBe3dZsKro7N9=i-Hj9aqsLBay2Q9Rw@mail.gmail.com>
Subject: Re: [PATCH v6 02/27] of: dynamic: Fix overlayed devices not probing
 because of fw_devlink
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Herve Codina <herve.codina@bootlin.com>, 
	Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kalle Niemi <kaleposti@gmail.com>, Matti Vaittinen <mazziesaccount@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Peter Rosin <peda@axentia.se>, 
	Arnd Bergmann <arnd@arndb.de>, Saravana Kannan <saravanak@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Charles Keepax <ckeepax@opensource.cirrus.com>, 
	Richard Fitzgerald <rf@opensource.cirrus.com>, David Rhodes <david.rhodes@cirrus.com>, 
	Linus Walleij <linusw@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Mark Brown <broonie@kernel.org>, Len Brown <lenb@kernel.org>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Shawn Guo <shawnguo@kernel.org>, Wolfram Sang <wsa@kernel.org>, linux-kernel@vger.kernel.org, 
	driver-core@lists.linux.dev, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, 
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-sound@vger.kernel.org, 
	patches@opensource.cirrus.com, linux-gpio@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org, 
	Allan Nielsen <allan.nielsen@microchip.com>, Horatiu Vultur <horatiu.vultur@microchip.com>, 
	Steen Hegelund <steen.hegelund@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Apr 22, 2026 at 12:27=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Apr 22, 2026 at 11:51:36AM -0700, Doug Anderson wrote:
> > On Wed, Apr 22, 2026 at 10:44=E2=80=AFAM Geert Uytterhoeven
> > <geert@linux-m68k.org> wrote:
> > > On Wed, 25 Mar 2026 at 15:36, Herve Codina <herve.codina@bootlin.com>=
 wrote:
>
> ...
>
> > > > +               if (fwnode->flags & FWNODE_FLAG_NOT_DEVICE)
> > >
> > > After commit f72e77c33e4b5657 ("device property: Make modifications
> > > of fwnode "flags" thread safe"), this must be changed to:
> > >
> > >     if (fwnode_test_flag(fwnode, FWNODE_FLAG_NOT_DEVICE))
> > >
> > > With this change my DT overlays are working again.
> > >
> > > I guess keeping the FWNODE_FLAG_* names, but changing their values
> > > from bit masks to bit numbers was probably not such a good idea,
> > > as it fails to catch missing conversions...
> >
> > Crud, I should have thought about that. :( Do you think it's worth it
> > to do a rename at this point to catch future problems?
>
> You can try locally with allyesconfig / allmodconfig and see the outcome.
> If there are missed cases, and their amount reasonably low, I won't bothe=
r
> in this case.

I believe I caught all of them at the time of my CL, but the problem
is in-flight stuff, right? I think the problem Geert is pointing out
isn't something I missed in my original patch but rather an
interaction between my patch and this in-flight patch.

> But for the future it's kinda rule of thumb to rename when
> semantics changed.

Noted. I've certainly done that before, but I didn't think about it in
this case.

-Doug
