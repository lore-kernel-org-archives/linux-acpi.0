Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B9B3C3BF1
	for <linux-acpi@vger.kernel.org>; Fri, 20 Mar 2026 15:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774022311; cv=none; b=ZRX2hFzR0OUtwI8I27QCAXEWi6D9gySlTmEet3eBkhGRliFrCjuEF5YUb113SKLCfmGzPbO61RBmrBuNMmrwYBdzOUrLSASmtM6oCkz7JkXC786VUoxw+tttcDoZyPiUGRlixX1zUtPV2AbLe4v9gAQZQIQ6FMUUgL9tRknxvWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774022311; c=relaxed/simple;
	bh=5OVfAAKYK3pCoLiGVQAI4LiOth4ynX3Xbge5VJYkavc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tTy76ocNY7+vdiS7IQVpufqDnl28mIQwTH8qA2TsVM+b8AHbT+xqQNIwTRoNxUWVDs4eQ7DELK6KjN6PW7v56RkY8ilLooefM+9uuwgvHSZs6OSvIaGTiDTgQLqUZvSF7xLahfIxYVWDdHROIgnh8iukMK1OJmbuWJkK/+Os0+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pl16mdaQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pl16mdaQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40E08C4AF09
	for <linux-acpi@vger.kernel.org>; Fri, 20 Mar 2026 15:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774022311;
	bh=5OVfAAKYK3pCoLiGVQAI4LiOth4ynX3Xbge5VJYkavc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pl16mdaQ5+COvdD9bX5ZRystAoUG0uE2dY3Yvx/WMuBeNO8FE3lhKUIpOLQg17eGT
	 0FhgrAVDhlH9C1iGGYtI3u+/XlktPJzKMcGFmHHp8+mQDNiY6rF0ztNzJijj3vq8oz
	 gcGClnbQENyd5qhJdBGbF3h3Zc1ZGp9PFi4NGz8wvyodWXjcf2nK+eoVCNbBtlkRWZ
	 TZACQxSFIr1KUyJi2Zg8TYtLAnIqjPEgRkNkZ5lAstrP+LSGDP85SJLPZzEYMWEzbT
	 NE2qZUwQ3n20WaxKqnvQ7HzD401uSj8kc+q67u3Ngz+2UdaCD3Uvkpk1ncw5vWPpG1
	 t0APO6MNg/N0Q==
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-4645dde00a7so2668945b6e.1
        for <linux-acpi@vger.kernel.org>; Fri, 20 Mar 2026 08:58:31 -0700 (PDT)
X-Gm-Message-State: AOJu0YyPz9nCqaZ09dh/OxJGaNB7xCoyKCx9hh6R31Gyp0niOjQyDA9H
	fj2LqPiZBpmIUYwzugLlnVcI2TGQa2/Dyy0iTurpc9BsHXFOExObyc+bYPzPcIUiaIHNb2XYfjt
	JvD7oNodpBLHXlrjJQiyzrgDLqBLm3i4=
X-Received: by 2002:a05:6808:4fe4:b0:467:cd8:7f5e with SMTP id
 5614622812f47-467cd556a0dmr4624044b6e.4.1774022310328; Fri, 20 Mar 2026
 08:58:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8683270.T7Z3S40VBb@rafael.j.wysocki>
In-Reply-To: <8683270.T7Z3S40VBb@rafael.j.wysocki>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 20 Mar 2026 16:58:18 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gt72nhueFkpP1Hp9PNNbnQ6cmskq_sxEbdgzxy-ZWqjg@mail.gmail.com>
X-Gm-Features: AaiRm53OWzJ_LsLSl2Q21Pi0otYOG2pKuGSzCAUkrh5-7mMws8P_z_zFxxlNZcA
Message-ID: <CAJZ5v0gt72nhueFkpP1Hp9PNNbnQ6cmskq_sxEbdgzxy-ZWqjg@mail.gmail.com>
Subject: Re: [PATCH v1] ACPI: PAD: xen: Convert to a platform driver
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, xen-devel@lists.xenproject.org, 
	LKML <linux-kernel@vger.kernel.org>, Juergen Gross <jgross@suse.com>, 
	Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 14, 2026 at 12:57=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.o=
rg> wrote:
>
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>
> In all cases in which a struct acpi_driver is used for binding a driver
> to an ACPI device object, a corresponding platform device is created by
> the ACPI core and that device is regarded as a proper representation of
> underlying hardware.  Accordingly, a struct platform_driver should be
> used by driver code to bind to that device.  There are multiple reasons
> why drivers should not bind directly to ACPI device objects [1].
>
> Overall, it is better to bind drivers to platform devices than to their
> ACPI companions, so convert the Xen ACPI processor aggregator device
> (PAD) driver to a platform one.
>
> While this is not expected to alter functionality, it changes sysfs
> layout and so it will be visible to user space.
>
> Link: https://lore.kernel.org/all/2396510.ElGaqSPkdT@rafael.j.wysocki/ [1=
]
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

If there are any objections or concerns regarding this change, please
let me know.

In the absence of any, I'll queue it up for 7.1.

Thanks!

> ---
>
> Note that the original ACPI PAD driver has been a platform driver for
> quite some time already.
>
> ---
>  drivers/xen/xen-acpi-pad.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/xen/xen-acpi-pad.c b/drivers/xen/xen-acpi-pad.c
> index ede69a5278d3..75a39862c1df 100644
> --- a/drivers/xen/xen-acpi-pad.c
> +++ b/drivers/xen/xen-acpi-pad.c
> @@ -11,6 +11,7 @@
>  #include <linux/kernel.h>
>  #include <linux/types.h>
>  #include <linux/acpi.h>
> +#include <linux/platform_device.h>
>  #include <xen/xen.h>
>  #include <xen/interface/version.h>
>  #include <xen/xen-ops.h>
> @@ -107,8 +108,9 @@ static void acpi_pad_notify(acpi_handle handle, u32 e=
vent,
>         }
>  }
>
> -static int acpi_pad_add(struct acpi_device *device)
> +static int acpi_pad_probe(struct platform_device *pdev)
>  {
> +       struct acpi_device *device =3D ACPI_COMPANION(&pdev->dev);
>         acpi_status status;
>
>         strcpy(acpi_device_name(device), ACPI_PROCESSOR_AGGREGATOR_DEVICE=
_NAME);
> @@ -122,13 +124,13 @@ static int acpi_pad_add(struct acpi_device *device)
>         return 0;
>  }
>
> -static void acpi_pad_remove(struct acpi_device *device)
> +static void acpi_pad_remove(struct platform_device *pdev)
>  {
>         mutex_lock(&xen_cpu_lock);
>         xen_acpi_pad_idle_cpus(0);
>         mutex_unlock(&xen_cpu_lock);
>
> -       acpi_remove_notify_handler(device->handle,
> +       acpi_remove_notify_handler(ACPI_HANDLE(&pdev->dev),
>                 ACPI_DEVICE_NOTIFY, acpi_pad_notify);
>  }
>
> @@ -137,13 +139,12 @@ static const struct acpi_device_id pad_device_ids[]=
 =3D {
>         {"", 0},
>  };
>
> -static struct acpi_driver acpi_pad_driver =3D {
> -       .name =3D "processor_aggregator",
> -       .class =3D ACPI_PROCESSOR_AGGREGATOR_CLASS,
> -       .ids =3D pad_device_ids,
> -       .ops =3D {
> -               .add =3D acpi_pad_add,
> -               .remove =3D acpi_pad_remove,
> +static struct platform_driver acpi_pad_driver =3D {
> +       .probe =3D acpi_pad_probe,
> +       .remove =3D acpi_pad_remove,
> +       .driver =3D {
> +               .name =3D "acpi_processor_aggregator",
> +               .acpi_match_table =3D pad_device_ids,
>         },
>  };
>
> @@ -157,6 +158,6 @@ static int __init xen_acpi_pad_init(void)
>         if (!xen_running_on_version_or_later(4, 2))
>                 return -ENODEV;
>
> -       return acpi_bus_register_driver(&acpi_pad_driver);
> +       return platform_driver_register(&acpi_pad_driver);
>  }
>  subsys_initcall(xen_acpi_pad_init);
> --
> 2.51.0
>
>
>
>
>
