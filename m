Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794248570;
	b=rvPa93T6ggFEEbWl96Mbt4rKNoxUCTKVno8zYjH7oMCX2cVOdiN+Su+nc3yPA1ScpyUm
	 qz42UjreEuDsEJgmxFFupksxXjCdNgAwSHir9esUd8hNaxN2jiUYUGYskLW6+TNJuZLVb
	 5uAEn5CGctBa5DL8p6rB2dVcPC+fsIVDySRT9PjxODM3w5N+xLARSNSAG4DWcWf87vDng
	 8SAM2LQYI/jZfpT4uFhBBTY285nfAllzstgbEYNVZ511/HbzirDCxfyr/N7r6laRkMfNJ
	 BgEAVrSkqfASwM0c4GYb/UAnfdmcPf3ywh86T31qMwQ1+oAdG+uPju1Mpx2KNuMxvUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794248570;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=PVjD9UIIFCSC8dyfllOxWG2BIVsv90HOg6kMoCemq0M=;
	b=UTF0Eh88QX7muph5FrwmyOlMQuyU8BxktGUmN9ypC7HTQsEfwC8elZlCHJUJtOEshypM
	 OA9Thd31hC5W+GeB3JbybRwm6ByP0X/8LaYdxZSpXRgQPMI8IiiJ5NwWKLHVfgfb2p//U
	 GnBw5DY5as6nwckqGo+BcQk9B1QZrkTQ4ig1lKsx2cb2HKjXo3xJQhe8osro1YEKFsXLZ
	 VZl08Wu2xBHxJd3zqfPD3FUP+RFYhySucTlovSAAIf18ihPb8H9AtmkkHAtch3mVb6bkU
	 RBASS9kYRwiUW8+5VFQJeGq6tRZa9c9vTxba3LlSn1a1ilFc5dbFyp/DQ4aZINLrmcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BQqAj4iu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C0F606A321
	for <linux-acpi@vger.kernel.org>; Mon,  9 Nov 2026 18:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BQqAj4iu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDC811F008A2
	for <linux-acpi@vger.kernel.org>; Mon,  9 Nov 2026 18:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794248568;
	bh=PVjD9UIIFCSC8dyfllOxWG2BIVsv90HOg6kMoCemq0M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=BQqAj4iua2aOdHYHDcrMMoH/UmWidAGDSgThJ1W76AHrBgSQ744p2RAmRye2HtxuP
	 mtUMyRb1fys7mULugXQnANCB7EOTGSZ30tF7ULNEkhBusgKsIJtEIi6L2F5zOrUQi9
	 sK6KWFHlPZR8IpIQ59tmL8fPlbP1r1lUyIFFmTHEWe+1Fh643t3mTY5WsZwj1IiQbc
	 AbBPbymiaYbBNMvVyZdGKXS9wW5ue/X7mdQO9arHyUkItnYJcRhsy8I335XPF3UnSL
	 3n/7GBbAbPBQgGGDr3Ktrp/0gPoEb+R7cd0rmA5E1YO8J5Ty4cxX6mGXSPZPbjm/Aa
	 X2/6xPxNycQ7A==
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5eaa5e03c47so945009e0c.0
        for <linux-acpi@vger.kernel.org>; Mon, 09 Nov 2026 10:22:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEU6Y3i8EPC2vlZlJl+MxRmAFlswPsr/xXhAwfjwIyoE6gfmoZn3/NT9L/mgGvqiT4+428OiBX4q0O+@vger.kernel.org
X-Gm-Message-State: APuU4Z+lqqIFoZb7ffbis9SQGMy3rlb9a/tQMPYtvkxYw7LePKVfNKuN
	vBl6MLEofkTlbFjbx4Wos5PGqyhVaouzoCEdvmv9dZB38MOy1MvUMF8qVq0Ar6w0GZa5sq8BGH5
	0YIsTF0DjfP4gAx21xFIWZxdQ/IMQR2o=
X-Received: by 2002:a05:6102:5087:b0:7ca:5626:11e with SMTP id
 ada2fe7eead31-7d3011e4a24mr101959137.36.1794248568104; Mon, 09 Nov 2026
 10:22:48 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261014204558.466130-1-uajain@igalia.com> <20261014204558.466130-3-uajain@igalia.com>
In-Reply-To: <20261014204558.466130-3-uajain@igalia.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 9 Nov 2026 19:22:34 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0htK7MdRQ3N+bNhzR5uvfxtS7g1mPvQwr1yQsoJ7qM66A@mail.gmail.com>
X-Gm-Features: AclHuK8gvI9HefgKRb-A51im7xZhO6B7JSKgS_yuv_YzzJP2XEdS1thpJ1w0130
Message-ID: <CAJZ5v0htK7MdRQ3N+bNhzR5uvfxtS7g1mPvQwr1yQsoJ7qM66A@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] acpi: battery: Read Battery charge time for
 Steamdeck devices
To: Umang Jain <uajain@igalia.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 10:44=E2=80=AFPM Umang Jain <uajain@igalia.com> wro=
te:
>
> Valve steamdeck devices can report battery status as
> charging, even when low-powered power supply is connected
> to the device. The battery status is reported as charging
> through sysfs, even though in reality, it is discharging.
>
> To handle this case, read out Battery charge time ("_BCT")
> as it is reported accurately on these devices, hence use that
> information for report charging vs discharging status.
> Battery charge time ("_BCT") with an eligible power supply unit
> will have valid values whereas with a low-powered supply unit,
> it shall report ACPI_BATTERY_VALUE_UNKNOWN. Use this as a
> differentiator to determine, whether the battery of steamdeck
> devices is really charging or not.
>
> Signed-off-by: Umang Jain <uajain@igalia.com>

I think that it would be better to merge this patch with the [1/2].

> ---
>  drivers/acpi/battery.c | 25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index fa20900bea0e..b7818695b6cb 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -242,7 +242,7 @@ static int acpi_battery_get_property(struct power_sup=
ply *psy,
>                                         : POWER_SUPPLY_STATUS_DISCHARGING=
;
>                                 return 0;
>                         }
> -               else if (battery->state & ACPI_BATTERY_STATE_CHARGING)
> +               else if (battery->state & ACPI_BATTERY_STATE_CHARGING) {
>                         /* Check the rate and capacity to validate the st=
atus. */
>                         if (!acpi_battery_is_full(battery) ||
>                             (battery->rate_now !=3D ACPI_BATTERY_VALUE_UN=
KNOWN &&
> @@ -252,6 +252,29 @@ static int acpi_battery_get_property(struct power_su=
pply *psy,
>                                 /* Full and zero rate. */
>                                 val->intval =3D POWER_SUPPLY_STATUS_NOT_C=
HARGING;
>                         }
> +
> +                       /*
> +                        * For Valve Steamdeck devices, evaluate _BCT to =
determine
> +                        * if we are really charging.
> +                        */
> +                       if (test_bit(ACPI_BATTERY_QUIRK_VALVE_STEAMDECK, =
&battery->flags) &&
> +                           acpi_has_method(battery->device->handle, "_BC=
T")) {

Can you check the _BCT presence at the time when the quirk bit is set
and avoid setting the bit when _BCT is not present?  That would allow
you to just test the bit here.

> +                               unsigned long long bct;
> +                               acpi_status status;
> +                               union acpi_object arg0 =3D { ACPI_TYPE_IN=
TEGER };
> +                               struct acpi_object_list args =3D { 1, &ar=
g0 };
> +
> +                               arg0.integer.value =3D 100;
> +                               status =3D acpi_evaluate_integer(battery-=
>device->handle, "_BCT",
> +                                                              &args, &bc=
t);
> +                               if (ACPI_FAILURE(status) || bct > ACPI_UI=
NT32_MAX)
> +                                       acpi_handle_info(battery->device-=
>handle,

This should be acpi_handle_debug(), but I'm not sure if this message
is interesting at all, especially if _BCT fails every time.  Also, it
may be confusing in the bct > ACPI_UINT32_MAX case because it may
print "success" then.

> +                                                        "_BCT evaluation=
 failed: %s",
> +                                                        acpi_format_exce=
ption(status));
> +                               else if (bct =3D=3D ACPI_BATTERY_VALUE_UN=
KNOWN)
> +                                       val->intval =3D POWER_SUPPLY_STAT=
US_DISCHARGING;
> +                       }
> +               }
>                 else if (battery->state & ACPI_BATTERY_STATE_CHARGE_LIMIT=
ING)
>                         val->intval =3D POWER_SUPPLY_STATUS_NOT_CHARGING;
>                 else if (acpi_battery_is_charged(battery))
> --
