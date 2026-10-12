Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5C94A0926
	for <linux-acpi@vger.kernel.org>; Mon, 12 Oct 2026 15:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791820601; cv=none; b=G+gqluTVnUqHotEuFjZkEPwdWzF8T9whOM6M/ijofX9hu6/hiVv5v0AQvNOf8xrwYiCwwn8wRUMu95Wdx0w2weF0W4PruQQFH8hGLe5HHX+Sadfrv88Cyqep/4Ej49eFU4fM/7SSCiV7Ff+hTw3xux292/BBTv3D3+1+Tgpm8NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791820601; c=relaxed/simple;
	bh=kiTVYqjYoNRgRbJej4/OC0B4WreCYsggVOX6+jGeCyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sn6HzJWti2P2CJqGiA39p7tqmBNOtL/VOVZ6Z0wu+UhMP0E3cFII+BCtKW4zW3++2Zib9uf1HDBdgNqB8/WrmsZmY2l61oQHfOLIMHr0o5+qN/BdnDHZWEUH1/cu8opts71tT5cjhI1bbyPvfDH4JQPEprAwuVk/B4VMqgGSXIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BX2O/dME; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BX2O/dME"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 471C11F0089B
	for <linux-acpi@vger.kernel.org>; Mon, 12 Oct 2026 15:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791820600;
	bh=RRzUnGM8DJxXtxqBDwULmqaThFPL3NI3XYRr4akMeCY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=BX2O/dMEQ2uT6/M+d0sdwWEDxX7QY20f7CXltyLUrl6KiMQKJpr/d/pAKI6iX8z9j
	 2Z/eaJHcZn/MLkvJU1Vaw93zOlH+cZ/zHj5Hvpg/W37DrIfVh2nhO1YhDkMN8qBl/a
	 AH4sPWswc/MRGwp6Ep1ktFcoLZoQibXeZxUNnGscgpinh5dEFGFv7hnjQsR1wWDhR5
	 dyhroRMrRwZFuGxEWR1VtN3I9A2L48dqFWP7/0GZQiRWEiC5LO6GqqvcmijOWoh0C0
	 dVRD9WrjaD6CWhHdmh+ZljwvMTvguO1wrp5vQo7RqrHZFqUEDp46Tkrtgk+3cf0FjN
	 k5GHOZLxWRsVg==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5bcdab9a82bso2287446e87.3
        for <linux-acpi@vger.kernel.org>; Mon, 12 Oct 2026 08:56:40 -0700 (PDT)
X-Gm-Message-State: AFq9FYIrU8kzgTKTEtjiurTVdnIYE5EweS7WZJjvBLn+h+r6BZAkuTNQ
	630KlDWGsZAfgR4bvYg50ech+a1QofreXTjbHLWC2f7/pXwpmE9p32kVVIX0/cIkHpOz8mb3Y9A
	lpQdT08l6QttTGYubRHt/x0oY0gTUZLI=
X-Received: by 2002:a05:6512:108c:b0:5b8:bc5e:b57a with SMTP id
 2adb3069b0e04-5bcde8d0388mr3384224e87.50.1791820598641; Mon, 12 Oct 2026
 08:56:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6ab7c7cd.aec4f0e4.3a9f4c.54b2@mx.google.com>
In-Reply-To: <6ab7c7cd.aec4f0e4.3a9f4c.54b2@mx.google.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 12 Oct 2026 17:54:29 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iZVEng-jFtpwDySfFe3TnM3p+x2YVZ17ttHMbDzgheAA@mail.gmail.com>
X-Gm-Features: AclHuK8M4Jx9ovoG5lFXQJQDaWFHG1Q-lfdNBwGCf58BE3gWMj-g3EbFKBdBjXY
Message-ID: <CAJZ5v0iZVEng-jFtpwDySfFe3TnM3p+x2YVZ17ttHMbDzgheAA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: battery: Force "Discharging" status on battery for
 ASUS TUF Gaming A16
To: calvitohq@gmail.com
Cc: linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 26, 2026 at 3:25=E2=80=AFPM <calvitohq@gmail.com> wrote:
>
> From: Marco <soytucalvitofavorito@icloud.com>
>
> On the ASUS TUF Gaming A16 (FA608UMI), after AC is unplugged the ACPI
> _BST status word reports neither the charging nor the discharging bit
> set, so the battery driver reports "Not charging" (and UPower
> "fully-charged") even though the battery is actively discharging
> (current_now stays positive).
>
> This is the same class of firmware bug as the ASUS Vivobook 18
> M1807HA (Launchpad bug 2152185), where the status flips between
> "Full"/"Not charging"/"Discharging". Add a DMI quirk that, when the
> system is running on battery, forces a computed "Full" or
> "Not charging" status to "Discharging".
>
> Based on the M1807HA quirk patch by Norman Becker.
>
> Signed-off-by: Marco <soytucalvitofavorito@icloud.com>
> ---
>  drivers/acpi/battery.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -58,6 +58,7 @@
>  static int battery_bix_broken_package;
>  static int battery_notification_delay_ms;
>  static int battery_ac_is_broken;
> +static bool battery_force_discharging;
>  static unsigned int cache_time =3D 1000;
>  module_param(cache_time, uint, 0644);
>  MODULE_PARM_DESC(cache_time, "cache time in milliseconds");
> @@ -192,6 +193,19 @@
>                 battery->full_charge_capacity < battery->design_capacity;
>  }
>
> +static void acpi_battery_force_discharging_fix_status(union power_supply=
_propval *val)
> +{
> +       if (!battery_force_discharging)
> +               return;
> +
> +       if (power_supply_is_system_supplied())
> +               return;
> +

The two checks above can be combined.

> +       if (val->intval =3D=3D POWER_SUPPLY_STATUS_FULL ||
> +           val->intval =3D=3D POWER_SUPPLY_STATUS_NOT_CHARGING)

What about POWER_SUPPLY_STATUS_CHARGING?

> +               val->intval =3D POWER_SUPPLY_STATUS_DISCHARGING;
> +}
> +
>  static int acpi_battery_get_property(struct power_supply *psy,
>                                      enum power_supply_property psp,
>                                      union power_supply_propval *val)
> @@ -250,6 +264,7 @@
>                         val->intval =3D POWER_SUPPLY_STATUS_FULL;
>                 else
>                         val->intval =3D POWER_SUPPLY_STATUS_NOT_CHARGING;
> +               acpi_battery_force_discharging_fix_status(val);

Also it looks like you want the status to be
POWER_SUPPLY_STATUS_DISCHARGING always if battery_force_discharging is
set and power_supply_is_system_supplied() returns 'false' which can be
checked upfront in the POWER_SUPPLY_PROP_STATUS case.

>                 break;
>         case POWER_SUPPLY_PROP_PRESENT:
>                 val->intval =3D acpi_battery_present(battery);
> @@ -1258,6 +1273,13 @@
>         return 0;
>  }
>
> +static int __init
> +battery_force_discharging_quirk(const struct dmi_system_id *d)
> +{
> +       battery_force_discharging =3D true;
> +       return 0;
> +}
> +
>  static const struct dmi_system_id bat_dmi_table[] __initconst =3D {
>         {
>                 /* NEC LZ750/LS */
> @@ -1294,6 +1316,15 @@
>                         DMI_MATCH(DMI_PRODUCT_NAME, "Surface Go 3"),
>                 },
>         },
> +       {
> +               /* ASUS TUF Gaming A16 FA608UMI */
> +               .callback =3D battery_force_discharging_quirk,
> +               .matches =3D {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "ASUS"),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "TUF Gaming A16 FA608=
UMI"),
> +                       DMI_MATCH(DMI_BOARD_NAME, "FA608UMI"),
> +               },
> +       },
>         {},
>  };
>
>
