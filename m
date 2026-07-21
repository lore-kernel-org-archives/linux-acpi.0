Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E43B3783DE
	for <linux-acpi@vger.kernel.org>; Tue, 21 Jul 2026 13:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784642341; cv=none; b=s5Lwfa0XfBFCkqKyXBzf6TmhLxzDI5ilJOt6PiIgM+/Am3Nt560l5o/zVyoVmrqTFS7Vt1AdWIrRl+v40Z/21VyL4Xe9IEdFRA0a5DVoW8dNiplMJsdK4A5kjUWxDbW1VK0C/7ljZGr9xtZ9cTQSQ/GI4CFymBscngJNUSw7Uh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784642341; c=relaxed/simple;
	bh=6A4f6zce2CzIpVWIoVC34FaCorwhUB4O775jmfLw2cg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kdZ/Js92Hf1wviY5XlbNiuvbxnVoN66Qt8LhloEe9n6oPGgcvks75Ndb4w51DMx3tJnVtH8BZZLAI3IoDOzKfpgA+Hg3EGH4+WQxEYn3tnJNxEo6F6rIuk3EBbNuVd39RKQ6o2KNyJAlX0XCoLEB4+yda+5vyhy3yitnlAB+uqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ihN3/vh9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ihN3/vh9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74EAD1F00A3E
	for <linux-acpi@vger.kernel.org>; Tue, 21 Jul 2026 13:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784642340;
	bh=B7qa7Q0H/wQufAECWimvbevjT3KmReqoTe9RKgyVspQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ihN3/vh92WH/AoPSCX9xjMyDZTHWNEJNUu4Ip7rmZJiVkVWajEFsJ+F5KNxb0Kr8O
	 K4Fq2MoDZHL72LRNxWUtBPdSrvIjYFQieB0AxRFtyiiDHI/emUbX27wGY9ueKQfuVy
	 zPAfngEUivlbivLv1iPhsMzPKGXpQGOJW9ALgN33V1czRisuwxLJ8xZKRPskLyll5t
	 NBz2pgmjFlkdmv7RrlyrxBwlfVOt5TwsriOhpiVSs0S2BABHZiq+hzGpDR4dsR1Uud
	 zPFs9bY0Jv7W+fDCHqV+0aZB/YFvMny2mVPFpjpZvWT6N4fbjY26iAtLDHbGxwn35a
	 +NAfiwXdVA0hQ==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5b2a74f25feso526481e87.0
        for <linux-acpi@vger.kernel.org>; Tue, 21 Jul 2026 06:59:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrRdJGbMhGM/aZMXqZuiC0vlLCUppx4GIA5GoEFRj59wN2+qmaET5toQW0mZjHOFbC0imYE+MOUasVG@vger.kernel.org
X-Gm-Message-State: AOJu0YySS0Cjex6osTqRUR9I2ztaBhhneSO6i06eb+mbmfhP4BFE0581
	c/3ujdCta+ICXEfejJSw4DzBwA4Jcz+zwu5t1G77DRcdlbmbo1JOt7VHBhBm+WGgveC3VRCPQQa
	CCyXESk0snnHh7k4g0i7HjzlLmcegHxs=
X-Received: by 2002:a05:6512:3598:b0:5b0:ceb2:194b with SMTP id
 2adb3069b0e04-5b28f9acd3dmr2984467e87.36.1784642338810; Tue, 21 Jul 2026
 06:58:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260715083253.22831-1-pengpeng@iscas.ac.cn>
In-Reply-To: <20260715083253.22831-1-pengpeng@iscas.ac.cn>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 21 Jul 2026 15:58:47 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iO1OfffmosXmA8zHgfT=Ap7vAhHLgdBap9EZdHMR_qUA@mail.gmail.com>
X-Gm-Features: AUfX_mxIn4PXXI_tbug4myJ4SOFU-9SjuDp6ZWuNbmgea21QWvL2efUJzci_QzA
Message-ID: <CAJZ5v0iO1OfffmosXmA8zHgfT=Ap7vAhHLgdBap9EZdHMR_qUA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: validate MADT IOAPIC entry bounds
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2026 at 10:33=E2=80=AFAM Pengpeng Hou <pengpeng@iscas.ac.cn=
> wrote:
>
> The IOAPIC hotplug lookup parses both MADT and _MAT records directly.
> The MADT walk previously used a subtable's declared length to advance the
> cursor after only locating a generic header.  The _MAT path likewise pass=
ed
> a generic header to the IOAPIC helper.
>
> Validate that a current record has a complete generic header, that its
> declared length is contained in the available record range, and that a
> typed IOAPIC record contains the full fixed IOAPIC body before reading it=
s
> fields.  Use the same relation for both MADT and _MAT provider paths.
>
> Fixes: ecf5636dcd59 ("ACPI: Add interfaces to parse IOAPIC ID for IOAPIC =
hotplug")
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
>  drivers/acpi/processor_core.c | 31 +++++++++++++++++++++++++------
>  1 file changed, 25 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.=
c
> index a4498357bd16..3bf076c150fa 100644
> --- a/drivers/acpi/processor_core.c
> +++ b/drivers/acpi/processor_core.c
> @@ -336,11 +336,26 @@ int acpi_get_cpuid(acpi_handle handle, int type, u3=
2 acpi_id)
>  EXPORT_SYMBOL_GPL(acpi_get_cpuid);
>
>  #ifdef CONFIG_ACPI_HOTPLUG_IOAPIC
> -static int get_ioapic_id(struct acpi_subtable_header *entry, u32 gsi_bas=
e,
> +static bool madt_entry_is_valid(struct acpi_subtable_header *entry,
> +                               unsigned long end)
> +{
> +       unsigned long start =3D (unsigned long)entry;
> +
> +       if (start >=3D end || end - start < sizeof(*entry))
> +               return false;
> +
> +       return entry->length >=3D sizeof(*entry) && entry->length <=3D en=
d - start;
> +}
> +
> +static int get_ioapic_id(struct acpi_subtable_header *entry,
> +                        const unsigned long end, u32 gsi_base,
>                          u64 *phys_addr, int *ioapic_id)
>  {
>         struct acpi_madt_io_apic *ioapic =3D (struct acpi_madt_io_apic *)=
entry;
>
> +       if (!madt_entry_is_valid(entry, end) || BAD_MADT_ENTRY(ioapic, en=
d))
> +               return 0;
> +
>         if (ioapic->global_irq_base !=3D gsi_base)
>                 return 0;
>
> @@ -361,17 +376,19 @@ static int parse_madt_ioapic_entry(u32 gsi_base, u6=
4 *phys_addr)
>                 return apic_id;
>
>         entry =3D (unsigned long)madt;
> +       if (madt->header.length < sizeof(*madt))
> +               return apic_id;
>         madt_end =3D entry + madt->header.length;
>
>         /* Parse all entries looking for a match. */
>         entry +=3D sizeof(struct acpi_table_madt);
> -       while (entry + sizeof(struct acpi_subtable_header) < madt_end) {
> +       while (madt_entry_is_valid((struct acpi_subtable_header *)entry,
> +                                  madt_end)) {
>                 hdr =3D (struct acpi_subtable_header *)entry;
>                 if (hdr->type =3D=3D ACPI_MADT_TYPE_IO_APIC &&
> -                   get_ioapic_id(hdr, gsi_base, phys_addr, &apic_id))
> +                   get_ioapic_id(hdr, madt_end, gsi_base, phys_addr, &ap=
ic_id))
>                         break;
> -               else
> -                       entry +=3D hdr->length;
> +               entry +=3D hdr->length;
>         }
>
>         return apic_id;
> @@ -398,7 +415,9 @@ static int parse_mat_ioapic_entry(acpi_handle handle,=
 u32 gsi_base,
>
>         header =3D (struct acpi_subtable_header *)obj->buffer.pointer;
>         if (header->type =3D=3D ACPI_MADT_TYPE_IO_APIC)
> -               get_ioapic_id(header, gsi_base, phys_addr, &apic_id);
> +               get_ioapic_id(header,
> +                             (unsigned long)header + obj->buffer.length,
> +                             gsi_base, phys_addr, &apic_id);
>
>  exit:
>         kfree(buffer.pointer);
> --

Applied as 7.3 material, thanks!
