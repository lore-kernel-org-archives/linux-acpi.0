Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403B1341ADF
	for <linux-acpi@vger.kernel.org>; Fri, 19 Jun 2026 19:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781895605; cv=none; b=dBUftOZpI9qulo8s/h3XIvZCh8gu4X1itSDc4YeG6DCm9UUshB1dACbU39KNfREMEot0HA9zofrmDmKwy5ME1j0D9Zw5xDvuJnH3pVjZCwBeSf9aM0dcwlubicA2kL+gqdhrC10tpwmsd37JH/zRT+O2nZF6VtE7G3Np2exvmko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781895605; c=relaxed/simple;
	bh=6lbTjPJj1mlFQkEh2k1V0gQyG1siH55KgOyarCteob8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sljgkt9wQg8YglViZF1niHMw8+AT6jmz+tyN4FMu0J7W6JlW2FpQ5QdpGO2fo+/moPV/eNBYjCybvVaFbvpXzdPHW1N2lLKvopmZaE697/XKVIemBc5zaZ+a+MivMpYF4g6u/E/2JYa0XGU7rwjbpfh9aSGOD0YPBEegfhKT7A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MhcoStmm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MhcoStmm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0CD61F000E9
	for <linux-acpi@vger.kernel.org>; Fri, 19 Jun 2026 19:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781895604;
	bh=ecESCBb9ykxvGL+Ny240sodwdBlP/vfs2O7nf6We+So=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=MhcoStmmp7T/IV5IxCW52gLbz04orVVUJ3cm2IZJZ8iMq26CptFOiVrEwlLure+HJ
	 egBby6soN8aGrTEYHdHDJ85cHq/p692YOQ1ezDeX4uO0/Awyzzrq0dvhUZpm7VMfyI
	 qmOxnGVIiovhU5jQYVLusKROSLDGwarnqjd8pWFmQTik8JG3W0Ftw3bCz/mYAK6sgE
	 czYSEJLMMQD/JIHc1zHW4n+tHC6VaxomOSeMV6DBJWb79ip6GyDJWYapHlMRpz4GZp
	 ebUKZZmYH1ZxQl0tmTQBhJ3Uv/3j2ic9TiRYbBLlxcZXUk3fRA0b01CiAoQtktKhez
	 xdYRfcSRIAe+A==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-39977ab0562so24702271fa.1
        for <linux-acpi@vger.kernel.org>; Fri, 19 Jun 2026 12:00:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9ELa641m5pKaiOAf9jJqByNE4jCjMHVOcV6w3Xo6/fEN8S5KD08Ul3vJdnzz1qPhSqBjdZEmDxI22Z@vger.kernel.org
X-Gm-Message-State: AOJu0YyhBuhnA1uVzkSbYH+/5T7ml9FapB0XghTPZpcUZLjiLIWeVIif
	7X4ahivWRCxlejwkpvOB/0JQUo/8WPhmtYHNfCnreSsMQsZe2FweMJ0lsgGVkc/ConVuZOGToSz
	306wqyX3e5KgXSVvDGaXIHmoWPa1hjNM=
X-Received: by 2002:a05:651c:985:b0:399:87c9:4571 with SMTP id
 38308e7fff4ca-3998be8a538mr13692801fa.16.1781895602247; Fri, 19 Jun 2026
 12:00:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <B486593E06E6F6E0+20260616093621.1039943-1-raoxu@uniontech.com>
In-Reply-To: <B486593E06E6F6E0+20260616093621.1039943-1-raoxu@uniontech.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 19 Jun 2026 20:59:49 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hVqgzwcO8hh=i=5K8zW2HyiCy1E1oL2tuYnqS2w5-T8w@mail.gmail.com>
X-Gm-Features: AVVi8CfvWGMsHg7fz1aNc3XPiDD34af6PT5KshdYatT1YdihLXG93R8n6wCtkp4
Message-ID: <CAJZ5v0hVqgzwcO8hh=i=5K8zW2HyiCy1E1oL2tuYnqS2w5-T8w@mail.gmail.com>
Subject: Re: [PATCH] ACPI: IPMI: Fix inverted interface check in ipmi_bmc_gone()
To: raoxu <raoxu@uniontech.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 11:36=E2=80=AFAM raoxu <raoxu@uniontech.com> wrote:
>
> From: Xu Rao <raoxu@uniontech.com>
>
> Before commit a1a69b297e47 ("ACPI / IPMI: Fix race caused by the
> unprotected ACPI IPMI user"), ipmi_bmc_gone() skipped entries whose
> interface number did not match the SMI being removed, then killed the
> matching entry:
>
>         if (ipmi_device->ipmi_ifnum !=3D iface)
>                 continue;
>
>         __ipmi_dev_kill(ipmi_device);
>
> That commit folded the removal block into the existing non-match test
> while converting the object lifetime handling, but left the comparison
> unchanged. The old !=3D meant "continue past this entry"; after the
> refactor it meant "kill this entry".
>
> As a result, a single ACPI IPMI interface is never removed when its SMI
> disappears. If multiple interfaces are tracked, the first interface
> whose number differs from iface is removed instead, while the interface
> that actually disappeared remains on driver_data.ipmi_devices. The
> stale entry is not marked dead and can continue to be selected for ACPI
> IPMI transactions. It can also prevent the same ACPI handle from being
> registered again.
>
> Change the comparison to =3D=3D so ipmi_bmc_gone() removes exactly the
> interface reported as gone by the SMI watcher. This restores the
> pre-a1a69b297e47 behavior and is the correct interface matching logic.
>
> Fixes: a1a69b297e47 ("ACPI / IPMI: Fix race caused by the unprotected ACP=
I IPMI user")
> Signed-off-by: Xu Rao <raoxu@uniontech.com>
> ---
>  drivers/acpi/acpi_ipmi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/acpi_ipmi.c b/drivers/acpi/acpi_ipmi.c
> index 8f1aeae8b72e..038b502224cc 100644
> --- a/drivers/acpi/acpi_ipmi.c
> +++ b/drivers/acpi/acpi_ipmi.c
> @@ -490,7 +490,7 @@ static void ipmi_bmc_gone(int iface)
>         mutex_lock(&driver_data.ipmi_lock);
>         list_for_each_entry_safe(iter, temp,
>                                  &driver_data.ipmi_devices, head) {
> -               if (iter->ipmi_ifnum !=3D iface) {
> +               if (iter->ipmi_ifnum =3D=3D iface) {
>                         ipmi_device =3D iter;
>                         __ipmi_dev_kill(iter);
>                         break;
> --

Applied as 7.2-rc material, thanks!
