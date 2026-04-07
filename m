Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D39F274B37
	for <linux-acpi@vger.kernel.org>; Tue,  7 Apr 2026 14:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775572756; cv=none; b=YL09r5eKAbZCsNlyVXrTLI8iFnF4ZzrkNgNdRAdb4OLXD+sFB5frnCLxPrrXagDt3Gb66tV0Sz4NEm+DClzPYuJYMq4WLch3WqSSGsQ2y8jNjU1KJntijiwPj+IEGiI5s1wNgtTQ99fvGxgCyrc3hT+lYANtWjGI3CgUwwqejaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775572756; c=relaxed/simple;
	bh=kZTBU/MN8qb0KFdasZ8l2Oiew+XgjVd6ru1SKKqnHXI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GJPXm9ED+jIQSdQ+/l76CE1Mxlr+JW9XuunDdmDGSKqBBy5D/Hpc7fhH63W3LDLN8CXWRNUI3wVfYqndwRwJmL36+IT1Fwc4Hc5gGE/B8oP64sbUCiuWccZpxktjLa8SaWTqR4r9MN2ZQWmh/GPbzvpCz4nS0arvzk6DnULAX3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RSgIASSX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RSgIASSX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22431C2BCF4
	for <linux-acpi@vger.kernel.org>; Tue,  7 Apr 2026 14:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775572756;
	bh=kZTBU/MN8qb0KFdasZ8l2Oiew+XgjVd6ru1SKKqnHXI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RSgIASSXXLs9JQRGDJpuAA0zEqXWtVbXxd+5GfRlYZUXtuANc3qiY0JVrLrfxpQFi
	 9LCFES4DAkHgOXLDUXO2+/tX7iss5yPu95YweVYjjSm1RQ3LnV2G2ioULYu7Hzp0zp
	 rCHcsJtYkZVORArVpiotk8spwWmKIIE9V04ExRTmz5TJq6MEZcgrARWnccssPYAys/
	 cLksjDvgE/tw02TQgAFY0YsXnRh24WswJbUBoytpwxjfQ5+lxgRqYeCxPcH3BhnO6R
	 iHpj8zPLIkxtrxSBiJGUAaU/M7jnuambwp+7FBD/PWy03cykePVrOKjVI3zGUTNMwa
	 yt9fOkhhWmFGA==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5a2c500750dso6410317e87.1
        for <linux-acpi@vger.kernel.org>; Tue, 07 Apr 2026 07:39:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUp9zEY+2C3RE/BTrDFQYcrLWWE8OAgsITjNtV9yy4sG7/24W7ndL6t7qNJuqvIgYP2mD8xHVUpdQIG@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4xNDn/yKAm1BxgbgZvF4PXr62qXrUh8rJTXVxLl9rECylasuq
	o5zQ2xQZK3EO+U6pFFOhzGbsm5j/yjjMRF6iQQTxz8P4xnfYSk5I8lcerXVkzJ0s8wxbbY84e5x
	dI1dEjbj2tKDGRaG/azw8keOi9GXfiNjvtmFCZ6Z9+w==
X-Received: by 2002:ac2:4c32:0:b0:5a3:7528:5d3 with SMTP id
 2adb3069b0e04-5a375280727mr3461360e87.43.1775572754730; Tue, 07 Apr 2026
 07:39:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407-swnode-unreg-retcode-v4-0-1b2f0725eb9c@oss.qualcomm.com>
 <20260407-swnode-unreg-retcode-v4-2-1b2f0725eb9c@oss.qualcomm.com> <adUVoiVaOkVq1C4w@ashevche-desk.local>
In-Reply-To: <adUVoiVaOkVq1C4w@ashevche-desk.local>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Tue, 7 Apr 2026 16:39:02 +0200
X-Gmail-Original-Message-ID: <CAMRc=MfN_zGJR4GV4PmGqzuUcuAuwer9+a7DG7RQYfjRZsiLtA@mail.gmail.com>
X-Gm-Features: AQROBzC6qoweNY6-nKE7ztgtcZvdgeV0XH2hyQI7m1-emdKmiVNMfmAeZBuPWMo
Message-ID: <CAMRc=MfN_zGJR4GV4PmGqzuUcuAuwer9+a7DG7RQYfjRZsiLtA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] gpio: swnode: defer probe on references to
 unregistered software nodes
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Andy Shevchenko <andy@kernel.org>, Linus Walleij <linusw@kernel.org>, Hans de Goede <hansg@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 7, 2026 at 4:33=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Apr 07, 2026 at 03:27:58PM +0200, Bartosz Golaszewski wrote:
> > fwnode_property_get_reference_args() now returns -ENOTCONN when called
> > on a software node referencing another software node which has not yet
> > been registered as a firmware node. It makes sense to defer probe in th=
is
> > situation as the node will most likely be registered later on and we'll
> > be able to resolve the reference eventually. Change the behavior of
> > swnode_find_gpio() to return -EPROBE_DEFER if the software node referen=
ce
> > resolution returns -ENOTCONN.
>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> ...
>
> >               ret =3D swnode_gpio_get_reference(fwnode, propname, idx, =
&args);
>
> >               if (ret =3D=3D 0)
> >                       break;
>
> Maybe check for an error first? Dunno. Up to you.
>
>                 if (ret =3D=3D -ENOTCONN)
>                         ...
>                 if (ret)
>                         continue;
>
>                 /* The reference is found, bail out */
>                 break;
>
> (Also may be done in a separate change no need to mix these things
>  in the proposed change.)
>
> > +             if (ret =3D=3D -ENOTCONN)
> > +                     /*
> > +                      * -ENOTCONN for a software node reference lookup=
 means
> > +                      *  that a remote struct software_node exists but=
 has
> > +                      *  not yet been registered as a firmware node. D=
efer
> > +                      *  until this happens.
> > +                      */
> > +                     return ERR_PTR(-EPROBE_DEFER);
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

Yes, I mentioned it in one of the earlier revisions. I'll do it
separately and only continue the loop on -ENOENT.

Bart
