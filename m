Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655F52D46C0
	for <linux-acpi@vger.kernel.org>; Thu,  9 Jul 2026 13:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783604298; cv=none; b=aKiGAYd77hBjs8rbq9qZxlDwGYYak79tGPnNXUdoHxW94VIhhGfWcHJO9a20TSZfd90DtmmYrife7RfEbx1agIlKEZPiM2rVRRROZTYawSUr/KVF2EbQz7bgFAO0tnr9rgC2A4gWlP1uFtSHewqF46AC4E+0Jx9tmFcwnbCeQaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783604298; c=relaxed/simple;
	bh=N2tvJR7EPbypzHMZlP14mpfdiTlBa1Nr9hAbw7+chok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aQGzN3mzhhaJ59bjoqqc2TrDuky8pzPa2xW6T6E+XZ7fEE8viGW8InVd5/OwUnSK2Oodthx3FDHE9WcDB4shsYSrN49ZL3Til22BT7jL2CmLdK2BcpY4HqEqrvAob8VeMlsbJdeCM5JNBNRdDjK3rdTdKbCqGq0C6bdG6h08v0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FT47u0qA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FT47u0qA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29DA51F000E9
	for <linux-acpi@vger.kernel.org>; Thu,  9 Jul 2026 13:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783604297;
	bh=JQq4bLAyJxaAzvYfWUIUCQUFAqauReyKcYetNj7RGKA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=FT47u0qAsVv8IE62z+BXdgeTly5/z9xg8RV90DFCLQ8V1g3vtj+87PlxlDa73dIqz
	 G0J7qBUHPkAFaB+bMVHFNuvP0YT9EzCuG7xfFhI5HzIQMSAlkPfBOgB0Sr5w43DQeU
	 gQ26voG3GsMDoLhUChS2ll0RZj1Lf05XmbUQcrgrRSbmfxksbylrNoONobSBaVdZ41
	 jvWsIDwwMYvIskt/npBCp9vVDWu39vJMQFoQcs4cvfeIhI7mm4UNp4oiCvNl/TBKSE
	 86Gic6Q9GYKYdrKc0AkGIeJYKzFlPRaPN44bVcZ0hXlbKr9lPoBWpTV9DvtvlK4pDo
	 bUV2WYt14BHPw==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5aebd77cbb4so768186e87.2
        for <linux-acpi@vger.kernel.org>; Thu, 09 Jul 2026 06:38:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqXhuTs3DiW5nDXpYI0hQDh+wgPhJWmmJAV+JWWq4psgVoHKCe5qEI74F2XSMniuUPMtjoe2tmVFDrL@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl07PbzHUXgUGFwtm4gYB1aznJbehujRrlQspkv1nx12h/s4HZ
	EG3SLynHuZqCsWUQhlWIPVWESJku8gUVInlTovOGgZlltYGagty/PvU18hshoriM0E5S62RIiat
	nHfyXwr1qjbrtG+kTiNg8TZ8IN8vp6Ps=
X-Received: by 2002:a05:6512:3701:b0:5ae:b6b6:c86c with SMTP id
 2adb3069b0e04-5b011479992mr1404155e87.63.1783604295666; Thu, 09 Jul 2026
 06:38:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708070732.578046-1-hpa@redhat.com>
In-Reply-To: <20260708070732.578046-1-hpa@redhat.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 9 Jul 2026 15:38:03 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i5YG9v4kiYoD_-n_33FjX506uZgstJo+=BSA0KPZ_6mw@mail.gmail.com>
X-Gm-Features: AUfX_mx0D8XU99NZvflDIR8SKsW-UE3OgVd1T2EJrvIr4n2TqFojzeL-0pa1TJI
Message-ID: <CAJZ5v0i5YG9v4kiYoD_-n_33FjX506uZgstJo+=BSA0KPZ_6mw@mail.gmail.com>
Subject: Re: [PATCH] acpi: battery: Sanitise model_number by dropping
 unprintable characters
To: Kate Hsuan <hpa@redhat.com>
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 8, 2026 at 9:07=E2=80=AFAM Kate Hsuan <hpa@redhat.com> wrote:
>
> The battery Embedded Controller (EC) may return the model name with
> trailing unprintable or non-ASCII characters. For example, on some system=
s:
>
> $ cat /sys/class/power_supply/BAT0/model_name
> LNV-5B10W51864=EF=BF=BD=EF=BF=BD

If they are just trailing and not in the middle of the string, you
could just find the first one and overwrite it with a NUL character.

Rewriting the entire string is overkill in that case.

> Strip these unprintable characters to ensure the model_name attribute
> contains a valid string. If left intact, these malformed strings prevent
> udev rules and hwdb from matching the attribute correctly.
>
> Link: https://gitlab.freedesktop.org/upower/upower/-/work_items/345
>
> Signed-off-by: Kate Hsuan <hpa@redhat.com>
> ---
>  drivers/acpi/battery.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index f5e0eb299610..dea0c3cc5160 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -10,6 +10,7 @@
>
>  #define pr_fmt(fmt) "ACPI: battery: " fmt
>
> +#include <linux/ctype.h>
>  #include <linux/delay.h>
>  #include <linux/dmi.h>
>  #include <linux/jiffies.h>
> @@ -194,6 +195,21 @@ static int acpi_battery_handle_discharging(struct ac=
pi_battery *battery)
>         return POWER_SUPPLY_STATUS_DISCHARGING;
>  }
>
> +static void acpi_battery_remove_special_chars(char *str)
> +{
> +       char *out =3D str;
> +       unsigned int i =3D 0;
> +

And I would use a for () loop below anyway.

> +       while (*str && i < MAX_STRING_LENGTH) {
> +               unsigned char c =3D *str++;
> +
> +               if (isascii(c) && isprint(c))
> +                       *out++ =3D c;
> +               i++;
> +       }
> +       *out =3D '\0';
> +}
> +
>  static int acpi_battery_get_property(struct power_supply *psy,
>                                      enum power_supply_property psp,
>                                      union power_supply_propval *val)
> @@ -524,6 +540,9 @@ static int extract_battery_info(const int use_bix,
>             battery->capacity_now > battery->full_charge_capacity)
>                 battery->capacity_now =3D battery->full_charge_capacity;
>
> +       if (!result)
> +               acpi_battery_remove_special_chars(battery->model_number);
> +
>         return result;
>  }
>
