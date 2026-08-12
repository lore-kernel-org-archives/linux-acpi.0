Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5484E44A739
	for <linux-acpi@vger.kernel.org>; Wed, 12 Aug 2026 13:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786540552; cv=none; b=gJhwiQVW9hLxY8epp6iFA7ljQ5pZvwfwmDLComVYYSrMXANiDd4W/eb3mzDmMHsUTqtpo4boH/s+f1jxj0YUeqjjDC9e5kBc7eWW+NXRjh5edOQxK8AiNh5rj9um8Gl61Dan/FT3vMIvLTUIfCyDgJ8d5XxIxofqqlx4SEZ186o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786540552; c=relaxed/simple;
	bh=lj5HmFV/xC4fhd/TZ1Q4a3YW7m0iWzHWU63QwES+DWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ni1Ci4JmhNVTm6/PoQOFty0Ficf9RUqeY2Q7EKUrH1MBdr1fvpj/k14XnNxexcTttFwTRNSNus6QYOoQ0Itjxd/BksT2FACDoapWZBPTdFp/MmA4hPD6Vb0yP2IAe1Lx+GhUPN20fkM/zvvCA8BNfOl5wu4Kj8oYFc4Rf4jVpR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oMxyewsu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oMxyewsu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 144611F00A3F
	for <linux-acpi@vger.kernel.org>; Wed, 12 Aug 2026 13:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786540550;
	bh=lWCOEIBkdDkyMERp1h8105RH6wjI0avpJB2ffYHEBWs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=oMxyewsu2cElNobJw+ys6Dpm1RM5D7HGFQK2VgU6FoRF5w/KtPgIYM2dcl1Bs4i3E
	 VuLSZFo3ZcjlsPG2wE0UGt+M5dR4E2kqdxwOp87h1uXBWMaEdFygSfVex9vxyqifdV
	 324kZwk7vG3hEtv7+Wi3jCRBLf7Bf+ln9r+tEuul9pqJ9FLQ2Xq6Hj8OsACMbmzFHm
	 s0s0EPQA4p1jCx/AWxCuEqdf4WUXAYb4C6lZ4nen+sSNZGRGFrR5yR5zPjr8lvHpFH
	 deDVU2IfpcU3sbMnYhst/dDiIoAco9RLVYnlTMb30fkC4Y+pSeXyssTdlFxU6Nd7mA
	 AA4CP2FWohUNQ==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5b29599b81cso1228851e87.1
        for <linux-acpi@vger.kernel.org>; Wed, 12 Aug 2026 06:15:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrbOgArNOeUyfoGWSRB+clx5JJj95Wh/Uscoo53bVz9Nzk6BM12SAGIFJUA/9PiqKcxzGt+ZwHs5FXi@vger.kernel.org
X-Gm-Message-State: AOJu0YxZNk6u1UD5nUKcG3Lf9li6uqbMfDwxUwIUAC0cQWvI4BzhlFYW
	PoW42a6vVT25PwVy7WxXQHJkUIf0zHITVQRToDcFhn00Fcqjv9RmnIi2YoPBKDeHHtNfYdM0u7X
	V7Av1ecY/9P8Bb5Ce3GI2DTzSgQ++55A=
X-Received: by 2002:a05:6512:3c84:b0:5b2:dba4:d8d9 with SMTP id
 2adb3069b0e04-5b44e302007mr724652e87.35.1786540548485; Wed, 12 Aug 2026
 06:15:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811-acpi-power-resource-ref-fix-v1-1-828f1c383831@linux.spacemit.com>
In-Reply-To: <20260811-acpi-power-resource-ref-fix-v1-1-828f1c383831@linux.spacemit.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 12 Aug 2026 15:15:27 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g3pVxLgXBAHho5B+kfAiQQkQHGoO-1uBxp0OyXiGGcRQ@mail.gmail.com>
X-Gm-Features: AUfX_mw9KNZxZnfr-X2CPvEO5g8iiDNzjXhfsUpbJGt3QCyQOxkJufW5STtdAZw
Message-ID: <CAJZ5v0g3pVxLgXBAHho5B+kfAiQQkQHGoO-1uBxp0OyXiGGcRQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: scan: Drop power resource references for deferred devices
To: Peixin Xie <peixin.xie@linux.spacemit.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Yixun Lan <dlan@kernel.org>, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 2:37=E2=80=AFPM Peixin Xie
<peixin.xie@linux.spacemit.com> wrote:
>
> acpi_bus_get_power_flags() initializes the device power state and takes
> references to any power resources required by that state.
>
> If the device is not ready for enumeration, acpi_bus_attach() parks it
> and clears power_manageable without dropping those references. When the
> dependency is later satisfied, power initialization takes the references
> again. The additional references prevent the resources from being
> turned off when the device enters D3.
>
> Transition the device to D3cold before clearing power_manageable to drop
> the references acquired during initial power state initialization.
>
> This is particularly easy to trigger on RISC-V, where dependencies on
> interrupt controllers are derived automatically from interrupt resources.
>
> Signed-off-by: Peixin Xie <peixin.xie@linux.spacemit.com>
> ---
> This issue was reproduced on a SpacemiT K3 RISC-V platform. The affected
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
>   [    0.403217] ACPI: \_SB_.USBD.PDPR: ACPI: PM: Power resource is on
>   [    0.409393] ACPI: \_SB_.USBD.PDPR: New power resource
>   [    0.419165] ACPI Debug:  "ACPI USBD: entering PDPR._ON"
>   [    0.424495] ACPI: \_SB_.USBD.PDPR: ACPI: PM: Power resource turned o=
n
>   [    0.431036] ACPI Debug:  "ACPI USBD: entering _PS0"
>   [    0.790826] ACPI: \_SB_.USBD.PDPR: ACPI: PM: Power resource already =
on
>   [    0.801777] ACPI Debug:  "ACPI USBD: entering _PS0"
>   [    0.995285] ACPI Debug:  "ACPI USBD: entering _PS3"
>   [    1.005550] ACPI: \_SB_.USBD.PDPR: ACPI: PM: Power resource still in=
 use
>
> After the change, the reference acquired before deferred enumeration is
> dropped, and _OFF is evaluated both when the device is deferred and when
> it later enters D3:
>
>   [    0.340111] ACPI Debug:  "ACPI USBD: entering PDPR._ON"
>   [    0.345459] ACPI Debug:  "ACPI USBD: entering _PS0"
>   [    0.350532] ACPI Debug:  "ACPI USBD: entering PDPR._OFF"
>   [    0.742054] ACPI Debug:  "ACPI USBD: entering PDPR._ON"
>   [    0.747282] ACPI Debug:  "ACPI USBD: entering _PS0"
>   [    0.758664] ACPI Debug:  "ACPI USBD: entering _PS3"
>   [    0.768959] ACPI Debug:  "ACPI USBD: entering PDPR._OFF"
> ---
>  drivers/acpi/scan.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 9a7ac2eb9ce0..7a8404719fa1 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -2350,6 +2350,11 @@ static int acpi_bus_attach(struct acpi_device *dev=
ice, void *first_pass)
>         acpi_bus_get_status(device);
>         /* Skip devices that are not ready for enumeration (e.g. not pres=
ent) */
>         if (!acpi_dev_ready_for_enumeration(device)) {
> +               /*
> +                * Drop power resource references acquired during initial
> +                * power state initialization before parking the device.
> +                */
> +               acpi_power_transition(device, ACPI_STATE_D3_COLD);
>                 device->flags.initialized =3D false;
>                 acpi_device_clear_enumerated(device);
>                 device->flags.power_manageable =3D 0;
>
> ---

Sashiko has concerns regarding this change:

https://sashiko.dev/#/patchset/20260811-acpi-power-resource-ref-fix-v1-1-82=
8f1c383831%40linux.spacemit.com

Moreover, it is kind of pointless to power up a device and then power
it down almost immediately later.

Have you considered dropping the acpi_bus_init_power() call from
acpi_bus_get_power_flags() and doing it only once when the device gets
ready for enumeration?

Since there should not be any drivers binding directly to struct
acpi_device in the tree now (and struc acpi_device is going to be
dropped entirely in 7.3 if all goes well), something like that should
work.
