Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5383655CB
	for <linux-acpi@vger.kernel.org>; Fri, 22 May 2026 17:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779471007; cv=none; b=UPyCr7hF6B/fU9qARj6o8dAs8EGXG/LM3hinwpfYcQ2zv7OQ3reHesLUXSuxFUeSDdzUn3G7a+ml3SUOoYFlmwDXAqJc12HVOowfJB2JE8lKF/9mPcQGb+kAKZzjS+I/2PF/bclsbs1g7+s4i1XDnQ+jjWRjVIqcxReZfv+oDV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779471007; c=relaxed/simple;
	bh=AhNJOV57PNZSR2kE33/TDZqrAbBNwLc8/W6iMZQoydI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nlLLh2ZE+Vpa6laKqRhtum3xqevtggx5gXNS7cmmDOhtM5jH9/Gk6ixknZIU/+4cNvb+vL+rywj0AN1VWeaB5IvIWsJ2fNv126inxwXVQ0tqktFi9vHcmwC9rJvV6+02wGkQrHxWzEcj+6/PZXovLdst8qCN4JQNiTtmI9ExFeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Npfnz/2f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Npfnz/2f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BADBB1F00A3E
	for <linux-acpi@vger.kernel.org>; Fri, 22 May 2026 17:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779471005;
	bh=HU1TVEmCcGVEK/wtAX6tRv68GA7AtK/DQYNdRAjmq00=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Npfnz/2fLLEDNNiEjkqtq2Wu4h9QIC25TX0N24eMWsEwHeAhB5Xub/T2kYjLbbfPj
	 X8T2ajj5DJPqNwmpoVdyvHQgGCVywggqAmnZx24u89z2JNDMJv14rcFM/Gukxf6Jnw
	 qhujMFqTvMsGIL7xe5eB7N6yeIP4PKVRKMNcKu0IZrtI5ujgMYKYlzHZ+bWTxxzqUR
	 NNDutzJht6OQfqXHwif14C4JEl6Qu1MBXQjzEO2k4SL0aXGPumIaweEeYB5p0X3ouS
	 cNLrQSJfv2y0T50b83pLhCZXrT4qwBaSAGKjg876nPFbVM7YA0R6066g7muJ4sSKZ9
	 +rL87CGx9eK+w==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5a87edf88b3so7754527e87.0
        for <linux-acpi@vger.kernel.org>; Fri, 22 May 2026 10:30:05 -0700 (PDT)
X-Gm-Message-State: AOJu0YyniX/LkQAFi6sZqeREm4wvOEfgafvfJHQOgU6aqP/NEhCNY7CC
	HzzzkI4h7+KdKL1JByZuwaeJ0cSHnu2cXfKQRAPubyBXn0Jw/PxfF9ZdfA9v9+P2am9QYkAzrRN
	bknt/WTVNGLJpoeCph9077l5TgAH9i4Y=
X-Received: by 2002:a05:6512:3186:b0:5a8:8eda:bed5 with SMTP id
 2adb3069b0e04-5aa3239abebmr1468569e87.32.1779471004196; Fri, 22 May 2026
 10:30:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511204646.4863-1-sakunix.ref@yahoo.com> <20260511204646.4863-1-sakunix@yahoo.com>
In-Reply-To: <20260511204646.4863-1-sakunix@yahoo.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 22 May 2026 19:29:52 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ikd24Vj3H=2XAGwwHtBudDXJumL4H-whu1GgU-KjMnmQ@mail.gmail.com>
X-Gm-Features: AVHnY4KAhOJEcJXx_skUT7y2ek5IjWjk4n9RraejRJxvkN2Ck0lQh5E1YiCoPwU
Message-ID: <CAJZ5v0ikd24Vj3H=2XAGwwHtBudDXJumL4H-whu1GgU-KjMnmQ@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: resource: Add quirk for Dell PMC memory region overlap
To: Manuel Quintero Fonseca <sakunix@yahoo.com>
Cc: linux-acpi@vger.kernel.org, skhan@linuxfoundation.org, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Hans de Goede <hansg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 10:47=E2=80=AFPM Manuel Quintero Fonseca
<sakunix@yahoo.com> wrote:
>
> On Dell OptiPlex 3080 systems, specifically during the initialization
> of the intel_pmc_core driver, the kernel reports a resource sanity
> check conflict. The issue was identified via dmesg logs showing:
>
> resource sanity check: requesting [mem 0xfdffe800-0xfe0007ff], which
> spans more than PNP0C02:03 [mem 0xfdb00000-0xfdffffff]
>
> And subsequently:
>
> resource sanity check: requesting [mem 0xfdffe800-0xfe0007ff], which
> spans more than Reserved [mem 0xfe000000-0xfe010fff]
>
> Investigation of /proc/iomem and ACPI tables on this specific model
> revealed that the BIOS defines reserved regions (as a PNP0C02 resource
> and an E820 reserved entry) that overlap with the Power Management
> Controller (PMC) register space.
>
> This overlap is harmless for system stability but produces persistent
> warnings in dmesg. This patch introduces a quirk to:
>
> 1. Filter out the conflicting fixed memory resources in
>    drivers/acpi/resource.c.
> 2. Skip the iomem sanity check for the specific problematic range in
>    kernel/resource.c.
>
> This ensures a clean boot log on these Dell units and allows the
> Intel PMC driver to bind correctly without resource conflicts.
>
> Signed-off-by: Manuel Quintero Fonseca <sakunix@yahoo.com>

I'm not a big fan of this approach TBH.  Adding quirks specifically to
avoid printing spurious messages is a bit of a stretch IMV.

Have you considered downgrading the log level of the messages in
question to "debug" instead?

> ---
> v2:
>   - Add DMI matching to restrict the quirk to Dell systems.
>   - Include <linux/dmi.h> to fix compilation errors.
>   - Expand commit description with specific hardware (Dell OptiPlex 3080)=
.
>   - Include dmesg logs showing the resource conflict.
>   - Reformat description to 75 characters per line.
>
>  drivers/acpi/resource.c | 32 ++++++++++++++++++++++++++++++++
>  kernel/resource.c       |  9 +++++++++
>  2 files changed, 41 insertions(+)
>
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index bc8050d8a6f5..464195e30080 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -50,6 +50,20 @@ static inline bool is_gsi(struct acpi_resource_extende=
d_irq *ext_irq)
>  }
>  #endif
>
> +/*
> + * List of Dell systems requiring memory resource quirks due to BIOS
> + * reservations overlapping with Intel PMC register space.
> + */
> +static const struct dmi_system_id dell_memory_quirks[] =3D {
> +       {
> +               .ident =3D "Dell Inc.",
> +               .matches =3D {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +               },
> +       },
> +       { }
> +};
> +
>  static bool acpi_dev_resource_len_valid(u64 start, u64 end, u64 len, boo=
l io)
>  {
>         u64 reslen =3D end - start + 1;
> @@ -110,6 +124,24 @@ bool acpi_dev_resource_memory(struct acpi_resource *=
ares, struct resource *res)
>         struct acpi_resource_memory32 *memory32;
>         struct acpi_resource_fixed_memory32 *fixed_memory32;
>
> +       /*
> +        * Quirk for Dell systems: ignore BIOS memory reservations that o=
verlap
> +        * with Intel PMC resources. Restricted via DMI to avoid impact o=
n
> +        * other manufacturers.
> +        */
> +       if (dmi_check_system(dell_memory_quirks)) {
> +               u32 addr =3D 0;
> +
> +               if (ares->type =3D=3D ACPI_RESOURCE_TYPE_FIXED_MEMORY32)
> +                       addr =3D ares->data.fixed_memory32.address;
> +               else if (ares->type =3D=3D ACPI_RESOURCE_TYPE_MEMORY32)
> +                       addr =3D ares->data.memory32.minimum;
> +
> +               if (addr =3D=3D 0xfdb00000 ||
> +                   (addr >=3D 0xfe000000 && addr <=3D 0xfe000fff))
> +                       return false;
> +       }
> +
>         switch (ares->type) {
>         case ACPI_RESOURCE_TYPE_MEMORY24:
>                 memory24 =3D &ares->data.memory24;
> diff --git a/kernel/resource.c b/kernel/resource.c
> index bb966699da31..16c82d9ea14f 100644
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -30,6 +30,7 @@
>  #include <linux/string.h>
>  #include <linux/vmalloc.h>
>  #include <asm/io.h>
> +#include <linux/dmi.h>
>
>
>  struct resource ioport_resource =3D {
> @@ -1857,6 +1858,14 @@ int iomem_map_sanity_check(resource_size_t addr, u=
nsigned long size)
>                  */
>                 if (p->flags & IORESOURCE_BUSY)
>                         continue;
> +               /*
> +                * Only apply this quirk on Dell systems to avoid false
> +                * positives elsewhere.
> +                */
> +               if (dmi_match(DMI_SYS_VENDOR, "Dell Inc.")) {
> +                       if (p->start =3D=3D 0xfe000000 && p->end =3D=3D 0=
xfe010fff)
> +                               continue;
> +               }
>
>                 pr_warn("resource sanity check: requesting [mem %pa-%pa],=
 which spans more than %s %pR\n",
>                         &addr, &end, p->name, p);
> --
> 2.47.3
>
>
