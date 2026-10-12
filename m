Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049AA49BD6C
	for <linux-acpi@vger.kernel.org>; Mon, 12 Oct 2026 15:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791818491; cv=none; b=WK+ubXKcvcgQYJjhrr0iHEua1qJvruGKe9qC6L8J08f2CIv/aJqiDRe4kG1/9ws/AIQ4pYDPQJrGa2EqTyuivI4thvagZ1Pq716+vDfzKYjHReP6cjsT1FUNNjCarjxknHWJW8P9enVxukQFWntp1lQ4IhqXHEEHE8wbOZoq7no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791818491; c=relaxed/simple;
	bh=zxKxNhPCmHb0zZ96ffPqcnWSUZG23uY3BM1v2Yapxr8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KngkuMAx4Oj3jaj0F6e5GT6X5kFud2ls/v6PnYeGtV40Pra7MNzTMyK78fgW0XV+LQMU+TIjqmEMVoSK49MMPmBZDE8v563NsZOAKj+sYLhPd6t++Mv9fMpbCZRJuHBo4mfyd74bILYwBxdxB7C34sLrWKsXbzbPGw4moc5qd/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k+ZDl6n+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k+ZDl6n+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2CF01F0089D
	for <linux-acpi@vger.kernel.org>; Mon, 12 Oct 2026 15:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791818489;
	bh=cwC1Bdu1ASAiuFFXOFyC9fhoty/NDnJ2PKsLdMCimZg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=k+ZDl6n+xNZrGH/v9gzTOj1yxcL3cazCis2vu30JUSUWuDAgbGLr4BQZP729XRZiG
	 HZ3euZLRvFTKQkipe9Ex87xI/sJhX7fuCgrTATUaLAqpfJzdUSdd8iGd6//ILAiTm8
	 hXwSE1Yg+Oy0jZmxsYVtWz7y3XbVTZcaPiV8jkgGtnKSJiGAcisWCZF5KCZgJHW1D/
	 kwoS8rvDJpTMOKHHbnlVzDACyj+3nSdBCiPjscauxIvpG49NjhY2xDg9Heapu/ahcb
	 ZfTMf3oyrUKqlJ9qJ3i2+Z6CjhlgbqNGvrZPcF842dOLYMGDST82bYWdGQFzhd11nB
	 jtCVEsSmWZOvw==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5bced78b3dfso972897e87.1
        for <linux-acpi@vger.kernel.org>; Mon, 12 Oct 2026 08:21:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBy0IVl2TN54/V9B/Gd8D3Jr37N186rtx4BjhkP/UE68s95bwOC1z7A92giDaZP1pwqlzHleQtxUtV6f@vger.kernel.org
X-Gm-Message-State: AFq9FYLv7O4exOgP02zpkw4wgy40q7mh00W9iTaPNhkmPuz6c9U5tweN
	/NWqH5Wk0UI/+W6b5OQ4a9BfIRqW8EoMk+C0J/DwmugGslf2l63WikSada3C55Nc+1xg+aKJgqg
	LNUjT1k4z9eTCypQjlP0omYG/rQuKdKo=
X-Received: by 2002:a05:6512:2352:b0:5ba:429b:c5bf with SMTP id
 2adb3069b0e04-5bcde8c83f1mr3340556e87.51.1791818488065; Mon, 12 Oct 2026
 08:21:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923082932.1049270-1-uajain@igalia.com> <20260923082932.1049270-3-uajain@igalia.com>
In-Reply-To: <20260923082932.1049270-3-uajain@igalia.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 12 Oct 2026 17:19:22 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j81xESWT9=c4_s0vNbkEtvPCj6j7o6dF0GxsqHPPng3A@mail.gmail.com>
X-Gm-Features: AclHuK9qA-xWxmBPQNVBYGde9U5B3Rbdhlz_WDt6Uv35GXNVWBAp_iL0-qqzPIE
Message-ID: <CAJZ5v0j81xESWT9=c4_s0vNbkEtvPCj6j7o6dF0GxsqHPPng3A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] acpi: battery: Handle Valve steamdeck devices quirk
To: Umang Jain <uajain@igalia.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 10:28=E2=80=AFAM Umang Jain <uajain@igalia.com> wro=
te:
>
> Valve steamdeck devices can report battery status as
> charging, even when low-powered power supply is connected
> to the device. The battery status is reported as charging
> through sysfs, even though in reality, it is discharging.
>
> To handle this case, we introduce a battery quirk for steamdeck
> devices ACPI_BATTERY_QUIRK_VALVE_STEAMDECK. Additionally, it has been
> found that on such devices, Battery Charge Time ("_BCT") is reported
> accurately, hence use that information for report charging vs
> discharging status. Battery Charge Time("_BCT") with an eligible power
> supply unit will have valid values whereas with a low-powered supply
> unit, it shall report ACPI_BATTERY_VALUE_UNKNOWN. Use this as a
> differentiator to determine, whether the battery of steamdeck devices
> is really charging or not.
>
> Signed-off-by: Umang Jain <uajain@igalia.com>
> ---
>  drivers/acpi/battery.c | 28 +++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index a1b7a821abaf..8defafd2b7c7 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -95,6 +95,14 @@ enum {
>          * on a full charge, but showing degradation in full charge cap.
>          */
>         ACPI_BATTERY_QUIRK_DEGRADED_FULL_CHARGE,
> +       /*
> +        * Valve steamdeck devices can get discharged even when battery s=
tatus
> +        * is charging. This happens typically when low power supply unit=
 is
> +        * connected. To accurately determine this scenario, we shall rea=
d
> +        * battery charge time ("_BCT"). This is the key differentiator t=
o
> +        * determine whether the steamdeck is actually charging or not.
> +        */
> +       ACPI_BATTERY_QUIRK_VALVE_STEAMDECK,
>  };
>
>  struct acpi_battery {
> @@ -236,7 +244,7 @@ static int acpi_battery_get_property(struct power_sup=
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
> @@ -246,6 +254,12 @@ static int acpi_battery_get_property(struct power_su=
pply *psy,
>                                 /* Full and zero rate. */
>                                 val->intval =3D POWER_SUPPLY_STATUS_NOT_C=
HARGING;
>                         }
> +
> +                       if (test_bit(ACPI_BATTERY_QUIRK_VALVE_STEAMDECK, =
&battery->flags) &&
> +                           test_bit(ACPI_BATTERY_BCT_PRESENT, &battery->=
flags) &&
> +                           battery->charge_time =3D=3D ACPI_BATTERY_VALU=
E_UNKNOWN)

Would it be practical to evaluate _BCT here without storing
charge_time in the battery object?

> +                               val->intval =3D POWER_SUPPLY_STATUS_DISCH=
ARGING;
> +               }
>                 else if (battery->state & ACPI_BATTERY_STATE_CHARGE_LIMIT=
ING)
>                         val->intval =3D POWER_SUPPLY_STATUS_NOT_CHARGING;
>                 else if (acpi_battery_is_charged(battery))
> @@ -1072,6 +1086,18 @@ static void acpi_battery_quirks(struct acpi_batter=
y *battery)
>                 set_bit(ACPI_BATTERY_QUIRK_DEGRADED_FULL_CHARGE, &battery=
->flags);
>                 battery->capacity_now =3D battery->full_charge_capacity;
>         }
> +
> +       if (test_bit(ACPI_BATTERY_QUIRK_VALVE_STEAMDECK, &battery->flags)=
)
> +               return;
> +
> +       if (dmi_name_in_vendors("Valve")) {
> +               const char *name;
> +
> +               name =3D dmi_get_system_info(DMI_PRODUCT_NAME);
> +               if ((name && (!strncmp("Jupiter", name, 7))) ||
> +                   (name && (!strncmp("Galileo", name, 7))))
> +                       set_bit(ACPI_BATTERY_QUIRK_VALVE_STEAMDECK, &batt=
ery->flags);
> +       }
>  }
>
>  static int acpi_battery_update(struct acpi_battery *battery, bool resume=
)
> --
