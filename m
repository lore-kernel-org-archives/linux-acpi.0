Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794332571;
	b=APEWuncwoH09nZbLe9Swz/v2SOjbejA/u60ZOKHpPpa0Au9BKM4z2GOb0MKa63csEd5y
	 QTUCwNqylBnvvgUQCONNMJZkZIJdEHxvx0wYNnTMJB7PRVeakjI+IrHrEZ8ETdySpa7Mq
	 c+Kkp3y6KhCOjE0a+UVUf5X3HNprD4X1g9BmEM2VTnIy+ejjCmdMa1SqTz4tXlqs2KG8K
	 jeGxrSomseGFhmfeHoYQm498XK3lkXDI/YtvxyYPnLYm1GfZgfmseSisbqlAWQB6Msif2
	 0JTYT2Ru/bp4ku0ILHNbFuGhfzVni9VWBnKcv36rpdtOQKyL7r5uQvVYugce1nem8OA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794332571;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=WJ2VhX1zIunziDo8+1yMjNUGG0cVlFTY9J5xCG4anBY=;
	b=nT+pqosZoi9ZIDXekaY288VBvoYT1+FHGdViL2xf91AdlVYg6EhYUP2AbNY7ZSdA3t5k
	 GZ8pnTKqSWzaAZzIatRPlaNDjS1Y4YQyD3gsElLJFnIRKVgXCKRofxF/mzhbJXxIhHqxs
	 TlWN1Hd8ZgBqGcpoi9K/B6+p4wg9NgKzaRhH2TkJkepX/Vmffsusj9xR0C39hc8Y82bvU
	 /MEpp9CiYS7sxyVFgBvGT4oTY94w7NaVGHWHy6+3tQzZXnmcTh8pXEdkEDHTNWtJqTO8M
	 LKv57Tee11pVi//d0jHV3e87JktPeg21uV3nx4BRWtrGZCL1MODaSIkwfP2Ch80jJkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rrs1g4bI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9D560A2612
	for <linux-acpi@vger.kernel.org>; Tue, 10 Nov 2026 17:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rrs1g4bI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27EE81F008A6
	for <linux-acpi@vger.kernel.org>; Tue, 10 Nov 2026 17:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794332571;
	bh=WJ2VhX1zIunziDo8+1yMjNUGG0cVlFTY9J5xCG4anBY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Rrs1g4bI3bealFFCrTKGzgW7nULJYNNq0U8n1ryvUN1UTexowUObEe4GzxWkm0SVc
	 bax9c4VqNOuEFa5aCuIQGmbq0iwqZmNUIXBpc90R5VJ0fHsKlZl3na6po4egT9VG7D
	 jtlhGQhkLMDEX0jg1gynA1aA7kFPMbeeR1DaSii57Ixd+aeAvRgN/mkorgUsybNxHP
	 xNAaNSJU4BMfro1OFEf9Z6vET8jPzpijibNpWVc/4zw+DFeeGZRc1wi3wX4sT9251/
	 vVKENhp0EPpTtxUtfH5VVaUXMTig6S6wNV21t/BtY/aA8tQu0NxOM5nEqZ2zMM493i
	 lKxn8PQ7h4sgQ==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3acff56a300so20810501fa.2
        for <linux-acpi@vger.kernel.org>; Tue, 10 Nov 2026 09:42:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHzuqlBJEkYezUpwdACgyHuNvwzV8VlXrqbjZ7086h31u17mvAls3wqC/8XpdDwb9bDCe3FaFsNfMrJ@vger.kernel.org
X-Gm-Message-State: APuU4Z9qOlk369mkucf2dxNTrNMKzSxAb8Fd6vienuI9gVVudkGn4nzd
	9fLFJ8GcqPQ+X1ANQcfl4543CXvn7C1FqNr7VlIAWBlhWUvlywfFemkc/Xd1PkGyXjEladAlzLe
	2NDKqqQwKtV46HsTtDfOAz0NJjS0RrUg=
X-Received: by 2002:a05:651c:2110:b0:3ac:f258:6191 with SMTP id
 38308e7fff4ca-3ae0964afcemr8335641fa.23.1794332569598; Tue, 10 Nov 2026
 09:42:49 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103114143.75756-1-k.chen@smail.nju.edu.cn>
In-Reply-To: <20261103114143.75756-1-k.chen@smail.nju.edu.cn>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 10 Nov 2026 18:42:36 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0huO=PGM60O=e-SmVdGpevFH0JWXb4vaVNAiJL-9wOUPQ@mail.gmail.com>
X-Gm-Features: AclHuK8Vk8YduiLbbVx_kyTD4Z9jZoc1RuwBnQppkz7Vu3gLKg-vqQlNv_eOdGY
Message-ID: <CAJZ5v0huO=PGM60O=e-SmVdGpevFH0JWXb4vaVNAiJL-9wOUPQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: property: verify nested _DSD packages
To: Kang Chen <k.chen@smail.nju.edu.cn>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Josh Triplett <josh@joshtriplett.org>, Hanjun Guo <guohanjun@huawei.com>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Grant Likely <grant.likely@linaro.org>, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 12:42=E2=80=AFPM Kang Chen <k.chen@smail.nju.edu.cn>=
 wrote:
>
> acpi_properties_format_valid() and acpi_add_nondev_subnodes() inspect
> the package.count of nested elements before checking that those
> elements actually are packages.  In union acpi_object, count aliases
> the length of a string or buffer, so a Buffer(2) or String(2) element
> passes the two-element test and the following elements[0]/elements[1]
> accesses read past the small allocation.  In the non-device subnode
> path, the resulting string pointer can reach acpi_get_handle().
>
> Test for ACPI_TYPE_PACKAGE before using package.count in both
> functions.  Also require an even number of entries in the _DSD package
> before reading paired GUID/link elements.
>
> Fixes: ffdcd955c307 ("ACPI: Add support for device specific properties")
> Fixes: 99db5ff7fe0b ("ACPI / property: Hierarchical properties support up=
date")
> Signed-off-by: Kang Chen <k.chen@smail.nju.edu.cn>

Applied as 7.5 material, thanks!

> ---
>  drivers/acpi/property.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> index 8ee5a1f0eb48..f5e0dc87edde 100644
> --- a/drivers/acpi/property.c
> +++ b/drivers/acpi/property.c
> @@ -194,7 +194,8 @@ static bool acpi_add_nondev_subnodes(acpi_handle scop=
e,
>
>                 link =3D &links->package.elements[i];
>                 /* Only two elements allowed. */
> -               if (link->package.count !=3D 2)
> +               if (link->type !=3D ACPI_TYPE_PACKAGE ||
> +                   link->package.count !=3D 2)
>                         continue;
>
>                 /* The first one (the key) must be a string. */
> @@ -262,6 +263,9 @@ static bool acpi_enumerate_nondev_subnodes(acpi_handl=
e scope,
>         int i;
>
>         /* Look for the ACPI data subnodes GUID. */
> +       if (desc->package.count % 2)
> +               return false;
> +
>         for (i =3D 0; i < desc->package.count; i +=3D 2) {
>                 const union acpi_object *guid;
>                 union acpi_object *links;
> @@ -331,9 +335,10 @@ static bool acpi_properties_format_valid(const union=
 acpi_object *properties)
>                  * Only two elements allowed, the first one must be a str=
ing and
>                  * the second one has to satisfy certain conditions.
>                  */
> -               if (property->package.count !=3D 2
> -                   || property->package.elements[0].type !=3D ACPI_TYPE_=
STRING
> -                   || !acpi_property_value_ok(&property->package.element=
s[1]))
> +               if (property->type !=3D ACPI_TYPE_PACKAGE ||
> +                   property->package.count !=3D 2 ||
> +                   property->package.elements[0].type !=3D ACPI_TYPE_STR=
ING ||
> +                   !acpi_property_value_ok(&property->package.elements[1=
]))
>                         return false;
>         }
>         return true;
> --
> 2.34.1
>
