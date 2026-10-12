Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750EE4C6522
	for <linux-acpi@vger.kernel.org>; Mon, 12 Oct 2026 18:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791828413; cv=none; b=lTCE++5LU0n0Q5Q8bCacI99i/YS0VBryGn5B6dai/ySBunEqyzQbPHj6ofHalUuLH7sp7nJLIv6G+KEAisTVQYTQJsjYPY/gJKmbT0i+KqaujoT9E4np0xRiP7s5kHX3xz/uF+NTTva9LbP9GFOAV4NQHRKUh6bypm7FgzaQSRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791828413; c=relaxed/simple;
	bh=WB+c9gJ9x0z/GXQzHq1xKnaSyOtrQGKVWPTilcEL+gI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PKK3JeVjIDjv6pyl0r/inrNAZGAvtZo/Go2e0a38bLEZWd5bbm0pIAmOUdhMG1lcBURNtJowX1eOWwyDRRMrm232mnD2JP9nuPLFCo1o+88W+RObF/8OXI36QIhmBoyahT80qXauqtUOzC8evUpz6gt0gP61qLaVUN/r6129gEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L69WIJpX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L69WIJpX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 198591F008A2
	for <linux-acpi@vger.kernel.org>; Mon, 12 Oct 2026 18:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791828412;
	bh=H0AzNFORaAGmI+3CO2UKiCL329dNPF72DuI/v/QkD10=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=L69WIJpX+NbfPNEZM0wrKH9mvztvK4eMm6uPstsul99BBb14NBOg+LNdwr1irmUJh
	 Mx6C0iZCDdtRYKusetXCFuOFCmBrl12hNFWfO0por1+rKN+sJpbR0IUpBmhEnLhI8U
	 g5wU+GeXJIpEEl9Nl6jeTme00rPWtr/gb8VW/wreaqzB1JxyJEsw71a9NRijXCrIT/
	 wH/txKpPEzHlRLPK6vz8c38rj4oJdhhCyGSvA7BpCA5l/1XrYceuMaF414zIzH2T/Z
	 2WdxFbASV4SI7OQ+9LQRkwllE1kaamyOrDWxccG3O0s/rfdK0EI4qRT8jD6tDbn0qS
	 yI+xP01wHz7Tw==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5bcb2ecebb4so1614949e87.2
        for <linux-acpi@vger.kernel.org>; Mon, 12 Oct 2026 11:06:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxJovhb1d9qu34csFSvJVCSAz7Q0C7zeLLxdKsQCrpJlddgTs7uXErP22Qd1T3YHEscb+n15N7RgZDj@vger.kernel.org
X-Gm-Message-State: AFq9FYIrwxQiR6J5Q2DIm9ZvRRHDSDAoaA18AG6Dfl3OpOGU5xxvZEes
	li0ivpYOaG1JDP1uI71NBLXLYLQDQb1yZN/0f+lOVKIi9Srxk0FKkkl3j+VW/O57Gp5X7Ne9Ng4
	CbHYeDoJoQRqByk2WZmxy2IDWkaYGII8=
X-Received: by 2002:a05:6512:4026:b0:5bb:6dda:9e1b with SMTP id
 2adb3069b0e04-5bcde8e835cmr3164300e87.65.1791828410523; Mon, 12 Oct 2026
 11:06:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261011054455.1472-1-lofm2605@gmail.com>
In-Reply-To: <20261011054455.1472-1-lofm2605@gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 12 Oct 2026 20:04:45 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ijcsXpPutEXf2TsSry8Hg8i+Bx8Or_9=cK3HmcGW45vg@mail.gmail.com>
X-Gm-Features: AclHuK9Rwpe_QOE8lV2HkxnKrLB9J8XUSALdLwwRidrXayAM0a_vQJoyix6ml3c
Message-ID: <CAJZ5v0ijcsXpPutEXf2TsSry8Hg8i+Bx8Or_9=cK3HmcGW45vg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: PM: Add unused power resource quirk for THUNDEROBOT 911Pro
To: lofm2605 <lofm2605@gmail.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 11, 2026 at 7:45=E2=80=AFAM lofm2605 <lofm2605@gmail.com> wrote=
:
>
> From: VU TUNG LAM <lofm2605@gmail.com>

I would have applied the patch, but the above doesn't match the
Signed-off-by tag below.

Please fix this up and resend.

Thanks!

> On the THUNDEROBOT 911Pro laptop (board NLCC, BIOS TP127), the NVMe
> drive in the CPU-attached M.2 slot (0000:02:00.0, behind root port
> 00:01.1) and the discrete NVIDIA GPU (0000:01:00.0) are inaccessible
> after boot:
>
>   nvme 0000:02:00.0: Unable to change power state from D3cold to D0, devi=
ce inaccessible
>   nvme 0000:02:00.0: error -ENODEV: probe failed
>   snd_hda_intel 0000:01:00.1: Unable to change power state from D3cold to=
 D0, device inaccessible
>
> Both devices are enumerated normally and work under Windows. This is
> the same symptom as on the THUNDEROBOT ZERO, a sibling Tiger Lake-H +
> RTX 3060 model, which was fixed by commit cd7ef20ba8c6 ("ACPI: PM: Add
> unused power resource quirk for THUNDEROBOT ZERO"). The SSDT with OEM
> Table ID "TglH_Rvp" on this machine defines PXP_ power resources in the
> same way, but the existing quirk only matches product names containing
> "ZERO".
>
> Add a DMI entry for the 911Pro so that its unused power resources are
> left on, as is done for the ZERO.
>
> Fixes: a1224f34d72a ("ACPI: PM: Check states of power resources during in=
itialization")
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D222118
> Assisted-by: LLM
> Signed-off-by: LamVU <lofm2605@gmail.com>
> ---
> Not tested: I have not been able to build and boot a kernel with this
> change yet. The failure was observed with Ubuntu's 7.0.0-31-generic
> kernel, which already contains cd7ef20ba8c6. I can test a patched
> kernel and boot with dyndbg=3D"file drivers/acpi/power.c +p" if needed.
>
>  drivers/acpi/power.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
> --- a/drivers/acpi/power.c
> +++ b/drivers/acpi/power.c
> @@ -1121,6 +1121,20 @@ static const struct dmi_system_id dmi_leave_unused=
_power_resources_on[] =3D {
>                 }
>
>         },
> +       {
> +               /*
> +                * THUNDEROBOT 911Pro (board NLCC): same SSDT bug as the
> +                * THUNDEROBOT ZERO above. Power resource 'PXP' is turned=
 off
> +                * as unused during initialization, which makes the NVMe =
drive
> +                * in the CPU-attached M.2 slot and the NVIDIA dGPU
> +                * inaccessible.
> +                */
> +               .matches =3D {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "THUNDEROBOT"),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "911Pro"),
> +                       DMI_MATCH(DMI_BOARD_NAME, "NLCC"),
> +               },
> +       },
>         {}
>  };
>
