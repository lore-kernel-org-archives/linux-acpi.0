Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C4A57ED88
	for <linux-acpi@vger.kernel.org>; Wed,  9 Sep 2026 15:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788969364; cv=none; b=grTgLFnHYd97FRZqJft+HNTsj8eqaF+WtG6hl1Ou7IRjp23tu7iMbG1XTsuniI0a6VevdBsN0mDLsU9zGdaZdnaLj9r0u9Yjtd6rEk1twj2K95uM5eM6Xa9KqOmuPuE/g4kM/EnC7BQB3oQeBHwjk08NlBWcnbN2zrmrGLYfw2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788969364; c=relaxed/simple;
	bh=lh59o6alPrhA0kytkDF8a2N0VXb3/OZaW+SxY6bjQcU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hycI41//1XsRBFH7p6t9UZ5fy682mmFdhJPS7S1kWtbDbcoYluH0spPTGz+brhNn2EMrjdhf5A9riM0Wvxshs16bbjVV2dKDlX24okcFqo7tVIoGMSoPhcqcGbDfLUsMMFZDbpW3MDmgOndAG/dhcwE/7FQweUDG6KW31viXsEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n9/vMKom; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n9/vMKom"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0B6A1F00A3F
	for <linux-acpi@vger.kernel.org>; Wed,  9 Sep 2026 15:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788969362;
	bh=ioV+x+EFqcjOBqUqrRqh+sx26qTm5P9GhDhi1qLRWwo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=n9/vMKom/fhoOgCHfwSU6u0gIiUcmCizW91SbWNZRnGp6MFIQ2xp3qPGEUOhS97g9
	 R4uYA4FmkPaMddatRqkxwriiFvDgppyfXNdRYhGM93ChMROyBih0mffe3aRpPBktuh
	 YXO1fMiKa8SOL6YPjpi0EBo6nRlC/XrfH5zYYBTp7K9mgklf3IuDZkzxulRG8rc0mG
	 SXSeOd+IsiZxkRiYRN+A9IFw9SBhO3huBaOGuGZ8wkeLKxSfVxWO8TJtVeXkoYQvMp
	 tKQ6Pmb764b9LcUFIeW5Yd5KNmMi/FWXZ6BrodKMaeX8AeLmNO0T6dDh/ZXB/J5LLC
	 2M4Y6eq6yYM4g==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-39ca300db70so46628461fa.2
        for <linux-acpi@vger.kernel.org>; Wed, 09 Sep 2026 08:56:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxTj+S5PqO8jyu7PYQM7+VJ7s910rVQ1FWjTMGUDK3/RV4wb72wQqFA/k9OSpKtsWJH1gbJzENX+Grk@vger.kernel.org
X-Gm-Message-State: AFuF++lCmb4OwsW68uo/7agncewIVEEqq61/ymildI+u5fHje9KvtEBb
	lpyBk+y3VYtT6NWboriUJiQnWe67PPqGIvfB93yMM9pQKrWkFUauiIzlNCaRPNTuwFNKCJQdmWr
	pKIGpiepBxFJy3zIIyrPyRCUUvFt0Vq0=
X-Received: by 2002:a2e:a9a5:0:b0:3a3:74d6:50aa with SMTP id
 38308e7fff4ca-3a374d65137mr34005511fa.29.1788969361185; Wed, 09 Sep 2026
 08:56:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902114912.6690-1-prabhakar.pujeri@dell.com>
In-Reply-To: <20260902114912.6690-1-prabhakar.pujeri@dell.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 9 Sep 2026 17:54:51 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gDyP7aXAgePQR2RtWodedQqHf4UPB576vCcQPoSgt17g@mail.gmail.com>
X-Gm-Features: AcwNN1Wl0aBn1Kv58PDCI537TmRA1xDDy3FlcWhWY3V4Qk01tRDuevwl3cPzeA8
Message-ID: <CAJZ5v0gDyP7aXAgePQR2RtWodedQqHf4UPB576vCcQPoSgt17g@mail.gmail.com>
Subject: Re: [PATCH] Documentation: ACPI: EINJ: Update stale driver source reference
To: Prabhakar Pujeri <prabhakar.pujeri@dell.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 1:49=E2=80=AFPM Prabhakar Pujeri
<prabhakar.pujeri@dell.com> wrote:
>
> The EINJ implementation was split when CXL protocol error injection
> support landed: einj-core.c holds the core logic, einj-cxl.c the
> CXL-specific part, and apei-internal.h the shared plumbing. The old
> drivers/acpi/apei/einj.c does not exist anymore, so the documentation
> points readers at a nonexistent file.
>
> Point them at the actual files instead.
>
> Signed-off-by: Prabhakar Pujeri <prabhakar.pujeri@dell.com>
> ---
>  Documentation/firmware-guide/acpi/apei/einj.rst | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/firmware-guide/acpi/apei/einj.rst b/Documentat=
ion/firmware-guide/acpi/apei/einj.rst
> index 7d8435d35..70fa59bd9 100644
> --- a/Documentation/firmware-guide/acpi/apei/einj.rst
> +++ b/Documentation/firmware-guide/acpi/apei/einj.rst
> @@ -180,8 +180,10 @@ function are specified using param1::
>         | segment |   bus  | device | function | reserved |
>         +-------------------------------------------------+
>
> -Anyway, you get the idea, if there's doubt just take a look at the code
> -in drivers/acpi/apei/einj.c.
> +Anyway, you get the idea, if there's doubt just take a look at the code:
> +drivers/acpi/apei/einj-core.c holds the core logic, while CXL-specific
> +handling lives in drivers/acpi/apei/einj-cxl.c and the shared plumbing
> +in drivers/acpi/apei/apei-internal.h.
>
>  An ACPI 5.0 BIOS may also allow vendor-specific errors to be injected.
>  In this case a file named vendor will contain identifying information
>
> base-commit: 89a312991dc6e638a36adc43ccb91dbc25504c04
> --

Applied as 7.4 material, thanks!
