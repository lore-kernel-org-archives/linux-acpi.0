Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794253273;
	b=pRNAnCY27gZh2FPZ+dzUunFTcn1TitIuSAJtxN23GV4CDW1bGN9WI06clxO4x8flrRUC
	 AwizhxbpPYY1WvRu+0KYG1n+q8+IsRcKGJ6sM1c43Ez6LBN0aqoV3z18RhbTrHoxQjGuZ
	 jNV8Hq/TDaGL7Lu/ZIcI7kVg7J3oSbav8WeK31Fk2n6aAordAbHsmtchFl/vGg2E7crkk
	 DGV2w1BHPeYfHpkhw8IUiWV1GMuvmKqKtGWohEYPkAKiMKCgBasG74iW46U9RfAF9LNG+
	 Ve1Os818Dt2uz59bmIbgpoeXbFmICSDCAb6YjEhMx9j3gjFScLaQVxvqV4fe1Fc6k6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794253273;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=fHpmjgsECIJi25ho/DxnUi1oX2Fy65R+OMp2li13J7k=;
	b=0277jKvRKZWKYcEaQ2Vp94lyv4dkHoSlDNvWH8Tm1izgclwO3f3aB81ZbTtuSvfLuPSx
	 YDNu1LZgG9uUAHBqwj6+zRCuPU2072thjSOWNWf3syNaeDB0pXWmUoTMw2bsLMKtanLVK
	 wBnFntBH3RvOFVaKLooz3Gf2u3lG5P68zZnA39v/nKuVYr1u3tbu0YW2gs0vq7Qu5tV02
	 2h/oFlfUejUHy5wfDIr3rIdWEXyYVrGI1GfgeIs3GQTbzfjZnFfFy5/EVMgxCpYEYfiVg
	 UV2nZcPQoUOtJNMKRvmVDyByvRJqpmnHkHzVsx7nYthvhxFU33CdQzWb+WAmTdPXGUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MF4ck2Pc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44F3606A321
	for <linux-acpi@vger.kernel.org>; Mon,  9 Nov 2026 19:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MF4ck2Pc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A21011F008A4
	for <linux-acpi@vger.kernel.org>; Mon,  9 Nov 2026 19:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794253272;
	bh=fHpmjgsECIJi25ho/DxnUi1oX2Fy65R+OMp2li13J7k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=MF4ck2Pc8I2KKygXZ4b4Y8mXk/y40jXRg8bD3N9msZKjNKjBygyDmfnRprZ2l559f
	 cegihAQrUpbeJcpuO5ptXxqZ3+6SlKRDEyfk0CMKR5mFoRfBuTSjtT9lYAJpHj7pOB
	 Zyrl1n/zLOGLz0kCHdkQsM5e24WKs033u0hvs74Bl9oUKJplsrLEbaMf9dSUFnzOPY
	 dQ2PK8IflS/TsQcxwjx+9i9px9Ehj7ZFad30L2LTPXzDjhJ0XJXFk8fpfQYoWdyCTX
	 KtNJnx1hlxt6kOk6BTzTX0h0GxqskUf5Ew2sYE0KEvQGZkQPMxsyPhiN7UXunEKX+c
	 Plujqm2rGEomg==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5bcb6faf862so1172499e87.2
        for <linux-acpi@vger.kernel.org>; Mon, 09 Nov 2026 11:41:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGbgDmG4lnzGmnxioPRq1+HSXBLYHsDEV583KhkW5pzNea7gVvawji1ILsXNe7uqqhkogtnbXfmQUyP@vger.kernel.org
X-Gm-Message-State: APuU4Z9sukqj06Fw3/hy6gVmyMQ990Wx3Q2BufeHLdwdovqjF3e+NFLn
	dsG60SJGiZ1pt+sZqvBY5II+dlTlP11X7mM/30duUNDz3PmcE3ZPu8HlmRDMt8x4GqSlRXYsKRB
	9lFo4h1o6Hj5cbyGXiBKMC5pMvYQUKcs=
X-Received: by 2002:a05:6512:3d91:b0:5c1:5006:9e8e with SMTP id
 2adb3069b0e04-5c156e8b6e8mr132729e87.29.1794253271030; Mon, 09 Nov 2026
 11:41:11 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027161650.59170-1-mail@taterr.org>
In-Reply-To: <20261027161650.59170-1-mail@taterr.org>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 9 Nov 2026 20:40:57 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gJGTY6F4gXPvaAPYQdA=3hqJu0+TyO9GMugQM5UQxzxw@mail.gmail.com>
X-Gm-Features: AclHuK9zrMj8xCWUkjHiVZslksOZ0-hUZelgJ8Pb4AIwM2FFKBbdpep1khz9AuM
Message-ID: <CAJZ5v0gJGTY6F4gXPvaAPYQdA=3hqJu0+TyO9GMugQM5UQxzxw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: fan: add missing MODULE_DESCRIPTION()
To: George Karagounis <taterraster@gmail.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mail@taterr.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 5:16=E2=80=AFPM George Karagounis <taterraster@gmai=
l.com> wrote:
>
> modpost now warns about modules without a MODULE_DESCRIPTION macro.
>
> Add one for the ACPI fan driver to silence the warning and provide
>
> proper module metadata.
>
> Signed-off-by: George Karagounis <mail@taterr.org>
> ---
>  drivers/acpi/fan_attr.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/acpi/fan_attr.c b/drivers/acpi/fan_attr.c
> index 9b7fa52f3c2a..6b3d91c14f5c 100644
> --- a/drivers/acpi/fan_attr.c
> +++ b/drivers/acpi/fan_attr.c
> @@ -15,6 +15,7 @@
>  #include "fan.h"
>
>  MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Extra sysfs attributes for the ACPI fan driver");
>
>  static ssize_t show_state(struct device *dev, struct device_attribute *a=
ttr, char *buf)
>  {
> --

Applied as 7.5 material, thanks!
