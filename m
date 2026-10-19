Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792434111;
	b=ELRJ+kp0VEvkP5S03lykxPXbmNmyUou6GS58LbAnarQ4MD0JDPfpbGoP8atcMkSvt6Jt
	 JSPUpe+GkGYYifu6T8pqOLPrTqhl2kN4rLZ2c5mOZupxQQXi6FJjOwwQVkuR27xAgoM+g
	 DP89yWe/uqMkB0yF4A46o7LT4+pPDEeaYUf7JLt7SxaQJHfiK1BO3du20zc3dOw+SgXBk
	 TLylgc0NI1/dfSC1i22Q81k/4Zp6YzrMQHvSTQLxj7R4rPXdvCv3DD6Bu4vYfhwcbccae
	 Qff5aki/xXaV1rP6xYr1UgWvykhskKvLKNtQoBhxm9W/5VGJ2loRC81dO4/5JFTQ2Tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792434111;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=do9zkVOZWTTSe+5LDjSsYgl1AUnh5qNGxL8rjq6MiuA=;
	b=5T9vIHoGFaCet97Cd2qQyln5OdndC5VoC7tUSDyapr5Zt5M2NtwwEjm1Z7o78ch54tcs
	 qMcqqhMwu7jLeYPJSTkavZK+6n5J1WbqzDuufHPfjvYKmNZUsqWvkLSGEFUtm8/8MAbFE
	 UmBOiNkcVmn8xcOC8V7h4m8HBT+AWGjUaSc+yj1sa61IAclFZpup33vNcKqm0fmHacbaH
	 pRtixJ60vD8+AxBqaBvV7jqlN7Z3Ub5JhDjTvsPzYgq7+IK+68WoBdN3XFVFZxA+RUeXm
	 dYj98q9QCX4761O29G/1c42hCl9wXYjF5WY4c0IecNpRibdXYsUrbk/YCpoj0KJc+TQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eAKmgxZ1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D87606A31D
	for <linux-acpi@vger.kernel.org>; Mon, 19 Oct 2026 18:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eAKmgxZ1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4056A1F000C6
	for <linux-acpi@vger.kernel.org>; Mon, 19 Oct 2026 18:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792434111;
	bh=do9zkVOZWTTSe+5LDjSsYgl1AUnh5qNGxL8rjq6MiuA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=eAKmgxZ1+5JLvASnHX4lU3r9u10tiDogVL3XIfjJR9hxifioM7A+YCL5ICQbUZwlu
	 V6QU2EcUJy2B4BnG09mXKm+SujRPXDT/RlVzSxZAsPmgIFwG9tlNLzt4e3o4IKChYe
	 HAE789MRODKKVh4YkkB5wSV8wT+Gp1Fyl+PRqTh7ATtlC1UgTQXe6vhyyWifKEjnAS
	 p4lN5CzBj3kRSfN3LE4OUs73jWz10TCA+A7hXPXUxC1sNOVzXLpJHUlVkzWDboouHo
	 im/s1hO2Rw2TVqM/QzmklryTCSTId3sP1zItMBGzEVCbbkZYokUfoYKLydcn3SytTD
	 9kEGJD7CP3U0A==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5be4d648aacso2069864e87.3
        for <linux-acpi@vger.kernel.org>; Mon, 19 Oct 2026 11:21:51 -0700 (PDT)
X-Gm-Message-State: AFq9FYLNYmaIGAiV6GdLqzxmrFDwEE9iHYs/s1nXyIP99uaqV3K9mI6B
	g+9i1FLAhFzOyy0ewbGpuRnTQc08tGP+Qi1SC9cHdMxHRLWQZ2diSG67U9y2GquedumkkSRCNxM
	lnUYTRubpvaVjhuX9V6ds8x618TF6QqQ=
X-Received: by 2002:a05:6512:10d3:b0:5b8:997b:c606 with SMTP id
 2adb3069b0e04-5be50a6bdcfmr2945046e87.41.1792434109677; Mon, 19 Oct 2026
 11:21:49 -0700 (PDT)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CADP5X9+xCTkxXZO1dcTodrwsfW=piV41c5f_zaOq6KsrxD0Hhw@mail.gmail.com>
In-Reply-To: <CADP5X9+xCTkxXZO1dcTodrwsfW=piV41c5f_zaOq6KsrxD0Hhw@mail.gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 19 Oct 2026 20:19:34 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jnfvszm+QSFgetUVR3qqwoz3tPqDtkSLtSp8XHw9KraA@mail.gmail.com>
X-Gm-Features: AclHuK9xes9SpWTJiLid9Oh_hvDgachX_0eJPV3PwmhXXb23XzyQu40fclhb5RI
Message-ID: <CAJZ5v0jnfvszm+QSFgetUVR3qqwoz3tPqDtkSLtSp8XHw9KraA@mail.gmail.com>
Subject: Re: [REGRESSION] ACPI: Power button (PWRB) broken on multiple
 machines after 6.18.57
To: Domenico Suppa <domenicosuppa@gmail.com>
Cc: linux-acpi@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 18, 2026 at 7:16=E2=80=AFAM Domenico Suppa <domenicosuppa@gmail=
.com> wrote:
>
> This issue is not limited to my machine (ASRock H310CM-HDV). Multiple
> users have reported that the power button stops working after upgrading
> to 6.18.57.

So can you please identify the change in 6.18.57 that broke it?

It looks like 6.18.57 might pick up an upstream commit without a dependency=
.

> I found an upstream patch that exactly addresses this:
> "[PATCH v1 2/2] ACPI: scan: Use acpi_setup_gpe_for_wake() for buttons"
> by Rafael J. Wysocki, which states:
>
>   After starting to use platform devices for representing buttons
>   enumerated via ACPI, acpi_mark_gpe_for_wake() is insufficient...
>   This causes acpi_enable_gpe() to fail and system suspend transitions
>   to be aborted.
>
>   Fixes: 52d864019636 ("ACPI: button: Convert the driver to a platform on=
e")
>
> My machine is also affected: PWRB (PNP0C0C), evtest shows no KEY_POWER
> event, and /sys/firmware/acpi/interrupts/ff_pwr_btn returns
> "0 STS invalid unmasked".
>
> The DSDT for my board (ASRock H310CM-HDV) shows the PNP0C0C device
> without any _PRW method:
>
>   Name (_HID, EisaId ("PNP0C0C"))
>   Name (PBST, One)
>   Method (_STA, 0, NotSerialized) { Return (0x0F) }
>
> This suggests the button may rely on a different mechanism (possibly
> fixed event) rather than a GPE declared via _PRW. The ff_pwr_btn counter
> shows "STS invalid", indicating the fixed event handler is not registered
