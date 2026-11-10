Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794330318;
	b=G/h++9gziW7KFoKT4k1tzT5Ljof9O4KHyGNVwdBN7/zuqijDqYBFprKpLb142jnT6lwJ
	 fb2IAi5iQdxZbr/uOGYewy0yX+dYyErd/IiJPHXN1D5GbkQEIb1KemKZ0JiznZ0LXnDdd
	 1xwxfVpmKTKGkGSmI9Y7YCXx4JBO8+q4rlcLWhg8RtOzYWjT+LMaQaVlm8SwxIV26T5R0
	 /zuiVKMI1nOUVN4vL6k63V5+XqrZzTYU6SVh0ZOAAbp+I9btgMPKdAuzI4t/WdlKg5YA/
	 XV1ia5KSUOfpuSKxo2c1k+a3l8lSiZRS3Nv95QgN2Y21kTVJQ6pEf6yrEGIHgucys5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794330318;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=uB4ZLTKdeIOszVbl3ScpQcZZ6kYQypB/7bAvtfA4px0=;
	b=yAYVHOzUPtDgAiXJReIfTZJXOUbySHJfuK8HM8dQWYxifrwE7EiKkv+xfFssDlRz9a4B
	 2Z1Tcyp+XXgvMfpuJKHEsqFTY1WyKr59a11Md7oXiHKMbqDZ0OyLM8781I7bYUo5Kdf0+
	 u0aJDXEROn4gDEMkaL+odyntTa0uevtpZhtDGyss6RWE1BR+NW+3UFdBfiZ0uZjANNNGI
	 HCSE28URTVSWJFTSzihlZtL1+REOug1yt0BMe8E7zwXRMMdrfBtpSE0jOswrJ2gYcuJNR
	 GvYfBYWyngkkbfI24s76IWbxatRFyvLS3samxSNnTO2Y5E2lws4S6MSgg/7R9H+tfRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XpIJYiT+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA787606A320
	for <linux-acpi@vger.kernel.org>; Tue, 10 Nov 2026 17:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XpIJYiT+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F7B71F008A3
	for <linux-acpi@vger.kernel.org>; Tue, 10 Nov 2026 17:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794330317;
	bh=uB4ZLTKdeIOszVbl3ScpQcZZ6kYQypB/7bAvtfA4px0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=XpIJYiT+DH6Wls6kI8zB618/xlP5iKiYSo3kgWy0vFFY4fNoab+zmqYxl2/2aCxA2
	 xt54dX7HTI3Yn6CMIqlHPHo8yEJLA2SeKbTC42PdBtd7LHya1k2uDXAjv0InURlce4
	 DgotbK6dFH47phW9EneVun9IOeEXl2iQQspg0gGTU2YK44C2SRz8rxDK6a/r0KleeW
	 n20mfqHWrLA/LmRg+NJvMEtCcWZYLuY+VjbpPvq7uOiJG4SwX8KEshwThbdWhnO1r7
	 KMe/Ue/eBPqI4J9U7xoGGNUVBJzo6+HQS/hEWFC9zsqW+/KAEkMLwJ0T0v7s6ef5MX
	 t51HZYkYMmzNQ==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5c148d4dbfbso2069064e87.3
        for <linux-acpi@vger.kernel.org>; Tue, 10 Nov 2026 09:05:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEpIVKYm60RWmZWN+gmWg8/etNksgfIP1qUNvAMsHxKLN1skrJwVApH82a6w0yw8gEAVUg/xgDTCZGD@vger.kernel.org
X-Gm-Message-State: APuU4Z/v6PiOuYE29mMt5GCSdBuUPxJphfNFFlsBC8Tg3Hyhp/h+Tdm7
	5irexVDsy423hWG69vD+losPPk6+n8bTAv7+ACcV+LNBrc06btdsXGjthy2utYW5W2Ou29zCdk+
	e/FDST6SXObHXfk9RblwZT3js49PS3mg=
X-Received: by 2002:a05:6512:3408:b0:5c1:4a5d:6ae1 with SMTP id
 2adb3069b0e04-5c156e7d626mr1138550e87.14.1794330315914; Tue, 10 Nov 2026
 09:05:15 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030193128.19493-1-muniquefeitoz4@gmail.com>
In-Reply-To: <20261030193128.19493-1-muniquefeitoz4@gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 10 Nov 2026 18:05:02 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hkM4POv0BYo5uDj7g5DonVx8c2jc2XVXEsBkkqCxVZRw@mail.gmail.com>
X-Gm-Features: AclHuK-M2pQJ8zn9halWfGVBafGfe7PU_zzxvYKLCPtO2WYLRMQ1Zok4-aTVUM4
Message-ID: <CAJZ5v0hkM4POv0BYo5uDj7g5DonVx8c2jc2XVXEsBkkqCxVZRw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: processor: idle: Add DMI quirk for HA0QING A520
To: Munique Feitoza <muniquefeitoz4@gmail.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2026 at 8:31=E2=80=AFPM Munique Feitoza
<muniquefeitoz4@gmail.com> wrote:
>
> On the HA0QING A520 motherboard paired with AMD Ryzen 5000 series
> processors (such as the Ryzen 5 5500, Cezanne), entering deep ACPI
> C-states (C2/C3 mapped to I/O ports 0x414/0x415, corresponding to
> hardware C6) causes severe system instability, random hard freezes,
> and memory corruption ('BUG: Bad page state' and list_del corruption
> in page allocator / LRU paths) during idle transitions.
>
> Restrict max_cstate to C1 via processor_power_dmi_table for the
> HA0QING A520 board to prevent the processor from entering broken deep
> C-states and ensure system stability.
>
> Signed-off-by: Munique Feitoza <muniquefeitoz4@gmail.com>
> ---
>  drivers/acpi/processor_idle.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.=
c
> index e113bcbbb..49768b176 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -105,6 +105,10 @@ static const struct dmi_system_id processor_power_dm=
i_table[] =3D {
>           DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK Computer Inc."),
>           DMI_MATCH(DMI_PRODUCT_NAME,"L8400B series Notebook PC")},
>          (void *)1},
> +       { set_max_cstate, "HA0QING A520", {
> +         DMI_MATCH(DMI_BOARD_VENDOR, "HA0QING"),
> +         DMI_MATCH(DMI_BOARD_NAME, "A520") },
> +        (void *)1},
>         {},
>  };
>
> --

Applied as 7.5 material, thanks!
