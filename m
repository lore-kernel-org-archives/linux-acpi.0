Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37479396D00
	for <linux-acpi@vger.kernel.org>; Mon,  6 Apr 2026 19:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775503804; cv=pass; b=LeXNIAeQsfE0iX6ezXdP+mpxoK9Nf/vVFzLwdE23VufN0BtT+YcId/asVgo/PnckmUApVM3M6P52HDR9TzG41DDT3RXltZiCYh//eh8JEN9RbS8lobjuu83zpoa7gv97QVrn1jHSGeAoziKHNPMrEiSO6uCAqGoGXdy9lNqO1w0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775503804; c=relaxed/simple;
	bh=E91vaeMNwDF/pEjv7G2aprNsjDohPpm/gfEXupHR2kM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=obOxRoLgo/7J++g/nIgMu1UPAoAVSe6aMyNKWM4rKGwm/9f/e7YzCJSXQFYh6tFcs8+W7V+TViSHY8EkAJq0QPr8o+Yg8tTeghVzS++5ROe3mJNXCxYibKrNt6za4PxsGjtUOLjSppHNy43NCh248tMJRj6yVpxw8YR/KZ5umXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fpYt8ULx; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fpYt8ULx"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b8f9568e074so713317766b.0
        for <linux-acpi@vger.kernel.org>; Mon, 06 Apr 2026 12:30:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775503801; cv=none;
        d=google.com; s=arc-20240605;
        b=LH0S2AAXSUKvOZ/tylZUdoVpXMoxgrFfhL1MC8RtRVZyD0itoWdWblP3AXpa9QPBfZ
         eq0Ukz7lOeHuHwyHbJan/ZgmYJsYjEBU6O25LxPKI5Uy2rOFL1xC+bKi5PV1l/KURuFK
         ZW3VDre718yemUjeh6G44GdtThvfEiKx4tJYy9gI9klZDw1e+z5IgPOhxScx4r9wrFvA
         faG5oKKkvlXoWJgkGbESD3qlakBZpixT16BUSybwDhylME47hfVRzZIMTuC2DEkknR1S
         4VhDVMokjF05GGeG5kUmuM8Zs9A3gaO8V5N19qdYEgcfxTnvtxwQH7n1RAersfJvJALI
         2xug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6oqpjiW2BP+Tsq4RmXpwQJ34Z4G51X+Eu8RZMOYwNBA=;
        fh=oRKgapMTPtAoJBaemD1jLV2bz/9kezBvHoOxbrQ84iA=;
        b=XjdRITQUMw0B69Fs+492iYC8L43B+Dg6WnlER9uiSUIxcbjNS00PUD7bO2avtXCNVg
         iCb4y8wjVe7SUsU92RfUX5lYWB6G/4rS7Gmw25rehhjyCKvV+NPKVt5rC+fd00DvUwoS
         1N08j3TDED2in6sZ0XlNPzABbDAvRsGzFEAr1l8l+v+qejWa3XKtw5qsiiWNx35+BZml
         C57eaJ7GYY6roIBn+4jc6ueHcZVkAgRpzbGXzHBJqcr2vNr1aMp7dZ3Tg69sXlUmcz7Y
         IpW/66FVIplgt/xJqo/+q8lF9WBB8nXH0yBeGYBKyHZ/84/uMiGaGsIDjUy90wmtgw3w
         ciMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775503801; x=1776108601; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6oqpjiW2BP+Tsq4RmXpwQJ34Z4G51X+Eu8RZMOYwNBA=;
        b=fpYt8ULxqnw2GUbo8PxtOmsJkkZtVysEaDZlyc4h2P68GO+cYulde84SIJ0uydhpZx
         jXNxQ9O2Gp2cuhIi61UgF3kYmIp0wsH6hphdOhhfWsv/rcIlbgPOzmweaqa3IgtwuzP9
         PGx5z6ohMvudLwSjIw93Q7vdhkwWj/QFO55A7+teVpb6rtuH474NgoX05nB2PuJumkIA
         SbfOZSaseyOcdue3nC51ekx29sYKiCI528A3gJM6P3mDHj/Bib7xmsx64QruetIGRfSe
         g7O7sqUO8j7eozf+iBdwIQCQgVMAopcZ4hX5BfHAeP7lWhUUHW9DOwoC0Z0o7v18+9wK
         9bBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775503801; x=1776108601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6oqpjiW2BP+Tsq4RmXpwQJ34Z4G51X+Eu8RZMOYwNBA=;
        b=fTMFu4Ol2aLJApG3et6X80+Z56rSVfZODJ8FYgvXrwrwRlpe9JpZGoZwvUCSWw78PM
         PNNDkBRHt00moKksz7gWJ85ik5W2FTEab2Mzt+lEoDb5+pxYZvLNYNW3Rb5qFGMBWXGi
         CiazdwMAUyUO0qCRqGPnb/m3eDSfkNXYDUi+6zVrdEiyVOG0jFxnU5J5Azk7TndiSrNg
         M7ScBwGqmpJ9pJw+64NMYGQIqFLZE0aBJ47JDqI9qvHAERi4xmwDJP64dcn4ZfTxdXN7
         zKXC5XoRf8SeJ1+J348WJS3SEBjM3PjAoIlAGaAfM+HEQDOmGXYUPN/oZs/ze2PLhRtT
         HsyA==
X-Forwarded-Encrypted: i=1; AJvYcCVTEI6HtC6bulvMtQBP1yIbIfcOkHMFuzXRkx6x3R17mssuXVVIJWuUrouipPj7y7oS8K36dNXKX1Gq@vger.kernel.org
X-Gm-Message-State: AOJu0YzDJEvsMFxXpDr5krCN5H0muv95XHPrpzpDyRUtefj+oSWPKaVX
	YwkZ+X5/fXVGjzSamiu+K5YZWghLL3huUdScoF6+7UKMo5eaDlHAkG3nRU7GAq8BM0g3Q0eugAs
	JKueib7rhwm1c+a/d/YR/8CncV7NVsIE=
X-Gm-Gg: AeBDiesTXnOvhcli6R8Apa90yaB3GsYY39Ejhj38/BlhVJLfkTb7fn94Ftis2LIcCX9
	fLUSMHVBbwRCkeZXEdXEbyHmvBMwUvcw781U8HSMmzF7DPSSIcxA/APIquc92aJCSCpg+l5tH1Q
	azv17K2Q2Hp1qnH+fg8SUpIXinNqp5Hjp3g/W8E5zHtlC9altRNWxVgM8f+Qiss153LN0qyJNRs
	69GuqnvMArLYNca8KVjIzQWCyHoW9cjePIxacpDA5XpIuWOBf9jRH4hEkOfFuCtiDprDTdcIF5u
	K6ApqRL+LckWGpmdDjUgfiX4bANpRPq4jWOoxSDqOQtT7K+L/aXEOkc4XaVk2n8FDEuXse0I1AW
	cojMAAk5e37dzcXfySQ==
X-Received: by 2002:a17:907:d87:b0:b9c:b069:8ac3 with SMTP id
 a640c23a62f3a-b9cb069bac2mr337550766b.3.1775503801341; Mon, 06 Apr 2026
 12:30:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403-swnode-unreg-retcode-v3-0-7886092b28b4@oss.qualcomm.com> <20260403-swnode-unreg-retcode-v3-2-7886092b28b4@oss.qualcomm.com>
In-Reply-To: <20260403-swnode-unreg-retcode-v3-2-7886092b28b4@oss.qualcomm.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 6 Apr 2026 22:29:24 +0300
X-Gm-Features: AQROBzA8JV6OQ6clUVeDdQ8y2N7R8Nc6EH_ZR0i5RXUt9ZfYunTBiDn_zltZ3Uw
Message-ID: <CAHp75Vca5R82wEV1hAyu1=zkuQOw3htXT787XhGH+LVN+EHQHg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] gpio: swnode: defer probe on references to
 unregistered software nodes
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Andy Shevchenko <andy@kernel.org>, Linus Walleij <linusw@kernel.org>, Hans de Goede <hansg@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	brgl@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 3, 2026 at 4:52=E2=80=AFPM Bartosz Golaszewski
<bartosz.golaszewski@oss.qualcomm.com> wrote:
>
> fwnode_property_get_reference_args() now returns -ENOTCONN when called
> on a software node referencing another software node which has not yet
> been registered as a firmware node. It makes sense to defer probe in this
> situation as the node will most likely be registered later on and we'll
> be able to resolve the reference eventually. Change the behavior of
> swnode_find_gpio() to return -EPROBE_DEFER if the software node reference
> resolution returns -ENOTCONN.

...

>         for_each_gpio_property_name(propname, con_id) {
>                 ret =3D swnode_gpio_get_reference(fwnode, propname, idx, =
&args);
> -               if (ret =3D=3D 0)
> +               if (ret =3D=3D 0 || ret =3D=3D -ENOTCONN)
>                         break;

If I understood the logic correctly this may be just extended as

  if (ret =3D=3D 0)
    break;

  if (ret =3D=3D -ENOTCONN)
    /* ... */
    return -EPROBE_DEFER;

>         }
>         if (ret) {
> +               if (ret =3D=3D -ENOTCONN)
> +                       /*
> +                        * -ENOTCONN for a software node reference lookup=
 means
> +                        *  that a remote struct software_node exists but=
 has
> +                        *  not yet been registered as a firmware node. D=
efer
> +                        *  until this happens.
> +                        */
> +                       return ERR_PTR(-EPROBE_DEFER);
> +
>                 pr_debug("%s: can't parse '%s' property of node '%pfwP[%d=
]'\n",
>                         __func__, propname, fwnode, idx);
>                 return ERR_PTR(ret);

--=20
With Best Regards,
Andy Shevchenko
