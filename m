Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941D940B36E
	for <linux-acpi@vger.kernel.org>; Fri, 21 Aug 2026 19:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787340933; cv=none; b=f++nhvrIgmCUsIf6mAwrAYyJuBBbPUn22+wUhA1Mya8pRrPKdQKbjyTj/htUvwmTFdkDVIVGbvY/xkl/iyRn72xt2HiiWbmHuiL3RaWMFZ/VC6WJn9ttyGod1NyJqH0NC3j/qvN903V6/lJh06cnQM0kCDT8cGnbbiZ1LUzMnf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787340933; c=relaxed/simple;
	bh=+kTVOgY3+G3Lk4f2mkpJ2phouhPnAHMLbkHysAMIBMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=klBWKyxgC8Z5Hkn+7rK5mz1ng+rl/9OGt7568H+qok+ZdGEHcPtNsxVdLNZ5RhtiZMMMAz0c3RSCx9+PNeWA53CJRrxRqFcFnEwUf5K7geOGNrXMif3ECJi4mQ87yv+H+vtoGotrSJODzjXno1E2h2maeSWIN4yu9BRtUxpPdcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YGGz0znH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YGGz0znH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40FEC1F000E9
	for <linux-acpi@vger.kernel.org>; Fri, 21 Aug 2026 19:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787340932;
	bh=hTt66gfcabXzoqjxK/8k4TigMiD9I6rFXawtq0/dbzk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=YGGz0znHlPFQehijynSYjqQH/sc2zYUKUby8456lafiEz/mjHYWtbKVOu+RFw1eiQ
	 Jl7dJkdvRpiHkKADtol9Wgb7eFH6A2HrgLCYXaI2Hj3RdloUXFkIwkSaeThyqnSZwL
	 qAJvxW5FVUU8JMGgCkn8id/vH1YIuJ2uX69lqoG7iOcgklj4F+Y1RNsIRwmKrICPw4
	 3fNlwEHFs8GgnO5NLE5qzUur+efqEdAAhhxvnWOXe9JMpJlA1QRndTngR1VHBh7MIh
	 3M6OG2cth6xB0GWy/TERou6QqCQhbOTAikDoSjk40uATQQPeWI7II0aHKx1XzGkwro
	 orMf7tWJGG7oQ==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-39c7ef2b1e2so13610581fa.1
        for <linux-acpi@vger.kernel.org>; Fri, 21 Aug 2026 12:35:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rp0hNSqn/ysaOmOJuQgOq4q3HSPnY7qGJq8GY2m9Dy1BQhbY4/mTu4jn3Khp91wFhhsAZwjIH8h6+i9@vger.kernel.org
X-Gm-Message-State: AFuF++kZu7McVqOEwRw/rMTqYoskCWL6iOaW0N5jm5XsB0VDf5ft2rmY
	i+SOu/5cAj8IvIgGdyZM5jddRFpoUSMdAz5owOsSuEJtgTsUn/VfjRbhSu6dKrxfUZZ0vLJoqDQ
	qftNhPz+pHmwdrx49zUMh3zP7QeavdDg=
X-Received: by 2002:a2e:b8cd:0:b0:39f:fc5b:5183 with SMTP id
 38308e7fff4ca-3a1aeb6f9aemr23260691fa.3.1787340930745; Fri, 21 Aug 2026
 12:35:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260817133259.195548-1-robineveraars@pm.me> <20260817141414.213075-1-robineveraars@pm.me>
In-Reply-To: <20260817141414.213075-1-robineveraars@pm.me>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 21 Aug 2026 21:34:54 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0juBUKAfrjLD_OK0oyfutkLyL5b0876E9C6yNWo93gekg@mail.gmail.com>
X-Gm-Features: AcwNN1UVmXPIk0CH7q_r_A4ifzeoWGZgHTL9REsNEbWYQFOId5RIwt7mjLnoDaY
Message-ID: <CAJZ5v0juBUKAfrjLD_OK0oyfutkLyL5b0876E9C6yNWo93gekg@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: button: Add DMI quirk for Razer Blade Pro 17
 early 2020 lid switch
To: Robin Everaars <robineveraars@pm.me>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2026 at 4:14=E2=80=AFPM Robin Everaars <robineveraars@pm.me=
> wrote:
>
> The lid switch reports "close" but can miss the matching "open", leaving
> _LID closed after resume. systemd-logind then suspends the system again
> roughly every 35 seconds.
>
> Reading the embedded controller's PSTA byte while _LID is stale shows tha=
t
> bit 0x04 is set, which the DSDT treats as open. The DSDT returns the cach=
ed
> LIDS byte from _LID. Its wake path aborts in RTEC on an unhandled
> SystemCMOS region before copying PSTA to LIDS.
>
> Initialize the lid state to open on resume, matching the existing quirk
> for the Razer Blade Stealth 13 late 2019. With
> button.lid_init_state=3Dopen, a physical close suspended once and resume
> reported open without another suspend.
>
> Signed-off-by: Robin Everaars <robineveraars@pm.me>
> ---
> Changes in v2:
> - Sorry for the noise. Proton's external OpenPGP/MIME signing inserted li=
ne
>   breaks into v1, so its diff could not be applied.
> - No code changes compared with v1.
>
>  drivers/acpi/button.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
>
> diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
> index 3836ee75dd66..cdbb1023a8ee 100644
> --- a/drivers/acpi/button.c
> +++ b/drivers/acpi/button.c
> @@ -133,6 +133,17 @@ static const struct dmi_system_id dmi_lid_quirks[] =
=3D {
>                 },
>                 .driver_data =3D (void *)(long)ACPI_BUTTON_LID_INIT_OPEN,
>         },
> +       {
> +               /*
> +                * Razer Blade Pro 17 early 2020, notification of the LID=
 device
> +                * only happens on close, not on open and _LID keeps retu=
rning closed.
> +                */
> +               .matches =3D {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "Razer"),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "Blade Pro 17 (Early =
2020) - RZ09-0329"),
> +               },
> +               .driver_data =3D (void *)(long)ACPI_BUTTON_LID_INIT_OPEN,
> +       },
>         {
>                 /*
>                  * Samsung galaxybook2 ,initial _LID device notification =
returns
> --

Applied as 7.3-rc material, thanks!
