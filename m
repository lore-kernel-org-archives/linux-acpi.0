Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1248A361DB1
	for <linux-acpi@vger.kernel.org>; Fri,  3 Apr 2026 07:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775201215; cv=none; b=Ai35NO/8LT6182Hn20upEJKeSJ2eQgC3b9LLy7a23p/7iGy5KoRxuInFh6nBNMvX0283fbItbXxowptRxwp4xOowAGHKOWt0P+c2faS8WulItYxMMyFcRFSnx46iT/y/PfDDY29AR2wT1lFMilb6Ph35hhB04Sq23z7hXC+c3/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775201215; c=relaxed/simple;
	bh=eM35KzWv2m6tgTzCIiEI5j3QXAuEjv2FFrCxl6NnM1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KSW2SUe274IjIJWJluGt6bDRW9gtugbP5hqPdej31ATmBW3gD2OwfoRZwbALPZiKQHhXMjOFP/7v3ss/k2jSjzKx2yGWBUDX+bqJl0DPSSpib1zmBpk2s9Nea+7QhM07NWrP42WTDVMS8I4tuNJ/6w/OpPFoQ61KksBye7v6Ae0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OUnEi7AL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OUnEi7AL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6EF0C2BCB2
	for <linux-acpi@vger.kernel.org>; Fri,  3 Apr 2026 07:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775201214;
	bh=eM35KzWv2m6tgTzCIiEI5j3QXAuEjv2FFrCxl6NnM1Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OUnEi7ALDfhHN79JTx5WS13kTaX7fcxQT09n2xOdIjnmkCIkyvHU0oQmoTLkh6mHU
	 lUOC09cZNjIUbdvjXczg+oMDC1cES/aS1AjvfSYWQjugA0JnD2ZJZ8lqfuAJqZhnIp
	 pFKTMllZc8sgc8PYxR79mJj1bOrkb4qUdUvUcbn9RhIzzpkuj7FNYmrdtQ7Foi5Tzs
	 FJ71KJQKopslSrhOVAsUc7c99PnGlj/c16Ft55jNAaWcZP3GeRQF15kxiBxn1HxMFm
	 V11aIqzbcRp82/EgmsX1C0RXIg4gUt+pcESNf8KyWKq805SRZJS9H4puUXURvFjqqA
	 Q/VC5BSuUN8rw==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a2b5ea59a1so2013931e87.1
        for <linux-acpi@vger.kernel.org>; Fri, 03 Apr 2026 00:26:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVGJrwgijCfQ8ocJds5eEWCPTpoZ1P9BQYpSE+AmIO5cSI2lhu1PGq0VBW/dSAMBjyWbvBuvISECa8p@vger.kernel.org
X-Gm-Message-State: AOJu0YyPCwRhLwODWosGHMm3vs6DwKTKHJn2HFIRYkiY6yZU+ilRoEGc
	CxnZrgNJHdr6P6M2lrX4Ml4SR7BYQMmHCdLb1Xuh/D/5ZLRoyoFa7+c9OMXpXNn59VPdqUJl8E/
	7VP+b34Lny3k3Vj487stn9RqFUKEB99EF1mdulT4o4w==
X-Received: by 2002:a05:6512:224a:b0:5a2:c914:8aff with SMTP id
 2adb3069b0e04-5a337556dd5mr775128e87.3.1775201213415; Fri, 03 Apr 2026
 00:26:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402-baytrail-real-swnode-v2-0-6f5054a4cc07@oss.qualcomm.com>
 <20260402-baytrail-real-swnode-v2-2-6f5054a4cc07@oss.qualcomm.com> <ac7ZA6HJFBhyCROM@google.com>
In-Reply-To: <ac7ZA6HJFBhyCROM@google.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Fri, 3 Apr 2026 09:26:41 +0200
X-Gmail-Original-Message-ID: <CAMRc=Mda08=9zUuhaFVPYc368WE8Tz+Pc7ABCPoiQXWCBiBt9A@mail.gmail.com>
X-Gm-Features: AQROBzAG5FPpFohnKOy2729dNSbwhXiSnZQOyCHPiJE-xJRTJR3vXtww77N-TeQ
Message-ID: <CAMRc=Mda08=9zUuhaFVPYc368WE8Tz+Pc7ABCPoiQXWCBiBt9A@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] gpio: swnode: defer probe on references to
 unregistered software nodes
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Andy Shevchenko <andy@kernel.org>, Linus Walleij <linusw@kernel.org>, Hans de Goede <hansg@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2026 at 11:04=E2=80=AFPM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> On Thu, Apr 02, 2026 at 02:54:27PM +0200, Bartosz Golaszewski wrote:
> > fwnode_property_get_reference_args() now returns -ENXIO when called on =
a
> > software node referencing another software node which has not yet been
> > registered as a firmware node. It makes sense to defer probe in this
> > situation as the node will most likely be registered later on and we'll
> > be able to resolve the reference eventually. Change the behavior of
> > swnode_find_gpio() to return -EPROBE_DEFER if the software node referen=
ce
> > resolution returns -ENXIO.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.co=
m>
> > ---
> >  drivers/gpio/gpiolib-swnode.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/drivers/gpio/gpiolib-swnode.c b/drivers/gpio/gpiolib-swnod=
e.c
> > index 0d7f3f09a0b4bee0cf1bbdaa8b7b8ae4cd5de581..06d74e9e199de0b91a019e5=
e15d4b83d330291e7 100644
> > --- a/drivers/gpio/gpiolib-swnode.c
> > +++ b/drivers/gpio/gpiolib-swnode.c
> > @@ -95,6 +95,15 @@ struct gpio_desc *swnode_find_gpio(struct fwnode_han=
dle *fwnode,
> >                       break;
> >       }
> >       if (ret) {
> > +             if (ret =3D=3D -ENXIO)
>
>
> I'll be just sitting here and quoting sashiko all day long ;)
>

I would love it to produce briefer messages. I'm always put off by the
walls of text. I would literally rather deal with neanderthal mode
like: "loop continues on ret !=3D 0, bad!".

> "
> If swnode_gpio_get_reference() returns -ENXIO during the first iteration
> (for example, when checking the con_id-gpios suffix), won't the loop cont=
inue
> since the return value is not 0?
>
> Looking at the loop just above this block:
>
>         for_each_gpio_property_name(propname, con_id) {
>                 ret =3D swnode_gpio_get_reference(fwnode, propname, idx, =
&args);
>                 if (ret =3D=3D 0)
>                         break;
>         }
>
> If the initial property check returns -ENXIO, but the subsequent fallback
> check for the con_id-gpio suffix returns -ENOENT, the ret variable gets
> overwritten.
>
> When the loop terminates, ret would be -ENOENT instead of -ENXIO. Could t=
his
> cause the probe deferral check to evaluate to false and fail the probe
> entirely instead of deferring it as intended?
>
> Should the loop also break early if -ENXIO is encountered?
>
> "
>
> You need to change that to
>
>         if (ret =3D=3D 0 || ret =3D=3D -ENXIO)
>                 break;
>
> because if we get -ENXIO that means the GPIO must be there (the property
> exists) but not ready yet and we do not want to fall back to another
> suffix.
>

Yes, thanks.

Bart
