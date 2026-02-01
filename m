Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049882D8DC3
	for <linux-acpi@vger.kernel.org>; Sun,  1 Feb 2026 12:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769950260; cv=none; b=HvamMEB7d/Ryfv1MbrteqQSzoVDh9pUWTBFr79dtGaix1DgppviyLRsjMjzXsOzMNbgRlP7DK/b6JLk2c5omAYQeJo/mRaDPClp8xnblOyRWJoxfzjZy7c0LryHPllKMFJrnKyoxZ4fCjtBTi2ZCIDEVJxifZM3JmLr+SPOd9/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769950260; c=relaxed/simple;
	bh=AGWlrM6sqPGtHtuuLZDHJXLKVADG2X0Xz2QLpV2wdJM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sBQHwDFRmGOj57iBvR/Spl4luFIVqvA2YnlM3ZSyDBJa6XdNLZG6ut7v+jaTO9h7WKQHSICr38rIKftBAW3Nt6iwd0VHqc5ukil6l58J/xFQehiXrkGF2pV2DwEiA4egJPm3rLye7y/GvR+7UMsVgppjqWx0rgmbcPZtjsEnkVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tsd44DxL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tsd44DxL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D487C4CEF7
	for <linux-acpi@vger.kernel.org>; Sun,  1 Feb 2026 12:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769950259;
	bh=AGWlrM6sqPGtHtuuLZDHJXLKVADG2X0Xz2QLpV2wdJM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tsd44DxLXIe0pDWo75dOLNRf3o/J4SL8Vets8Ea8qYEtFpWtDYFruXewL/1hSsgyd
	 EJlMpdIRkkhiz+bhrHVeDv6Pno+6SAJCD4kpSfUpHN5QMggYKlWDBeoqRFlfVukOb5
	 K98igPqU1Mmff4VgL/gBhwx/wADttOLHbr5pMK+pV/z4J7s18yHP+V202sEUnurpfQ
	 hK1zwfYPJm6pZTKVons9LQLesRh2cCmoTFnbyWgBF9JLOls5iI6I4ZGA1OtsvN3UdQ
	 uiG8HB+HWrErt0Z4vzGvIVT6OQVQiHKXTHYOHEKWSxFQz7h3wEfYh7YwJfW6yj+tfc
	 pLEglkutx61fQ==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-4095b6f9c5aso2220031fac.0
        for <linux-acpi@vger.kernel.org>; Sun, 01 Feb 2026 04:50:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVbjygDJpJ1Xu1HgHQamaoJRJPa+0vaSBO0fPmTPEVSKIqGx6pJmFlvBo9Poer1j6Q6XifuJ2TJJM1H@vger.kernel.org
X-Gm-Message-State: AOJu0YyaOpIYlyI2Xmb9V25OQNx3KbF625DC0tOHHitORJq3m4NEwAQU
	csIhAKzjPqQUQoNXiHLJwVhR0j1GNMhilQ4IN+F+/9Qct+zZymxUWUcvTlYCqQTbXz1j9mX/7a3
	hoeVo5J0sUGTt12J5q2x2qC7oqvR1ewE=
X-Received: by 2002:a05:6870:b527:b0:3d4:8741:edd3 with SMTP id
 586e51a60fabf-409a6b31ad2mr4626349fac.20.1769950258631; Sun, 01 Feb 2026
 04:50:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129144856.43058-1-atailhan2006@gmail.com>
In-Reply-To: <20260129144856.43058-1-atailhan2006@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sun, 1 Feb 2026 13:50:45 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iEzUgG5t6iYS75BWJJwHMRficwME2GOtfecoM1jWFH1A@mail.gmail.com>
X-Gm-Features: AZwV_Qjo8DWEvTp5wvKJxPlbR3ISuFcUAAcbgmVR19NkwvwQcl2OoZfhl7-sO54
Message-ID: <CAJZ5v0iEzUgG5t6iYS75BWJJwHMRficwME2GOtfecoM1jWFH1A@mail.gmail.com>
Subject: Re: [PATCH] ACPI: battery: fix incorrect charging status when current
 is zero
To: =?UTF-8?B?QXRhIMSwbGhhbiBLw7ZrdMO8cms=?= <atailhan2006@gmail.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 29, 2026 at 3:49=E2=80=AFPM Ata =C4=B0lhan K=C3=B6kt=C3=BCrk
<atailhan2006@gmail.com> wrote:
>
> On some laptops, such as the Huawei Matebook series
> the Embedded Controller continues to report "Charging"
> status even when the charge threshold is
> reached and no current is being drawn.
>
> This incorrect reporting prevents the
> system from switching to battery
> power profiles, leading to significantly
> higher power consumption (e.g., 18W
> instead of 7W during browsing) and
> broken battery remaining time estimation.
>
> Validate the "Charging" state
> by checking if rate_now is zero. If the
> hardware reports charging but the current is zero,
> report "Not Charging" to user space.
>
> Signed-off-by: Ata =C4=B0lhan K=C3=B6kt=C3=BCrk <atailhan2006@gmail.com>
> ---
>  drivers/acpi/battery.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index 34181fa52..b4ba8085f 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -211,7 +211,13 @@ static int acpi_battery_get_property(struct power_su=
pply *psy,
>                 if (battery->state & ACPI_BATTERY_STATE_DISCHARGING)
>                         val->intval =3D acpi_battery_handle_discharging(b=
attery);
>                 else if (battery->state & ACPI_BATTERY_STATE_CHARGING)
> -                       val->intval =3D POWER_SUPPLY_STATUS_CHARGING;
> +                       /* Check if we can fetch ACPI current info */
> +                       if (battery->rate_now !=3D ACPI_BATTERY_VALUE_UNK=
NOWN &&
> +                               battery->rate_now =3D=3D 0)
> +                               /* On charge but no current (0W/0mA) */
> +                               val->intval =3D POWER_SUPPLY_STATUS_NOT_C=
HARGING;
> +                       else
> +                               val->intval =3D POWER_SUPPLY_STATUS_CHARG=
ING;
>                 else if (battery->state & ACPI_BATTERY_STATE_CHARGE_LIMIT=
ING)
>                         val->intval =3D POWER_SUPPLY_STATUS_NOT_CHARGING;
>                 else if (acpi_battery_is_charged(battery))
> --

Applied as 6.20/7.0 material, thanks!
