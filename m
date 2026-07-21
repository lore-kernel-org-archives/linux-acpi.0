Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696C246F49A
	for <linux-acpi@vger.kernel.org>; Tue, 21 Jul 2026 19:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784662143; cv=none; b=utOyBIxI2Uicorv3SPTDXGCbnOjvV2sT/uBxETCIIIOfTP72h+g4cpxbPyZ1rvL/VcPr0Yn2sauorHI2vZBR0fDZStmvP5DjVCLZWsBSmIN3JkyPSdpoLybOb0wxUed729fuG9mYBkP9dh4b+JDxlAH8MKctouZeUeMrX3rijxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784662143; c=relaxed/simple;
	bh=ACvjltgEpqbSP9ZceuIzPy9fJBiUl+tkbgu7EKRAvDo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A1Ka6z0SRVLz2WzAtVkc6IYhoKDJBSqKe9KWi0SKUHHBM8EUfye5HG5HuGZBuTADmfuqSx8dmj7o0bUIoIpKizuPvE92i8gwTzhC4gtE4rmqeuAIG8Di/MGgAXPy0vs2cvI3CH/m2lF64ueI/h+2XLp9lvtFqXZKJnOuZ2w6oYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YtUvO4L/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YtUvO4L/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A8431F00A3E
	for <linux-acpi@vger.kernel.org>; Tue, 21 Jul 2026 19:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784662138;
	bh=+wO7sHrpdTteU3Brt5qKC9yAAPgd4tp4zqCms16ybrE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=YtUvO4L/8HRU+09F4knrn6KcB7cnArCflwJL0LBhCwGV7glMs9c1GrMLAHjhDrQ6Z
	 3dqMQ7ZgozBnOQsrGpU5j7FrcCvQvE/K9SZBjK2MJP9UM73gmpc+ff/PDE5aGlp1ha
	 xNVol/OSAN+ps9nH7iyvL6RLMoAJcyBB1364hyXTWwFW5hAfQ0PObCtLdhmvPGvY8I
	 FvN8/Pch+iF7+N1swI39fuj1bOotlOpeDZn/y7pmaihRMp7xZ3gmFA/YegI8kGUBLT
	 A5/YG0ikFZ5+6vKv4H6/KzH70NKrJUBTLiQ67s90JjPiEKyvIjufhP/UY+llF0vjre
	 9Fg+XIYgghTlA==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5b15d5e986eso3577612e87.1
        for <linux-acpi@vger.kernel.org>; Tue, 21 Jul 2026 12:28:58 -0700 (PDT)
X-Gm-Message-State: AOJu0YylW6oWHSZyB7x0b/xEWIKlAdXxBuZcuwRSIOjjvkAJn4dutBQ4
	SDoJp+vGKU5TIOwEq8wepskAIpesjKA+k/IwP4amKSezqDc5iEokUHtTZdQ8JQ74aEzpsT28wcx
	crPFI+quIQhTg/6f+J02wY1YffbV+qvM=
X-Received: by 2002:a05:6512:3dab:b0:5b0:17e7:67d0 with SMTP id
 2adb3069b0e04-5b28fad39f4mr4517292e87.62.1784662136588; Tue, 21 Jul 2026
 12:28:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260717171635.1783543-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20260717171635.1783543-1-andriy.shevchenko@linux.intel.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 21 Jul 2026 21:28:43 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ga2mZ_S0nO8Q-NSN7ZuF9qwhUZ2opxUX_2XGMdg9qFag@mail.gmail.com>
X-Gm-Features: AUfX_mzydc3UWeDKdYi2wyHCHg60BRi_uT3lpOQOWTbMUbjmAo8RHZGACaFwxZs
Message-ID: <CAJZ5v0ga2mZ_S0nO8Q-NSN7ZuF9qwhUZ2opxUX_2XGMdg9qFag@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] ACPI: NHLT: Remove always included kconfig.h
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>, Saket Dumbre <saket.dumbre@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 17, 2026 at 7:16=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> The inclusion of <linux/kconfig.h> is unneeded as it's guaranteed by
> the build starting from the commit 2a11c8ea20bf ("kconfig: Introduce
> IS_ENABLED(), IS_BUILTIN() and IS_MODULE()"). Remove it here.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  include/acpi/nhlt.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/include/acpi/nhlt.h b/include/acpi/nhlt.h
> index 2108aa6d0207..370958d93706 100644
> --- a/include/acpi/nhlt.h
> +++ b/include/acpi/nhlt.h
> @@ -10,7 +10,6 @@
>  #define __ACPI_NHLT_H__
>
>  #include <linux/acpi.h>
> -#include <linux/kconfig.h>
>  #include <linux/overflow.h>
>  #include <linux/types.h>
>
> --

Applied as 7.3 material, thanks!
