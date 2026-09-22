Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C4F53D9C6
	for <linux-acpi@vger.kernel.org>; Tue, 22 Sep 2026 12:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790078780; cv=none; b=uY6GBGFTRo5XZGyTzGziiEJliclNsi6HMyImic3/6gxEipQi5oYPCAnTROnbCDZd7TPbByp/iQnWkLANhUDgqSPhdP4sSNeIGKQKmVnT3weeRESWiLo9/sWcfBgsYOynnzJ07moSsY9HVbvWvMTVnGlWH5IRmIJkLm7SlI19VR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790078780; c=relaxed/simple;
	bh=qrBPaEhoOlbrbf6cdxY2nGBDf1vM6ryopde2Igiaum4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DQ82CVqfEjW7FX04kW+gBUYZLChituhhA7cLO8ZRzgyzXovvF3hnqd2AAczhnd3Azyh/lWNocqfwRxFnujiIL9wzK6Pc3pzcP0A98MLqgbwCSt1WV1ior3p/UIflZshx+YJX/Hvxx2Z5w6ajL2LVdldhrCqBfnYepnj65vjO2Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=URdN5Hcj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="URdN5Hcj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7446A1F00893
	for <linux-acpi@vger.kernel.org>; Tue, 22 Sep 2026 12:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790078778;
	bh=ugr5bJ4okbW7Q03V27ZXeHgo+ECEOTsTbRB2dpi47to=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=URdN5HcjCBLlngsvTzJw+1pN+4qhBJGakkxuO+2iKYqCbiVPHbuJz0JXIopo2xvMa
	 7iz41qsZQAE0uxhB7gh3FFUYZKl2z6tAdbIdLwNZzJJyTY42AU/1dYqU2b6wvQ9dBX
	 ZsQKJuudGQSoWelagCceHTxUM9BG2McDKhkqPV51TiTcNWPLKNAV8Hb1nISVIfTyuJ
	 BNCXnbonukV6p0OwrVxlHCQRepz3J3A5sLGDn7zTpUcrWTJP5ReF8hpSlaUsBrvW0m
	 xyLsppVHdJVEtFxl5szsUESZ6c7/7a3v6tpqlF0lW1KfiS6EM+hhoHEZRlzEuR2/Kh
	 87lkDJvPyg6Lw==
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a2ff00b8d8so32918361fa.1
        for <linux-acpi@vger.kernel.org>; Tue, 22 Sep 2026 05:06:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBycwYQRBVp/iQeMX2ZlTvZgfTmsuTnfT/02xoEXCsIS1aLgj+U4NRRfB1s2xtW8ITiUMlblzmpBeMyl@vger.kernel.org
X-Gm-Message-State: AFuF++nsNOGTdDMUpuYx+kDmtwOJMEjO12B50uV43lJTLpGyJO4alge4
	EWV5Msog4WxChjIEbmhMosl3fC8XRwSyDWrKx6DY4yEjjoySjVKcWuaoyjhoNXZw4/gJLM9DyV7
	mAFy/B3a5LBEQdqxMGKgdGK2BvlM5z58=
X-Received: by 2002:a2e:bc12:0:b0:3a5:e541:4205 with SMTP id
 38308e7fff4ca-3a5fbbc2f6bmr32004331fa.0.1790078776798; Tue, 22 Sep 2026
 05:06:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260918135628.2322188-1-uajain@igalia.com>
In-Reply-To: <20260918135628.2322188-1-uajain@igalia.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 22 Sep 2026 14:04:44 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jW5PEkjchBT-JxJUiK1v=1Pr4pn8_KfLrNM1QFap1M4A@mail.gmail.com>
X-Gm-Features: AcwNN1Ww060CyThxNKR8k5L6iMGzWZxVKaOjKTRT2NhCSerdb0Rx_D79RRnUke0
Message-ID: <CAJZ5v0jW5PEkjchBT-JxJUiK1v=1Pr4pn8_KfLrNM1QFap1M4A@mail.gmail.com>
Subject: Re: [PATCH] acpi: battery: Handle Valve steamdeck devices quirk
To: Umang Jain <uajain@igalia.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2026 at 3:55=E2=80=AFPM Umang Jain <uajain@igalia.com> wrot=
e:
>
> Valve steamdeck devices can report battery status as
> charging, even when low-powered power supply is connected
> to the device. The battery status is reported as charging
> through sysfs, even though in reality, it is discharging.
>
> To handle this case, first we introduce a battery quirk
> for steamdeck devices ACPI_BATTERY_QUIRK_VALVE_STEAMDECK.
> Additionally, it has been found that on such devices,
> Battery Charge Time ("_BCT") is reported accurately, hence
> use that information for report charging vs discharging status.
> Battery Charge Time with an eligible power supply unit will have
> valid values whereas with a low-powered supply unit, it shall report
> ACPI_BATTERY_VALUE_UNKNOWN. Use this as a differentiator to
> determine, whether the battery of steamdeck devices is really
> charging or not.
>
> Signed-off-by: Umang Jain <uajain@igalia.com>

Please add _BCT support as a separate patch and the quirk on top of it.

Thanks!

> ---
>  drivers/acpi/battery.c | 42 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 41 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index 670853ec3a4d..db611f3302c4 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -76,6 +76,7 @@ MODULE_DEVICE_TABLE(acpi, battery_device_ids);
>  enum {
>         ACPI_BATTERY_ALARM_PRESENT,
>         ACPI_BATTERY_XINFO_PRESENT,
> +       ACPI_BATTERY_BCT_PRESENT,
>         ACPI_BATTERY_QUIRK_PERCENTAGE_CAPACITY,
>         /* On Lenovo Thinkpad models from 2010 and 2011, the power unit
>          * switches between mWh and mAh depending on whether the system
> @@ -94,6 +95,14 @@ enum {
>          * on a full charge, but showing degradation in full charge cap.
>          */
>         ACPI_BATTERY_QUIRK_DEGRADED_FULL_CHARGE,
> +       /*
> +        * Valve steamdeck devices can get discharged even when battery s=
tatus
> +        * is charging. This happens typically low power supply unit is
> +        * connected. To accurate determine this scenario, we shall read
> +        * battery charge time ("_BCT") to know whether the steamdeck is
> +        * really charging with the power supply unit.
> +        */
> +       ACPI_BATTERY_QUIRK_VALVE_STEAMDECK,
>  };
>
>  struct acpi_battery {
> @@ -110,6 +119,7 @@ struct acpi_battery {
>
>         struct mutex property_lock; /* Protects properties below. */
>         unsigned long update_time;
> +       unsigned long long charge_time;
>         int revision;
>         int rate_now;
>         int capacity_now;
> @@ -234,7 +244,7 @@ static int acpi_battery_get_property(struct power_sup=
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
> @@ -244,6 +254,12 @@ static int acpi_battery_get_property(struct power_su=
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
> +                               val->intval =3D POWER_SUPPLY_STATUS_DISCH=
ARGING;
> +               }
>                 else if (battery->state & ACPI_BATTERY_STATE_CHARGE_LIMIT=
ING)
>                         val->intval =3D POWER_SUPPLY_STATUS_NOT_CHARGING;
>                 else if (acpi_battery_is_charged(battery))
> @@ -613,6 +629,10 @@ static int acpi_battery_get_state(struct acpi_batter=
y *battery)
>         int result =3D 0;
>         acpi_status status =3D 0;
>         struct acpi_buffer buffer =3D { ACPI_ALLOCATE_BUFFER, NULL };
> +       union acpi_object arg0 =3D { ACPI_TYPE_INTEGER };
> +       struct acpi_object_list args =3D { 1, &arg0 };
> +
> +       arg0.integer.value =3D 100;
>
>         lockdep_assert_held(&battery->property_lock);
>
> @@ -638,6 +658,15 @@ static int acpi_battery_get_state(struct acpi_batter=
y *battery)
>         battery->update_time =3D jiffies;
>         kfree(buffer.pointer);
>
> +       if (test_bit(ACPI_BATTERY_BCT_PRESENT, &battery->flags)) {
> +               status =3D acpi_evaluate_integer(battery->device->handle,=
 "_BCT",
> +                                              &args, &battery->charge_ti=
me);
> +               if (ACPI_FAILURE(status))
> +                       acpi_handle_info(battery->device->handle,
> +                                        "_BCT evaluation failed: %s",
> +                                        acpi_format_exception(status));
> +       }
> +
>         /* For buggy DSDTs that report negative 16-bit values for either
>          * charging or discharging current and/or report 0 as 65536
>          * due to bad math.
> @@ -1057,6 +1086,15 @@ static void acpi_battery_quirks(struct acpi_batter=
y *battery)
>                 set_bit(ACPI_BATTERY_QUIRK_DEGRADED_FULL_CHARGE, &battery=
->flags);
>                 battery->capacity_now =3D battery->full_charge_capacity;
>         }
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
> @@ -1083,6 +1121,8 @@ static int acpi_battery_update(struct acpi_battery =
*battery, bool resume)
>                         if (result)
>                                 return result;
>                         acpi_battery_init_alarm(battery);
> +                       if (acpi_has_method(battery->device->handle, "_BC=
T"))
> +                               set_bit(ACPI_BATTERY_BCT_PRESENT, &batter=
y->flags);
>                 }
>
>                 result =3D acpi_battery_get_state(battery);
> --
> 2.55.0
>
