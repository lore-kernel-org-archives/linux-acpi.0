Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E91D3E51C7
	for <linux-acpi@vger.kernel.org>; Wed, 15 Apr 2026 17:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776273051; cv=none; b=Ac8rvTmHdUYoUdlKSWdbV346JYJoJQUA8U406AMY540xwXrhNMLPuL0viFnbNUOEJmmHMDuo1OvQH+E2ONwahYqvgL8dCBFn8nlu+Kt1lidVOkmbrA+4uBAHSudtc/2WjQodrHTmgtSi4pzQ51UCNt+PGiGNuuNHguV3Re4PTZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776273051; c=relaxed/simple;
	bh=TEJMegXA8h76DN083DNJlP80Z2m2EzDgfSpEWJAo/lo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dmMTPScGjxzHeaDStAohQysj+QkEFvXGtsMPcsHrl/XU6ZkY8paGDrF4KHxPwEnHi2axiZvfUm0ahm2Um/zgmeiCisrkIQuFc989FFTuNIPPwz79GRLeF0pS+8e6TamklAC2DDRnM285Hg958KT9garYTuRifnpzy8JVJ0LGbJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ki3N9WvK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ki3N9WvK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BD21C2BCB7
	for <linux-acpi@vger.kernel.org>; Wed, 15 Apr 2026 17:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776273051;
	bh=TEJMegXA8h76DN083DNJlP80Z2m2EzDgfSpEWJAo/lo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ki3N9WvKYpnZm0NbFvmUnFBCAjc74glT0kcDHKOsO54/yPnsla6TrFDo9lHI/W+gi
	 r/UQAHdCo9vk8Wz15oUww2B9y7W3+w0VbKHCWDA5CSoVW9tzwbVh/5UqSobD5lIvKx
	 RbRvP2rMwM7Yr+IiFZSMatYReOZZ5yhRMX4TgPvzgpdRdoJZVZRMpP8gT+WQaAvMvS
	 QBHx9LwFlERUEDV7IRvPe5YlRM4I9ubd6pk5b3W73+bdsNNBF2hvVzv7oOW8K+ZK39
	 nmeEg9KKJIYvrlmU4LtQBOhX1fHgsc1QUI9FNSPlsxSbmu+1KTcAe0HEM2d3nMFxRg
	 RQjmGYlEHoP3g==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-4042fe53946so3206375fac.3
        for <linux-acpi@vger.kernel.org>; Wed, 15 Apr 2026 10:10:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9iT3Hr0YoNqOhFscjS3mZmu2j5vEXjSfddftoSE7lc1X3MkmRBmwlabqBdl98YF981S5EC7ZF3wbP+@vger.kernel.org
X-Gm-Message-State: AOJu0YxwODuthuC6MLax8reJIMbTDY8M0iE+Bwg5lIdh8jEexbiF+a45
	H4h8vo4HPhjy2fCTHvibWof2uO0nIdKKCX9nOT/2wEW582Kk/rZIMAyFrXzkdtYe4281Z2yzvGk
	5oDKx1XM+3dbK/B6gRbOVQJYuUwIuHKU=
X-Received: by 2002:a05:6870:c6a4:b0:417:1c8a:6ce7 with SMTP id
 586e51a60fabf-423e0da4f64mr12398566fac.3.1776273050479; Wed, 15 Apr 2026
 10:10:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413102118.33088-1-lukas.bulwahn@redhat.com>
In-Reply-To: <20260413102118.33088-1-lukas.bulwahn@redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 15 Apr 2026 19:10:39 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hPd+J1L_Z8Wj=nz+zAp4gDp5v2jf7j2V1armLDGhFiBw@mail.gmail.com>
X-Gm-Features: AQROBzDvWgFHE5FNRaBWneRSujrKAJlgz01rp_FPorzmMnXAsPXFNKe0Z1Yvuik
Message-ID: <CAJZ5v0hPd+J1L_Z8Wj=nz+zAp4gDp5v2jf7j2V1armLDGhFiBw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: adjust file entry in NVIDIA GHES HANDLER
To: Lukas Bulwahn <lbulwahn@redhat.com>
Cc: Kai-Heng Feng <kaihengf@nvidia.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Tony Luck <tony.luck@intel.com>, 
	Borislav Petkov <bp@alien8.de>, Hanjun Guo <guohanjun@huawei.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Shuai Xue <xueshuai@linux.alibaba.com>, 
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 13, 2026 at 12:21=E2=80=AFPM Lukas Bulwahn <lbulwahn@redhat.com=
> wrote:
>
> From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
>
> Commit d7610855b0b5 ("ACPI: APEI: GHES: Add NVIDIA vendor CPER record
> handler") adds the file drivers/acpi/apei/ghes-nvidia.c and also adds a
> section NVIDIA GHES VENDOR CPER RECORD HANDLER in the MAINTAINERS file wi=
th
> a file entry referring to drivers/acpi/apei/nvidia-ghes.c. Note that the
> file name in the entry (nvidia-ghes.c) differs from the actual file in
> the repository (ghes-nvidia.c).
>
> Adjust the file entry to the actual existing file.
>
> Fixes: d7610855b0b5 ("ACPI: APEI: GHES: Add NVIDIA vendor CPER record han=
dler")
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d4b396dccfe9..a74012c38542 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19103,7 +19103,7 @@ NVIDIA GHES VENDOR CPER RECORD HANDLER
>  M:     Kai-Heng Feng <kaihengf@nvidia.com>
>  L:     linux-acpi@vger.kernel.org
>  S:     Maintained
> -F:     drivers/acpi/apei/nvidia-ghes.c
> +F:     drivers/acpi/apei/ghes-nvidia.c
>
>  NVIDIA VRS RTC DRIVER
>  M:     Shubhi Garg <shgarg@nvidia.com>
> --

Applied as 7.1-rc material, thanks!
