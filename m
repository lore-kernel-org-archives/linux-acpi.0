Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5D71B809
	for <linux-acpi@vger.kernel.org>; Tue,  5 Mar 2024 20:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709670904; cv=none; b=aB5l5Nzk//VdlyWt623YPcFxoqu6WnchoDoATTiANXXLyNKGSpxhkQFwgDjoy8q8uu82H0i2YJEOSCJQvbzladkEPb6uXDf/2LHAdDyDtVs0R6o0hPXwpqqj1i1NmPdAWjp2+7UdMJADbO+OBt2hkDTgQ5s5hvL4+sscP1Ps8wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709670904; c=relaxed/simple;
	bh=8SqPH0jZnS3MO0CaXYWxk5MBNyJY9smYPI43uwjA5Tg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UNvhq9I8SZ+dHzMhj0chbyKM2WNtR+WT/4bkA5K/Z4VhbzSFajCQlim+ONaHApiphfeiaWIp4uKy61jpW77W9nQ9A6JX7mJ2lGPDaXsx+LF0pHhWWaIcqbdZr8Fa2te2ZDfDGb9UjwTAEXUNGDW/xmpJX5p/YXrHJ4IU5FD/xIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3c1f5312e8fso292164b6e.0
        for <linux-acpi@vger.kernel.org>; Tue, 05 Mar 2024 12:35:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709670902; x=1710275702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cecbShf5m9pmIi6Xc9WA1oS+slIfHNLuBPbxSkx3ZYo=;
        b=GtlBtJKW/8uM+EFFg7sLeuU2N4MFnbgTrLECWQzyef+EnMTg44288dtTLtsFvKkp96
         S7nq8oQoTKobIGlPw/35T0d/JWTJtcZc5FbMxHRSKLzVSVzsZbxyn+dEVPFq2z5P4zuA
         otAwbFy8hQOs/pCXXI+4o8uOkxoNjPaNhgkDQ4VfAUtLU4nCabzys/xrG31+k4TBTnpB
         1WmmReJXxzM2sVtUbG5sMmP7E8AUzT+/rytxc4yWfCfp2Z/jof8J2vkn1b3aLZ4KQmYS
         eK6clpAfIzKW2omNXJzKa6fp8ecVayaeIUZVImz4TQ/tjlVQTOBUyY2LETUpbqSg6Jh3
         blEQ==
X-Gm-Message-State: AOJu0Yw7J0lLphZMDFuYEom5FbjxfVgJnqLpBPXm/A38jjP9CSzRIpCj
	BEoGBf5wkebSAywv02NyMwhZjG8qDQ6FrGZhtsFzQc7P60QZB/a7n+yu97U4Er7cA+bQ/byMwmM
	FqEgoiS5N3Q0ljQVJIy+5c/XtvNokWRu1
X-Google-Smtp-Source: AGHT+IGD9xscdjI3d4g8fdROhkHGJi8xwDZO9165ZpHtNw0yn/DR1612Kfe8yG/MIh3XHt5YbE/Or8ghksX4XOStvjM=
X-Received: by 2002:a05:6870:d0d3:b0:221:3b96:4e84 with SMTP id
 k19-20020a056870d0d300b002213b964e84mr1555517oaa.5.1709670902036; Tue, 05 Mar
 2024 12:35:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304092733.49466-1-kalinichev.so.0@gmail.com>
In-Reply-To: <20240304092733.49466-1-kalinichev.so.0@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 5 Mar 2024 21:34:51 +0100
Message-ID: <CAJZ5v0jtR=CgVBtr_6SPk7-fOrc3A3xffSNaXOzSb8v8diqTfA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: resource: Use IRQ override on Maibenben X565
To: Sergey Kalinichev <kalinichev.so.0@gmail.com>
Cc: linux-acpi@vger.kernel.org, rafael@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 10:28=E2=80=AFAM Sergey Kalinichev
<kalinichev.so.0@gmail.com> wrote:
>
> Use ACPI IRQ override on Maibenben X565 laptop to make the internal keybo=
ard work.
> Add a new entry to the irq1_edge_low_force_override structure, similar to=
 the existing ones.
>
> Signed-off-by: Sergey Kalinichev <kalinichev.so.0@gmail.com>
> ---
>  drivers/acpi/resource.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index dacad1d84..485ecc235 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -588,6 +588,13 @@ static const struct dmi_system_id irq1_edge_low_forc=
e_override[] =3D {
>                         DMI_MATCH(DMI_BOARD_NAME, "GM5RGEE0016COM"),
>                 },
>         },
> +       {
> +               /* Maibenben X565 */
> +               .matches =3D {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "MAIBENBEN"),
> +                       DMI_MATCH(DMI_BOARD_NAME, "X565"),
> +               },
> +       },
>         { }
>  };
>
> --

Applied as 6.9 material, thanks!
