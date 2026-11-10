Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794330637;
	b=JNrqgNAAqox56FLeH48kSlRl7gtDR8kf0CDUTHiFKCdPNSJ3egYFyuBElgTJR4d39FhC
	 xUuIogkQejQA7BXuIM3fANltaNeW43LvMwFPqDK6Lh1IucYiPZWcAeFT92njZqOS5uCjo
	 MydjDqEf0f56pgXPLXE1EpPwrcPZN7ciOsxH68IP4MTWCqh1UG1oA3yf/EvdsReAgMLSO
	 PM5Wi0BUjfPb6jiMSmoK/dPu4q1Nak1FX7p+ZDhFPlAFmxeqkmbZ23rpXtavUvQC0GUmq
	 flFoHH5YCAwektTYmRlFfb+rE2fKy2C8gaGGr78BIzKzKVnPC2G7UXsVyyCVjOR1VzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794330637;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=przLLxAqFqjpDdZgtU4TWcmHK4UDhoFC4j8tCCnZGaQ=;
	b=Gl4v6VmKDS/PUVLUWoG2twTa22qNfqV9NrfIspZmIwWZWeV2sgJ/IB2LUrMc8FQpL3Hb
	 N6Oz+eeb90MP/fk5XnvB2sUEPJfKU27Ata4rIbH+yMawyDDw9Ll4+QciF2MBL0Agrbuao
	 mgK6rHRH5zB7yjhpBUfCZPzVt1/YTnbbhrEvCcxnTXJZRgD9Ta86KEqYSS76SBXq/m7GM
	 E0D3+30Ac9EWmMT4Wl44R9qmWdp4KcErKrOn22fG1utgeiroFJiRr0i4kvklt29xN60th
	 qJzk6xGozVgRY8NIvWGN6ws+7h3pCcVHAjAVtvIwcOq034dG2yzaUNf37h2LOgr32mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hbfk1z6W;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6608606A320
	for <linux-acpi@vger.kernel.org>; Tue, 10 Nov 2026 17:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hbfk1z6W
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE95D1F008A2
	for <linux-acpi@vger.kernel.org>; Tue, 10 Nov 2026 17:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794330636;
	bh=przLLxAqFqjpDdZgtU4TWcmHK4UDhoFC4j8tCCnZGaQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=hbfk1z6WpzUrIO1EAAZQWi4nOjH/1V2YeFK8X+dld2Yt2c07hZRfPl8UhEAzVNtqX
	 6qe+pzgHyVRW0MsaR77Q1GI8QzWmHmySYcwKkxn6eaugbU0FKCm3spfNzprEWayuBR
	 Dc/HJN6lpMqnEC1fMSfgGGDxGxbj+KSUn6TjkTkU36iJp1VaYhHI8lGxvqkV3iyEfP
	 b65RqtvpOr85l1t9ObninIYhXQYu3cxVgXMYbaseduASqkKfpxsnKYL045CYECEzsV
	 FTM1QeExIXCc9/2z4TaGSQICMQmcIH4UQl8pRyLb1zgepZeOoDClyfmwbIShhGh/Pf
	 qijr9rX2ItIOQ==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3adfe77d35aso18409241fa.1
        for <linux-acpi@vger.kernel.org>; Tue, 10 Nov 2026 09:10:36 -0800 (PST)
X-Gm-Message-State: APuU4Z/DIWO2AOoLq4t0wh3K+vVjv/FwpAYe7E6yri496R1yax7Hkfum
	fEbvm2zLNJXOJP54w3xIFrj9hkwQjcP3r7nbaO4otl0f3i5zR1NWtd9Qm5pgmwBhkvMJ0QDO2Xe
	V3KHKDu5sE166JTen2HPIFks2eZgIxn8=
X-Received: by 2002:a05:6512:1288:b0:5c0:b5c:4052 with SMTP id
 2adb3069b0e04-5c156e37b7cmr1034036e87.2.1794330635114; Tue, 10 Nov 2026
 09:10:35 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261031144115.4189-1-zakat1984@gmail.com>
In-Reply-To: <20261031144115.4189-1-zakat1984@gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 10 Nov 2026 18:10:22 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0h+hO6Vb3fw=VJeZ0PNAHMv_TtUSUUBy04xV=wKwGQqOA@mail.gmail.com>
X-Gm-Features: AclHuK9kE2PCOKFFc9C_M4-O18Red5IDQN9yUpwGjs2Ud0CSIUQUEgtFAYYck_Q
Message-ID: <CAJZ5v0h+hO6Vb3fw=VJeZ0PNAHMv_TtUSUUBy04xV=wKwGQqOA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: resource: Do IRQ override on MECHREV GM7RG7M
To: Andrei Galiant <zakat1984@gmail.com>
Cc: linux-acpi@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 31, 2026 at 3:41=E2=80=AFPM Andrei Galiant <zakat1984@gmail.com=
> wrote:
>
> The MECHREV Jiaolong17 Series GM7RG7M (TongFang GM7RG7M, Ryzen 7
> 6800H) describes the PS/2 keyboard interrupt in its DSDT as
> edge-triggered, active-low and shared:
>
>     IRQ (Edge, ActiveLow, Shared) {1}
>
> The keyboard controller actually asserts IRQ 1 active-high.  On AMD
> Zen systems acpi_dev_irq_override() skips the ACPI IRQ override for
> GSI 1, so the IO-APIC redirection entry is programmed with the DSDT's
> active-low polarity and the interrupt is never delivered: the embedded
> controller still scans the matrix and places scancodes in port 0x60,
> but atkbd_receive_byte() is never called and the internal keyboard is
> dead under Linux, while it works in the firmware setup, in GRUB and in
> Windows.
>
> Add the board to irq1_edge_low_force_override[] so that the standard
> edge/high override is applied, matching the already-listed sibling
> GM7XG0M (Jiaolong17KS).
>
> Fixes: 9946e39fe8d0 ("ACPI: resource: skip IRQ override on AMD Zen platfo=
rms")
> Cc: stable@vger.kernel.org
> Tested-by: Andrei Galiant <zakat1984@gmail.com>
> Signed-off-by: Andrei Galiant <zakat1984@gmail.com>
> ---
>  drivers/acpi/resource.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index 56df459..0a944ba 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -553,6 +553,12 @@ static const struct dmi_system_id irq1_edge_low_forc=
e_override[] =3D {
>                         DMI_MATCH(DMI_BOARD_NAME, "GM7XG0M"),
>                 },
>         },
> +       {
> +               /* MECHREVO Jiaolong17 Series GM7RG7M */
> +               .matches =3D {
> +                       DMI_MATCH(DMI_BOARD_NAME, "GM7RG7M"),
> +               },
> +       },
>         {
>                 /* XMG APEX 17 (M23) */
>                 .matches =3D {
> --

Applied as 7.5 material, thanks!
