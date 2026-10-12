Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C163A4ACC78
	for <linux-acpi@vger.kernel.org>; Mon, 12 Oct 2026 18:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791828245; cv=none; b=r/PmQ/DkBUC26VyOjh4xLC4HqWNygHomFIeiRbtOAvJUHzMQSRGWCOZuRelWJjuqGso7l4L3eEwAWcTzrjFMZyB175f30yeZnL7pyUNHF2NLXnL8zFT4G1M1UFVSnjqxa1G2undctjC4aIIf0NJdStTBtL0wuj4wrFQ7VyfeafA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791828245; c=relaxed/simple;
	bh=gG9Kx7p7puwk2D18xEHfDWSfIqsQFAcxntsqTlAcQrs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c4Dt/NdbdbBZaC5FoF57OcfX+ZobllJQ3NOSgR22efmSlGSuPXMuP+Sg6/iHE5/hX55zA2bJ0mGlQEgAPhG505vaZD2vsLQXXce+aPpou3zDoganbnR2Mlgpby3dfrTRtgPqCwNmmicY1XAolPGgz9VVEyDn7Fgm9bMPVSahsGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UG4wZEA+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UG4wZEA+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 768131F0089B
	for <linux-acpi@vger.kernel.org>; Mon, 12 Oct 2026 18:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791828243;
	bh=BQKaj5Awg5w3e5n3316cCBdk7B1Ni55RY2sulUGiQTs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=UG4wZEA+09wnT3hhsYiJTI5gp7ItwMYOgHmghTaQc63BsnG+BdwKAdwkW1ehU3XVo
	 yulscydhvCCTnKp0TADs166eUDO1ggujPJTlv4gR7BUgOK0XT5fQq1jQdbpVeAdeU/
	 MImU7dG6KmfyJhALG7+B8rUfYLGoUBqvlITfkmtwIeJyyXUp3Mh4iqI8dN7wPtAdXJ
	 zXb917UDhCxhlgPFbSfMNDzoEG1cnz1VXhLHQmj3VI8CcmZaXc/nvkDX4Qaq9FxdXC
	 Z6wAQBE2bYhTsuR65mzKp65eIacAyOnZOlKc6eO+faXzWdfMKpCKlbz+aPi2QXScqg
	 RLBF5JgwEAzSg==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5ba35c0df4fso1706471e87.0
        for <linux-acpi@vger.kernel.org>; Mon, 12 Oct 2026 11:04:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByfRhRo2mwYH8kjUuUWx1Chzu4p6lIlPkBIV6ebVUyzPAuzi+LM8/aG2JHW38w70geRCZAxVdlvS89G@vger.kernel.org
X-Gm-Message-State: AFq9FYKOCq+LHIa/ANWzfylQ6k2B260AQmvSQx6/pP/o2uIN9NtngNQa
	xFb1Mfk4ClodMV1vawKh2VvIT1abGPUXsNDNyJFUlDOabkkvvLmIk6NhD8b6ZdEvEC/sMvm4d+v
	l0YeEE8H5W4ql3ipEfIg9UIC6AgmDDTo=
X-Received: by 2002:a05:6512:2399:b0:5b8:f59c:dba3 with SMTP id
 2adb3069b0e04-5bcde8bc89dmr2896031e87.35.1791828241779; Mon, 12 Oct 2026
 11:04:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261005174939.53873-1-hakan.abay84@gmail.com>
In-Reply-To: <20261005174939.53873-1-hakan.abay84@gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 12 Oct 2026 20:01:57 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iUgPZV9BtgH584GSNCYkWwgfw04PZ6rkG6tJoGnpMofw@mail.gmail.com>
X-Gm-Features: AclHuK8lXAoIHf2r9Eiq5zfHASH537dA3HLlccMtYiZlwGahTanKVaYmYQKyExo
Message-ID: <CAJZ5v0iUgPZV9BtgH584GSNCYkWwgfw04PZ6rkG6tJoGnpMofw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: PM: Add unused power resource quirk for Casper
 Excalibur G900
To: Hakan Abay <hakan.abay84@gmail.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 5, 2026 at 7:50=E2=80=AFPM Hakan Abay <hakan.abay84@gmail.com> =
wrote:
>
> On the Casper Excalibur G900, the NVIDIA discrete GPU and the second
> NVMe device become inaccessible when unused ACPI power resources are
> turned off during initialization.
>
> The failure is similar to the THUNDEROBOT ZERO case addressed by
> commit cd7ef20ba8c6 ("ACPI: PM: Add unused power resource quirk for THUND=
EROBOT ZERO").
>
> Without the quirk, the NVIDIA GPU and the second NVMe device are left
> inaccessible in D3cold and attempts to transition them back to D0 fail.
>
> Add a DMI quirk for the affected Casper Excalibur G900 with NLCC 001
> mainboard to leave unused ACPI power resources on.
>
> With the quirk applied, the second NVMe device remains accessible. The
> NVIDIA GPU can enter D3cold while idle and subsequently return to D0
> for accelerated rendering.
>
> Link: https://bugs.kali.org/view.php?id=3D9891
> Assisted-by: LLM
> Signed-off-by: Hakan Abay <hakan.abay84@gmail.com>
> ---
>  drivers/acpi/power.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
> index 23a4e207a01e..2e79defca42b 100644
> --- a/drivers/acpi/power.c
> +++ b/drivers/acpi/power.c
> @@ -1121,6 +1121,18 @@ static const struct dmi_system_id dmi_leave_unused=
_power_resources_on[] =3D {
>                 }
>
>         },
> +       {
> +               /*
> +                * CASPER EXCALIBUR G900 laptop: Keep unused ACPI power
> +                * resources on to prevent the NVIDIA dGPU and NVMe #2
> +                * from becoming inaccessible.
> +                */
> +               .matches =3D {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "CASPER BILGISAYAR SIST=
EMLERI"),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "EXCALIBUR G900"),
> +                       DMI_MATCH(DMI_BOARD_NAME, "NLCC 001"),
> +               },
> +       },
>         {}
>  };
>
> --

Applied as 7.4 material, thanks!
