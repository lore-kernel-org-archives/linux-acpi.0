Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD8A37A4AF
	for <linux-acpi@vger.kernel.org>; Tue, 23 Jun 2026 14:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782225952; cv=none; b=jvjstL6pCrmUwPSC8SP2wnNDZxj46eQ1jLRmSwWm7Spem5L4DHtAZeU8dqPpoL7ZlL7EPmXeU4b80hlH6yWSqy99He3CGDnoW7b+OaXzZvxqZAT9GcLtkgdT/k3s4nuSDKikl841Vdlva+dWJOlUbQU+CQspj/Th/gT0V9h8UTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782225952; c=relaxed/simple;
	bh=LTwsTmF49w2cMZ2gKSHh+RfSYdqNOmXzy955xiHaf9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=osByFsJDGYFxQhVH8WUqVHa3TewJJ4OwDJ5PDTVflwWcawmTWG6XEN68IpkfPkWvHfkLBfsvlk7n9Dfs5OyPNV22juUf39Yr6xuNi02Kdpec676pm+koKqMvVWs6ipFxPdNlFMXL7d749pZ4coAFnuw3IOp8/sexEzsjX4A0Ae0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NQ2D4psq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQ2D4psq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 805251F00A3E
	for <linux-acpi@vger.kernel.org>; Tue, 23 Jun 2026 14:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782225951;
	bh=lWjRkB6fqgtfBUQp5LkWwjqUm202MAntr0ZdfPaXI8M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=NQ2D4psqZHJSdFFSzkJenZbJFG2Klkn/OKVuUSkUPqT3FXD9wdWo+d4sKE/NxWYsF
	 M7y/9TrBcrFeCVM6aOktx5uKG1w3bObwY1qr6H1SFtYGLfuvRI54lcElCNpTT9IChh
	 2JN8TGSPE5Z1U7xS34qvHZRo6cVeJSLShNBXfavJJRDgsiiOFCjdHZPHwFfi1tfPr8
	 8W21yjek3pwzApT0tVFJqMo7We+ZIwx5caOHFES8wWUAd14l8ASx+tp6Z6lJWZsdxi
	 R3Pr+hBqfjtSmmwNo0E+doLVEe+6uYZXErM2CTx/xiu5NMVfa4KnJmHf1QFJnnbLO7
	 gRDJfPaNKTvSg==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5ad49da7123so1092700e87.0
        for <linux-acpi@vger.kernel.org>; Tue, 23 Jun 2026 07:45:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/vVmpwsp2/Akb6lD3cuqcRwXUThqvuZFGB1qvFbm3LjRZx68d8QLzvgG7hwf/ewH0PVXlbDeHYj1x0@vger.kernel.org
X-Gm-Message-State: AOJu0YwTocwpx3691jyCV4vsWqfZU16cgWEz8FnVYKCpAMxv3VzAn2Hs
	Ep4VHWSrTLoiOYf2MUF+KhRmw6vFua0GtSF+btOoIR8+eCbptTAbC3xVmx1hh56fu5q7bYWlFyR
	BJ/tWw2moDqXOZmtTC5eq5F+ZpzVioxY=
X-Received: by 2002:a05:6512:611:20b0:5ad:5bc8:3047 with SMTP id
 2adb3069b0e04-5ad695a00acmr791283e87.21.1782225949984; Tue, 23 Jun 2026
 07:45:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623055703.3793586-1-guanghuifeng@linux.alibaba.com>
In-Reply-To: <20260623055703.3793586-1-guanghuifeng@linux.alibaba.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 23 Jun 2026 16:45:38 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g+bCE5rR_X6Bc0asZA0qFJ=u8M9WrAv7EZg_=YxL8nVg@mail.gmail.com>
X-Gm-Features: AVVi8CdHcTL-tlrpE3weGd_CvE4X8v1TWyJbdoz26Jj_l3wZl_o6mUIsHc2z1vw
Message-ID: <CAJZ5v0g+bCE5rR_X6Bc0asZA0qFJ=u8M9WrAv7EZg_=YxL8nVg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: PRM: Fix off-by-one in efi_pa_va_lookup() address
 range check
To: Guanghui Feng <guanghuifeng@linux.alibaba.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, alikernel-developer@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 7:57=E2=80=AFAM Guanghui Feng
<guanghuifeng@linux.alibaba.com> wrote:
>
> The boundary check in efi_pa_va_lookup() uses a strict less-than
> comparison (md->phys_addr < pa), which incorrectly excludes the case
> where the lookup address equals the start of an EFI memory descriptor's
> physical address range.
>
> This causes a lookup failure when a PRM handler address happens to be
> at the exact start of a runtime memory region, as the descriptor that
> should match gets skipped.
>
> Fix this by using a non-strict comparison (md->phys_addr <=3D pa) to
> include the region start address, consistent with the standard
> __efi_mem_desc_lookup() implementation in drivers/firmware/efi/efi.c.
>
> Fixes: cefc7ca46235 ("ACPI: PRM: implement OperationRegion handler for th=
e PlatformRtMechanism subtype")
> Signed-off-by: Guanghui Feng <guanghui.fgh@linux.alibaba.com>
> ---
>  drivers/acpi/prmt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
> index 7f5851371e5f..fcc17ce0a88e 100644
> --- a/drivers/acpi/prmt.c
> +++ b/drivers/acpi/prmt.c
> @@ -80,7 +80,7 @@ static u64 efi_pa_va_lookup(efi_guid_t *guid, u64 pa)
>
>         for_each_efi_memory_desc(md) {
>                 if ((md->attribute & EFI_MEMORY_RUNTIME) &&
> -                   (md->phys_addr < pa && pa < md->phys_addr + PAGE_SIZE=
 * md->num_pages)) {
> +                   (md->phys_addr <=3D pa && pa < md->phys_addr + PAGE_S=
IZE * md->num_pages)) {
>                         return pa_offset + md->virt_addr + page - md->phy=
s_addr;
>                 }
>         }
> --

Sashiko sees a problem with this change which might cause an absent
buffer to be mapped incorrectly:

https://sashiko.dev/#/patchset/20260623055703.3793586-1-guanghuifeng%40linu=
x.alibaba.com

Some more complex changes appear to be needed to address the problem at han=
d.
