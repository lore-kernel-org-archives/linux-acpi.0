Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778653EFD21
	for <linux-acpi@vger.kernel.org>; Tue, 22 Sep 2026 15:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790091233; cv=none; b=Sn1VhdMKDbq+m17G+ZVIJUGnJIS3v63s+Crirt5Kr9RyMTbpl0ho+JHPbyiPcuzN0lT4QcEJsAdoxe+lvD/udJIR8kwMlhSjeNaziW01QvhzDXW9Azo9oOsME7/e0WHN2cZJOPfg7Wo4nTdaI7HGbMC7uMPBVhLInfmEi+7d/sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790091233; c=relaxed/simple;
	bh=yMVOvHmFlGbzrwn4Ac+6633Z8bR05Gyg8jnUa5AQlig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dBylLqWBWEItGWgx0TaYjfr55iAr+teX1GnLg/igPrskmNJ4M6rl+pDpC+PAKnWI9UVydLrzd/1OJzv9bMK+ler3sxJGJFDwtWshupeEjAgvccRU6mrnPH2FpM8XWmp03VafWjZ2yROBpYJFmpKo8fVHTldZ1ZZ8+v2Cn4P/wNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SRTgORf3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SRTgORf3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E47F1F00898
	for <linux-acpi@vger.kernel.org>; Tue, 22 Sep 2026 15:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790091232;
	bh=GYI5wtFM2GoPmjMjUy0CxDry+Zkrbpzec5EzEIlRoZA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=SRTgORf3Kp0yQB9+Dg98aeLjBdkQHOLJhJiHn33yUmW0XUWi4EgdE+q0qw7ghkheG
	 qCFhqHmpMBQ+MBFu/dOsN9s2dYmGuKQOXBI+TC0/NvDKSwLEEXGQfoZB1eKVu5QUNR
	 4jo7LDB4QvWKt+aV06ujI/rSCMbAIsv8hwi1oqEnnFomiB9lBiUmEiMUBaMuLDrbad
	 TXVfxzv0kdGvHATnuH08uPg94XTJKPrw1RvgiiJfUdpugV74zhy2qNtos5x42FCHFQ
	 1L3C2KxSA7ryVvDChOSHdeqxZ3B2cLqKa7Tg4QY8AVdJ7mU5nPIOwsj+UcBqf8nX4F
	 sB65I06CczJWQ==
Received: by mail-lr2-f35.google.com with SMTP id 38308e7fff4ca-3a60e33d456so24896241fa.1
        for <linux-acpi@vger.kernel.org>; Tue, 22 Sep 2026 08:33:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxXoe9unQT1LfE1OslyhrM7sau55YEv7wS5m0cdiRa4iHYyWiM/Ez1VytU4rYiX72JJkiNKiDPX3ozg@vger.kernel.org
X-Gm-Message-State: AFuF++lxJd6gvtCv5gGABlSi0doixaxBFfM9XZfFf0CyiXCpjZx2ipEz
	HmQd1xC8a9RVAr/HMbfX+746V9eqIOsQj6ofbCNlDOM2J0zW+0g2bVAtuUJPvksiQyUiCVIz+Zz
	1r5lC18kHtaL3jzwsLPmM8+0pYZU5l1o=
X-Received: by 2002:a2e:bc01:0:b0:3a3:7680:67fa with SMTP id
 38308e7fff4ca-3a5fbfe6617mr32263861fa.25.1790091230654; Tue, 22 Sep 2026
 08:33:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260919124605.12429-1-johannes.goede@oss.qualcomm.com> <20260919124605.12429-2-johannes.goede@oss.qualcomm.com>
In-Reply-To: <20260919124605.12429-2-johannes.goede@oss.qualcomm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 22 Sep 2026 17:32:18 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g3WvT9jUkpaAtFOk+DttCU1JrrUBRzokFwSffnJvjHzQ@mail.gmail.com>
X-Gm-Features: AcwNN1X3x3tS9smBg95IPgka02vbS_64Ol06MSaKP5oP-0ZvG6-SSs8af_1gAwU
Message-ID: <CAJZ5v0g3WvT9jUkpaAtFOk+DttCU1JrrUBRzokFwSffnJvjHzQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] ACPI: scan: Skip acpi_scan_dep_init() for processor devices
To: Hans de Goede <johannes.goede@oss.qualcomm.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, 
	linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 19, 2026 at 2:46=E2=80=AFPM Hans de Goede
<johannes.goede@oss.qualcomm.com> wrote:
>
> acpi_bus_check_add() only calls acpi_scan_add_dep() for devices of
> the ACPI_TYPE_DEVICE type. So the dep list of processor devices will
> never contain any deps for that device, making the acpi_scan_dep_init()
> call a no-op.
>
> Make acpi_add_single_object() only call acpi_scan_dep_init() for devices
> with the ACPI_TYPE_DEVICE type matching acpi_bus_check_add().
>
> Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
> ---
>  drivers/acpi/scan.c | 27 ++++++++++++++-------------
>  1 file changed, 14 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 40bbf9e322c2..38ac6c470a9f 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -1873,25 +1873,26 @@ static int acpi_add_single_object(struct acpi_dev=
ice **child,
>                 return -ENOMEM;
>
>         acpi_init_device_object(device, handle, type, acpi_device_release=
);
> +
> +       if (type =3D=3D ACPI_BUS_TYPE_DEVICE && dep_init) {
> +               mutex_lock(&acpi_dep_list_lock);
> +               /*
> +                * Hold the lock until the acpi_tie_acpi_dev() call
> +                * below to prevent concurrent acpi_scan_clear_dep()
> +                * from deleting a dependency list entry without
> +                * updating dep_unmet for the device.
> +                */
> +               release_dep_lock =3D true;
> +               acpi_scan_dep_init(device);
> +       }
> +

Instead of doing the above, I'd prefer to add a type =3D=3D
ACPI_BUS_TYPE_DEVICE check to the dep_init check below:

>         /*
>          * Getting the status is delayed till here so that we can call
>          * acpi_bus_get_status() and use its quirk handling.  Note that
>          * this must be done before the get power-/wakeup_dev-flags calls=
.
>          */
> -       if (type =3D=3D ACPI_BUS_TYPE_DEVICE || type =3D=3D ACPI_BUS_TYPE=
_PROCESSOR) {
> -               if (dep_init) {

               if (type =3D=3D ACPI_BUS_TYPE_DEVICE && dep_init) {

                       mutex_lock(&acpi_dep_list_lock);
                       /*
                        * Hold the lock until the acpi_tie_acpi_dev() call
                        * below to prevent concurrent acpi_scan_clear_dep()
                        * from deleting a dependency list entry without
                        * updating dep_unmet for the device.
                        */
                       release_dep_lock =3D true;
                       acpi_scan_dep_init(device);
               }
               acpi_scan_init_status(device);
       }

>         acpi_bus_get_power_flags(device);
>         acpi_bus_get_wakeup_device_flags(device);
> --
