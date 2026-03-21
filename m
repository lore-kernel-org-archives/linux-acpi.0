Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11B08462
	for <linux-acpi@vger.kernel.org>; Sat, 21 Mar 2026 03:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774063006; cv=none; b=fmUg8dLutoi2KrFyyOrnpKH9MWy1LkTI9L4h6tCDi4AxxLLCsi1DjrQv9vCzPBW87DeDD1jocKEGPaXwohGG0Hq77nw2kUGm9W0swnrwMsLWuQnWuJHZSXhv04HTIVcOmpedTAoKSObzUnRWsfEeKvTvrY2K1uPSmHZ7x26dtlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774063006; c=relaxed/simple;
	bh=KCouMn/Dg6hm0eYmov7z8hH1AZtJwHW0P50SCpJ5vto=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EF1splwBpXyLijSdRkUatD2K9Fn+rlcH2H9Itpi0GzIM6VKXx5LQTKj8EjFgJ7hVpZIQNuN0hvtUANZ3H7BuHvELRBo5CS3EoF12qFZwPMqhkA/MdvthHMlk4MQH1SQyn+yFUYxoutHuMo5DRagqTzf9GnCxyeGWYJQVDSNlxkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=H+fe1FAt; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H+fe1FAt"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a12cd0bd79so2530273e87.2
        for <linux-acpi@vger.kernel.org>; Fri, 20 Mar 2026 20:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1774063003; x=1774667803; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8/RSF0E6FhLD8wutFoB7bxuZrdpYQYvN1Rthj0xeHEY=;
        b=H+fe1FAtzJ1wTxSeGQRTZl+6GMsejcmW6vjbAAkEKrTv+bM6cR6S3/1zh7xblcXZsu
         j05krWWCzI4s+kJQCd4yfCcd/5DyNJFkMMObY09e3ZPiBNl6joI7wCJP8bHPmRQz2vLd
         ahg+78JyTz8MWoW+x1XZ6eC1pv5OMnmoCgnkQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774063003; x=1774667803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8/RSF0E6FhLD8wutFoB7bxuZrdpYQYvN1Rthj0xeHEY=;
        b=fn6gaPnfIreWl4JEtjcU/+5r7vD2ww4HOIY6vaJS2lHBSWCDqmxV+iv/YylCWZu3Ck
         7GeI6UO3YBN320bCUcSR9tUDLfNvRG4TWdJ9ol2LvEAlHrJDwhS39/+6BaUTGNLIR2gA
         lyjB64o4/yPddbjktBXXINImjBFqYn4KIbjY02WfmwUjIKCdWy5MBrdDCEsa4zZ2Zs1L
         gqV2XPATkXlAqxLeoJ68b5zuHBDONHQCh8732uNoiKZVNTdoO3L04MG4VBdUK+yaDQgY
         FvyiA1A8OHDWUh+NZJD9rNPtr47vLdTAXxcHlr+01bTW6CqvxaNN/C8ylOIZN5Ncakqa
         /ngQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeSnSfUza2xHmKh9Lc6w98TZ/fjQVj0/AsUqAzMco5QsAj3BHu4wAAG4DmsVuxrMdQsmMLH7T5YxzN@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhaf63BBUH0NOBW31h2JMi6fsfqvHWdXLFMWuJIp2KRMqC2iVh
	2ceZb77ZxZQSw1Xvs/0qUNgB2Slfy+6ArkeiFeJmnhPHQ4TLDD1m6KdXGKuLq2vIQt4z7OmFsE9
	tBhPnBH3X
X-Gm-Gg: ATEYQzxQXpzU+xoii5rk93al2aOxM3PxczsKt/Qhjnyt3t+3aEZ4euiFH4pp5jG7tZe
	8ePY9bu+/Rhs6ufgxJSTrMxqsoov1BFgm3sSsMSp1+lxYmPTZ0ark0rGVmoOdzAsMsweOyuZuGk
	OJV7UQwXZm0nrLhQUpGVjrxAvNDqhvQ45LHCt92ioR95o1To2qjZWQVU/FKA2vORfiZ7rUf4Wlo
	wxd0gDjRcTUQGhBQXQJRw1qad2yTXA1zsdniw/zlNhxuE66JhCaoidv7M3BZijbhuLnSe8/nV7c
	gMps3a5tgmZUpG/xYMH0a//mQmW7lBoXb1VGpL2FgzU/Hdolcouzpb2crsh8vRm3K77ermjEgZL
	8u0FfjK6yhBFM055GRUUXpkT+IOeeY38hpTRiedAyN/5QxFuKHgh/clt4dWqVS2r5h6udP5Jzqa
	uHQvdx5NesvlKFoTd3NJmNTnNpYz+GUPZJo1jj6stVw7SczR03QVu69/vCHuSif31++g==
X-Received: by 2002:a05:6512:684:b0:5a2:84cb:89b5 with SMTP id 2adb3069b0e04-5a285b500fcmr1505126e87.30.1774063002751;
        Fri, 20 Mar 2026 20:16:42 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a28520734csm892432e87.53.2026.03.20.20.16.42
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2026 20:16:42 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-389f9895c81so26343261fa.2
        for <linux-acpi@vger.kernel.org>; Fri, 20 Mar 2026 20:16:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWSb6Fc9QGvWfunAMC7LD7xoGLtfAWwsfrHSfS78v7CTh0kegFk6XEP0yjeMSabyBU/4gum3FUqksKo@vger.kernel.org
X-Received: by 2002:a05:600c:8119:b0:485:345b:ccb1 with SMTP id
 5b1f17b1804b1-486ff031f5dmr63989995e9.27.1774062615176; Fri, 20 Mar 2026
 20:10:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317090112.v2.1.I0a4d03104ecd5103df3d76f66c8d21b1d15a2e38@changeid>
 <CACRMN=euZzwDpCQupzth-J1z9qWXPenmy_bu727+R-kt97zexw@mail.gmail.com> <CAD=FV=WEWMdh+SuSE-5P81g7NhV8KH_4u_FxcRdBFRTAaASqhQ@mail.gmail.com>
In-Reply-To: <CAD=FV=WEWMdh+SuSE-5P81g7NhV8KH_4u_FxcRdBFRTAaASqhQ@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 20 Mar 2026 20:10:03 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VsAi-K9WnkT996WExfividTRi-aVcyLVD4Aicif=D=dA@mail.gmail.com>
X-Gm-Features: AaiRm53JJySLwTXCCA6qh8x4Qo2JwYxEnfOViwtwDhVjyjDx4WswvOZrKm9fsCw
Message-ID: <CAD=FV=VsAi-K9WnkT996WExfividTRi-aVcyLVD4Aicif=D=dA@mail.gmail.com>
Subject: Re: [PATCH v2] device property: Make modifications of fwnode "flags"
 thread safe
To: Saravana Kannan <saravanak@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, stable@vger.kernel.org, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mark Brown <broonie@kernel.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Andrew Lunn <andrew@lunn.ch>, 
	Daniel Scally <djrscally@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, Len Brown <lenb@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, devicetree@vger.kernel.org, 
	driver-core@lists.linux.dev, imx@lists.linux.dev, linux-acpi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 19, 2026 at 10:52=E2=80=AFAM Doug Anderson <dianders@chromium.o=
rg> wrote:
>
> Hi,
>
> On Thu, Mar 19, 2026 at 10:25=E2=80=AFAM Saravana Kannan <saravanak@kerne=
l.org> wrote:
> >
> > On Tue, Mar 17, 2026 at 9:04=E2=80=AFAM Douglas Anderson <dianders@chro=
mium.org> wrote:
> > >
> > > In various places in the kernel, we modify the fwnode "flags" member
> > > by doing either:
> > >   fwnode->flags |=3D SOME_FLAG;
> > >   fwnode->flags &=3D ~SOME_FLAG;
> > >
> > > This type of modification is not thread-safe. If two threads are both
> > > mucking with the flags at the same time then one can clobber the
> > > other.
> > >
> > > While flags are often modified while under the "fwnode_link_lock",
> > > this is not universally true.
> > >
> > > Create some accessor functions for setting, clearing, and testing the
> > > FWNODE flags and move all users to these accessor functions. New
> > > accessor functions use set_bit() and clear_bit(), which are
> > > thread-safe.
> > >
> > > Cc: stable@vger.kernel.org
> > > Fixes: c2c724c868c4 ("driver core: Add fw_devlink_parse_fwtree()")
> > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > Acked-by: Mark Brown <broonie@kernel.org>
> > > Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > > ---
> > > While this patch is not known for sure to fix any specific issues, it
> > > seems possible that it could fix some rare problems. I'm currently
> > > trying to track down a hard-to-reproduce heisenbug and one (currently
> > > unproven) theory I had was that the fwnode flags could be getting
> > > messed up like this. Even if turns out not to fix my heisenbug,
> > > though, this seems like a worthwhile change to take.
> >
> > Reviewed-by: Saravana Kannan <saravanak@kernel.org>
>
> Thanks for the review!
>
>
> > Thanks Doug. Hope this isn't the cause of the hisenbug. If you report
> > it here, I might be able to take a look at it too (no promises).
>
> I don't _think_ it fixes my bug, but I'm still not 100% sure because
> the bug can take a day or so to reproduce and it appears to only
> reproduce on official kernels built by the builder. :( This makes it
> hard to say anything for certain and also hard for me to inject extra
> debug logic.

Just in case anyone out there was wracking their brains based on my
description of the bug...

I've made progress in getting the issue to reproduce even with debug
information added. With that, I've found that
device_links_driver_bound() is getting called where `dev->fwnode->dev`
is NULL. That prevents it from running the ever-important
__fw_devlink_pickup_dangling_consumers().

I can see that device_add() has started, but it just hasn't made it to
the `dev->fwnode->dev =3D dev;` line yet.  My printout next to that line
shows up _after_ my printout in device_links_driver_bound().

So obviously something can happen to cause the device to probe before
the call to bus_probe_device().

OK, I managed to get a stack crawl for when `dev->fwnode->dev =3D=3D
NULL`. It looks like this (FWIW, it's a 6.6 kernel but issue also
reproduces on our 6.12 kernel, and I see no reason it wouldn't
reproduce on mainline):

  Call trace:
  dump_backtrace+0xe8/0x108
  show_stack+0x18/0x28
  dump_stack_lvl+0x50/0x6c
  dump_stack+0x18/0x24
  device_links_driver_bound+0xa4/0x4b4
  driver_bound+0x48/0x1c4
  really_probe+0x244/0x374
  __driver_probe_device+0xa0/0x12c
  driver_probe_device+0x3c/0x218
  __driver_attach+0x110/0x1ec
  bus_for_each_dev+0x104/0x160
  driver_attach+0x24/0x34
  bus_add_driver+0x154/0x270
  driver_register+0x68/0x104
  __platform_driver_register+0x24/0x34
  init_module+0x20/0xfe4 [max77779_pmic_pinctrl
e09198e651272bc5df70245355346d6eb1ba3a8f]
  do_one_initcall+0xdc/0x360
  do_init_module+0x58/0x23c
  load_module+0xffc/0x1130
  __arm64_sys_finit_module+0x260/0x300
  invoke_syscall+0x58/0x114

It looks like what happens is that immediately after device_add()
calls bus_add_device() there's a possibility of another thread
inserting the module holding the device driver. That means that the
driver can start probing much earlier than we expect.

I've posted an RFC patch to fix this. If folks are interested, please revie=
w it:

https://lore.kernel.org/r/20260320200656.RFC.1.Id750b0fbcc94f23ed04b7aecabc=
ead688d0d8c17@changeid

Given the stack crawl I got, I'm fairly certain that this will fix the
problem, but I'll also let reboot tests run over the weekend to
confirm.

-Doug
