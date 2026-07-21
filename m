Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468072367B8
	for <linux-acpi@vger.kernel.org>; Tue, 21 Jul 2026 12:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784637433; cv=none; b=LynhRqzsPRrqy1VCklTAmsrqgDOvvE6SZKozJu5fXYjOsFZirEb3NFwJflD3GuBvQ76JXpItmb+SaWWVoRRUBhyvipUuwjchTbi2TSOngmimfuMmSTP8qTmiGKDiYQsoOaT9zlg8vqnY911M/6e9Pc8VdlUgh2MYJTJCKAM1YVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784637433; c=relaxed/simple;
	bh=2N2bWLBziZWnTmUBq9OQWodjZU1YiHxGCakcilVhWcc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mP9InCyDMrTfEonG/uDuHY6v8Gt6Lx4tvNLa4RhyLqy+lDS1nwB+qCRasWfttGAWCKbQbZ/TAIRAUhC7UQA89F0sOWO1H/sOByesEc4imuiS3PleHnPJuDrk0xXFdamZPBtp+x1MpdSVeMbnZaZkrEuBHskomH9PZE9R5/r2xAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VPhNWc/V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VPhNWc/V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00F971F00A3F
	for <linux-acpi@vger.kernel.org>; Tue, 21 Jul 2026 12:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784637432;
	bh=K6e9N94ZAOgU6TNlko5uvFwfIB/lZzewzichH04mlcw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=VPhNWc/VqgR4ulb+qJJnVPv1H2xyg1utYhSAxMFCr8S2Z65J7GQRQpSAtpR7gBJSH
	 A2q7rvmf2WUoLy7nbb8zkk0MbEo+DCTRkWpEFZqiehH9ucdJq3UdPXt5Ltc8+/im1Q
	 1Y84yhNWjL/5TWm+fMR0lUeB+hXQ62bDxGLsNSWoX4lxrCUbMkgNVZeDakryPNjn5G
	 74mWWfj1S0Zypnxd/cRX/rziI3BI7UALo5+FNnmPVgKEsawbB/HeqGEK6CqOKiPU9o
	 nuEafDAM137BCIfRTbIupCFZNfw2XaVuecoUMowJzH3kfimcNdGgkCn0y+lbaQxo7Q
	 4oqsfwPYkjxfg==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5aeb8c19017so13888674e87.0
        for <linux-acpi@vger.kernel.org>; Tue, 21 Jul 2026 05:37:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Ror/+ER2FP3xZh2UofrJmHp8El1epgsQN7UnJmdWoVulvRo0Smei63n7tCW1AXjPcftSQcJ16LbEil5@vger.kernel.org
X-Gm-Message-State: AOJu0YyO35BXo3YLYfp/PWLMxJKl5rnYYaiPR+gtKD0I4PTByDZ0rA3i
	YQzXoUr/OpF7C+r8gYP0hX+lfsoBxMKc5njyioYCXQh7Jj9LJcPBKyE16UH8wH4VcyQBoFqdwCq
	kNkkLAwyAWDB8BPv5uLRT5HuydoewyQ8=
X-Received: by 2002:a05:6512:3408:b0:5b2:925d:6c6f with SMTP id
 2adb3069b0e04-5b2925d6db3mr4927050e87.34.1784637430388; Tue, 21 Jul 2026
 05:37:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706094141.82438-1-pengpeng@iscas.ac.cn>
In-Reply-To: <20260706094141.82438-1-pengpeng@iscas.ac.cn>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 21 Jul 2026 14:36:51 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hd-mDkE_PFUE6dOc0QKxEL0v+zNBdtgHf8+Bau1Vncpg@mail.gmail.com>
X-Gm-Features: AUfX_myq2txhVH9wMy4GLufMhNfrCMmvFTEBPWhcaaEz218gSP_ZNbNG75ruJ9A
Message-ID: <CAJZ5v0hd-mDkE_PFUE6dOc0QKxEL0v+zNBdtgHf8+Bau1Vncpg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: FPDT: validate table and record lengths
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 6, 2026 at 11:41=E2=80=AFAM Pengpeng Hou <pengpeng@iscas.ac.cn>=
 wrote:
>
> FPDT records are supplied by firmware and are walked through
> length fields stored in the table itself.
>
> Check the main-table entry length before reading an entry, check
> the mapped subtable length before remapping it, and check each
> record length before saving a typed record pointer for sysfs.
>
> This keeps malformed firmware records from being interpreted as
> complete resume, suspend, or boot records when the current item
> is shorter than the structure consumed by the driver.
>
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
>  drivers/acpi/acpi_fpdt.c | 53 +++++++++++++++++++++++++++++++++++-----
>  1 file changed, 47 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/acpi/acpi_fpdt.c b/drivers/acpi/acpi_fpdt.c
> index e75dd28d31a9..79191ed20f76 100644
> --- a/drivers/acpi/acpi_fpdt.c
> +++ b/drivers/acpi/acpi_fpdt.c
> @@ -168,7 +168,7 @@ static int fpdt_process_subtable(u64 address, u32 sub=
table_type)
>         struct fpdt_subtable_header *subtable_header;
>         struct fpdt_record_header *record_header;
>         char *signature =3D (subtable_type =3D=3D SUBTABLE_FBPT ? "FBPT" =
: "S3PT");
> -       u32 length, offset;
> +       u32 length, offset, remaining;
>         int result;
>
>         if (!fpdt_address_valid(address)) {
> @@ -182,10 +182,17 @@ static int fpdt_process_subtable(u64 address, u32 s=
ubtable_type)
>
>         if (strncmp((char *)&subtable_header->signature, signature, 4)) {
>                 pr_info(FW_BUG "subtable signature and type mismatch!\n")=
;
> +               acpi_os_unmap_memory(subtable_header, sizeof(*subtable_he=
ader));
>                 return -EINVAL;
>         }
>
>         length =3D subtable_header->length;
> +       if (length < sizeof(*subtable_header)) {
> +               pr_err(FW_BUG "Invalid FPDT subtable length %u.\n", lengt=
h);
> +               acpi_os_unmap_memory(subtable_header, sizeof(*subtable_he=
ader));
> +               return -EINVAL;
> +       }
> +
>         acpi_os_unmap_memory(subtable_header, sizeof(*subtable_header));
>
>         subtable_header =3D acpi_os_map_memory(address, length);
> @@ -194,17 +201,29 @@ static int fpdt_process_subtable(u64 address, u32 s=
ubtable_type)
>
>         offset =3D sizeof(*subtable_header);
>         while (offset < length) {
> -               record_header =3D (void *)subtable_header + offset;
> -               offset +=3D record_header->length;
> +               remaining =3D length - offset;
> +               if (remaining < sizeof(*record_header)) {
> +                       pr_err(FW_BUG "Truncated FPDT record header.\n");
> +                       result =3D -EINVAL;
> +                       goto err;
> +               }
>
> -               if (!record_header->length) {
> -                       pr_err(FW_BUG "Zero-length record found in FPTD.\=
n");
> +               record_header =3D (void *)subtable_header + offset;
> +               if (record_header->length < sizeof(*record_header) ||
> +                   record_header->length > remaining) {
> +                       pr_err(FW_BUG "Invalid FPDT record length %u.\n",
> +                              record_header->length);
>                         result =3D -EINVAL;
>                         goto err;
>                 }
> +               offset +=3D record_header->length;
>
>                 switch (record_header->type) {
>                 case RECORD_S3_RESUME:
> +                       if (record_header->length < sizeof(*record_resume=
)) {
> +                               result =3D -EINVAL;
> +                               goto err;
> +                       }
>                         if (subtable_type !=3D SUBTABLE_S3PT) {
>                                 pr_err(FW_BUG "Invalid record %d for subt=
able %s\n",
>                                      record_header->type, signature);
> @@ -221,6 +240,10 @@ static int fpdt_process_subtable(u64 address, u32 su=
btable_type)
>                                 goto err;
>                         break;
>                 case RECORD_S3_SUSPEND:
> +                       if (record_header->length < sizeof(*record_suspen=
d)) {
> +                               result =3D -EINVAL;
> +                               goto err;
> +                       }
>                         if (subtable_type !=3D SUBTABLE_S3PT) {
>                                 pr_err(FW_BUG "Invalid %d for subtable %s=
\n",
>                                      record_header->type, signature);
> @@ -236,6 +259,10 @@ static int fpdt_process_subtable(u64 address, u32 su=
btable_type)
>                                 goto err;
>                         break;
>                 case RECORD_BOOT:
> +                       if (record_header->length < sizeof(*record_boot))=
 {
> +                               result =3D -EINVAL;
> +                               goto err;
> +                       }
>                         if (subtable_type !=3D SUBTABLE_FBPT) {
>                                 pr_err(FW_BUG "Invalid %d for subtable %s=
\n",
>                                      record_header->type, signature);
> @@ -317,7 +344,21 @@ static int __init acpi_init_fpdt(void)
>         }
>
>         while (offset < header->length) {
> +               if (header->length - offset < sizeof(*subtable)) {
> +                       pr_err(FW_BUG "Truncated FPDT subtable entry.\n")=
;
> +                       result =3D -EINVAL;
> +                       goto err_subtable;
> +               }
> +
>                 subtable =3D (void *)header + offset;
> +               if (subtable->length < sizeof(*subtable) ||
> +                   subtable->length > header->length - offset) {
> +                       pr_err(FW_BUG "Invalid FPDT subtable entry length=
 %u.\n",
> +                              subtable->length);
> +                       result =3D -EINVAL;
> +                       goto err_subtable;
> +               }
> +
>                 switch (subtable->type) {
>                 case SUBTABLE_FBPT:
>                 case SUBTABLE_S3PT:
> @@ -330,7 +371,7 @@ static int __init acpi_init_fpdt(void)
>                         /* Other types are reserved in ACPI 6.4 spec. */
>                         break;
>                 }
> -               offset +=3D sizeof(*subtable);
> +               offset +=3D subtable->length;
>         }
>         return 0;
>  err_subtable:
> --

Applied as 7.3 material, thanks!
