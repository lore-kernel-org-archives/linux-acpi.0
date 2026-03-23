Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B30929AB02
	for <linux-acpi@vger.kernel.org>; Mon, 23 Mar 2026 12:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774270301; cv=none; b=qDDufwpNdR5N7Rhr3GJ5QTYNLHhdNIec7y7Xa3gHxTSBS7XS+62FaP06kH5nM/INlFN8UYin+mFIQNrFI3jF1rG3uc042+9867XLbPDJDtDQriz5OW3ejefwuk2tJo+v+dgJHEMbMeNoEnTCbdW2UzniMdjJW2LRNLMNw8NQoaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774270301; c=relaxed/simple;
	bh=ezhpRLIBzp4mQ8CMr8bCkXIvjw0TfjiVM1Q2QAas6nw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AOox6+3Qvjyue55tZe0Mj7AznUmXHLCWjDllibUoBDYlm6ggzMEZPcRs2c5Yv0/jdXrb2aLctof8wGgkrAUJmUx8YqdAEfS3e5lyWGmqvnPJAZeodYQknDEb/OCjDBIcqP/zNTSaMclj5zOVdji9ed0uVdju4MA91LLd921YSp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MpFlw1Dc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MpFlw1Dc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16F75C2BCB4
	for <linux-acpi@vger.kernel.org>; Mon, 23 Mar 2026 12:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774270301;
	bh=ezhpRLIBzp4mQ8CMr8bCkXIvjw0TfjiVM1Q2QAas6nw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MpFlw1DcKCZXnTGKHrbqRSlqg51Ghgf849Qe8MyDpmwUXEOVKksAWQocs//GL/6+H
	 tfWvP/gCJyxiEX+9uO2QIkOzlgAI9l5C1WZW/w6osS8vFTQUmTzww0qWQyRRo4UYc0
	 ByNrq0larqrEcD3qvUirsMjoCg2oQtNfovl5Es5ZAVdj3VmDMSD86pz6iyX26fOy0H
	 j4K7/3kexveDNcbWUyg3pPojM3CecjxviYCWpLUlrRL75tPDiaVbLRIkt0Mxwfp5Ql
	 MMk3qhGwZt6QC4+Oad1+Pfu6wFQwvMWqN+uaV7i95AvJvzN0e3GE2AytQPJSmk4UNo
	 T/iXPpFrTkGwQ==
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7d86eb7c854so837237a34.3
        for <linux-acpi@vger.kernel.org>; Mon, 23 Mar 2026 05:51:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWG80XZQ+NE3Ob7S9ynlthiHUXXhY+OYdDL4QqfQTv0dekPHAT26DhccYqh1ZDZhNX+XqytcsNxuilV@vger.kernel.org
X-Gm-Message-State: AOJu0YyFUaNswosky7BfnVkyrhRZy6X+v4YBoe6Grl7MGPAgp/wOPHWV
	CKK17u1qB4XQD1X9u1KsE6Q7Y+NvLgXbA23pM6XQlVN2Bjykn03G+D8rJDuF6Maji1SFnGg4xxK
	ank/JVQfpL+T8NhvvNYPsYxWo3hSWyZQ=
X-Received: by 2002:a05:6830:8384:b0:7d7:d702:401c with SMTP id
 46e09a7af769-7d7eb0baf03mr8231419a34.32.1774270300147; Mon, 23 Mar 2026
 05:51:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260322153529.3325784-3-bestswngs@gmail.com>
In-Reply-To: <20260322153529.3325784-3-bestswngs@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 23 Mar 2026 13:51:24 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gFizazkso9TXc1eu46=g6ht77z1Q00Aps-z9RKAnOZew@mail.gmail.com>
X-Gm-Features: AQROBzDDpfejb6Cb8oXB0TJLJtwSvveKl1DP1qokQVpi-Dw4BRQI7hyG15KqNW0
Message-ID: <CAJZ5v0gFizazkso9TXc1eu46=g6ht77z1Q00Aps-z9RKAnOZew@mail.gmail.com>
Subject: Re: [PATCH] ACPICA: fix NULL pointer dereference in acpi_ns_custom_package()
To: Weiming Shi <bestswngs@gmail.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Robert Moore <robert.moore@intel.com>, 
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
	Xiang Mei <xmei5@asu.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 22, 2026 at 4:36=E2=80=AFPM Weiming Shi <bestswngs@gmail.com> w=
rote:
>
> acpi_ns_custom_package() unconditionally dereferences the first element
> of the package to read the _BIX version number, without checking for
> NULL:
>
>   if ((*elements)->common.type !=3D ACPI_TYPE_INTEGER)
>
> When firmware returns a _BIX package whose first element is an
> unresolvable reference, ACPICA evaluates that entry to NULL.
> acpi_ns_remove_null_elements() does not strip NULL entries for
> ACPI_PTYPE_CUSTOM packages (fixed-position format would break if
> elements were shifted), so acpi_ns_custom_package() sees the NULL
> and panics.
>
>  general protection fault, probably for non-canonical address
>  0xdffffc0000000001: 0000 [#1] SMP KASAN NOPTI
>  KASAN: null-ptr-deref in range
>  [0x0000000000000008-0x000000000000000f]
>  RIP: acpi_ns_check_package
>  (drivers/acpi/acpica/nsprepkg.c:634
>   drivers/acpi/acpica/nsprepkg.c:110)
>  Call Trace:
>   <TASK>
>   acpi_ns_check_return_value (nspredef.c:136)
>   acpi_ns_evaluate (nseval.c:266)
>   acpi_evaluate_object (nsxfeval.c:360)
>   acpi_battery_get_info (battery.c:537)
>   acpi_battery_update (battery.c:1007)
>   acpi_battery_add (battery.c:1237)
>   acpi_device_probe (bus.c:1076)
>   really_probe (dd.c:659)
>   </TASK>
>
> Add a NULL check for the first element (version field) before
> dereferencing it. The battery probe then fails gracefully with
> AE_AML_OPERAND_TYPE instead of crashing the kernel.
>
> Required CONFIG: CONFIG_ACPI_BATTERY=3Dy
>
> Fixes: 7952d40240855932 ("ACPICA: ACPI 6.0: Update _BIX support for new p=
ackage element")
> Reported-by: Xiang Mei <xmei5@asu.edu>
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> ---
>  drivers/acpi/acpica/nsprepkg.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/acpi/acpica/nsprepkg.c b/drivers/acpi/acpica/nsprepk=
g.c
> index ca137ce5674f..c32770570120 100644
> --- a/drivers/acpi/acpica/nsprepkg.c
> +++ b/drivers/acpi/acpica/nsprepkg.c
> @@ -631,6 +631,13 @@ acpi_ns_custom_package(struct acpi_evaluate_info *in=
fo,
>
>         /* Get version number, must be Integer */
>
> +       if (!(*elements)) {
> +               ACPI_WARN_PREDEFINED((AE_INFO, info->full_pathname,
> +                                     info->node_flags,
> +                                     "Return Package has a NULL version =
element"));
> +               return_ACPI_STATUS(AE_AML_OPERAND_TYPE);
> +       }
> +
>         if ((*elements)->common.type !=3D ACPI_TYPE_INTEGER) {
>                 ACPI_WARN_PREDEFINED((AE_INFO, info->full_pathname,
>                                       info->node_flags,
> --

ACPICA changes need to be routed via upstream ACPICA project on GitHub.

Please see Documentation/driver-api/acpi/linuxized-acpica.rst
