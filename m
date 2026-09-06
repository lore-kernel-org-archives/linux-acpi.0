Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4467C1ABEDE
	for <linux-acpi@vger.kernel.org>; Sun,  6 Sep 2026 11:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788694719; cv=none; b=sUGu0WrErnNNqoaYwbcnN/5QnqkPNlLDyOgKEkpeVS+nXTJb3HbMd2ag+LrEJ2GS8CIQj/ITuV+FMgUAQzZNSx+YiJ+DMp21m1AZVp5qvRihFG5VL44LBepbCYCNhBoRV+tOswk8Tp0+9sDFZSb7y231Ku0MhKnSKf28Fx5iNEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788694719; c=relaxed/simple;
	bh=8zyVRKoe229/41kYwValVZLtUs+e5hCzDduQ52Ut+50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r0NBCOha6wxVV2LmoSnmHMfh4RQhS53VLJPr/kcGsSwc0uNSsv5Xpedp/zGQv8ZTyEz4zCCi4K95torB4huAyV3w0BZu/8j7WQdkisKWaw3u4GKAIpy26mnrEH4UPI61VY+7/IZZKq4bja/tmSbfjRH/e6xUaU0Svn0ErLWg5w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=USsTrUs/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="USsTrUs/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F29981F00A3D
	for <linux-acpi@vger.kernel.org>; Sun,  6 Sep 2026 11:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788694718;
	bh=8d5LYRivhBjGa3J3T6gbUIeJ8r2G/KnX0C5WVFWijlI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=USsTrUs/DbT5X0vbHQGmKyMXsKc4Tgxh1QcvmTPgMB5wqt3RDdZGV5J8P5DnUAw9i
	 eeCWG3gjrhyrQQuN8Tl0dTebPQt3jyyvFfmMkJkHSM/9e+QyNqiZ+PaFZLE56ROecs
	 pTYHQ3hgHIe7NZhKLhMhBdXS1l61rmn3UVkwhsQkNqyKgyozS/TCagL8TllnAYjTYj
	 X1LNIItTXAdH5uUVl34MO/lUMIzXFD15JKtgfSxFElZD44ed04z8bxsQC4GfSWdAPy
	 +feapVMkmoD6cfMXeElLlRUeZPAk08G136HsVOMuAS5uTFQkA6uu2UoDyWPOj5/V8J
	 CXGpNjFNMdctQ==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3a2e985245eso18851801fa.0
        for <linux-acpi@vger.kernel.org>; Sun, 06 Sep 2026 04:38:37 -0700 (PDT)
X-Gm-Message-State: AFuF++l1MBRTd8hVvtl7ahVzl93TxDEZLK1HYw/73enB3s3wGcVPoTkJ
	QClM3tiUrVuqa80NZoHNUt2k/xRPz8XxRV9nfR9A0tj9p+Ogm7/Ti6aEu23iXkWBIGXX94PY9o4
	ETF2LptdiUV9So+Gj9EVE0lGrkHhhwMs=
X-Received: by 2002:a05:651c:552:b0:3a3:74b9:8a78 with SMTP id
 38308e7fff4ca-3a374b98afamr15952291fa.17.1788694716331; Sun, 06 Sep 2026
 04:38:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6048536.DvuYhMxLoT@rafael.j.wysocki>
In-Reply-To: <6048536.DvuYhMxLoT@rafael.j.wysocki>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Sun, 6 Sep 2026 13:37:32 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gqEuKu774XH3NZdG-bwKkPUAUjPKZF2L0opp9LOON3CQ@mail.gmail.com>
X-Gm-Features: AcwNN1VFeNeBi8GHmzBSusAsdoayKvAd_NlLEqq5i3DtoWzhFtpr3aDAw8wumpo
Message-ID: <CAJZ5v0gqEuKu774XH3NZdG-bwKkPUAUjPKZF2L0opp9LOON3CQ@mail.gmail.com>
Subject: Re: [PATCH v3] ACPI: glue: Reduce debug noise from acpi_device_notify()
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 10:12=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>
> When debug is enabled in the ACPI glue code that handles binding
> devices to ACPI companions, acpi_device_notify() produces a lot of
> message noise related to devices that have no ACPI companions.
>
> Reduce that noise by checking the most obvious case, ACPI device
> objects, directly and returning from acpi_device_notify() in that
> case without printing any debug messages.  Also avoid printing a
> debug message when there is no matching ACPI companion lookup
> method for the given device, which is the case for the vast
> majority of devices.
>
> Additionally, make the debug messages that get printed more informative
> and adjust the "success" debug message for devices whose ACPI companions
> have no ACPI handles (for example, they are fixed event buttons).
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>
> v2 -> v3:
>    * Do not change pr_fmt() definition (Sashiko)
>    * adjust the "success" debug message for devices whose ACPI companions
>      have no ACPI handles
>    * Update changelog
>
> v1 -> v2:
>    * Do not return early from acpi_device_notify() for devices
>      without a bus type (Sashiko)
>    * Do not print messages for devices without matching ACPI bus
>      type definition (the vast majority)
>    * Update changelog
>
> ---
>  drivers/acpi/glue.c |   27 +++++++++++++++------------
>  1 file changed, 15 insertions(+), 12 deletions(-)
>
> --- a/drivers/acpi/glue.c
> +++ b/drivers/acpi/glue.c
> @@ -354,22 +354,27 @@ void acpi_device_notify(struct device *d
>         struct acpi_device *adev;
>         int ret;
>
> +       /* ACPI devices have no ACPI companions. */
> +       if (dev->bus =3D=3D &acpi_bus_type)
> +               return;
> +
>         ret =3D acpi_bind_one(dev, NULL);
>         if (ret) {
>                 struct acpi_bus_type *type =3D acpi_get_bus_type(dev);
>
>                 if (!type)
> -                       goto err;
> +                       return;
>
>                 adev =3D type->find_companion(dev);
>                 if (!adev) {
>                         dev_dbg(dev, "ACPI companion not found\n");
> -                       goto err;
> +                       return;
>                 }
>                 ret =3D acpi_bind_one(dev, adev);
> -               if (ret)
> -                       goto err;
> -
> +               if (ret) {
> +                       dev_dbg(dev, "Binding to ACPI companion failed\n"=
);
> +                       return;
> +               }
>                 if (type->setup) {
>                         type->setup(dev);
>                         goto done;
> @@ -389,13 +394,11 @@ void acpi_device_notify(struct device *d
>                 adev->handler->bind(dev);
>
>  done:
> -       acpi_handle_debug(ACPI_HANDLE(dev), "Bound to device %s\n",
> -                         dev_name(dev));
> -
> -       return;
> -
> -err:
> -       dev_dbg(dev, "No ACPI support\n");
> +       if (adev->handle)
> +               acpi_handle_debug(adev->handle, "Bound to device %s\n",
> +                                 dev_name(dev));
> +       else
> +               dev_dbg(dev, "Bound to ACPI device %s\n", dev_name(&adev-=
>dev));

Self review: This isn't particularly nice and it kind of works around
a broader issue which is that the acpi_handle_debug() message is
somewhat misleading because it suggests that an ACPI namespace object
has been bound to a "physical" device, which is not what really
happens.

In fact, the "physical" device is bound to an ACPI device object
attached to the ACPI namespace object represented by the handle (or
namespace path).

So scratch this one and there will be a v4 (which will consist of 2 patches=
).
