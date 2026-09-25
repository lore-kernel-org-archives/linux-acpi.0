Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6560F4D09F4
	for <linux-acpi@vger.kernel.org>; Fri, 25 Sep 2026 15:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790350695; cv=none; b=L34gUW9YQFBsU+qbv1El4jekEh6fkedR5Pp1F1UEWJmyRDe+O7bLrBtoSFwRpEdz0ji1ftItBI5anj3R2j9P5tnWLs3dcOUgGaJcQKty4s/dR4fiHiKgt3cbZWuGJKvFhR8DhcmCO5A3u4so0oxqUa/5Uw7AFhKwfkOWrNmyzvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790350695; c=relaxed/simple;
	bh=R9ZvPoqCku9almMzakLa7ZXEB9R9SYeZaEl4deCFJP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gEE7pz5yoESVwWkrfwnblNm055PvHxvZt7CQCJoCmdhZJfvi3y7PNwPkg1pUss9oFge4VWGOq/ovxsZvns/iw5REFfH+JjRNLh6XS6s7gJKKgKr7/eGjEeigHKp7AdYHDOcCvf22UGhZ5tjaPTMYpQCNAFFfea+uShr7ydzk01A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fPIAL4E9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fPIAL4E9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26BEA1F00893
	for <linux-acpi@vger.kernel.org>; Fri, 25 Sep 2026 15:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790350694;
	bh=Wek62W+kRFsKJPtoX0m2rFT+XwrRF1I/2Ks22JZyF/U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=fPIAL4E9HH17kwCnrccNKWRfxj4ZZ2mwyTbFx35p/tvmuglTsd6s3tWTbMXfxcrhJ
	 BdEBDfhYzld4S8szpYmwOlTNy9BLwYUn83pRNubV+q5PtozZsalyU7rIYrRTTiwKUk
	 NCK4J2x4ZBMuyYlyQ0IzTR2rnNistBYiNm4C7eiBewR1Jv/AVgCMkKhrUVt2pi2FXK
	 yjIbb7MEdwmf5skOYikrLXs1cTTM0N8oWIaTw73JtBRF+EfTqVgPsJy75tcB2xdXOV
	 QjACAJgszIQBxQGbekqYpYuqY4Vu+nyZxhkkjeVTnLc+kMbpmH+r3D7GY1v2ZousFF
	 /FQ4y64zhE2BQ==
Received: by mail-lr2-f35.google.com with SMTP id 38308e7fff4ca-3a659495608so181031fa.2
        for <linux-acpi@vger.kernel.org>; Fri, 25 Sep 2026 08:38:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzWaXzZxGhIkPl49aV7dGLi9WUMXks3O8+Qm1AL3UfjhFoEvNjsqUT6hyU5HWCMWeW70BcxBpLQlbP9@vger.kernel.org
X-Gm-Message-State: AFuF++m4FGaBRbcvVYcc+oExCU8EBtnV1A2XcjAJ5glZprc8ep+bCPXY
	X3lv63cvjk8Z/d4D6fWm8c/AMJZjvjYHLJ1Ad96XvN/UjS3OSvMOAz0Jghhb5RvrTo40kTYCJw3
	TmU0nMM5gczZtrkfx04f6Yn/o6C6lHJ4=
X-Received: by 2002:a05:651c:502:b0:3a3:476:2e37 with SMTP id
 38308e7fff4ca-3a63dd61f6fmr14973111fa.6.1790350692193; Fri, 25 Sep 2026
 08:38:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260925-acpica-pcc-field-leak-v2-1-e37008e715af@debian.org>
In-Reply-To: <20260925-acpica-pcc-field-leak-v2-1-e37008e715af@debian.org>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 25 Sep 2026 17:36:34 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jfqfg2VHqZ+x0hb53vvBZBVRphmdYRTusyKq2DBdb2XQ@mail.gmail.com>
X-Gm-Features: AclHuK_FYPVEltT73pW_e9bZj6mBFs4ygpg75eVubvcIjsZZXuj7Kj_C_2zOyt4
Message-ID: <CAJZ5v0jfqfg2VHqZ+x0hb53vvBZBVRphmdYRTusyKq2DBdb2XQ@mail.gmail.com>
Subject: Re: [PATCH v2] ACPICA: Fix memory leak at acpi_ds_create_field()
To: Breno Leitao <leitao@debian.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Saket Dumbre <saket.dumbre@intel.com>, 
	Len Brown <lenb@kernel.org>, Sudeep Holla <sudeep.holla@kernel.org>, 
	Bob Moore <robert.moore@intel.com>, 
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, 
	Pawel Chmielewski <pawel.chmielewski@intel.com>, Erik Kaneda <erik.kaneda@intel.com>, 
	Kyle Pelton <kyle.d.pelton@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org, thepacketgeek@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 4:35=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:
>
> acpi_ds_create_field() allocates internal_pcc_buffer for operation
> regions in the PCC address space.
>
> The function runs once per field, so a second field on the
> same region overwrites the pointer and orphans the previous buffer.
>
> The matching ACPI_FREE() in acpi_ut_delete_internal_obj() only ever sees
> the last one.
>
> An arm64 platform whose SSDT declares regions with multiple fields each
> leaks two buffers at boot, as detected by kmemleak:
>
>   unreferenced object 0xffff000051e65400 (size 192):
>     comm "swapper/0", pid 1, jiffies 4294668436
>     backtrace (crc 0):
>       __kmalloc_noprof
>       acpi_ds_create_field
>       acpi_ds_load2_end_op
>       acpi_ds_exec_end_op
>       acpi_ps_parse_loop
>       acpi_ps_parse_aml
>       acpi_ns_load_table
>       acpi_load_tables
>       acpi_init
>
> Do not allocate a region if it was previously allocated before,
> preserving the current design, but, not leaking memory.
>
> Fixes: aa6ec56b574d ("ACPICA: ACPI 6.3: add PCC operation region support =
for AML interpreter")
> Link: https://github.com/open-acpica/acpica/commit/c71849d476bb5f97ca1867=
849e893368e12a69e6
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
> Changes in v2:
> - Got the fix into ACPI CA first, and now respining this one with the
>   Link to ACPI CA change.
> - Link to v1: https://patch.msgid.link/20260813-acpica-pcc-field-leak-v1-=
1-3d6c5f0eb557@debian.org
> ---
>  drivers/acpi/acpica/dsfield.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/acpica/dsfield.c b/drivers/acpi/acpica/dsfield.=
c
> index d7d56cc600d318..f7e503bf57c87c 100644
> --- a/drivers/acpi/acpica/dsfield.c
> +++ b/drivers/acpi/acpica/dsfield.c
> @@ -522,7 +522,8 @@ acpi_ds_create_field(union acpi_parse_object *op,
>         }
>
>         if (info.region_node->object->region.space_id =3D=3D
> -           ACPI_ADR_SPACE_PLATFORM_COMM) {
> +           ACPI_ADR_SPACE_PLATFORM_COMM &&
> +           !region_node->object->field.internal_pcc_buffer) {
>                 region_node->object->field.internal_pcc_buffer =3D
>                     ACPI_ALLOCATE_ZEROED(info.region_node->object->region=
.
>                                          length);
>
> ---

Applied as 7.4 material, thanks!
