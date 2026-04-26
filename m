Received: from relay10.grserver.gr (relay10.grserver.gr [37.27.248.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D85F15ECCC
	for <linux-acpi@vger.kernel.org>; Sun, 26 Apr 2026 17:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.27.248.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777223030; cv=none; b=SFM0NnqrX5ccF0qCLdPZwyTJtbEarYLmrAnxgE5w7BVk6XXvyysumDAEpej4J3EmYPBnC24fysncQSSCzX7gk5QlrdfIg1sXg4qOgsLRo6RK9iWdU2PoiIw52SKxm/pN16s7ecYhM86gBmjEPbhA+bW0rKA1qysEMnZP3Hdp+kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777223030; c=relaxed/simple;
	bh=u4g4f5IE0Cynm1ZQNlu2Tk9YpQjwNZYKT8qSytxaPIE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Naq2cPqRUkj1JVtQlIEFrSR3u8y0b0T3SsO3/q4ugWzUNEkwrKPBhn3qJ5N02kHFt8kJG4PWp5w0DMQsZlgvbisUizk9bUZ/rmYPD7VYxJzxs/9FoCgC3viY2QQnf6+d1APJiIxop7t6AeyD675bLka+J7C66LDgFFvYKSaDSCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=JtMO+Ofa; arc=none smtp.client-ip=37.27.248.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="JtMO+Ofa"
Received: from relay10 (localhost.localdomain [127.0.0.1])
	by relay10.grserver.gr (Proxmox) with ESMTP id BA38E4281B
	for <linux-acpi@vger.kernel.org>; Sun, 26 Apr 2026 19:54:56 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay10.grserver.gr (Proxmox) with ESMTPS id B4C73427F4
	for <linux-acpi@vger.kernel.org>; Sun, 26 Apr 2026 19:54:55 +0300 (EEST)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id C34CC1FDE21
	for <linux-acpi@vger.kernel.org>; Sun, 26 Apr 2026 19:54:54 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1777222495;
	bh=PHyksx3SrYCAksdyFDyGJC4k4AOcdtDlG3f/xsyVUYU=;
	h=Received:From:Subject:To;
	b=JtMO+OfaquiG26OUZcc/7vkuRZOG79FihrHZkCL5xucQE6M5+b9Ty/cDdb7a+tfGb
	 FROkhcYP2v7UM4gqkTbhTDkJJMbIttj7B+eu2OG/Vs+pjfCW8Mz6QjsKZIVMRnxhpY
	 BXF8zUL5hVVU0Uv6VPXfxEhpW6zC+3PV1S6GKyrcqzCZ5HUQAz6nDI1tfvJU9wgHLm
	 ib7qRf+ufN5S3OwFWD3Zqzqh8cnmklE1G+c+1NgW6e+4IHbTsK3iEK5Sn+SIicuRKT
	 0V+4LD9PE8p6pBXPObvtYgrIZQ4Q+6hMFqqD3Ulh1F5lK9F8pTWHfhRhWpLFHYf8Eg
	 f9UepeTnbWxEg==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.214.171) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-pl1-f171.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-2b4650d5f5cso35273795ad.0
        for <linux-acpi@vger.kernel.org>;
 Sun, 26 Apr 2026 09:54:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ8dJYzIrNjNYnb2OTFFZllgSsFZpHTEm5tBm+yjad/FUR4uigaguxGOna+qZky6UxcS0UatCwngd5EG@vger.kernel.org
X-Gm-Message-State: AOJu0YxSgkTJiXVBK5jmDrEo2YbXGrjLxrmuOjJFbtoKypvY6JOMLFf+
	c2VM2+Y5WN8/rJ+Z5gIL65NmHoGzV9dwahCA+4TeLxE7MPSuOg1ME1LUr7tL9gzjWzFaZ6nHgDt
	ilr0SJQ6bFo36syrxOKowZebC1Exymo4=
X-Received: by 2002:a17:902:868f:b0:2b4:59bf:5728 with SMTP id
 d9443c01a7336-2b5f9f3ca68mr311602245ad.25.1777222492929; Sun, 26 Apr 2026
 09:54:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260425215734.14116-1-lkml@antheas.dev>
 <20260425215734.14116-2-lkml@antheas.dev>
 <CAJZ5v0ipM9khNZs3uNu5GuFO3nJZ=EOht7mLtLNNsW9s9jWCsg@mail.gmail.com>
In-Reply-To: 
 <CAJZ5v0ipM9khNZs3uNu5GuFO3nJZ=EOht7mLtLNNsW9s9jWCsg@mail.gmail.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Sun, 26 Apr 2026 18:54:41 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwE4aqgBur-45whZManQzj-bMF4GUfA-oPk+huRnpkGRYA@mail.gmail.com>
X-Gm-Features: AQROBzBUutY0iqVq8V5-HgxBaFnjta-3eJA1kE9fzUUNEwlDl2ydpE8BwfqoC_8
Message-ID: 
 <CAGwozwE4aqgBur-45whZManQzj-bMF4GUfA-oPk+huRnpkGRYA@mail.gmail.com>
Subject: Re: [RFC v2 01/10] acpi/x86: s2idle: Rename LPS0 constants so they
 mirror their function
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: dmitry.osipenko@collabora.com, bob.beckett@collabora.com,
	bookeldor@gmail.com, hadess@hadess.net, jaap@haitsma.org,
	kernel@collabora.com, lennart@poettering.net, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, mccann@jhu.edu, richard@hughsie.com,
	sebastian.reichel@collabora.com, superm1@kernel.org,
	systemd-devel@lists.freedesktop.org, xaver.hugl@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-PPP-Message-ID: 
 <177722249519.171739.647858828543374472@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Sun, 26 Apr 2026 at 16:15, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Sat, Apr 25, 2026 at 11:57=E2=80=AFPM Antheas Kapenekakis <lkml@anthea=
s.dev> wrote:
> >
> > The LPS0 3/4 constants are part of a firmware notification called
> > "Display on/off", in which the device enters a "Screen Off" state.
> > The LPS0 7/8 constants are part of a firmware notification in which
> > a Windows modern standby computer enters a "sleep" state where the
> > CPU may still be active and maintain the radios.
> >
> > However, currently, the values are named as "Screen on/off" and "MS
> > entry/exit", where Modern Standby is abbreviated as "MS". Therefore,
> > perform a minor rename so that the values match their function. Then,
> > fix the debug message to say that it executes notifications instead of
> > entering states as it is otherwise confusing.
> >
> > Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> > ---
> >  drivers/acpi/x86/s2idle.c | 84 +++++++++++++++++++++------------------
> >  1 file changed, 45 insertions(+), 39 deletions(-)
> >
> > diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
> > index b6b1dd76a06b..61a044b59776 100644
> > --- a/drivers/acpi/x86/s2idle.c
> > +++ b/drivers/acpi/x86/s2idle.c
> > @@ -43,20 +43,20 @@ static const struct acpi_device_id lps0_device_ids[=
] =3D {
> >  #define ACPI_LPS0_DSM_UUID     "c4eb40a0-6cd2-11e2-bcfd-0800200c9a66"
> >
> >  #define ACPI_LPS0_GET_DEVICE_CONSTRAINTS       1
> > -#define ACPI_LPS0_SCREEN_OFF   3
> > -#define ACPI_LPS0_SCREEN_ON    4
> > +#define ACPI_LPS0_DISPLAY_OFF  3
> > +#define ACPI_LPS0_DISPLAY_ON   4
>
> You've clearly ignored my feedback on this.

Hi,

did https://lore.kernel.org/all/CAGwozwE_QbiNk53+kTjwELtWhK31LCrBm5fgx2b46s=
Za_5wjaA@mail.gmail.com/
not address your feedback?

The notifications are named display off / on in the document you linked.

I did not receive a response so I considered it resolved.

Antheas

> Thanks!
>

