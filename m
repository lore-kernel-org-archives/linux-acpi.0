Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C14430ACFB
	for <linux-acpi@vger.kernel.org>; Thu, 20 Aug 2026 18:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787251556; cv=none; b=NzC/D+TVFy9pIBoZWJfr1sJjL6OqLJI/82DgI7HC1lkqVHx8b4z1ja3k/aysou0tAe5FT88NjIq45xdDmH519/pVdLvBX9C3OyBQqsOxlhKSWBroNCyxLJdpF08gP9SgO5JwVk/W9y8wcFxuQH8U6hOLdC96Jk1b5q8hjj/+3NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787251556; c=relaxed/simple;
	bh=Kxj72uJxMJgTN8QsLiK7yqQbiy536nQgV+BgpdQfmaI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OlpDtQ0Q7SGqCiQ5oy3JybL3DNRnNssQRtpLW++B8YZh7S1BulbamjGuXkEj2TEOoq66QEb9eIi9QBPnob28mZGLREgvqsl9K3nSv7lxbf0CKxlXG7F9i/dgK0TIyc8a6Beo7v+OG59szLk5hs8I4odb2x98hgL7RUz55bW8B2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e/+La2GY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/+La2GY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF9CB1F00A3A
	for <linux-acpi@vger.kernel.org>; Thu, 20 Aug 2026 18:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787251554;
	bh=YVb4J1V0CMvgwLitjlRlo9yrvIFqh3ZSrAUYXqj6bIs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=e/+La2GY4UAk5VcwL4muLjCKn2rx880XpGq0C5KgbU1DtW1UMyDREDlr5v0wC2bDn
	 JJ0HZIRbNSwCcFnNhcIuYctP2YK8pwl6adfCUoKkkKRlgUAX5XTyO/Ev1Yn9zpmLQi
	 K6PC+1fhC8DScW+2dFN0XBhyIkxQd9AxZC6YHGUWkecMeTaL+UDybyuv/6fm8qgV6K
	 aqtcw3IgVMYuFNJzm6VOGVwOvQNuurOMyfdErNwWT2RayKu8uVP/nUHff6MvTe5gsW
	 C06TFCHa+pUv558ENfF5BzP2jhGE/CEGfdBwB9jB6iPiCYv5PCk9NcmMNEb17nEPv+
	 WFsCBEnuIXm+A==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5aec6360133so131123e87.1
        for <linux-acpi@vger.kernel.org>; Thu, 20 Aug 2026 11:45:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqYs4KWgV2czHME7yuvsSkP0+W4/QyIAki8HmDYqoeYnU2Y2uXM8vngoCZT6eMuK6r6iC1Mqld/OZGE@vger.kernel.org
X-Gm-Message-State: AFuF++ngDHXnKqqPtE7QpfzGuazsx0VEE32l9fp8Pm0gYB151QJtEAY1
	mAY+X3HCIB+T9y1SKtc5QrK4w6y+EPl6hWf+JxTy9uSwXgB3xup6Lk02NZCGJfs3MbSr1FG9EWR
	XzoUV6svs/dJqxETsmqtHCPEoHs3rrXA=
X-Received: by 2002:a05:6512:3b90:b0:5b4:5846:d925 with SMTP id
 2adb3069b0e04-5b484233905mr120830e87.21.1787251553281; Thu, 20 Aug 2026
 11:45:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820-acpi-power-resource-ref-fix-v2-1-29818173ea13@linux.spacemit.com>
In-Reply-To: <20260820-acpi-power-resource-ref-fix-v2-1-29818173ea13@linux.spacemit.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 20 Aug 2026 20:45:19 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hxNALP_GRBk+QpfrpSAwJxbhjcvdYWkh8aakTppZnHSQ@mail.gmail.com>
X-Gm-Features: AcwNN1Xkgg8dkhd5DrHEclBbxpwM5hJZxuiRpd3gKjDhZGY6sALVJ87AqhbLVIw
Message-ID: <CAJZ5v0hxNALP_GRBk+QpfrpSAwJxbhjcvdYWkh8aakTppZnHSQ@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: scan: Defer device power initialization
To: Peixin Xie <peixin.xie@linux.spacemit.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Yixun Lan <dlan@kernel.org>, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026 at 7:56=E2=80=AFAM Peixin Xie
<peixin.xie@linux.spacemit.com> wrote:
>
> acpi_bus_get_power_flags() initializes the device power state while the
> ACPI device object is being created, before checking whether the device
> is ready for enumeration.
>
> If enumeration is deferred, acpi_bus_attach() clears the initialized and
> power_manageable flags. When the dependency is later satisfied,
> acpi_bus_init_power() is called again and takes additional references to
> the power resources used by the device. These references prevent the
> resources from being turned off when the device enters D3.
>
> Remove the early acpi_bus_init_power() call and leave regular ACPI device
> objects uninitialized until acpi_bus_attach() runs after the device is
> ready for enumeration.
>
> Power resource objects are initialized through acpi_add_power_resource()
> and do not require the generic initialization in acpi_bus_attach(), so
> mark them as initialized there.
>
> This also avoids powering up devices before their dependencies are
> available.
>
> Signed-off-by: Peixin Xie <peixin.xie@linux.spacemit.com>
> ---
> This issue was reproduced on a SpacemiT K3 RISC-V Pico-ITX. The affected
> device uses a power resource through _PR0 and has an automatically derive=
d
> dependency on its interrupt controller.
>
> Before the change, the initial power initialization acquires a power
> resource reference. The device is then deferred, but that reference is no=
t
> dropped. When the dependency becomes available, power initialization
> acquires another reference. Consequently, entering D3 only drops the
> reference count from 2 to 1 and _OFF is not evaluated:
>
>  [    0.314611] ACPI Debug:  "I2P2 _STA"
>  [    0.318260] ACPI: \_SB_.I2P2: ACPI: PM: Power resource is on
>  [    0.323998] ACPI: \_SB_.I2P2: New power resource
>  [    0.382108] ACPI Debug:  "I2P2 _STA"
>  [    0.478964] ACPI Debug:  "I2P2 _ON"
>  [    0.482498] ACPI: \_SB_.I2P2: ACPI: PM: Power resource turned on
>  [    0.488597] ACPI Debug:  "I2C2, PS0"
>  [    0.863170] ACPI: \_SB_.I2P2: ACPI: PM: Power resource already on
>  [    0.873686] ACPI Debug:  "I2C2, PS0"
>  [    2.416055] ACPI Debug:  "I2C2, PS3"
>  [    2.423397] ACPI: \_SB_.I2P2: ACPI: PM: Power resource still in use
>
> After the change, device power state initialization is deferred until its
> dependency is met. Since no reference is acquired before then, the power
> resource left on by firmware is turned off as unused after the namespace
> scan. Once the dependency is met, the resource is turned on once for the
> device and is turned off normally when the device later enters D3:
>
> [    0.314628] ACPI Debug:  "I2P2 _STA"
>  [    0.318277] ACPI: \_SB_.I2P2: ACPI: PM: Power resource is on
>  [    0.324016] ACPI: \_SB_.I2P2: New power resource
>  [    0.382118] ACPI Debug:  "I2P2 _STA"
>  [    0.496116] ACPI: \_SB_.I2P2: ACPI: PM: Turning OFF
>  [    0.501081] ACPI Debug:  "I2P2 _OFF"
>  [    0.504705] ACPI: \_SB_.I2P2: ACPI: PM: Power resource turned off
>  [    1.415899] ACPI Debug:  "I2P2 _ON"
>  [    1.418866] ACPI: \_SB_.I2P2: ACPI: PM: Power resource turned on
>  [    1.424947] ACPI Debug:  "I2C2, PS0"
>  [    2.647655] ACPI Debug:  "I2C2, PS3"
>  [    2.654856] ACPI Debug:  "I2P2 _OFF"
>  [    2.654866] ACPI: \_SB_.I2P2: ACPI: PM: Power resource turned off
> ---
> Changes in v2:
> - Replace the D3cold transition added in v1 with deferred device power
>   initialization, as suggested by Rafael.
> - Mark power resource objects as initialized in their dedicated creation
>   path.
> - Link to v1: https://patch.msgid.link/20260811-acpi-power-resource-ref-f=
ix-v1-1-828f1c383831@linux.spacemit.com
> ---
>  drivers/acpi/power.c | 1 +
>  drivers/acpi/scan.c  | 4 ----
>  2 files changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
> index d4131c184be8..4f1479103bfe 100644
> --- a/drivers/acpi/power.c
> +++ b/drivers/acpi/power.c
> @@ -955,6 +955,7 @@ struct acpi_device *acpi_add_power_resource(acpi_hand=
le handle)
>         INIT_LIST_HEAD(&resource->dependents);
>         device->power.state =3D ACPI_STATE_UNKNOWN;
>         device->flags.match_driver =3D true;
> +       device->flags.initialized =3D true;
>
>         /* Evaluate the object to get the system level and resource order=
. */
>         status =3D acpi_evaluate_object(handle, NULL, NULL, &buffer);
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 9a7ac2eb9ce0..489352ba80e1 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -1141,9 +1141,6 @@ static void acpi_bus_get_power_flags(struct acpi_de=
vice *device)
>                 if (!list_empty(&device->power.states[ACPI_STATE_D3_HOT].=
resources))
>                         device->power.states[ACPI_STATE_D3_COLD].flags.va=
lid =3D 1;
>         }
> -
> -       if (acpi_bus_init_power(device))
> -               device->flags.power_manageable =3D 0;
>  }
>
>  static void acpi_bus_get_flags(struct acpi_device *device)
> @@ -1822,7 +1819,6 @@ void acpi_init_device_object(struct acpi_device *de=
vice, acpi_handle handle,
>         acpi_init_properties(device);
>         acpi_bus_get_flags(device);
>         device->flags.match_driver =3D false;
> -       device->flags.initialized =3D true;
>         device->flags.enumeration_by_parent =3D
>                 acpi_device_enumeration_by_parent(device);
>         acpi_device_clear_enumerated(device);
>
> ---

Applied as 7.3-rc material, thanks!
