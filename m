Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792694681;
	b=gNo959y0oDY7Gx9I2ok0on6iIsb3LlYMZU62edxiZVADKYWxuKbHzHw/SHT6jUfKOQT5
	 nrcEAOALTXMCM9vNNeVbOZMM0JOhvkjz0kT2epDjrNvHFmuSqHH3NOjn76kH6Y8dNPSoZ
	 sEvyot8clkb0PjhStCwO5ywwu5/ldW2Gd4cCOrAMt4e55xFAD+M4YUD9a8ol9YKPyF0rh
	 zCf4e6Bo4+XgBcVXd4qxwXXDGQIgHpnWuVfuTS7KDCV1Fam4AKV6mNSYjNlfiroE5Jq02
	 EW6iQAZDblDbKqfQJO8pgq4LaXxGPFo6YP7y2e+D9nlG73Vn/Ek88vw1iNUavXLyXUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792694681;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=g2LfIwDxVBmR9BMyADZLLYuuWNtJdFL8FAUPTERMtU8=;
	b=df6pv5YY7zr42B0pxdzxHcf1jRSQ3cQVYPlObwWIpRwr/8D0/TbInQkdqjmuqB9i79Ed
	 EJBdRVIFT85wOBofTktSILg+0ih5rkZeQXOWvlzwf8xKzg26tOr/PlYzA5TKJyxN6zRIh
	 IUVbltn1Dw5/IGcO2Vzff0RUoD9qcJdtKZb6uLXvviYphePwOUU0IUcS0FjT78BQ68Gl5
	 2zyuz0aC1vse9l46nfg11XRo4hfNkzD48uD88DW1SY19Z+PWx86k1Pzc+1sgCbtQ0BGKn
	 0b3RntFX5kjQ4jAX0Dze4kNcMzOTXbtSBG9LhGv0BNB8r3HMBxrjWPNEt+DIwwsLm6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Od/13cqW";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75E3606A31A
	for <linux-acpi@vger.kernel.org>; Thu, 22 Oct 2026 18:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Od/13cqW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B3711F01825
	for <linux-acpi@vger.kernel.org>; Thu, 22 Oct 2026 18:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792694680;
	bh=g2LfIwDxVBmR9BMyADZLLYuuWNtJdFL8FAUPTERMtU8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Od/13cqWMRUeTGz+uowEVhEOkpveKmzT+5c8EG2HZpytg+C1uowtXjUQK4Q2FQ20N
	 oyFtQd0cX6dozkuzXy/a+V9L/k7SSJzeWyym+tcDSbtAtKvdg9dZDkV8UycCOfzu7/
	 jpYreTLAkJ8jYEM02hbu5pviztpWJEgLfjG5OqvrZFLNERYch8wRHXVlJ73rkPncsK
	 vKQ02b/jeKHAbSgdNUQTw8Aji+X73on1NpmhGuZVdhSOs1lYFqJyQHoJ9A+7RwjUGc
	 D57xJAbTQRkWlv/zNssM1EZcVnf6kac7XuskhHAQgxmpiseezcqQezW9PZTEnvlTkm
	 uMVI9ed9DP/vA==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5bcb0f245e0so13372e87.3
        for <linux-acpi@vger.kernel.org>; Thu, 22 Oct 2026 11:44:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBycnEz4MsOTfxcsSmsxTAUweZhCSABom7yYNyxwZx9idqnwEuKUjZIDgJ8yja2n77ndVbgjRiIAGpj5@vger.kernel.org
X-Gm-Message-State: AFq9FYI11uew72sGEfX2ZU800CIL0WhcI70LpRweLQH5Qghbifqa6R7y
	+Z/tCQfByE20Amn4l3g0I7CYlZORjhPMvFIdMtL6R508te932VMCJfL9vqQh7yeT9kNkOnBJr/I
	ZVq+L0PVsDsis5fN9uV5u+pSaa78Igxg=
X-Received: by 2002:a05:6512:3b0b:b0:5be:5196:9591 with SMTP id
 2adb3069b0e04-5bfa1c4f787mr2669620e87.59.1792694678773; Thu, 22 Oct 2026
 11:44:38 -0700 (PDT)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261013180728.957618-1-jamien@nvidia.com>
In-Reply-To: <20261013180728.957618-1-jamien@nvidia.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 22 Oct 2026 20:42:18 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iwUo6OmDEVBCoSp4Gtopntp3w1gw6s4yTTKFygmsrONQ@mail.gmail.com>
X-Gm-Features: AclHuK86uxd2cAvIMmFetJsl2IEyYqV7HJXL18Dj7Ear_GON0bDSDngEWudD6a4
Message-ID: <CAJZ5v0iwUo6OmDEVBCoSp4Gtopntp3w1gw6s4yTTKFygmsrONQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: sysfs: Map only the requested range in acpi_data_show()
To: Jamie Nguyen <jamien@nvidia.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, 
	Punit Agrawal <punitagrawal@gmail.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 8:08=E2=80=AFPM Jamie Nguyen <jamien@nvidia.com> wr=
ote:
>
> acpi_data_show() maps the whole data region on every read(), although
> it copies at most count bytes and sysfs passes at most PAGE_SIZE bytes
> per call. acpi_os_unmap_iomem() defers the iounmap until after an RCU
> grace period, so a process reading one of these files in a loop keeps
> many full-size mappings in flight.
>
> Map only the range being read. acpi_os_map_iomem() rounds the mapping
> to page boundaries, so each mapping is now at most two pages, whatever
> the size of the region.
>
> A malformed table can describe a region that wraps around the end of
> the physical address space. acpi_os_map_iomem() doesn't check for that,
> and its lookup of existing mappings then matches an unrelated mapping,
> with or without this change. Fail reads of such a region before mapping
> anything.
>
> Assisted-by: LLM
> Signed-off-by: Jamie Nguyen <jamien@nvidia.com>
> ---
> As discussed on the BDAT v2 thread:
> https://lore.kernel.org/r/CAJZ5v0ixQ_5jmrfm4mz50tZtCEq6nJt1b2eMoBdhr0f3AY=
+k7w@mail.gmail.com
>
> This doesn't depend on that series and applies on its own.
>
> Tested on an arm64 server with 4K and 64K pages, with the BDAT v2
> series applied:
>
> - The BERT and BDAT data files match /dev/mem when read whole, byte by
>   byte, page by page, and across page boundaries.
> - Each read maps at most two pages. With 4K pages, looping full reads
>   of the 90754-byte BDAT file kept at most 167 MiB of vmalloc space
>   mapped (1740 MiB before), and looping 1-byte reads at most 355 MiB
>   (3090 MiB before).
> - Malformed BERT tables loaded via initrd table upgrade, with regions
>   that wrap around the end of the physical address space, fail every
>   read with -EINVAL.
>
>  drivers/acpi/sysfs.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
> index dd4a99f09efea65..138009659a7b55f 100644
> --- a/drivers/acpi/sysfs.c
> +++ b/drivers/acpi/sysfs.c
> @@ -419,6 +419,7 @@ static ssize_t acpi_data_show(struct file *filp, stru=
ct kobject *kobj,
>         struct acpi_data_attr *data_attr;
>         void __iomem *base;
>         ssize_t size;
> +       u64 end;
>
>         data_attr =3D container_of(bin_attr, struct acpi_data_attr, attr)=
;
>         size =3D data_attr->attr.size;
> @@ -432,13 +433,17 @@ static ssize_t acpi_data_show(struct file *filp, st=
ruct kobject *kobj,
>         if (count > size - offset)
>                 count =3D size - offset;
>
> -       base =3D acpi_os_map_iomem(data_attr->addr, size);
> +       /* acpi_os_map_iomem() can't handle a range that wraps around */
> +       if (check_add_overflow(data_attr->addr, size, &end))
> +               return -EINVAL;
> +
> +       base =3D acpi_os_map_iomem(data_attr->addr + offset, count);
>         if (!base)
>                 return -ENOMEM;
>
> -       memcpy_fromio(buf, base + offset, count);
> +       memcpy_fromio(buf, base, count);
>
> -       acpi_os_unmap_iomem(base, size);
> +       acpi_os_unmap_iomem(base, count);
>
>         return count;
>  }
> --

Applied as 7.4-rc material, thanks!
