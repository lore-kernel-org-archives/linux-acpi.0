Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE48422553
	for <linux-acpi@vger.kernel.org>; Mon,  6 Jul 2026 18:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783361034; cv=none; b=jPr4ImPeKlEnuEmuY84D9XbV2EF9DRNFVY93Bqc28Wv3C8J/rJ7KrfvdFWYum61zbe8iw1h1rPZyfazZZSiBfrBhND8Qo2ltqAbH6l9J73VCiuiBL5U0L+5eI8B+d2wfVQ8aYxYLpFDQEuOydR3buO49uT5b9yhj4pASMiO55wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783361034; c=relaxed/simple;
	bh=TLyVNrsHBzCfLqllSzfl0iwK9J7/vbKa3jNjGTc16IU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kZpIsGHb23PaesptJO0nIZXdx9jW+SKGi8UE3jfF4aev4qze438YvKSfjUBm/NwT4uDihHg5IlfbpHMKTx2DCzKO78Ft94gIMb5BtYaf1X++gD/2sBmHa81jejofTjOh1TP0U1tRPQeuiyK2Uf4fN62AEL+kaU6Fw9D40HqPPN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ERUxOEe8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ERUxOEe8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0AFA1F000E9
	for <linux-acpi@vger.kernel.org>; Mon,  6 Jul 2026 18:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783361031;
	bh=KhlSoP1eZlU5pYaY6J/V+g8pe6XOpEulzVW/XUv9z5Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ERUxOEe8NVZa5liaCRru3mGmNDOjWi2H2589TdrIISr5ozFn+7qjGCaXecs4n8zKw
	 bXbpx08N6QIuKf8VwqEr6w6+silouNduRBIDkwRa9rWlEur0AWQY+V81J0n9yRbFCv
	 XZ85RH/z90K6/HCwiH68n5IuIHHsP4cC3AweEfTWTXL66EIP7yNKpkeBAJC0enh+aY
	 fRlaoGdX9FyH4pnBpQ4MZOZiE1qWFJttyaG9SBbyJBp7RPW+GmjHydE2RVQxpLdEjv
	 v4k6bf0NCwh4MM+j3rrTQpY3dhbwnqKSKVx10sTkxl9ud2xq9EVVJX+kdZfvMv4bY8
	 LU8Bs36zzCCbA==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5aeb2df5cc1so2461099e87.3
        for <linux-acpi@vger.kernel.org>; Mon, 06 Jul 2026 11:03:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrU/7fA207/qch9H0PMebz2EEVX8L4OSNgTRVVz2BMNGQUKdbrem2I+HAflyNn61VxL/C0qFsrzCyV9@vger.kernel.org
X-Gm-Message-State: AOJu0YxI/OAnU1kjqM6r/dQU61SdSre8nhlINrDtsoQ+hhLvSES8qByq
	MXG7ngeK/POyEY4NgwsrcboQRLiLQprGqBFVAzikGT+GeMczZSRn1hjcJwhc7C6t95x0JDrx/d6
	TzAO5/AD/gBbdiH8F07uXZ2wysMmdW9M=
X-Received: by 2002:ac2:50a8:0:b0:5ae:b8b6:9e0f with SMTP id
 2adb3069b0e04-5b007c42537mr270299e87.49.1783361030265; Mon, 06 Jul 2026
 11:03:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702232555.96539-1-dbgh9129@gmail.com>
In-Reply-To: <20260702232555.96539-1-dbgh9129@gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 6 Jul 2026 20:03:36 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0honUmKf8Qk9o_TQMaXdY2L7P-i=fXKahw+vnNpmUhphg@mail.gmail.com>
X-Gm-Features: AVVi8CeZCPywxGqKEF8oEW044by_dDQmctFeDig8B0ik4qvWsrHra3l4kd3H8dw
Message-ID: <CAJZ5v0honUmKf8Qk9o_TQMaXdY2L7P-i=fXKahw+vnNpmUhphg@mail.gmail.com>
Subject: Re: [PATCH v1] ACPI: sysfs: Fix hotplug kobject cleanup on failure
To: Yuho Choi <dbgh9129@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Toshi Kani <toshi.kani@hp.com>, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 3, 2026 at 1:26=E2=80=AFAM Yuho Choi <dbgh9129@gmail.com> wrote=
:
>
> acpi_sysfs_init() creates the ACPI hotplug kobject and the force_remove
> sysfs file before creating the pm_profile file. If force_remove creation
> fails, the hotplug kobject is left behind. If pm_profile creation fails,
> both force_remove and the hotplug kobject are left behind.
>
> Add the missing unwind paths so the partial hotplug sysfs state is
> removed before returning an error.

But platform_profile does not really depend on the hotplug thing, so
dropping it on pm_profile creation failure is not necessary.

> Fixes: 683058e315f0 ("ACPI / hotplug: Use device offline/online for grace=
ful hot-removal")
> Signed-off-by: Yuho Choi <dbgh9129@gmail.com>
> ---
>  drivers/acpi/sysfs.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
> index 908cc5c7e643..0b642ba1a526 100644
> --- a/drivers/acpi/sysfs.c
> +++ b/drivers/acpi/sysfs.c
> @@ -1037,8 +1037,18 @@ int __init acpi_sysfs_init(void)
>
>         result =3D sysfs_create_file(hotplug_kobj, &force_remove_attr.att=
r);
>         if (result)
> -               return result;
> +               goto err_hotplug;
>
>         result =3D sysfs_create_file(acpi_kobj, &pm_profile_attr.attr);
> +       if (result)
> +               goto err_force_remove;
> +
> +       return 0;
> +
> +err_force_remove:
> +       sysfs_remove_file(hotplug_kobj, &force_remove_attr.attr);
> +err_hotplug:
> +       kobject_put(hotplug_kobj);
> +       hotplug_kobj =3D NULL;
>         return result;
>  }
> --
> 2.43.0
>
