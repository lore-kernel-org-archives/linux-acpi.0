Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794331614;
	b=t3IceITl8G0Q0N3Sblermdmj90aTHeTMX+oTzDE4ZEWP5xye3ExXa024ohHwp9cnVLrj
	 ucDEi/yLGa8GJYCnofsITTtATP6eDV4g0cCBUuetzE9Bu7b3WhUuHCJGRPbMx6+0bcOko
	 e4+IF41SNaS2cqGL19lLvLAlKkTeE4qVdGK4GaXrFm4sY13ntUGC6bgCl5UuYfdGZNRqo
	 8TXZ+3xeX+UnMHGMZx4BzNFape1/CMEqoIsYXMvWUmv2f5GMNO/9ejXQgQVKlrtbMPcAg
	 dpskvfdqj0v3MJJ+Pyd6q5azvhRqMwowxs6EcHgEnl5yB63KRlxXLfl/ZmXo4hTHm3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794331614;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=cmQoUl9fujoMKZGwxPMJk/W1qqjVzAa+dA0fv2IKSMw=;
	b=2zg37WuqhNuqcSZjZ4TAogAK9wfi2gGUf94O+ouGYdzi9FFGYpXzI8ENRhClvl4kJ1rV
	 SWkHQxWPdfnTkNbxy4rjU80uoGxDewm1a2wHJFNN7I21AF8W+6ffkUBIEzI4ckzXOGsbC
	 JVoQjwaZDT/s0IiJyabrgWbpUpfwU0S8eAuScexC5L3x2ZZxOxBjVJY6lqO9EhQVQVyYa
	 AzRKsblmH3WPhPVG2QmH20POxI9PhIeo69Mzd1ixishe+m4y/3l8KP5v0zyVwp3Cr9y96
	 xnWemym3gXyqsNe+jU2eomD5Kk9mZ2xhVyYxlvaS5DpUso/qHRjkMV7NFSS07REQjYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XWKVhwUY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8142E606A31C
	for <linux-acpi@vger.kernel.org>; Tue, 10 Nov 2026 17:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XWKVhwUY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EB931F008A5
	for <linux-acpi@vger.kernel.org>; Tue, 10 Nov 2026 17:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794331613;
	bh=cmQoUl9fujoMKZGwxPMJk/W1qqjVzAa+dA0fv2IKSMw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=XWKVhwUYw2SyrkUSuYDPn4wNX/g3itQ/zZfFoGqSrdWTMTTQu/Z8wcQ0+HicaZQG/
	 ML0VK7tPHlid9zxNjAm7/Dv/6XYHyBeQF+fosNQxvSfN/biQogigY2LFmIdsJmWPJC
	 Z7WxUGjaj17kKXOOEq8MJG/7AgiXnt/lKWJsSEEFiRJbAjIlsLIgKYj7uQDL6vy1hL
	 0HwNNSBjWJaUr7a48LT5xzgKvXkyViWf8kMsMLbwSifTBL0r6Mspqs4/oNUWx9yhRf
	 PFj9Rf4QERfbGNppxoeDi/AqK3Em5W+1GNpZ8Gl8hxSV7y9KPrA3rtoZbqVe1jVZTL
	 gABomlT8sJjug==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3adfc004920so19753481fa.3
        for <linux-acpi@vger.kernel.org>; Tue, 10 Nov 2026 09:26:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGGr0+9vBPLg+tTcJ9hhRoUv15RY4BwX/FXa6+2DNlZgXqFy3vNHpSkI42pBBZYG+OmdUhc5uz9YPBb@vger.kernel.org
X-Gm-Message-State: APuU4Z9FcXPWKGmL0X9DMFGc0y1UR6v/u2jTE83s7yxk7atS9n9g8QYw
	nHujCPGnR6kvyekySl8tVYliEVZggYsy/DF4NVkwofIBi0yjKpZv6mnMR6a9+ahTfzQLDXF4Vyp
	gcU2/eEnQlY7vzMMArh9IFQoEqRVVGRY=
X-Received: by 2002:a05:651c:2214:b0:3ac:ff0a:9d86 with SMTP id
 38308e7fff4ca-3ae096202efmr6674061fa.15.1794331611570; Tue, 10 Nov 2026
 09:26:51 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103114118.74782-1-k.chen@smail.nju.edu.cn>
In-Reply-To: <20261103114118.74782-1-k.chen@smail.nju.edu.cn>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 10 Nov 2026 18:26:39 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iCfDR341Barrui1TSiY6o7ePYd2f7aZYXvo3aper2pvA@mail.gmail.com>
X-Gm-Features: AclHuK9Olaj_vF-OXIzinsrYt4nJo78Pj_uJi8sT6dq3T9Ngf7ytgRHpahlG2po
Message-ID: <CAJZ5v0iCfDR341Barrui1TSiY6o7ePYd2f7aZYXvo3aper2pvA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: video: reject out-of-range _BQC indexes
To: Kang Chen <k.chen@smail.nju.edu.cn>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Aaron Lu <aaron.lu@intel.com>, 
	Danny Baumann <dannybaumann@web.de>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 12:41=E2=80=AFPM Kang Chen <k.chen@smail.nju.edu.cn>=
 wrote:
>
> acpi_video_bqc_value_to_level() indexes brightness->levels[] with the
> value returned by _BQC once the index quirk has been armed, but does
> not verify that the value is inside the array.  A firmware that behaves
> consistently during the quirk detection and then returns a large value
> can make the driver read out of bounds; the reversed branch also
> underflows before indexing.
>
> Return an invalid level when the index is out of range, so that the
> existing callers disable _BQC.  Also guard against a brightness table
> with no usable levels, and tighten the range check in the quirk
> detection before its reversed subtraction.
>
> Fixes: 994fa63c5b12 ("ACPI / video: Fix applying indexed initial brightne=
ss value.")
> Signed-off-by: Kang Chen <k.chen@smail.nju.edu.cn>
> ---
>  drivers/acpi/acpi_video.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
> index 2a2822516665..44af7ffb9a81 100644
> --- a/drivers/acpi/acpi_video.c
> +++ b/drivers/acpi/acpi_video.c
> @@ -533,6 +533,13 @@ acpi_video_bqc_value_to_level(struct acpi_video_devi=
ce *device,
>                  * items with special meaning (see enum acpi_video_level_=
idx),
>                  * so we need to compensate for that by offsetting oursel=
ves
>                  */
> +               if (device->brightness->count <=3D ACPI_VIDEO_FIRST_LEVEL=
)
> +                       return U64_MAX;
> +
> +               if (bqc_value >=3D device->brightness->count -
> +                                ACPI_VIDEO_FIRST_LEVEL)
> +                       return U64_MAX;
> +
>                 if (device->brightness->flags._BCL_reversed)
>                         bqc_value =3D device->brightness->count -
>                                 ACPI_VIDEO_FIRST_LEVEL - 1 - bqc_value;
> @@ -781,7 +788,7 @@ static int acpi_video_bqc_quirk(struct acpi_video_dev=
ice *device,
>
>         if (level !=3D test_level) {
>                 /* buggy _BQC found, need to find out if it uses index */
> -               if (level < br->count) {
> +               if (level < br->count - ACPI_VIDEO_FIRST_LEVEL) {
>                         if (br->flags._BCL_reversed)
>                                 level =3D br->count - ACPI_VIDEO_FIRST_LE=
VEL - 1 - level;
>                         if (br->levels[level + ACPI_VIDEO_FIRST_LEVEL] =
=3D=3D test_level)
> --

Applied as 7.5 material, thanks!
