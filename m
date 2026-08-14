Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907CB3314C3
	for <linux-acpi@vger.kernel.org>; Fri, 14 Aug 2026 19:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786736516; cv=none; b=IYL80nypjXxiOvknBHU7mDNmtZvTUFl0MJ1+jzMqdyP73plwT4Z0/LMItGn8WZvF1FGZaZYwUNu4AD1QxvSHpyVwZYekZVjaRK/fueaf4PXrxD5q5H4QAtyYUwjccCV60m1QtB6EY+4q4qQXLyypa0xNsS1pTR5eCPKI9BRSM0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786736516; c=relaxed/simple;
	bh=XWCWKtvcQ7H51oZUBx/VGFGzk0o5hSILKUe2cVvoVzg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DRIm47Cpmptg7KXZfW+IneXEt4MhMIBwaJ3h97Qoq1hA2/s9xWgUtZnGT7RaNT8TAZKXriky7NUwnXTxfBvkAaPcG8DJz6Z4LhwLdDFwDnhuIX2rFklzf0hchRxZvrkeH9P4p9+f/N3Tw3TXLGqkLSOuVC1YLjfLdBkDFHSD7ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJWmHSGb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJWmHSGb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4289B1F00A3E
	for <linux-acpi@vger.kernel.org>; Fri, 14 Aug 2026 19:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786736514;
	bh=FFtU03ISaHPPtUc1ysEOBT/IWGeKZlGHUseUe6jrEFI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=EJWmHSGbvNcUQynzOVnMcrlDaYqfyD6AaF9YWn9x5bCbQ1cBmr0C7r9VYQOTJN+mj
	 kB9HrIVI211T2ilu9LwumwuQI7J3fsUniAz4EFoOnnjjPf/v81dMH/IbAbKDSfy4h2
	 pPqTA108cM8jPeE6yl0YhXDLKBru99hgEWwfKYlDFmJ4T+mGWG6EBGrNZ2tPBK+3et
	 lKfcLf3/L8Yjic0Vw25U4rKJ/q63U/4pzChctPNCpxUjF79Hfhgoa3n7FZcIUAP8Ir
	 5lp/19jIQBguv3DRVwR6dlGPzT0BaKrPJmyyHRG2e7/AR1GPB4Hgpn80u4eJ3b9Fjm
	 O1PmmEur8ZZ5g==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5aeb98460c6so1142120e87.2
        for <linux-acpi@vger.kernel.org>; Fri, 14 Aug 2026 12:41:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpGhyBEf4FQN8GCVZVjMEZdO/lXfi9FhNLJpVgNi1PeqlBk13r29IbECOooaWPrIGytxBd6SxLmKNrr@vger.kernel.org
X-Gm-Message-State: AOJu0YyBnaGTVLvuMbLvGEqVZOCku2Va3BUER1UjRDxXwovIoBOO1AT5
	yspPMLW0eT+wJ0tgpou4x4Cwn9GSk95UU0e0wIkSzVbmYA4AaAeHtCZYvgFJ6Z3IuH9v9WjADfG
	FdQiuTeFvihpgs30k1YI2MzC+4r8fNzU=
X-Received: by 2002:ac2:4c50:0:b0:5b2:a6e6:8d83 with SMTP id
 2adb3069b0e04-5b45916c878mr1505863e87.23.1786736512705; Fri, 14 Aug 2026
 12:41:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804154854.1555-1-getshell@seu.edu.cn> <20260808085943.526-1-getshell@seu.edu.cn>
In-Reply-To: <20260808085943.526-1-getshell@seu.edu.cn>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 14 Aug 2026 21:41:29 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i05zUkpz01nTAh0R_rha7fqfhH1gWDpKFzmfZczHyHXw@mail.gmail.com>
X-Gm-Features: AUfX_mx4a3kQs3InYd2T6kxlvUy2XDwYYc7Jc4FPrVDZG2r8XUgJxZ15C1KiqdI
Message-ID: <CAJZ5v0i05zUkpz01nTAh0R_rha7fqfhH1gWDpKFzmfZczHyHXw@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: scan: fix bus ID cleanup on device_add() failure
To: Hongyan Xu <getshell@seu.edu.cn>
Cc: rafael@kernel.org, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	jianhao.xu@seu.edu.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 8, 2026 at 10:59=E2=80=AFAM Hongyan Xu <getshell@seu.edu.cn> wr=
ote:
>
> When device_add() fails after acpi_device_set_name() has allocated an
> instance ID and linked a new acpi_device_bus_id into acpi_bus_id_list, th=
e
> rollback path only removes wakeup_list and detaches the ACPI handle data.
>
> That leaves the bus-ID bookkeeping behind and keeps the allocated instanc=
e
> number consumed.
>
> Move the bus-ID cleanup and wakeup-list removal into a single helper.
> Use it from both the normal device teardown path and the device_add()
> rollback path. The wakeup list node is initialized before registration, s=
o
> it can be deleted without checking whether the device is wakeup-capable, =
as
> in the original teardown path.
>
> Found by manual review of reports from the
> kernel70rc2-fail11-retry-20260801 run.
>
> Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>

Applied (with some non-essential modifications) as 7.3 material, thanks!

> ---
> v2:
> - Fold the bus-ID cleanup and wakeup-list removal into one helper to avoi=
d
>   duplicating the same sequence in acpi_device_del() and the device_add()
>   rollback path.
> - Drop the wakeup.flags.valid check before list_del(&device->wakeup_list)=
.
>
> v1: https://lore.kernel.org/linux-acpi/20260804154854.1555-1-getshell@seu=
.edu.cn/
>
>  drivers/acpi/scan.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index ff7000b71fd1..a311af60d8d3 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -520,12 +520,10 @@ static void acpi_device_release(struct device *dev)
>         kfree(acpi_dev);
>  }
>
> -static void acpi_device_del(struct acpi_device *device)
> +static void acpi_device_del_list(struct acpi_device *device)
>  {
>         struct acpi_device_bus_id *acpi_device_bus_id;
>
> -       mutex_lock(&acpi_device_lock);
> -
>         list_for_each_entry(acpi_device_bus_id, &acpi_bus_id_list, node)
>                 if (!strcmp(acpi_device_bus_id->bus_id,
>                             acpi_device_hid(device))) {
> @@ -540,6 +538,13 @@ static void acpi_device_del(struct acpi_device *devi=
ce)
>                 }
>
>         list_del(&device->wakeup_list);
> +}
> +
> +static void acpi_device_del(struct acpi_device *device)
> +{
> +       mutex_lock(&acpi_device_lock);
> +
> +       acpi_device_del_list(device);
>
>         mutex_unlock(&acpi_device_lock);
>
> @@ -800,7 +805,7 @@ int acpi_device_add(struct acpi_device *device)
>  err:
>         mutex_lock(&acpi_device_lock);
>
> -       list_del(&device->wakeup_list);
> +       acpi_device_del_list(device);
>
>  err_unlock:
>         mutex_unlock(&acpi_device_lock);
> --
> 2.50.1.windows.1
