Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794331387;
	b=3VP+j+Lqr44ahepaLl1DcV2mttFvhJj5h5TCznonQI709bK7sm/h0ui8zI7nCmoQz6o+
	 /DrCwNmrFLhOrYWzGILvrWgP4uMk56RLf3syttZZXVPHAzQns3nyXOcL2ccup7tLdT3Kj
	 9vB3CHeSeszMZpWBk5lwsmkl/+dCWSXV80Rk9cvfBQpVaq1NZqgqgRWx+n5h+LD+b/jrP
	 C4JWFVm87phWuTpzDzLz8bT7iR/iVunnona3uL9EgMwXQJlYYIvNq5XrKuEVh566wiPlU
	 FcE3A/sTlpf5OgTTx600cG/xqJeUcIqoLWdgXug0OYBnsL8WLqDQhwE2WTmybfsV1SA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794331387;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=58+5W24TEkZL4yyEJ0XD+8BOXeOxVo1XZoPC+dOeuTw=;
	b=IpmAU+3f/6sdNYsmwXxr2yAKnfsjQiWis2v7HWtpeVzlKV0BuPBeV3eqkatZxtQ9xa6d
	 j8vBu91L2ma+b8OKISHRQFFtv0YKdOYFwjSmqYVaKl2oDPzI/wCrXSs2D2S9H6kJcjJhZ
	 GY+K0IhNIGkIgF8r1jYbTMNtHpUFtPF8FFEhu1KVuLqPboCmwFK0VvQZwsTZb5TRXxNXu
	 JnvK5Ge/p+STn4hCWrb7cVCdByKA4cqgOmAkgZfrkeuj+F67D82N/Q7R3nCAB7OpHXHlU
	 Xvfd2gLcLA01wC3tlog6UxYUdHerq5dx9ilpUy8WryCo81Ll1UWCUpZEnxkxMGrLqjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TyUbh0bv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA91606A32A
	for <linux-acpi@vger.kernel.org>; Tue, 10 Nov 2026 17:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TyUbh0bv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59BB41F008A5
	for <linux-acpi@vger.kernel.org>; Tue, 10 Nov 2026 17:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794331386;
	bh=58+5W24TEkZL4yyEJ0XD+8BOXeOxVo1XZoPC+dOeuTw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=TyUbh0bvnMOuR4VhbkSZNObcwkVZSea2JMUlyOl3AVINgwZ527x/jTHquQj3psbQ7
	 CASNe1Kvtz5VFY9Ml+FYmKzT61urywvIPDzv0HJjP8qAoGKA6HhTzUstkQpobJnQfb
	 jNquPR1Qaqj4OxzuyDpUYObRG5ezGE+LSitoW1whg4t4zXkjhibADnZ1zh71uy9fKl
	 /1APe7P1CxRos81etD1DOA6W2uArqrq8BT4JaHvH4ghHDcXKBL5RkYUpZSBnACMD43
	 +4Khn1i2kBBVswNGnFTVC4xW0lTI3mWpTQ/OdnvLLjZc4mLTrNmoF6DiLjhSgE4fKO
	 rjfZYkoqJA0Hw==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5c14f6f58aeso2106692e87.2
        for <linux-acpi@vger.kernel.org>; Tue, 10 Nov 2026 09:23:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErE5P/ECEWbSf+rAdzvIvFD8CDRhsx3oC0sN9Jdl7s5uwdvqLUfbdIxbCY3GaaCXuPYO0jrQ9pVXhTdt@vger.kernel.org
X-Gm-Message-State: APuU4Z/7WYDBkUxic0TT/GEW2ygdtW4GBbGCG8QVjuj7TUC3tKp0C09u
	O4L+7dU7FzRbKQP7KBTpZGxmvvPi24ojwID3mhqx5nnfklMgfWOYT2Q7c/VZ20B8fWGW6rSo2pv
	H029QPb33yVR7MsORnuWDob3CSMHPdjw=
X-Received: by 2002:a05:6512:3d1a:b0:5bf:f76f:b5ff with SMTP id
 2adb3069b0e04-5c156ed6238mr1053807e87.52.1794331384727; Tue, 10 Nov 2026
 09:23:04 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103114112.74527-1-k.chen@smail.nju.edu.cn>
In-Reply-To: <20261103114112.74527-1-k.chen@smail.nju.edu.cn>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 10 Nov 2026 18:22:51 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gr0QiNJb7QGL_7NDyAKObDnSmzBrcv2ax+AgTV53oEVQ@mail.gmail.com>
X-Gm-Features: AclHuK9kHKKxQ7CLRz11_FBi1uSmkd0AJNzNDMwSQ9tx4V8LhEsjPNpkvbza4aM
Message-ID: <CAJZ5v0gr0QiNJb7QGL_7NDyAKObDnSmzBrcv2ax+AgTV53oEVQ@mail.gmail.com>
Subject: Re: [PATCH] PCI/ACPI: validate _HPX type 3 record lengths
To: Kang Chen <k.chen@smail.nju.edu.cn>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Alexandru Gagniuc <mr.nuke.me@gmail.com>, linux-acpi@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 12:41=E2=80=AFPM Kang Chen <k.chen@smail.nju.edu.cn>=
 wrote:
>
> program_type3_hpx_record() computes the expected record length as
> 3 + desc_count * 14 in 32 bits.  A firmware-provided desc_count of
> 0x80000000 makes this wrap to 3, so the package count check passes for
> a three-element record and the loop then walks far beyond the elements
> array, feeding out-of-bounds data into PCI config space writes.  The
> record is also indexed at fields[1] and fields[2] before its length has
> been checked.
>
> Reject records with fewer than three elements, verify that fields[1]
> and fields[2] are integers, and reject desc_count values for which the
> expected length would overflow.  Reject revision or descriptor count
> values that do not fit in 32 bits instead of silently truncating them.
> Use an unsigned loop index and advance the register pointer explicitly
> so the walk cannot overflow either.  In acpi_run_hpx(), reject records
> that do not have at least the two elements needed to read the type and
> revision.
>
> Fixes: f873c51a155a ("PCI/ACPI: Implement _HPX Type 3 Setting Record")
> Signed-off-by: Kang Chen <k.chen@smail.nju.edu.cn>

From the ACPI support perspective

Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

> ---
>  drivers/pci/pci-acpi.c | 24 +++++++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index 1150f2fbabf4..b15700523810 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -607,12 +607,28 @@ static acpi_status program_type3_hpx_record(struct =
pci_dev *dev,
>         u32 desc_count, expected_length, revision;
>         union acpi_object *reg_fields;
>         struct hpx_type3 hpx3;
> -       int i;
> +       u32 i;
> +
> +       if (record->package.count < 3)
> +               return AE_ERROR;
> +
> +       if (fields[1].type !=3D ACPI_TYPE_INTEGER ||
> +           fields[2].type !=3D ACPI_TYPE_INTEGER)
> +               return AE_ERROR;
> +
> +       if (fields[1].integer.value > U32_MAX)
> +               return AE_ERROR;
>
>         revision =3D fields[1].integer.value;
>         switch (revision) {
>         case 1:
> +               if (fields[2].integer.value > U32_MAX)
> +                       return AE_ERROR;
> +
>                 desc_count =3D fields[2].integer.value;
> +               if (desc_count > (UINT_MAX - 3) / 14)
> +                       return AE_ERROR;
> +
>                 expected_length =3D 3 + desc_count * 14;
>
>                 if (record->package.count !=3D expected_length)
> @@ -622,10 +638,11 @@ static acpi_status program_type3_hpx_record(struct =
pci_dev *dev,
>                         if (fields[i].type !=3D ACPI_TYPE_INTEGER)
>                                 return AE_ERROR;
>
> +               reg_fields =3D fields + 3;
>                 for (i =3D 0; i < desc_count; i++) {
> -                       reg_fields =3D fields + 3 + i * 14;
>                         parse_hpx3_register(&hpx3, reg_fields);
>                         program_hpx_type3(dev, &hpx3);
> +                       reg_fields +=3D 14;
>                 }
>
>                 break;
> @@ -661,7 +678,8 @@ static acpi_status acpi_run_hpx(struct pci_dev *dev, =
acpi_handle handle)
>
>         for (i =3D 0; i < package->package.count; i++) {
>                 record =3D &package->package.elements[i];
> -               if (record->type !=3D ACPI_TYPE_PACKAGE) {
> +               if (record->type !=3D ACPI_TYPE_PACKAGE ||
> +                   record->package.count < 2) {
>                         status =3D AE_ERROR;
>                         goto exit;
>                 }
> --
> 2.34.1
>
