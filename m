Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBB137C928
	for <linux-acpi@vger.kernel.org>; Tue, 28 Apr 2026 21:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777410331; cv=pass; b=C2IPRS3tTCe8x4jhJx8o5SP0yZL1T7+RmqRj+U8de634gGJYuDTiRv5wG7ZadqmLFXROMUqkKTvLiGfafsLdBZ6Ax6xtaVs4BATgPqsSUUg2Lo2ZO3vxfSTWY1ccSJC7E5+PWVog8OvaF+xlS4HEmJ5BL6ja5Q/AjfKn14VBjqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777410331; c=relaxed/simple;
	bh=1yuXwi+NqO9qPAU8oODt9J+EEmGmc1IBnbpHbe4Kmn0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S10ydVG9NWKiE2nAgFx2DobWSYSxnyQmJB+Y4KcFqTj8XM2IPROMtGdC0FDlk3IEU2UzK7pHP/KEFLi3v9Tt19FXKkFDLN1kZrau77RFR1CNyqs/ZwnFOOuyR6S6uRA6FMKcbO29XfS3Rxms0AJSgcaWll9AVHZRA23U0Wkkn1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pTZrcay7; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pTZrcay7"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ba6838e76f2so1241834866b.2
        for <linux-acpi@vger.kernel.org>; Tue, 28 Apr 2026 14:05:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777410328; cv=none;
        d=google.com; s=arc-20240605;
        b=Ha1+Ex6GAgxOkX6LACMiJK9kaDABT8o/EVdwqBWMY7R+hVWQr+fuLBjocPb2bwhxaE
         IpY2rh71JpaZrrjIwow08rgcxjcfZXxHKt+hP2L6VU5MkZRQ0C+2MRIZWdgUpM01NwHa
         7rFiA8akJUSG7Ih52pk6Kc0aXUFDctfw3NbVEDhcAS/6Z46Ngwkgz0YagesRDTgLTCOU
         9+ylu972S9k6jez3C1VlO7NBTC9IlOCy7+DEznZ4Xgbwq0RCx5kECmhNRDm9/Q+c5evi
         wiFomauGKPKmvCO8P6YmT0l8yIhBE6ycMhr8mgTWmxzsbUgerKcP6nxBZaGgAsxLpHX5
         DCww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MYqCNgCYe/2QmSmAUXHuU+yjG/QUozFu1M4rpW5vIC8=;
        fh=CYZ7ZdGsL+3UQTkSnxNHjOP6iHNnRkHvCq/tp+cmT1M=;
        b=BTbKfMnhcRhF2ptnnjwY0DyTcIud1T7dQ3cfDHUJbZEX6NJpiafANY1FCj81qmWcEO
         1wMLsaoAY7LTsTTC4y0SZe0RrcrAuorXcKJLLE5s+cci6gTDdBtnwRPW1VJE/NXpNtcc
         CARnK8ms7N2tGUNZRXg7eq0VYpBP9ZEUqrmrOCXMVvj6y97qeKbpLJeTIBI486BK6jMy
         EhUFqwpbrrGP9eJlB8p5voDPO4Lx8ZSdIKHli7KAmAwrK4qwg1cwuUSmF5/TbxVAzKzf
         LfZNPdxObTaVExpBD0u+rF97Z4bfVRnbhzv1U67Xea6SzyermLPxVvZz1zaKa4cGmCuX
         dt7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777410328; x=1778015128; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MYqCNgCYe/2QmSmAUXHuU+yjG/QUozFu1M4rpW5vIC8=;
        b=pTZrcay7Rs0gMqoIpMx8yr5ZId4Ukib0pW70qY568w0/nLJitt0s7RMz8YnmQ8C36p
         hU78+uf56ggLYUkmrvnGy79FWKtGGBuTYadVSSHxxHCzoe17aS0IYhqn3Tol6NT75pbr
         fUQLw1QEOyPIPBm28t0nHfQ8ip3O7ZErhHwPOFMoPR4FOeRJKN4bkT1UV6ahLnNfrxY2
         cWSHXVXKb3QRhNumR9/+Z3XRVwN8L6airwRsnY26sIBL5WNFtl1gbIqvp2zFkYHgEh+t
         tvBWYiNupZ9A58OAbXh1BO74b6fZGFk1LB6WRX/UW31yXP+RmhIbRewO80BQ+7HEMSkD
         GmfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777410328; x=1778015128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MYqCNgCYe/2QmSmAUXHuU+yjG/QUozFu1M4rpW5vIC8=;
        b=FV5QXM8NGyQzvj999t7+5Mz7uDGjGzFhHgHNKrOXFmSZZgVYJHw7c9nZ1ZStrskKDK
         07w7Ez5+gQGyVz9oq+uYdtuYMzQQC/oxfCOzmwRr9kzhYlc/mCku6QTOV+jDBFAOZghh
         AnocD+DtkBxra63ZQ5BlovNSrncH8puqvv+wNN+EH5myC2yVTwykJ7Z9dzlLUDCroj8Z
         d/XMdzUQW1T3WrxOjvFHevcLQ7cP2O5hR+CywU9Dk02BR8xsBJPT4EdWPcUBISwa+S4G
         8M1aMBCPS76DaHq4kLeS/xW3PdMAz7dG7DCDRYfH9K6U7LYssUSuv9cxbYA5WwaWbPYt
         NACg==
X-Forwarded-Encrypted: i=1; AFNElJ/bAtw3ETmGs1kd3qVXhlUATSvGVxKER3PFaerTM/wza1VWWppNIzvMJCG+HlX32Grr/ITp4HsumqIH@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+mxikbXJkde7YtadBMkgzb8DSBlsMFf/DmDl5N4n2iSJZoNtt
	Vp+Z1XeVBFkqt4FMbJmN3I3I+TV15Re46cf5TTHMRCWAjJVrjKuZv+Ls8Rk0rYgvZsNX8K2rc9H
	GqR3CCgZ/RGHdyj0QWTKnhzrXN2Y+XkZxEIPx
X-Gm-Gg: AeBDiesY84BHEwf6NIg4NOupRD5u9TELpcss5HaDy0Hukqupfl4BV5h77dHx40nMI52
	D/h9FhGwd3Ln0cslwfHRbjeh5o1ceeTJIStyqzw9fOOO76KXkRkFPMJMgJp8x06PKIF8pNjs+Zt
	gM4yir5JXypoXydaGDscUWMnbXnXkeOCUibeS+qpxH4Fas7rWSgNGsBaubUrXSoRMv2f9JoTv6T
	1k5QX8MD7mGm+qpIboGCwiGekChM8LWppOws/f/J1JnFQ5/ijJgsndm6jO35nXSz8jxTnWVMtwW
	vIP1elib5IA9YXpT6upojJO4JZGk
X-Received: by 2002:a17:906:4785:b0:baa:77ac:97a with SMTP id
 a640c23a62f3a-bb93e655b30mr56610966b.36.1777410327474; Tue, 28 Apr 2026
 14:05:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12879883.O9o76ZdvQC@rafael.j.wysocki> <6281827.lOV4Wx5bFT@rafael.j.wysocki>
 <CAGAxtY1VBXN_6xY0WiraJt-BQiYp_kSdTt8xbPkgP8xPB26=WQ@mail.gmail.com> <12904177.O9o76ZdvQC@rafael.j.wysocki>
In-Reply-To: <12904177.O9o76ZdvQC@rafael.j.wysocki>
From: Evgeny Sagatov <evgeny.sagatov@gmail.com>
Date: Wed, 29 Apr 2026 00:05:14 +0300
X-Gm-Features: AVHnY4Ki0QIR34i68-Z6MwECjgIbd1TRovLm9MfERd7YAUb8T7QA0bS1UzvhZ1o
Message-ID: <CAGAxtY2SEkx7OgMgM5ypA8qsBN0h6pcs111VjnhD-5ZGq7Je6Q@mail.gmail.com>
Subject: Re: Pressing the power button causes the device to freeze completely
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: regressions@lists.linux.dev, linux-acpi@vger.kernel.org, 
	Thorsten Leemhuis <regressions@leemhuis.info>, LKML <linux-kernel@vger.kernel.org>, 
	Wysocki Rafael J <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The PC also froze with this patch when I pressed the power button.

=D0=B2=D1=82, 28 =D0=B0=D0=BF=D1=80. 2026=E2=80=AF=D0=B3. =D0=B2 22:58, Raf=
ael J. Wysocki <rafael@kernel.org>:
>
> On Tuesday, April 28, 2026 9:11:34 PM CEST Evgeny Sagatov wrote:
> > Yes, the PC froze when I pressed the power button.
>
> Well, in that case, let's try to serialize all accesses to I/O ports
> used in the ACPI code.
>
> The patch below replaces the previous one, please give it a go.
>
> ---
>  drivers/acpi/osl.c             |    6 ++++++
>  drivers/cpufreq/acpi-cpufreq.c |    4 +++-
>  2 files changed, 9 insertions(+), 1 deletion(-)
>
> --- a/drivers/acpi/osl.c
> +++ b/drivers/acpi/osl.c
> @@ -664,6 +664,8 @@ u64 acpi_os_get_timer(void)
>                 (ACPI_100NSEC_PER_SEC / HZ);
>  }
>
> +static DEFINE_RAW_SPINLOCK(acpi_os_port_lock);
> +
>  acpi_status acpi_os_read_port(acpi_io_address port, u32 *value, u32 widt=
h)
>  {
>         u32 dummy;
> @@ -682,6 +684,8 @@ acpi_status acpi_os_read_port(acpi_io_ad
>         else
>                 value =3D &dummy;
>
> +       guard(raw_spinlock_irqsave)(&acpi_os_port_lock);
> +
>         if (width <=3D 8) {
>                 *value =3D inb(port);
>         } else if (width <=3D 16) {
> @@ -703,6 +707,8 @@ acpi_status acpi_os_write_port(acpi_io_a
>         if (!IS_ENABLED(CONFIG_HAS_IOPORT))
>                 return AE_NOT_IMPLEMENTED;
>
> +       guard(raw_spinlock_irqsave)(&acpi_os_port_lock);
> +
>         if (width <=3D 8) {
>                 outb(value, port);
>         } else if (width <=3D 16) {
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -913,7 +913,9 @@ static int acpi_cpufreq_cpu_init(struct
>         data->resume =3D 1;
>
>         policy->fast_switch_possible =3D !acpi_pstate_strict &&
> -               !(policy_is_shared(policy) && policy->shared_type !=3D CP=
UFREQ_SHARED_TYPE_ANY);
> +               (!policy_is_shared(policy) ||
> +                policy->shared_type =3D=3D CPUFREQ_SHARED_TYPE_ANY) &&
> +               perf->control_register.space_id !=3D ACPI_ADR_SPACE_SYSTE=
M_IO;
>
>         if (perf->states[0].core_frequency * 1000 !=3D freq_table[0].freq=
uency)
>                 pr_warn(FW_WARN "P-state 0 is not max freq\n");
>
>
>
