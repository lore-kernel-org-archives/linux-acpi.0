Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5669E2941A
	for <linux-acpi@vger.kernel.org>; Fri,  7 Aug 2026 17:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786124305; cv=none; b=qQ+YO67uKgX9pq2KOwYQCO9Hr/+m0DGQNFZV5wDn/UDxF/ZOBcycvxpowLKfcINWB0VbeLyQT73aA8v/0dJ3iNmIf2j18DiehaMVAZ8NQVRB+6May6APvWOWoN1Fjz7MU1R40tzy5tuFYHPaiYy/bl1CjxXxHB9eP9CkxPTQPC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786124305; c=relaxed/simple;
	bh=PG4ZcQRW80+BmrOGuIYMCcir8h+FB1XiPZjtnANtBJ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cRJjisV2/oFUgx6h7Abn2YjF2pKHVKXX8gT9cqadm7x87YxbKXZ0vMMppR1sIuyb6UnDoT/vRrvj1D3FVtKbwFARle4hvHEyzBI3IcuNuRFmJXqbPpBOWf2pBeJYaEVZxdhGUvODMO15WG9GuMyGmCtYCDazNLBDRfi2Qtx5QdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YICSgPfD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YICSgPfD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0FD21F00A3A
	for <linux-acpi@vger.kernel.org>; Fri,  7 Aug 2026 17:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786124303;
	bh=67EAXC9BjiGYpgYtJ4mS7EPJmnvsyV0lcrjCdivHKFI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=YICSgPfD6jEfzZRSG0FJ7eIG/kukOawbeyCyjM7vo0e1nWQWaXjPytxz3ijzf3FyT
	 UL6PWDN+C+89HKDhTEDJwLVQ0XrHe0EdDjYeObE47XY7g8QD2WHsUgef6ZyqFkUlOo
	 huCHY2n/iD/KThRJ6bmnWmvUwG4vRTZPowgi/DNgYF2btYf5YYampPafrlVFGeE6zS
	 pbHDCdBn1WQWGSbmw0VLkDZehIkEt5fln0FfG7z67XsfG5rKe6ZfWyvm/7EdxKaP6Z
	 wDdxoVypMoU0+UZyJj9CGIgNTXW2tRhxgaVV4bSCM3qfLfPawCCwGKq341aSLSBQVa
	 9S94lEepUB2NA==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-39ca300db70so32439411fa.2
        for <linux-acpi@vger.kernel.org>; Fri, 07 Aug 2026 10:38:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpmGgOiNeCg4VGY5n1AXkS9dHGHB7wXS1x2l+V3ktJTAsux7XVTWt9FPQSPmeAzm9oTlKgsX65v7nsM@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc3k6U34+EFmIa/gLGytj1szPmeMEx36zb6dSFFBfDNI1iw8eG
	/f1z1ogMnt3NkYkT+eYXJpKCM1hOWjhsj/kb9yHLlv5EOY/mlMmFgeUO5lwU4X2MW2e6/Pl4IU1
	Wg/7+N7HmVyiNSLIcZ7dkWyCbm9bNuU0=
X-Received: by 2002:a05:651c:a322:b0:39f:1b37:82b8 with SMTP id
 38308e7fff4ca-39fbb267984mr26994341fa.21.1786124302336; Fri, 07 Aug 2026
 10:38:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804154854.1555-1-getshell@seu.edu.cn>
In-Reply-To: <20260804154854.1555-1-getshell@seu.edu.cn>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 7 Aug 2026 19:38:10 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gOZK8pgAJyyOLYeX0Ky4hdi6m2o88PP3nQkq8DZbWDsw@mail.gmail.com>
X-Gm-Features: AUfX_mzdI4sgRYOu4YY2cB1E8vwpTHQTmbeaaX4TWy4TYWVdgbfG4Nq9GQw7Lbg
Message-ID: <CAJZ5v0gOZK8pgAJyyOLYeX0Ky4hdi6m2o88PP3nQkq8DZbWDsw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: scan: fix bus ID cleanup on device_add() failure
To: Hongyan Xu <getshell@seu.edu.cn>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	jianhao.xu@seu.edu.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 5:49=E2=80=AFPM Hongyan Xu <getshell@seu.edu.cn> wro=
te:
>
> When device_add() fails after acpi_device_set_name() has allocated an
> instance ID and linked a new acpi_device_bus_id into
> acpi_bus_id_list, the rollback path only removes wakeup_list and
> detaches the ACPI handle data.
>
> That leaves the bus-ID bookkeeping behind and keeps the allocated
> instance number consumed.
>
> Factor the bus-ID removal into a helper, use it from both the normal
> device teardown path and the device_add() rollback path, and only drop
> wakeup_list when it was actually linked.
>
> Found by manual review of reports from the
> kernel70rc2-fail11-retry-20260801 run.
>
> Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
> ---
>  drivers/acpi/scan.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index ff7000b71..852682436 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -520,12 +520,10 @@ static void acpi_device_release(struct device *dev)
>         kfree(acpi_dev);
>  }
>
> -static void acpi_device_del(struct acpi_device *device)
> +static void acpi_device_remove_bus_id(struct acpi_device *device)
>  {
>         struct acpi_device_bus_id *acpi_device_bus_id;
>
> -       mutex_lock(&acpi_device_lock);
> -
>         list_for_each_entry(acpi_device_bus_id, &acpi_bus_id_list, node)
>                 if (!strcmp(acpi_device_bus_id->bus_id,
>                             acpi_device_hid(device))) {
> @@ -538,8 +536,16 @@ static void acpi_device_del(struct acpi_device *devi=
ce)
>                         }
>                         break;
>                 }
> +}
>
> -       list_del(&device->wakeup_list);
> +static void acpi_device_del(struct acpi_device *device)
> +{
> +       mutex_lock(&acpi_device_lock);
> +
> +       acpi_device_remove_bus_id(device);
> +
> +       if (device->wakeup.flags.valid)
> +               list_del(&device->wakeup_list);
>
>         mutex_unlock(&acpi_device_lock);
>
> @@ -800,7 +806,9 @@ int acpi_device_add(struct acpi_device *device)
>  err:
>         mutex_lock(&acpi_device_lock);
>
> -       list_del(&device->wakeup_list);
> +       acpi_device_remove_bus_id(device);
> +       if (device->wakeup.flags.valid)
> +               list_del(&device->wakeup_list);

You have exactly the same code sequence in two places, so any chance
to avoid that duplication?

Also, it is not necessary to check device->wakeup.flags.valid before
doing list_del(&device->wakeup_list) if I'm not mistaken.

>
>  err_unlock:
>         mutex_unlock(&acpi_device_lock);
> --
