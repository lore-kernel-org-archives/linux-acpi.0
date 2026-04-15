Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606583939DB
	for <linux-acpi@vger.kernel.org>; Wed, 15 Apr 2026 07:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776237619; cv=none; b=G1lLEPnJkxHBftDdxzlTYPmtHecPWH8aLovfHv5dBZOX76uxaBe9LcWMwhVjt9rxoN0PZ+i5A8BKmX9AXl2u3ZEICgCfy+WUCjQfZ/PssM78WYla0w7kxX63h3uO0mwE8K3Pfd1i1iyWLo4HqTjvLR8TlNFaldLohZGI8QoByeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776237619; c=relaxed/simple;
	bh=lshuN7u3tdnE2Nk4U3GEDSNvBWdShEn8csloQughEc4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a5RrDDYTxnit2ed7yVr87p+0uT9ncuF8OEy1axWXrp+dyiNVqj5I4VylomkHIeB7HA1cl2M1Pgw1wOZm9RQnXPJCbX6m6VE6y/TerVoExHjaF3yNQfoJ7FwDMjjGavxyoVDxxuZBhhdgZJkNaSXSYAYAz9Hhaj0bNY2saH4xWU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wtzn7e2D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wtzn7e2D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 434B9C2BCB4
	for <linux-acpi@vger.kernel.org>; Wed, 15 Apr 2026 07:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776237619;
	bh=lshuN7u3tdnE2Nk4U3GEDSNvBWdShEn8csloQughEc4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Wtzn7e2DYWZfvackUq98/gME3uGMzf5P9ycPULIPf1QTXKdvDmEIBWw2XwW+F7tSe
	 pNPL/ob+bn9KuLsMhmNzYrZFX0f35C0zmVYpR2xa1tRgc3pe/VA3FUzLBxPSaaNpmF
	 JqHTBjvoQCoV3bNKOKARg1SDyqNHApm5mstSLD8Ooq+Z+hDiEinTdLQ4FOCBm6IVdk
	 yg2FLft929aMa8bbrXhyYU+20GWlyj//m22D37gBMSGQuvaTxfMBB0yV9QAtQoKhdA
	 RuTwgXFXUEP0eSBmNn5CkinDtGXSot+ynk/NRLvZMI7L0igCwijvqfDvjcjIHKExGP
	 8qFD+l0wpEcZw==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-67c250805ccso2196351eaf.1
        for <linux-acpi@vger.kernel.org>; Wed, 15 Apr 2026 00:20:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9ZDmc0bEKJVI2dFnsvYWnXLFisK+CeRET9gIIncGZsYrFZ2zv0CUL5TeGk1DyiT20g/wYfuw1GVzE7@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3XBnQrpdgS5usfVWrYJMoW126NRd9p46v4vhnHV+a6t8b7+u9
	FG3n6v0atz8F/bUj+c2k7s5a/i7Rd6YGWsaEAG24uqncCcSujJ8KnDWifx83Ql7PIQhH2kN3Iys
	OE5IvZEGyUfo7TpZmxRw7o8re94raTYM=
X-Received: by 2002:a05:6820:6001:b0:67e:244a:7dd5 with SMTP id
 006d021491bc7-68be86dff33mr7057356eaf.51.1776237618329; Wed, 15 Apr 2026
 00:20:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ad624e0d-cfd7-4521-ae33-c5c3287b4204@linux.ibm.com>
In-Reply-To: <ad624e0d-cfd7-4521-ae33-c5c3287b4204@linux.ibm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 15 Apr 2026 09:20:06 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g4R+X+JXf1JB=3b_gqAdbyOv0drF242MCKkuNx1n4oow@mail.gmail.com>
X-Gm-Features: AQROBzC1jw-t-hZLv7MDU0mcXdlJeOqJKbqEkmhHugBwv1Bcg2HKP0MjnRDTopg
Message-ID: <CAJZ5v0g4R+X+JXf1JB=3b_gqAdbyOv0drF242MCKkuNx1n4oow@mail.gmail.com>
Subject: Re: Build failure in linux-next: implicit declaration of acpi_has_method
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, lenb@kernel.org, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, luiz.dentz@gmail.com, 
	Ritesh Harjani <riteshh@linux.ibm.com>, Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2026 at 9:16=E2=80=AFAM Venkat Rao Bagalkote
<venkat88@linux.ibm.com> wrote:
>
> Greetings!!!
>
> IBM CI has reported a build failure on linux-next repo.
>
> Failures:
>
> drivers/bluetooth/btintel_pcie.c: In function
> =E2=80=98btintel_pcie_acpi_reset_method=E2=80=99:
> drivers/bluetooth/btintel_pcie.c:2309:14: error: implicit declaration of
> function =E2=80=98acpi_has_method=E2=80=99; did you mean =E2=80=98acpi_ha=
s_watchdog=E2=80=99?
> [-Werror=3Dimplicit-function-declaration]
>   2309 |         if (!acpi_has_method(handle, "_PRR")) {
>        |              ^~~~~~~~~~~~~~~
>        |              acpi_has_watchdog
>
>
> The function acpi_has_method() lacks a stub definition in
> include/linux/acpi.h
> for the !CONFIG_ACPI case, unlike other ACPI utility functions.

Code that calls acpi_has_method() clearly depends on ACPI though, so
building it in the !CONFIG_ACPI case is questionable.

> Below diff fixes the build failure.
>
>
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index bfacb9475aac..d3804f7f2610 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -1100,6 +1100,11 @@ static inline const char
> *acpi_get_subsystem_id(acpi_handle handle)
>          return ERR_PTR(-ENODEV);
>   }
>
> +static inline bool acpi_has_method(acpi_handle handle, char *name)
> +{
> +        return false;
> +}
> +

This doesn't belong in include/linux/acpi.h.

It might go into include/acpi/acpi_bus.h, but see above.

>   static inline int acpi_register_wakeup_handler(int wake_irq,
>          bool (*wakeup)(void *context), void *context)
>   {
