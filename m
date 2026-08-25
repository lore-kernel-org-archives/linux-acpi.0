Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677033F4854
	for <linux-acpi@vger.kernel.org>; Tue, 25 Aug 2026 11:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787658914; cv=none; b=jpu5qGTrzma5ykP3Bfy+i0qbI5Plj4RvfB0gGIakSErjJljUCiUExs0fKWDDCSZMbewQWkEJBBuwGG+o1YJh3BsJ3d3QNkO6QOlSM071C28KLQkI7FXWSdgIz+I5HOvjTs+9+JACmpZdH2fqpX1mxtt2QmgqsFbcpvHWC6yQMt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787658914; c=relaxed/simple;
	bh=uuLHDXojOmQlBpYTFmdE1Jff9XmQqG/o6T4eVzVURc4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YDvuK/kej/KD6qHJ/tBzICFUymQNVEaKHtpgIM6EECaDtbZSrA6siX335ffl2GlKEnpByxn6nJaBMN77FDQTi5ZV/El19PptKVt0Lzouu+Yi6UwBhv4LHd2mudzn0FQjgwynB0IuBXT8CEBLSCHpIVvDcul0qmIVBjr4/YEb19Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lum8UFJZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lum8UFJZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 134081F00A3A
	for <linux-acpi@vger.kernel.org>; Tue, 25 Aug 2026 11:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787658913;
	bh=vO3yLiFapfMGTS7LuG+orAdvPOkTE8X1o49OtJLBIaw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=lum8UFJZ5AFe6ANVBFbw/bzQ0MoSrjR5eIa6uACtFsN4agHAEQZyQoKkBQpfEtaYA
	 znEnYOE+pFyf3zFHrOfTqhsbZ36PeEHfZOPQcuPSqD3EB+2xY/TKNt7sp4C4n1MbqX
	 H6agE+PI5k0bChib1tEJdymPZf63kxNuvsrgL3usYHS0c6zRjjXg1HGiVLD22gKYMe
	 /D+sq77hUVtppSJ2HaTZHLlQ/euaquFd3o/6gA65MtxZekSFWruu0S01V8piXEz6vP
	 GyLYF1FTZTsFSIlFQBNBTnnY36q+2wEkblhZINGz6Go5s4IqUehgAg9JZR26uD/cO1
	 f2m5DGy0scOzQ==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3a1585728b5so37174971fa.0
        for <linux-acpi@vger.kernel.org>; Tue, 25 Aug 2026 04:55:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqAl2yWugAWuHQVU3OXHUv0eyqJ6r084RmURBi1WEQhYxbtV6ApbG1AxQqiRZMjnv2pghkR+ux3wga0@vger.kernel.org
X-Gm-Message-State: AFuF++lW1jcR5LMaj+fLLCu1rR27kSoT7X1U8NForWYnSmEN6aJVMlV3
	qQPBACqmRcAT7KqPJY5ta6+gWBg35sEVV9LYTcijnyFKv1N5JJPXnGlT7hGD0hzSGhcaqLWsoPV
	q2YochfbJzcWkh1R3DbyfpKn/CpT5oQs=
X-Received: by 2002:a2e:be2c:0:b0:39b:3e32:4a58 with SMTP id
 38308e7fff4ca-3a1aec07846mr81663401fa.10.1787658911391; Tue, 25 Aug 2026
 04:55:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824211338.3583976-1-sakari.ailus@linux.intel.com> <20260824211338.3583976-5-sakari.ailus@linux.intel.com>
In-Reply-To: <20260824211338.3583976-5-sakari.ailus@linux.intel.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 25 Aug 2026 13:54:28 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h41GA+O3u40eaKUy5uBDGGzg_KOuRJi5GEEa1z_dh63Q@mail.gmail.com>
X-Gm-Features: AcwNN1W9CN6iT5_8Czvfu7ibS9qDMDa8pxCNqmHJYCWFiaw23xkuP-HQRhcwapY
Message-ID: <CAJZ5v0h41GA+O3u40eaKUy5uBDGGzg_KOuRJi5GEEa1z_dh63Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] platform/x86: int3472: Release ACPI objects using __free()
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-media@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, 
	Daniel Scally <dan.scally@ideasonboard.com>, Hans de Goede <hansg@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 11:13=E2=80=AFPM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Use __free() to release ACPI objects received from
> acpi_evaluate_dsm_typed() without explicit ACPI_FREE().

Well, the benefit of doing so is not entirely clear to me.

At least there is more overhead in the new code, or am I mistaken?

> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  drivers/platform/x86/intel/int3472/discrete.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/platform/x86/intel/int3472/discrete.c b/drivers/plat=
form/x86/intel/int3472/discrete.c
> index b4a95b583edb..2024eaa09033 100644
> --- a/drivers/platform/x86/intel/int3472/discrete.c
> +++ b/drivers/platform/x86/intel/int3472/discrete.c
> @@ -4,6 +4,7 @@
>  #include <linux/acpi.h>
>  #include <linux/array_size.h>
>  #include <linux/bitfield.h>
> +#include <linux/cleanup.h>
>  #include <linux/device.h>
>  #include <linux/dmi.h>
>  #include <linux/gpio/consumer.h>
> @@ -327,7 +328,6 @@ static int skl_int3472_handle_gpio_resources(struct a=
cpi_resource *ares,
>         unsigned int enable_time_us;
>         u8 active_value, pin, type;
>         unsigned long gpio_flags;
> -       union acpi_object *obj;
>         struct gpio_desc *gpio;
>         const char *con_id;
>         int ret;
> @@ -339,10 +339,11 @@ static int skl_int3472_handle_gpio_resources(struct=
 acpi_resource *ares,
>          * ngpios + 2 because the index of this _DSM function is 1-based =
and
>          * the first function is just a count.
>          */
> -       obj =3D acpi_evaluate_dsm_typed(int3472->adev->handle,
> -                                     &int3472_gpio_guid, 0x00,
> -                                     int3472->ngpios + 2,
> -                                     NULL, ACPI_TYPE_INTEGER);
> +       union acpi_object *obj __free(ACPI_FREE) =3D
> +               acpi_evaluate_dsm_typed(int3472->adev->handle,
> +                                       &int3472_gpio_guid, 0x00,
> +                                       int3472->ngpios + 2,
> +                                       NULL, ACPI_TYPE_INTEGER);
>
>         if (!obj) {
>                 dev_warn(int3472->dev, "No _DSM entry for GPIO pin %u\n",
> @@ -433,7 +434,6 @@ static int skl_int3472_handle_gpio_resources(struct a=
cpi_resource *ares,
>         }
>
>         int3472->ngpios++;
> -       ACPI_FREE(obj);
>
>         /*
>          * Either return an error or tell acpi_dev_get_resources() to not=
 make a
> --
> 2.47.3
>
