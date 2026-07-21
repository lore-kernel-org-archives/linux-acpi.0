Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970623A1B5
	for <linux-acpi@vger.kernel.org>; Tue, 21 Jul 2026 12:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784637889; cv=none; b=TZ/emaIEBJUsR8l59t3S0wMWhGS2bxXkN6xFzH7t5x85gBW/OcTNBQoY+63jV8ovWr9f0wiXPIvWmTRWoj7f3FavgOn7Hwu+jw18Eifqb89e7UXW3A8FVQlDCsZsptCxax0ez4E43whOueaxR9IFHMWNxkLavWA+WXv95O0p/2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784637889; c=relaxed/simple;
	bh=0s2L8Pwx8Vq4iLOteMCCbP3DqGBBFvQVkiq6pYs54pk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dPSPbegWlAnyCqJKX3hkKWiE77LIzJlBioQAUfOOMO/QpXmhFDcaXLrKpxD5z540RnEwKLzJZPlql34TrpuWNoxMwiiIb8248EITEB9s0xPqucrtjuxKoU9MiIZegNyM+/lSIY3Ko7C+mU4JVeQ7lxsCfzCMdDA5ayoCLb/tzsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=inNq7At/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="inNq7At/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E2A81F00A3E
	for <linux-acpi@vger.kernel.org>; Tue, 21 Jul 2026 12:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784637888;
	bh=LBd9zLTzns99cc89FHKDXmVlP0KCH8JsNrMPB2bRNrw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=inNq7At/S/SfxypXEoiEKFFbmxQaNq83h//DI8KhlXqxTIv/LThrf7PJ0EPDASSPp
	 Izn12od6LdARXXFS7mD86R3OnpAaRjsny0lMoOpowYExLONoSWNXfjFZfw/Run2XUP
	 f4kUgk4pRJFZeS4UuLvFcWFRoNXx826Z9y5tVOUzsMzGo3PKD2v1vkKUSsfbu1F+Wj
	 44Hi5u+Ql9FUQDVK1jhOL28QnqLEfHMegzl/JTGbihk3zgpJEhUlcK/sueu8pDURlV
	 u9oDdWW1OvYq5HhzsIiolwypBRTfWLoGln9ZbhyDaV3pi3CIuoxw/sT6lyJa/5hQOy
	 z/B6nnHBaNOmQ==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-39669bcaadfso94884231fa.0
        for <linux-acpi@vger.kernel.org>; Tue, 21 Jul 2026 05:44:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RodilHZ0ojhJNKWftLCi+ozzjATuOhetJONwwFkwGrfcmm2KKF+6fg/gxbF1156qOOS4WiFuHdzx2T7@vger.kernel.org
X-Gm-Message-State: AOJu0YzyBMi1CCEB9W3uawx7zdulVa3+XnqDojvmgCnhxMVVbmlYlaHt
	amAE+2BrWwddlCVywlmaJNzzbBQus8s0hMYGhD2HHz27bvHIhHks6ERGkLxEI9KWkaJqA2mrkZM
	l6kxZeNg+kBzDNeLsizHGmWDSWuJKzNs=
X-Received: by 2002:a2e:7013:0:b0:39b:3082:cfe4 with SMTP id
 38308e7fff4ca-39eb2878426mr27216681fa.38.1784637886816; Tue, 21 Jul 2026
 05:44:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706094504.82920-1-pengpeng@iscas.ac.cn>
In-Reply-To: <20260706094504.82920-1-pengpeng@iscas.ac.cn>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 21 Jul 2026 14:44:26 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jnmFWnZ-j2M2gnP0vTj_zH=4o0wA-e=WTOEXhy92mPJw@mail.gmail.com>
X-Gm-Features: AUfX_my_edY30MbTvwpOhdf_-yT6DNjELgSXrLz7LpFlxf5PX2T6zuWf48X2AhM
Message-ID: <CAJZ5v0jnmFWnZ-j2M2gnP0vTj_zH=4o0wA-e=WTOEXhy92mPJw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: PRMT: validate module handler bounds
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 6, 2026 at 11:45=E2=80=AFAM Pengpeng Hou <pengpeng@iscas.ac.cn>=
 wrote:
>
> PRMT module entries carry handler array offsets and counts inside
> firmware data.  Validate the current module length and handler
> array bounds before allocating kernel-side handler storage or
> walking the handler records.
>
> This also rejects zero-handler modules, since the existing loop
> expects at least one handler record before it starts copying
> handler metadata.
>
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
>  drivers/acpi/prmt.c | 54 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
>
> diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
> index 7f5851371e5f..e531f2cd724e 100644
> --- a/drivers/acpi/prmt.c
> +++ b/drivers/acpi/prmt.c
> @@ -17,6 +17,7 @@
>  #include <linux/kernel.h>
>  #include <linux/efi.h>
>  #include <linux/acpi.h>
> +#include <linux/overflow.h>
>  #include <linux/prmt.h>
>  #include <asm/efi.h>
>
> @@ -91,6 +92,56 @@ static u64 efi_pa_va_lookup(efi_guid_t *guid, u64 pa)
>  #define get_first_handler(a) ((struct acpi_prmt_handler_info *) ((char *=
) (a) + a->handler_info_offset))
>  #define get_next_handler(a) ((struct acpi_prmt_handler_info *) (sizeof(s=
truct acpi_prmt_handler_info) + (char *) a))
>
> +static bool __init prmt_module_info_valid(struct acpi_prmt_module_info *=
module_info,
> +                                         const unsigned long end)
> +{
> +       struct acpi_prmt_handler_info *handler_info;
> +       unsigned long start =3D (unsigned long)module_info;
> +       size_t handler_bytes;
> +       size_t remaining;
> +       int i;
> +
> +       if (start >=3D end)
> +               return false;
> +
> +       remaining =3D end - start;
> +       if (remaining < sizeof(*module_info) ||
> +           module_info->length < sizeof(*module_info) ||
> +           module_info->length > remaining) {
> +               pr_err(FW_BUG "Invalid PRMT module length\n");
> +               return false;
> +       }
> +
> +       if (!module_info->handler_info_count) {
> +               pr_err(FW_BUG "PRMT module has no handlers\n");
> +               return false;
> +       }
> +
> +       if (module_info->handler_info_offset < sizeof(*module_info) ||
> +           module_info->handler_info_offset > module_info->length) {
> +               pr_err(FW_BUG "Invalid PRMT handler offset\n");
> +               return false;
> +       }
> +
> +       if (check_mul_overflow(module_info->handler_info_count,
> +                              sizeof(*handler_info), &handler_bytes) ||
> +           handler_bytes > module_info->length -
> +                           module_info->handler_info_offset) {
> +               pr_err(FW_BUG "Invalid PRMT handler array\n");
> +               return false;
> +       }
> +
> +       handler_info =3D get_first_handler(module_info);
> +       for (i =3D 0; i < module_info->handler_info_count; i++) {
> +               if (handler_info[i].length < sizeof(*handler_info)) {
> +                       pr_err(FW_BUG "Invalid PRMT handler length\n");
> +                       return false;
> +               }
> +       }

Sashiko has a comment on this that looks valid to me:

https://sashiko.dev/#/patchset/20260706094504.82920-1-pengpeng%40iscas.ac.c=
n

The validation should also take the case when there is too much data
into account.

> +
> +       return true;
> +}
> +
>  static int __init
>  acpi_parse_prmt(union acpi_subtable_headers *header, const unsigned long=
 end)
>  {
> @@ -105,6 +156,9 @@ acpi_parse_prmt(union acpi_subtable_headers *header, =
const unsigned long end)
>         void *temp_mmio;
>
>         module_info =3D (struct acpi_prmt_module_info *) header;
> +       if (!prmt_module_info_valid(module_info, end))
> +               return -EINVAL;
> +
>         module_info_size =3D struct_size(tm, handlers, module_info->handl=
er_info_count);
>         tm =3D kmalloc(module_info_size, GFP_KERNEL);
>         if (!tm)
> --
