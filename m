Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3563391831
	for <linux-acpi@vger.kernel.org>; Wed, 18 Mar 2026 11:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773831757; cv=none; b=r4GjghbUwHfg8KUySxKUpzkn47b5QCROTmcbQ3C+hANrQi9tRXVrtvbXiXZUvlKzFJ6eBuGfJRk66d8iNugHlqfkIVM5E4Zyd5mn6pZcEhA5dGFgeB7+SmVvGbWeeNJmm/8vprK3wAuQv/ylP4a68SmvqvhL/IrndIvKnLvHoPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773831757; c=relaxed/simple;
	bh=JxShbSkrxiHPYbo+nzGUPalwh0rtSomZv9Z5BlAG2ys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d068B8p1dwnw97Tl1JDxHDpzsh5aND/EoJ6qT7p2h37G1XO+sBv9+x35fQqU0nbAF1JOxVT60G/oJLXxo4NggFypeMH5ilimO5ePFAIHUOyjeshO+DC3tHCXe0H6A0CKaFNHp0hdISUzJN/sK1pS6Slmq1tVKYa2owhcrFolGHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WPLgZ97H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WPLgZ97H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C0F6C2BC9E
	for <linux-acpi@vger.kernel.org>; Wed, 18 Mar 2026 11:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773831756;
	bh=JxShbSkrxiHPYbo+nzGUPalwh0rtSomZv9Z5BlAG2ys=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WPLgZ97Hsek2PL1wEfCo9eLlJ6ddbuik9ymAtVjqBG2pzsdSby8cxrCEp8V+LJI8v
	 6AtfbYCAPvNNciZsxq7dGu+3kDxQziQnsCKY6sr8NWHCmGFzjvjTe8gMqeaZkZhJYR
	 meY9wXuAAgRCIRpeVublVtNaTrJv1un+Vh4ca7IuZyQcWsnZiKm/HZWE6Q9p5Wg2CX
	 WzKTgqODJP0dqU+njRNaXQ6nG4j/+IuBcKGyPPHG6bGSLhcMptM+GQ5xFqejSqUVn4
	 J+MwnIDp96Z8F0dYlxizCITJAKN463G5qZTSw4EQJBta8JmLumO6HeQW5F/WnwNp8P
	 1QspQMruQzVWQ==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-417400afaeeso650959fac.1
        for <linux-acpi@vger.kernel.org>; Wed, 18 Mar 2026 04:02:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUGc6YJ5wGgH2ZLxFijuF9hPN8nDg1t7S+kdux/gIU7fHApUd7Igsy9rDt4mjVjfoqv56eD26lzkINi@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9rqhrwloo55evpjYzCI8c6c3wCDoxuebWurLH4ZiMol7WFvk7
	X4WVGBZmW6fiE9QCnQ47bTBbY7lVBEPSQvsoipjxeUQ5CMvPm9kYz0lqEHmrPpu4pIyWo3OOSGT
	NFXtRiFV6fRnv2Jh0tuYoeO7BPV6E+Xg=
X-Received: by 2002:a05:6870:c213:b0:417:3161:bfcc with SMTP id
 586e51a60fabf-41bd1ea8023mr1946152fac.5.1773831755596; Wed, 18 Mar 2026
 04:02:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318034842.1216536-1-pratap.nirujogi@amd.com>
In-Reply-To: <20260318034842.1216536-1-pratap.nirujogi@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 18 Mar 2026 12:02:23 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hhVv5mpoUYx21LcTk=gAtn=HgWB-6zvAvzXmTrPng4Bg@mail.gmail.com>
X-Gm-Features: AaiRm52Titwx0iuFPnwy01BsJm37Dm3ajgRXLfLhz4_c0QYuqbRUQhizOdkflXA
Message-ID: <CAJZ5v0hhVv5mpoUYx21LcTk=gAtn=HgWB-6zvAvzXmTrPng4Bg@mail.gmail.com>
Subject: Re: [PATCH v1] ACPI: bus: Fix MFD child automatic modprobe issue
To: Pratap Nirujogi <pratap.nirujogi@amd.com>
Cc: rafael@kernel.org, lenb@kernel.org, mlimonci@amd.com, bin.du@amd.com, 
	alexander.deucher@amd.com, benjamin.chan@amd.com, king.li@amd.com, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2026 at 4:49=E2=80=AFAM Pratap Nirujogi <pratap.nirujogi@am=
d.com> wrote:
>
> MFD child devices sharing parent's ACPI Companion fails to probe as
> acpi_companion_match() returns incompatible ACPI Companion handle for
> binding with the check for pnp.type.backlight added recently. Remove this
> pnp.type.backlight check in acpi_companion_match() to fix the automatic
> modprobe issue.
>
> Fixes: 7a7a7ed5f8bdb ("ACPI: scan: Register platform devices for backligh=
t device objects")
> Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
> ---
>  drivers/acpi/bus.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index f6707325f5821..2ec095e2009e4 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -818,9 +818,6 @@ const struct acpi_device *acpi_companion_match(const =
struct device *dev)
>         if (list_empty(&adev->pnp.ids))
>                 return NULL;
>
> -       if (adev->pnp.type.backlight)
> -               return adev;
> -

Good catch!

I forgot to remove this in

https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/=
?h=3Dacpi-7.0-rc4&id=3D6ab3532b4c98f4e51969f0e5f3fc919c535f3ce1

>         return acpi_primary_dev_companion(adev, dev);
>  }
>
> --

So applied as 7.0-rc material, thanks!
