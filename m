Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D9F883F
	for <linux-acpi@vger.kernel.org>; Fri,  7 Aug 2026 14:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786112075; cv=none; b=Y15mlQ4ULYDctH8iUSPIjEqy4ePWzSsRKAM2MkjEBVf3Y0lrMcKmBTnKnUdxHKO1Ilfk/NsDGt3RwhAqJwANMf/TU2zlfK9NRLwcMhd3OLO43imP0TOoZlOPdo9GqA5k2SreimshJU8z5QORBvsgnnuoIwWWLa6MAT+Cfm2qN0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786112075; c=relaxed/simple;
	bh=9glZgDhJsCoSG9bSfFFi+1mXs7svligfcqnbVMyG/TQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pmYw6IX+94WJW/RcAcYrBojoGoyxV33DRPf6/es/20CmoLdAWkMCg1YkzN3/Wq1mXRvX8T8AwtQMcy1waNNXjqYMgwWwEbfEtkyEWEFucy2enE4zMwpRmpQzxUnKkb4RmJRHKL0XzriZcfJv2kCrxJK99aL6KAESIAPTTQtDrzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GTL8X3lu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GTL8X3lu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73B341F00AC4
	for <linux-acpi@vger.kernel.org>; Fri,  7 Aug 2026 14:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786112068;
	bh=QSBQq1iZ4TIttTi7WtPUV0Lctn3BW8e48z0P6hPV+rg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=GTL8X3luoJo8ojA2eygaPsq8zHijMD3dU2i3jNschrAb4qHvxO6Qg0PNKHhwUIYVz
	 dya9F9p5gBS2dUNqPlMl3c8Bxu9LOdv3ZjCOirsjUFJ6OfmlTU8xlj25ZupahK6k5h
	 IxC3+uR5g9KaxbxFXWUcuXokH5hODYhyV0h33eR51O1sLHBj80GfwnpYk72o43T/6K
	 icxbshYswHl6bpwk1rBlm+vDBJE0Vt0u5cPrIFFRoyWZwHpBQZ9u9hoMa+2XQxWIDu
	 f3wtGQMWDXahGUsA97LIDvFpX+IrdFyAM7HYT+6dfwkWWV0sCnDgNslcLgS9L4YoCX
	 +nJEcX7GEwc1A==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-39c86945164so29778401fa.1
        for <linux-acpi@vger.kernel.org>; Fri, 07 Aug 2026 07:14:28 -0700 (PDT)
X-Gm-Message-State: AOJu0YxhmhJCZv6JMBpJinl5Kvv8W4y0GhiruHEWrdGCz4XhY0Uy6ACy
	Xa70Zb+fTfbv4D1e76YM7rPq/d7VIS4MPPBhunHkErNlMpHcPVdmVCWtTPjB3m8s4/Eh3IVVGKj
	VeQzPvuGUJMZn6PYe9BaBI9hUucEfjYo=
X-Received: by 2002:a05:651c:a394:20b0:39b:695:32a3 with SMTP id
 38308e7fff4ca-39fe56d06bemr804331fa.13.1786112066901; Fri, 07 Aug 2026
 07:14:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <19fd74e46a8.25f5bfd941182.5953196137231825269@a0rg.com> <19fd7a647c3.1059430542637.572965728630481984@a0rg.com>
In-Reply-To: <19fd7a647c3.1059430542637.572965728630481984@a0rg.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 7 Aug 2026 16:14:14 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j5N-=yzvUF3wqsJCCnqeT50d8NECqpnWDPkfp7HCpUBg@mail.gmail.com>
X-Gm-Features: AUfX_myJ24AZX--Dy6aql1rCvYDOlICOhVSQ7k5e-kcqZNrAIq9efsEhhXqmyMs
Message-ID: <CAJZ5v0j5N-=yzvUF3wqsJCCnqeT50d8NECqpnWDPkfp7HCpUBg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: pfr_update: fix stack buffer overflow in query_capability()
To: Anirudh Prasad <icarus@a0rg.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, rafaeljwysocki <rafael.j.wysocki@intel.com>, 
	linux-kernel <linux-kernel@vger.kernel.org>, stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 5:17=E2=80=AFPM Anirudh Prasad <icarus@a0rg.com> wro=
te:
>
> > If the firmware wants the kernel to copy more data than the latter has
> > room for, the operation should fail instead of pretending to succeed.
>
> Agreed. v2 validates all four buffer lengths upfront and returns
> -EINVAL if any exceeds its destination field size.

Can you please resend this afresh with proper versioning?

> ---
>
> query_capability() copies four ACPI buffer objects returned by the
> firmware _DSM into fixed-size u8[16] fields in struct
> pfru_update_cap_info using memcpy with the firmware-supplied length:
>
>   memcpy(&cap_hdr->code_type,
>          elements[CAP_CODE_TYPE_IDX].buffer.pointer,
>          elements[CAP_CODE_TYPE_IDX].buffer.length);
>
> The same pattern repeats for drv_type, platform_id, and oem_id.
> If the firmware returns buffer.length > 16 for any of these fields,
> memcpy writes past the destination array.
>
> struct pfru_update_cap_info is stack-allocated in pfru_ioctl().
> Confirmed with KASAN on 7.2-rc6: three stack-out-of-bounds reports
> are generated when a DSM returns 64-byte buffers, with writes reaching
> 44 bytes past the end of cap_hdr's [64, 156) frame window into
> adjacent stack redzones.
>
> Fix by validating each buffer length against its destination field
> size before copying, and returning -EINVAL if the firmware supplies
> an oversized buffer.
>
> Fixes: 0db89fa243e5 ("ACPI: Introduce Platform Firmware Runtime Update de=
vice driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Anirudh Prasad <icarus@a0rg.com>
> ---
>  drivers/acpi/pfr_update.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/acpi/pfr_update.c b/drivers/acpi/pfr_update.c
> index 6283105bb0e8..e14e053cea44 100644
> --- a/drivers/acpi/pfr_update.c
> +++ b/drivers/acpi/pfr_update.c
> @@ -158,6 +158,14 @@ static int query_capability(struct pfru_update_cap_i=
nfo *cap_hdr,
>                 goto free_acpi_buffer;
>         }
>
> +       if (out_obj->package.elements[CAP_CODE_TYPE_IDX].buffer.length > =
sizeof(cap_hdr->code_type) ||
> +           out_obj->package.elements[CAP_DRV_TYPE_IDX].buffer.length > s=
izeof(cap_hdr->drv_type) ||
> +           out_obj->package.elements[CAP_PLAT_ID_IDX].buffer.length > si=
zeof(cap_hdr->platform_id) ||
> +           out_obj->package.elements[CAP_OEM_ID_IDX].buffer.length > siz=
eof(cap_hdr->oem_id)) {
> +               ret =3D -EINVAL;
> +               goto free_acpi_buffer;
> +       }
> +
>         cap_hdr->update_cap =3D out_obj->package.elements[CAP_UPDATE_IDX]=
.integer.value;
>         memcpy(&cap_hdr->code_type,
>                out_obj->package.elements[CAP_CODE_TYPE_IDX].buffer.pointe=
r,
> --
> 2.55.0
>
>
>
>
>
> From: Anirudh Prasad <icarus@a0rg.com>
> To: "linux-acpi"<linux-acpi@vger.kernel.org>
> Cc: "rafaeljwysocki"<rafael.j.wysocki@intel.com>, "linux-kernel"<linux-ke=
rnel@vger.kernel.org>, "stable"<stable@vger.kernel.org>
> Date: Thu, 06 Aug 2026 19:10:59 +0530
> Subject: [PATCH] ACPI: pfr_update: fix stack buffer overflow in query_cap=
ability()
>
>  > query_capability() copies four ACPI buffer objects returned by the
>  > firmware _DSM into fixed-size u8[16] fields in struct
>  > pfru_update_cap_info using memcpy with the firmware-supplied length:
>  >
>  >  memcpy(&cap_hdr->code_type,
>  >  elements[CAP_CODE_TYPE_IDX].buffer.pointer,
>  >  elements[CAP_CODE_TYPE_IDX].buffer.length);
>  >
>  > The same pattern repeats for drv_type, platform_id, and oem_id.
>  > If the firmware returns buffer.length > 16 for any of these fields,
>  > memcpy writes past the destination array.
>  >
>  > struct pfru_update_cap_info is stack-allocated in pfru_ioctl().
>  > Confirmed with KASAN on 7.2-rc6: three stack-out-of-bounds reports
>  > are generated when a DSM returns 64-byte buffers, with writes reaching
>  > 44 bytes past the end of cap_hdr's [64, 156) frame window into
>  > adjacent stack redzones.
>  >
>  > Fix by clamping each memcpy length to the size of its destination
>  > field with min_t(u32, buffer.length, sizeof(cap_hdr->field)).
>  >
>  > Fixes: 0db89fa243e5 ("ACPI: Introduce Platform Firmware Runtime Update=
 device driver")
>  > Cc: stable@vger.kernel.org
>  > Signed-off-by: Anirudh Prasad <icarus@a0rg.com>
>  > ---
>  >  drivers/acpi/pfr_update.c | 12 ++++++++----
>  >  1 file changed, 8 insertions(+), 4 deletions(-)
>  >
>  > diff --git a/drivers/acpi/pfr_update.c b/drivers/acpi/pfr_update.c
>  > index 6283105bb0e8..0219347cd78f 100644
>  > --- a/drivers/acpi/pfr_update.c
>  > +++ b/drivers/acpi/pfr_update.c
>  > @@ -161,24 +161,28 @@ static int query_capability(struct pfru_update_c=
ap_info *cap_hdr,
>  >      cap_hdr->update_cap =3D out_obj->package.elements[CAP_UPDATE_IDX]=
.integer.value;
>  >      memcpy(&cap_hdr->code_type,
>  >             out_obj->package.elements[CAP_CODE_TYPE_IDX].buffer.pointe=
r,
>  > -           out_obj->package.elements[CAP_CODE_TYPE_IDX].buffer.length=
);
>  > +           min_t(u32, out_obj->package.elements[CAP_CODE_TYPE_IDX].bu=
ffer.length,
>  > +             sizeof(cap_hdr->code_type)));
>  >      cap_hdr->fw_version =3D
>  >          out_obj->package.elements[CAP_FW_VER_IDX].integer.value;
>  >      cap_hdr->code_rt_version =3D
>  >          out_obj->package.elements[CAP_CODE_RT_VER_IDX].integer.value;
>  >      memcpy(&cap_hdr->drv_type,
>  >             out_obj->package.elements[CAP_DRV_TYPE_IDX].buffer.pointer=
,
>  > -           out_obj->package.elements[CAP_DRV_TYPE_IDX].buffer.length)=
;
>  > +           min_t(u32, out_obj->package.elements[CAP_DRV_TYPE_IDX].buf=
fer.length,
>  > +             sizeof(cap_hdr->drv_type)));
>  >      cap_hdr->drv_rt_version =3D
>  >          out_obj->package.elements[CAP_DRV_RT_VER_IDX].integer.value;
>  >      cap_hdr->drv_svn =3D
>  >          out_obj->package.elements[CAP_DRV_SVN_IDX].integer.value;
>  >      memcpy(&cap_hdr->platform_id,
>  >             out_obj->package.elements[CAP_PLAT_ID_IDX].buffer.pointer,
>  > -           out_obj->package.elements[CAP_PLAT_ID_IDX].buffer.length);
>  > +           min_t(u32, out_obj->package.elements[CAP_PLAT_ID_IDX].buff=
er.length,
>  > +             sizeof(cap_hdr->platform_id)));
>  >      memcpy(&cap_hdr->oem_id,
>  >             out_obj->package.elements[CAP_OEM_ID_IDX].buffer.pointer,
>  > -           out_obj->package.elements[CAP_OEM_ID_IDX].buffer.length);
>  > +           min_t(u32, out_obj->package.elements[CAP_OEM_ID_IDX].buffe=
r.length,
>  > +             sizeof(cap_hdr->oem_id)));
>  >      cap_hdr->oem_info_len =3D
>  >          out_obj->package.elements[CAP_OEM_INFO_IDX].buffer.length;
>  >
>  > --
>  > 2.55.0
>  >
>
>
