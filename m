Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92143CE48C
	for <linux-acpi@vger.kernel.org>; Fri, 20 Mar 2026 16:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774022409; cv=none; b=JsBNGDD/pDZymA1Er9ZHMwYWTHh6hPIjCjhV3Gzi8A6cqzjVFsXa+rRAC+Li0FjH/5kHDy9SWoQQXGrr0UBtmgC8CfQbQSKDTkUiMHD1wqUCrZrRYl/k/brEp77MijImXFe1WT0ZsliFybekhNllV01MMlnCzRwaj0xP+sNovSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774022409; c=relaxed/simple;
	bh=+S6+qVjldY4Zm8SgY2bQ+KNyNutONdqyhsxm7OcMsSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AI0riO8TmoCVZiENghk2kuGgz6xig2qb0me5S1jQIomk+TlAjnTNuZnuUqNMQLsh0Tn6+rK3LM+WehV9QjKwTZ31HZZNJSHE8d798f9sNW1Zzx40wHJBWQ/FcQ3vH/I28ey7D9gpZKAF35fE6IR9t3BpqgyZmnfnrrYi4B7SCp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Er5ZZzgq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Er5ZZzgq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACF51C4AF09
	for <linux-acpi@vger.kernel.org>; Fri, 20 Mar 2026 16:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774022409;
	bh=+S6+qVjldY4Zm8SgY2bQ+KNyNutONdqyhsxm7OcMsSg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Er5ZZzgq1lbM4rDRvccaq9bIWw1QUqZoh++soreQYUelw56woiofh6TDi7wT2uEge
	 zUVvnl0wEM+CPmOFD2zLwW2sIBpiYv3fKmxCe481PAq1T+95RKVfzaZg3FFE+r491z
	 7m6DOmIjJ3hQ0uZ3Kr1/beX1RJle7RXKDoeTS1i92WyyvJoE/lcLLfGOAbVXilIwiZ
	 rubrKCMsi2OhGZ0dHmoPnQkQBP9cos/3rfj8ziiJ+81SGU2hvUX/a49Tyg4AF2c+fq
	 jRUU3byUfEUW5cLHq7I98CRvBEMDu6oMoa3E89v9E3m70SqinV0wybc8781CmxPD4L
	 WzSgg448iImzw==
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7d751ef36ccso374291a34.0
        for <linux-acpi@vger.kernel.org>; Fri, 20 Mar 2026 09:00:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUAW6NFd+faJPafhqYPfT6Rej7nHcEeQV3k8nk8NLVgXPsD52L12XjCSAgMDH5S9SsNRmn8zkR64J5a@vger.kernel.org
X-Gm-Message-State: AOJu0YxW7wiSqV4vD3pAbYhrRC6JFqxLrO7Fi4mPFQ466q9FfyuUMa+r
	5jDLnGQzOt/dBC1u6UdIfM75Z2O5MkSVKgEvdyoTWsfKrgAVSQdIPPvkfJz0aaivu4bem/xYOnJ
	HKBHUd9Ge+KTWB0rwr40lLyFN0c8NPHc=
X-Received: by 2002:a05:6830:370b:b0:7d7:cb13:3fea with SMTP id
 46e09a7af769-7d7eafb7ee3mr2094869a34.18.1774022408735; Fri, 20 Mar 2026
 09:00:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <13996583.uLZWGnKmhe@rafael.j.wysocki> <b8c1319a-4920-42b8-b98d-248e419cb87f@roeck-us.net>
In-Reply-To: <b8c1319a-4920-42b8-b98d-248e419cb87f@roeck-us.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 20 Mar 2026 16:59:57 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gWxH1rOHADwjHJTySN9ERY6sBwe_q51BjsAqiUxf6C5g@mail.gmail.com>
X-Gm-Features: AaiRm51MS6I49wlYS7FME3bJzlMN_x1rEw6gQq6q8GjCQySQxkPYi_A__FNPXVA
Message-ID: <CAJZ5v0gWxH1rOHADwjHJTySN9ERY6sBwe_q51BjsAqiUxf6C5g@mail.gmail.com>
Subject: Re: [PATCH v1] watchdog: ni903x_wdt: Convert to a platform driver
To: Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	Wim Van Sebroeck <wim@linux-watchdog.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2026 at 4:13=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> =
wrote:
>
> On 3/14/26 04:53, Rafael J. Wysocki wrote:
> > From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> >
> > In all cases in which a struct acpi_driver is used for binding a driver
> > to an ACPI device object, a corresponding platform device is created by
> > the ACPI core and that device is regarded as a proper representation of
> > underlying hardware.  Accordingly, a struct platform_driver should be
> > used by driver code to bind to that device.  There are multiple reasons
> > why drivers should not bind directly to ACPI device objects [1].
> >
> > In particular, registering a watchdog device under a struct acpi_device
> > is questionable because it causes the watchdog to be hidden in the ACPI
> > bus sysfs hierarchy and it goes against the general rule that a struct
> > acpi_device can only be a parent of another struct acpi_device.
> >
> > Overall, it is better to bind drivers to platform devices than to their
> > ACPI companions, so convert the ni903x_wdt watchdog ACPI driver to a
> > platform one.
> >
> > While this is not expected to alter functionality, it changes sysfs
> > layout and so it will be visible to user space.
> >
> > Note that after this change it actually makes sense to look for
> > the "timeout-sec" property via device_property_read_u32() under the
> > device passed to watchdog_init_timeout() because it has an fwnode
> > handle (unlike a struct acpi_device which is an fwnode itself).
> >
> > Link: https://lore.kernel.org/all/2396510.ElGaqSPkdT@rafael.j.wysocki/ =
[1]
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Unless anyone has any objections or concerns, I'm going to queue up
this patch for 7.1.

Thanks!

> > ---
> >   drivers/watchdog/ni903x_wdt.c | 27 ++++++++++++++-------------
> >   1 file changed, 14 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/watchdog/ni903x_wdt.c b/drivers/watchdog/ni903x_wd=
t.c
> > index 045bb72d9a43..8b1b9baa914e 100644
> > --- a/drivers/watchdog/ni903x_wdt.c
> > +++ b/drivers/watchdog/ni903x_wdt.c
> > @@ -8,6 +8,7 @@
> >   #include <linux/interrupt.h>
> >   #include <linux/io.h>
> >   #include <linux/module.h>
> > +#include <linux/platform_device.h>
> >   #include <linux/watchdog.h>
> >
> >   #define NIWD_CONTROL        0x01
> > @@ -177,9 +178,9 @@ static const struct watchdog_ops ni903x_wdd_ops =3D=
 {
> >       .get_timeleft =3D ni903x_wdd_get_timeleft,
> >   };
> >
> > -static int ni903x_acpi_add(struct acpi_device *device)
> > +static int ni903x_acpi_probe(struct platform_device *pdev)
> >   {
> > -     struct device *dev =3D &device->dev;
> > +     struct device *dev =3D &pdev->dev;
> >       struct watchdog_device *wdd;
> >       struct ni903x_wdt *wdt;
> >       acpi_status status;
> > @@ -189,10 +190,10 @@ static int ni903x_acpi_add(struct acpi_device *de=
vice)
> >       if (!wdt)
> >               return -ENOMEM;
> >
> > -     device->driver_data =3D wdt;
> > +     platform_set_drvdata(pdev, wdt);
> >       wdt->dev =3D dev;
> >
> > -     status =3D acpi_walk_resources(device->handle, METHOD_NAME__CRS,
> > +     status =3D acpi_walk_resources(ACPI_HANDLE(dev), METHOD_NAME__CRS=
,
> >                                    ni903x_resources, wdt);
> >       if (ACPI_FAILURE(status) || wdt->io_base =3D=3D 0) {
> >               dev_err(dev, "failed to get resources\n");
> > @@ -224,9 +225,9 @@ static int ni903x_acpi_add(struct acpi_device *devi=
ce)
> >       return 0;
> >   }
> >
> > -static void ni903x_acpi_remove(struct acpi_device *device)
> > +static void ni903x_acpi_remove(struct platform_device *pdev)
> >   {
> > -     struct ni903x_wdt *wdt =3D acpi_driver_data(device);
> > +     struct ni903x_wdt *wdt =3D platform_get_drvdata(pdev);
> >
> >       ni903x_wdd_stop(&wdt->wdd);
> >       watchdog_unregister_device(&wdt->wdd);
> > @@ -238,16 +239,16 @@ static const struct acpi_device_id ni903x_device_=
ids[] =3D {
> >   };
> >   MODULE_DEVICE_TABLE(acpi, ni903x_device_ids);
> >
> > -static struct acpi_driver ni903x_acpi_driver =3D {
> > -     .name =3D NIWD_NAME,
> > -     .ids =3D ni903x_device_ids,
> > -     .ops =3D {
> > -             .add =3D ni903x_acpi_add,
> > -             .remove =3D ni903x_acpi_remove,
> > +static struct platform_driver ni903x_acpi_driver =3D {
> > +     .probe =3D ni903x_acpi_probe,
> > +     .remove =3D ni903x_acpi_remove,
> > +     .driver =3D {
> > +             .name =3D NIWD_NAME,
> > +             .acpi_match_table =3D ni903x_device_ids,
> >       },
> >   };
> >
> > -module_acpi_driver(ni903x_acpi_driver);
> > +module_platform_driver(ni903x_acpi_driver);
> >
> >   MODULE_DESCRIPTION("NI 903x Watchdog");
> >   MODULE_AUTHOR("Jeff Westfahl <jeff.westfahl@ni.com>");
>
