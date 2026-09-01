Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6E54A2605
	for <linux-acpi@vger.kernel.org>; Tue,  1 Sep 2026 20:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788293843; cv=none; b=sz8SvhwifZXwYmJhPXm2th4yocboVxjnbh6FRwGE4/it/Hj9mcwG9xvATHhHamGKfcgWIJeF7wFsUe8er36EhsbwZOT/NaHusWY1RDjrdLi6Wt54K8oIjhbR2bRWuwkp9K2N8swWeVIvNOvM7b9bzuHqDmsN+jldo0nkqEu6JQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788293843; c=relaxed/simple;
	bh=kX6R0uGiewLxLqtDPAWk/lTM+7v2mBoOdyQrkc8oJ6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NZLloCeQBOrpHD+z2yzTUv65kpiLpZOQ5zAAoaZ92jmur1Q5ibO4y0Q+BuW05ydVCY7i2ziwv2CfntXB2PU+DXhYL3UY2l+iiIlfxhP17KLTkK/o/SVRGmxPst+6HmpZ+ddiq1j/GQb4f4YRhspQeC+yf4PZNtTHW7y3vq9Nhxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PK7AQNxx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PK7AQNxx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CE9E1F000E9
	for <linux-acpi@vger.kernel.org>; Tue,  1 Sep 2026 20:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788293841;
	bh=/JtZqSgQwQL84mpmsj+CNyH020eKL1dZGL9iAEfD15U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=PK7AQNxxNvDpbWxsckrguOBIRe14aCs7ACoiIdfK7+pnR46Te+X1+ZGk+crGuewzz
	 poOn6/4yQjbdLEhTcyfP2Sr2PKY2C0wKTeq1Ma+ox0zA/fENv4GNhaTkXouxoek0oT
	 O5Kr5pKlTYpw98uh40Ix+f4EnNmbWcaxEBh0XvgcB0Z6uA9s4Xok3tP6h9B3Ek4G8O
	 7Ne2B17AhCI5FMs9IAPwLo1hGWPnF1UlLiPjoXzLyU0qEymREsfbnQsGysi83lLfO1
	 y+sPOm6f12Aq0RGDMqJd/1gb88dFpOmGRATK1JqG0ceZuCao8TFL0hYPr7PFvcqMN4
	 Rur7oug7TMgcQ==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3a33307ecd9so2579401fa.2
        for <linux-acpi@vger.kernel.org>; Tue, 01 Sep 2026 13:17:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwT2t0+rWabY6RVnKpWD2CU8znBiAG6TrgVQbETbeVi8LZUUzr/Tnku5ANM6m+hKF8bBrvrx23OVtTN@vger.kernel.org
X-Gm-Message-State: AFuF++nnaYptwp9vlg2TuuU2gm0PJK4hRFOK+HN7fbYubNma4fd38Fm6
	ZsxNjhRJIXH2m2VFP2S/J3SUWB52sQeqTSNoDbV/+UFAo+wYOvhOsnp7P7XJNc8EdPnrkGlXCjH
	UuGtyyIhiFUkeVHFLb+htKXVlhwk4zhA=
X-Received: by 2002:a05:651c:15c9:10b0:3a3:314d:115e with SMTP id
 38308e7fff4ca-3a34fd306f9mr465731fa.10.1788293839751; Tue, 01 Sep 2026
 13:17:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806233817.622975-1-W_Armin@gmx.de> <f2f17b0d-22a1-4a57-895b-318bb50456f3@gmx.de>
In-Reply-To: <f2f17b0d-22a1-4a57-895b-318bb50456f3@gmx.de>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 1 Sep 2026 22:16:24 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j4EAZnrEA3Z7EKX5fdfhTWYbb=f0rOPnLsz5zaEMguGQ@mail.gmail.com>
X-Gm-Features: AcwNN1VmJIxHsPFMk3Eh7VQAdXvrNJskmokvjUmcZTD3__OtWkTl-4usxtRgBHA
Message-ID: <CAJZ5v0j4EAZnrEA3Z7EKX5fdfhTWYbb=f0rOPnLsz5zaEMguGQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: battery: Fix bogus cycle count values on systems
 without _BIX
To: Armin Wolf <W_Armin@gmx.de>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, wse@tuxedocomputers.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 1, 2026 at 10:11=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wrote:
>
> Am 07.08.26 um 01:38 schrieb Armin Wolf:
>
> > Devices supporting only the legacy _BIF ACPI control method cannot
> > know the cycle count of the associated battery, so cycle_count always
> > remains 0. Claiming support for POWER_SUPPLY_PROP_CYCLE_COUNT on
> > such devices can thus mislead userspace applications and prevents
> > power supply extensions from supplying correct cycle count values.
> >
> > Fix this by not claiming support for POWER_SUPPLY_PROP_CYCLE_COUNT
> > on devices without _BIX.
>
> Any thoughts on this? I tested it on my device, and so far everything see=
ms
> to work flawlessly.

It looks good overall, but it is quite substantial, which is why it
didn't make it into 7.3-rc1.

I'm planning to apply it for 7.4.

> > Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> > ---
> >   drivers/acpi/battery.c | 131 +++++++++++++++++++++++++++++++++++-----=
-
> >   1 file changed, 113 insertions(+), 18 deletions(-)
> >
> > diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> > index 0084f308b790..b64f876f93cb 100644
> > --- a/drivers/acpi/battery.c
> > +++ b/drivers/acpi/battery.c
> > @@ -324,7 +324,9 @@ static int acpi_battery_get_property(struct power_s=
upply *psy,
> >       return ret;
> >   }
> >
> > -static const enum power_supply_property charge_battery_props[] =3D {
> > +/* For devices supporting the _BIX ACPI control method */
> > +
> > +static const enum power_supply_property charge_battery_extended_props[=
] =3D {
> >       POWER_SUPPLY_PROP_STATUS,
> >       POWER_SUPPLY_PROP_PRESENT,
> >       POWER_SUPPLY_PROP_TECHNOLOGY,
> > @@ -342,7 +344,7 @@ static const enum power_supply_property charge_batt=
ery_props[] =3D {
> >       POWER_SUPPLY_PROP_SERIAL_NUMBER,
> >   };
> >
> > -static const enum power_supply_property charge_battery_full_cap_broken=
_props[] =3D {
> > +static const enum power_supply_property charge_battery_full_cap_broken=
_extended_props[] =3D {
> >       POWER_SUPPLY_PROP_STATUS,
> >       POWER_SUPPLY_PROP_PRESENT,
> >       POWER_SUPPLY_PROP_TECHNOLOGY,
> > @@ -356,7 +358,7 @@ static const enum power_supply_property charge_batt=
ery_full_cap_broken_props[] =3D
> >       POWER_SUPPLY_PROP_SERIAL_NUMBER,
> >   };
> >
> > -static const enum power_supply_property energy_battery_props[] =3D {
> > +static const enum power_supply_property energy_battery_extended_props[=
] =3D {
> >       POWER_SUPPLY_PROP_STATUS,
> >       POWER_SUPPLY_PROP_PRESENT,
> >       POWER_SUPPLY_PROP_TECHNOLOGY,
> > @@ -374,7 +376,7 @@ static const enum power_supply_property energy_batt=
ery_props[] =3D {
> >       POWER_SUPPLY_PROP_SERIAL_NUMBER,
> >   };
> >
> > -static const enum power_supply_property energy_battery_full_cap_broken=
_props[] =3D {
> > +static const enum power_supply_property energy_battery_full_cap_broken=
_extended_props[] =3D {
> >       POWER_SUPPLY_PROP_STATUS,
> >       POWER_SUPPLY_PROP_PRESENT,
> >       POWER_SUPPLY_PROP_TECHNOLOGY,
> > @@ -388,6 +390,68 @@ static const enum power_supply_property energy_bat=
tery_full_cap_broken_props[] =3D
> >       POWER_SUPPLY_PROP_SERIAL_NUMBER,
> >   };
> >
> > +/* For devices supporting only the _BIF ACPI control method */
> > +
> > +static const enum power_supply_property charge_battery_props[] =3D {
> > +     POWER_SUPPLY_PROP_STATUS,
> > +     POWER_SUPPLY_PROP_PRESENT,
> > +     POWER_SUPPLY_PROP_TECHNOLOGY,
> > +     POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
> > +     POWER_SUPPLY_PROP_VOLTAGE_NOW,
> > +     POWER_SUPPLY_PROP_CURRENT_NOW,
> > +     POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
> > +     POWER_SUPPLY_PROP_CHARGE_FULL,
> > +     POWER_SUPPLY_PROP_CHARGE_NOW,
> > +     POWER_SUPPLY_PROP_CAPACITY,
> > +     POWER_SUPPLY_PROP_CAPACITY_LEVEL,
> > +     POWER_SUPPLY_PROP_MODEL_NAME,
> > +     POWER_SUPPLY_PROP_MANUFACTURER,
> > +     POWER_SUPPLY_PROP_SERIAL_NUMBER,
> > +};
> > +
> > +static const enum power_supply_property charge_battery_full_cap_broken=
_props[] =3D {
> > +     POWER_SUPPLY_PROP_STATUS,
> > +     POWER_SUPPLY_PROP_PRESENT,
> > +     POWER_SUPPLY_PROP_TECHNOLOGY,
> > +     POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
> > +     POWER_SUPPLY_PROP_VOLTAGE_NOW,
> > +     POWER_SUPPLY_PROP_CURRENT_NOW,
> > +     POWER_SUPPLY_PROP_CHARGE_NOW,
> > +     POWER_SUPPLY_PROP_MODEL_NAME,
> > +     POWER_SUPPLY_PROP_MANUFACTURER,
> > +     POWER_SUPPLY_PROP_SERIAL_NUMBER,
> > +};
> > +
> > +static const enum power_supply_property energy_battery_props[] =3D {
> > +     POWER_SUPPLY_PROP_STATUS,
> > +     POWER_SUPPLY_PROP_PRESENT,
> > +     POWER_SUPPLY_PROP_TECHNOLOGY,
> > +     POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
> > +     POWER_SUPPLY_PROP_VOLTAGE_NOW,
> > +     POWER_SUPPLY_PROP_POWER_NOW,
> > +     POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN,
> > +     POWER_SUPPLY_PROP_ENERGY_FULL,
> > +     POWER_SUPPLY_PROP_ENERGY_NOW,
> > +     POWER_SUPPLY_PROP_CAPACITY,
> > +     POWER_SUPPLY_PROP_CAPACITY_LEVEL,
> > +     POWER_SUPPLY_PROP_MODEL_NAME,
> > +     POWER_SUPPLY_PROP_MANUFACTURER,
> > +     POWER_SUPPLY_PROP_SERIAL_NUMBER,
> > +};
> > +
> > +static const enum power_supply_property energy_battery_full_cap_broken=
_props[] =3D {
> > +     POWER_SUPPLY_PROP_STATUS,
> > +     POWER_SUPPLY_PROP_PRESENT,
> > +     POWER_SUPPLY_PROP_TECHNOLOGY,
> > +     POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
> > +     POWER_SUPPLY_PROP_VOLTAGE_NOW,
> > +     POWER_SUPPLY_PROP_POWER_NOW,
> > +     POWER_SUPPLY_PROP_ENERGY_NOW,
> > +     POWER_SUPPLY_PROP_MODEL_NAME,
> > +     POWER_SUPPLY_PROP_MANUFACTURER,
> > +     POWER_SUPPLY_PROP_SERIAL_NUMBER,
> > +};
> > +
> >   /* Battery Management */
> >   struct acpi_offsets {
> >       size_t offset;          /* offset inside struct acpi_sbs_battery =
*/
> > @@ -875,6 +939,7 @@ static void __exit battery_hook_exit(void)
> >
> >   static int sysfs_add_battery(struct acpi_battery *battery)
> >   {
> > +     bool extended_info_available =3D test_bit(ACPI_BATTERY_XINFO_PRES=
ENT, &battery->flags);
> >       struct power_supply_config psy_cfg =3D {
> >               .drv_data =3D battery,
> >               .attr_grp =3D acpi_battery_groups,
> > @@ -888,25 +953,55 @@ static int sysfs_add_battery(struct acpi_battery =
*battery)
> >
> >       if (battery->power_unit =3D=3D ACPI_BATTERY_POWER_UNIT_MA) {
> >               if (full_cap_broken) {
> > -                     battery->bat_desc.properties =3D
> > -                         charge_battery_full_cap_broken_props;
> > -                     battery->bat_desc.num_properties =3D
> > -                         ARRAY_SIZE(charge_battery_full_cap_broken_pro=
ps);
> > +                     if (extended_info_available) {
> > +                             battery->bat_desc.properties =3D
> > +                                     charge_battery_full_cap_broken_ex=
tended_props;
> > +                             battery->bat_desc.num_properties =3D
> > +                                     ARRAY_SIZE(charge_battery_full_ca=
p_broken_extended_props);
> > +                     } else {
> > +                             battery->bat_desc.properties =3D
> > +                                     charge_battery_full_cap_broken_pr=
ops;
> > +                             battery->bat_desc.num_properties =3D
> > +                                     ARRAY_SIZE(charge_battery_full_ca=
p_broken_props);
> > +                     }
> >               } else {
> > -                     battery->bat_desc.properties =3D charge_battery_p=
rops;
> > -                     battery->bat_desc.num_properties =3D
> > -                         ARRAY_SIZE(charge_battery_props);
> > +                     if (extended_info_available) {
> > +                             battery->bat_desc.properties =3D
> > +                                     charge_battery_extended_props;
> > +                             battery->bat_desc.num_properties =3D
> > +                                     ARRAY_SIZE(charge_battery_extende=
d_props);
> > +                     } else {
> > +                             battery->bat_desc.properties =3D
> > +                                     charge_battery_props;
> > +                             battery->bat_desc.num_properties =3D
> > +                                     ARRAY_SIZE(charge_battery_props);
> > +                     }
> >               }
> >       } else {
> >               if (full_cap_broken) {
> > -                     battery->bat_desc.properties =3D
> > -                         energy_battery_full_cap_broken_props;
> > -                     battery->bat_desc.num_properties =3D
> > -                         ARRAY_SIZE(energy_battery_full_cap_broken_pro=
ps);
> > +                     if (extended_info_available) {
> > +                             battery->bat_desc.properties =3D
> > +                                     energy_battery_full_cap_broken_ex=
tended_props;
> > +                             battery->bat_desc.num_properties =3D
> > +                                     ARRAY_SIZE(energy_battery_full_ca=
p_broken_extended_props);
> > +                     } else {
> > +                             battery->bat_desc.properties =3D
> > +                                     energy_battery_full_cap_broken_pr=
ops;
> > +                             battery->bat_desc.num_properties =3D
> > +                                     ARRAY_SIZE(energy_battery_full_ca=
p_broken_props);
> > +                     }
> >               } else {
> > -                     battery->bat_desc.properties =3D energy_battery_p=
rops;
> > -                     battery->bat_desc.num_properties =3D
> > -                         ARRAY_SIZE(energy_battery_props);
> > +                     if (extended_info_available) {
> > +                             battery->bat_desc.properties =3D
> > +                                     energy_battery_extended_props;
> > +                             battery->bat_desc.num_properties =3D
> > +                                     ARRAY_SIZE(energy_battery_extende=
d_props);
> > +                     } else {
> > +                             battery->bat_desc.properties =3D
> > +                                     energy_battery_props;
> > +                             battery->bat_desc.num_properties =3D
> > +                                     ARRAY_SIZE(energy_battery_props);
> > +                     }
> >               }
> >       }
> >
