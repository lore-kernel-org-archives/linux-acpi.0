Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794301961;
	b=UlJWbwOr7HgscPs9orM5XhYI4BQDJjT/WuAIkDe6tI0f+7vUFMMIBL88lM/7gk7nAbka
	 xjJqw8lY6UcujUFGLJg9cyGFcbCtJpbYKmoiUJtqiVUPqj39ZXxsQNp1qJFOzmr8EtN8u
	 WnO4iQin6e8xgCFr0pnPy/U9GHHPQrf4tfIzmY+G9oJfWDvFLUCEgv2b0MNA7fuRyfEYG
	 LhpgU+GJxa9gews6WyP+9PncI/zZkCUF5H7N5WE0jSYu8KRCEMnTTvSo2cp5V1+9TO5IU
	 JcavD7zH17tTqNnX4uIKlDg6BlnFLyQ9Z9CAaP55C/sSxEImAIqXDrgIO3q+1XpRTKA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794301961;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=CL+mYaY3tGDnGHrtpelaQSBbIHf49nURgXV9HJQUfY0=;
	b=NlolmP/MIMT75GbTILTrpWcwsV0SgQ903VKRFlFvYLRopsRqkR8xV1eWQ9BR7fp8njiY
	 oD8EXSAe+bZN9h9cisPjZGCdkQGirZs9BO2604kPWwZ8Ll8YXZUH+6Ahlyp8YIBkSiI/O
	 y+E8osOSpjneRyUElJZk1oJks0MraHygeyvHsFpnMyEwSDxArHeNiBY7ULHHCVCbIbnPQ
	 O3ao/lrxFjUbj0Q9scCKl2rACvBAPGlslXOJHFoxA8jRsVv0sXdysyMbRb4iB3FzyZOUI
	 2zK0PducFUxO3gVsHB1GwLtMF4UriVThlkdIaK7/IPhUZYhZGg9Y56kTuLPdRtMmqcA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zXKLOI63;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.173
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AC4606A31C
	for <linux-acpi@vger.kernel.org>; Tue, 10 Nov 2026 09:12:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1AC4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zXKLOI63
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-8b30477a320so13255747b3.1
        for <linux-acpi@vger.kernel.org>; Tue, 10 Nov 2026 01:12:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794301960; cv=none;
        d=google.com; s=arc-20260327;
        b=ekQImh4d1Ns8ZQZtpuQ3NnqCcgb5892FC4tTN9/HoL1S+9/m3+/bPfwVOeKWXiNMN7
         H1v3hwsaziJRpRjZMJlDL9hGem1eVlh6QX73eDIlR4BZ3sa0GDgsKBIQugr8ZTNqv4h0
         b7M5yNRTSd7wmsUfsKy4RjjaOs+fjr0B7fmGr/oG9c0EWAtFLNqh2vUgA+dSB3A01JGY
         ZOK2gzLDPhpz9ffcQEJKhVXI1s7RENIVfhzcVEy31ee9D6TvHJQSTVKbq2LiQnkD/cRU
         4LkgK28RmHNGEXteD8l1F96mK+38wN3Sv/X7we+pvFL3rZcT3tSGc1oZpraCc1zVtMLN
         Nw3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CL+mYaY3tGDnGHrtpelaQSBbIHf49nURgXV9HJQUfY0=;
        fh=YOOYRgE1nwukrcyP7FUlE4oXl9St2J/dTrFHVGwM2iE=;
        b=LPpfdNHIg6ynIKsqmtXgrMEhvLzJNyKnS6zFzR3lPMO+Mv1QVlLtuAP58Cz5MFrVIG
         I6dknjHh/R1hQA8lormem8IEZu8Hiak62DZ0fDeSyEK2sW8WzVE2ep+XLQBxDSFte0kA
         HtT4oypY5aaqzDSRLQINeVvEpc5BWtWblAYJwe5iyGniGKHL0X8yJLvxtzQF2kneo1p+
         L9R1B+BAoplp6GY6gyfiw2uhn+4sVgUGei+IA8AvgTzOk7zymkxi6hPTl1ztjqzhJXGM
         7ODqRb5nX5sOrInuLaeONZuQWEyHnla82lR7GpJc1QEEc28Ruw+9j53NiYaVMsoAB/7N
         pQ3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794301960; x=1794906760; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CL+mYaY3tGDnGHrtpelaQSBbIHf49nURgXV9HJQUfY0=;
        b=zXKLOI63QCscfYZHZY4+Myzicd3aopoC7ck6ONm/yWOwDd9HV1/45+T4CD9+NQGcTG
         SlNX7swBaKhRgHML4wPGgoeSBIi35vGBbJSSz4yimhH3cIFRhcjsbCyjb9Uu/ORVkgD6
         hsv+pqcRKb0uHQ/jo7P8JQs3ZK6hvlZjj1oof/XjmAN9/VfK/6x0zq58UrGVPVenk8Du
         3XU4RtAafPfiVRYCDA5qoTR7c7CTBlHqK+BsdQtwJe7rfa9Kr0DBbBdYZZ3bpmYeqIPY
         93hSDDNLGk1fNgdbjh4PX7UbjOYPTKMD1Lhw4NO63Yj/9bYTocSAjc6Wvo5ijvVNmQ+p
         jmpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794301960; x=1794906760;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CL+mYaY3tGDnGHrtpelaQSBbIHf49nURgXV9HJQUfY0=;
        b=S7YU+9luEVKsXekTbgYDd5ieWhMLGqy7pLr3JGms681Es1+HztKJTRRtO1oRrO/YX9
         jIBJGEdYkv2Y+yvCgXGoddxA2/cir+9u3WZKpvowAumBNRDlcrO4QA1rivyH8TyG1G7d
         vLCLC9KyPGl22mGyk9y6mKf37kNufm+DG1zqes0VUIBzykr+KldoSD+keXYKXenFNQZC
         urbUdp8Yo7jEIQFbzIVJLu4bCT3RMHjJyfOxaIUze/0MpV8J+lo+B/e6++bb1bapipCb
         8EK7ntOViUF4nGlRJrGn+2EVuuqtQfWsQ+8P2Qv50tyXJx+9vJTxT/TeUccm/FZeEGd6
         aTzg==
X-Forwarded-Encrypted: i=1; AL+hErEdirCmBhuUBiuSTDWIRzeHY21AALkuQ3CpEkQUM98HYcn1wH/A7Jg11NUjTK2Bf3/eHMf7P2X17sdo@vger.kernel.org
X-Gm-Message-State: APuU4Z8hwVV3towXTH+Oka66U57PLArdN/kj5zquovH3FtOoLJyj2FZ4
	LdGV6hSiWLgahc9386NfN2UaYOJQpyrc+LOoNDChFCoyWSD9EReyF03XZG3KCtG+FXc9lYsKRt9
	MJO1lbpccnge285Ra2eJzCFyOgSAIolE=
X-Gm-Gg: AYBFou1o4BFJqZzTWzVdxO27TYE+Jo2Xu2drAGasVlkW0Ctm/6pP6atPjbn4C3FCobQ
	dNAx6ZYcLvafdc5D4PFb5350yLijqF186B6JllSbzuFxSk8soj3OscaN7UUOS3l5dsJ39mdCdOx
	TyW4r4NiFm995jgNiddynWlxvzolPAs8IUHizRRqovxjCwMOrGV8BGXPKKAlttSi2d5HM31b+AO
	3vygcChWc6MaCzPxVhLFDIZzyuYR42xEDkDikq3MJExyQhUHpJHpyWrfScTlgQemL9mLfFGVMvd
	EWpNVeWdQXN6ATKPLKrClTCwdw+TmxbAbsVKiwUJMrNu/Z6Ugrk0B4R3wrxnWYheAkgKOHsYBQi
	BjLJConVWhlgC/aOcAvZlBWyP+EEpUiqLKNjNDploWXJ9H68w34Qhllongy850eSgSZIVmjtBk/
	ZXPmCkur3fhW8fwJ0f3dXvCwmg6LNxoJLHvZY+qBaYxCRfupwHksYzsMiVXYusQxzz7w/9Pqze/
	IjEKHaZ0yFkEEwrIsjZBCzPg4vid6cTzeEhiVkA7PmpxSupIHgb6Z8sdH5q644=
X-Received: by 2002:a05:690c:1c:b0:8b0:a01e:2cc1 with SMTP id
 00721157ae682-8b392bd3a6bmr12222497b3.53.1794301959730; Tue, 10 Nov 2026
 01:12:39 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-fwnode-for-each-prop-v1-0-6e28fe1c72c4@oss.qualcomm.com>
 <20261104-fwnode-for-each-prop-v1-5-6e28fe1c72c4@oss.qualcomm.com>
 <auuhy40x1BMoW96-@ashevche-desk.local> <7sfr4ljlwbehal3or4dmy5jxbjz6ya2lf3dq3yptr54wym5tea@eqaexflmocih>
 <avICwdxyi-W1Y3PD@ashevche-desk.local> <ab73ez55exen3ew52svsxfinwsuatppdodu2e2zp6izjwwqwwu@2imxzxwclgtl>
In-Reply-To: <ab73ez55exen3ew52svsxfinwsuatppdodu2e2zp6izjwwqwwu@2imxzxwclgtl>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 10 Nov 2026 11:12:02 +0200
X-Gm-Features: AclHuK-j7UjC7_2X91Fl0h3tqgy10rRsGsXGtMX-1tGj0PKndsOn6ITWu7Xe30s
Message-ID: <CAHp75VcwiGHB73ny8iSvXeFdjbTKUpnXZPS5iD7NwaMcJ6q-7A@mail.gmail.com>
Subject: Re: [PATCH 5/9] of: property: implement the .property_get_names()
 fwnode operation
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>, Hans Verkuil <hverkuil@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Kees Cook <kees@kernel.org>, 
	Andy Shevchenko <andy@kernel.org>, Len Brown <lenb@kernel.org>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@kernel.org>, Linus Walleij <linusw@kernel.org>, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 11:00=E2=80=AFAM Bartosz Golaszewski <brgl@kernel.o=
rg> wrote:
> On Mon, Nov 09, 2026 at 07:28:33PM +0200, Andy Shevchenko wrote:
> > On Mon, Nov 09, 2026 at 02:07:46PM +0100, Bartosz Golaszewski wrote:
> > > On Wed, Nov 04, 2026 at 11:21:15PM +0200, Andy Shevchenko wrote:
> > > > On Wed, Nov 04, 2026 at 03:03:47PM +0100, Bartosz Golaszewski wrote=
:

...

> > > > > +               names[i] =3D kstrdup(prop->name, GFP_KERNEL);
> > > >
> > > > Can property be statically defined somewhere? We might want to also=
 optimize
> > > > these duplications with const variant (here or elsewhere, for fwnod=
e generic
> > > > path, I believe).
> > >
> > > Please rephrase because I'm not quite following what you're saying.
> >
> > Can prop->name come from something that is declared as
> >
> > static const ... foo =3D {
> >       ... .name =3D "bar";
> > };
>
> You can't know it for every instance of struct fwnode_handle, so the
> answer is: no.

I believe I misput my question. If there is any potential that *some*
of fwnodes use statically defined string literals for the property
name? If so, kstrdup_const() and friends may be a better choice here
to save some memory (which is getting more and more expensive these
days :-).

> PS: is there a way of using match_string() with non-const data?

Why? It's an input parameter, it returns an index. Whatever you
provide will be not modified.


--=20
With Best Regards,
Andy Shevchenko
