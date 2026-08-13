Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B83D47F2FA
	for <linux-acpi@vger.kernel.org>; Thu, 13 Aug 2026 13:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786628404; cv=none; b=R/Yl8sXBPndYctUiPG9zW4ID5oirpDRZ/qM/+0wezj3DiqmgI5u6xnO6raGp0ma/3PwMKBWJpPOGCuvYrZFjcl2e7ET4fopKxXLXHZcG6Tu2p3VKtNT9d6OXz/GLDr6xOTcdRlnXjQi/UMBmFyOD1hJD+KJwUItIEcm2FZWwk1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786628404; c=relaxed/simple;
	bh=Yt71PdNAuF4tbg0N3KwNIduV8vLoYAUtuTU5KBbqH/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p7MWbUF4j+eUw29/5tp+VTJlHI7qwqcIHdoMABNUuyEkAbkl8WJTK/gT7RiaqvD5UkdODy8A/w7HQwR4fG1SVlVH9bmdKveT6K3AHRM8H+7z5d5/nJUmCybkQ7NCCRuMUBNG0f9EWW/LDg+59LAmgrcjAfbQxPYXob1WsPeqfR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i86icHCK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i86icHCK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E569E1F00ADF
	for <linux-acpi@vger.kernel.org>; Thu, 13 Aug 2026 13:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786628400;
	bh=IDvrtM2j5bM3scjT80piDheU4wqcOWmJrKcAsl8N5wA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=i86icHCKDss+Ffr5CmJya6nIRNGd4mKdYjD80vGZig9net7P6GiFbyK6EieEd2IBI
	 vJg35JZHGy5T4zu0/KPMrxhm2E4p6dg6kHj/oSzfklPZbypbTKteDKjDqgDuqOz2wp
	 ffEoAoAqm/nR+oNlDJYTGBcFT1QX2KeU+U9gKsNTPYNjbceuSh+lLVE24Xy0KgVXbh
	 52EtpwZ84JWRyEAd8cJ5KMkF7Ku6gAT5hU5JaF81JXA/oIgBoZWkM8wY6GsrEEfllX
	 4+M+CBiOk2fRtLzCtF3OD7ngLHBAxlKQQ3NJ5+Soxjy/qWqZ2MB8cXkhFIJEe5RJ5Y
	 XKpXV0aHLpEcw==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5b29599b81cso939930e87.1
        for <linux-acpi@vger.kernel.org>; Thu, 13 Aug 2026 06:40:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpPmBnlWYXdjGIPBKDsIVc8SiXC+Uimkikry9TKRkHXsDPKu72vILxtctLVinDVUgZfftAvYKtHz+Xl@vger.kernel.org
X-Gm-Message-State: AOJu0YywaevTN0uTfUNbgUNA2bKxiI5H1Sr3yHvO5sH4Tzo53QLuS+q/
	dRK3SH6Gd5SA+v94VzkiDAN2vYp/f9TZdUAPoriTo7Wt+9B7GLT8QDazkQxumX4odv6ic5UYOx2
	TQFKNWEsCXDU6SrDph4oUPu21jaFkuM0=
X-Received: by 2002:a05:6512:8053:b0:5b1:5237:c351 with SMTP id
 2adb3069b0e04-5b453f3143emr664102e87.2.1786628399306; Thu, 13 Aug 2026
 06:39:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813-acpica-pcc-field-leak-v1-1-3d6c5f0eb557@debian.org>
In-Reply-To: <20260813-acpica-pcc-field-leak-v1-1-3d6c5f0eb557@debian.org>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 13 Aug 2026 15:39:37 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0isQYRN9aZCmWty-kZpjHvZWyJT2AnRXs9RDszy7b5TkA@mail.gmail.com>
X-Gm-Features: AUfX_mz7sT_ESz6rllVVtXacUSOPLqedLRCDcTOyYKo2v_zQcV5yChJYZxkPb1o
Message-ID: <CAJZ5v0isQYRN9aZCmWty-kZpjHvZWyJT2AnRXs9RDszy7b5TkA@mail.gmail.com>
Subject: Re: [PATCH] ACPICA: Fix memory leak at acpi_ds_create_field()
To: Breno Leitao <leitao@debian.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Saket Dumbre <saket.dumbre@intel.com>, 
	Len Brown <lenb@kernel.org>, Sudeep Holla <sudeep.holla@kernel.org>, 
	Bob Moore <robert.moore@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org, catalin.marinas@arm.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 3:35=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
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
> Fixes: 0acf24ad7e10 ("ACPICA: Add support for PCC Opregion special contex=
t data")
> Signed-off-by: Breno Leitao <leitao@debian.org>

As per Documentation/driver-api/acpi/linuxized-acpica.rst, please
submit a pull request with this change to the upstream ACPICA project
on GitHub.  The Linux patch will become applicable when there is a
corresponding commit upstream.

> ---
>  drivers/acpi/acpica/dsfield.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/acpica/dsfield.c b/drivers/acpi/acpica/dsfield.=
c
> index d7d56cc600d31..f7e503bf57c87 100644
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
> base-commit: 28d012efb4327f9c75d5e042a7c91e9a542efa98
> change-id: 20260813-acpica-pcc-field-leak-8f676f55179b
>
> Best regards,
> --
> Breno Leitao <leitao@debian.org>
>
