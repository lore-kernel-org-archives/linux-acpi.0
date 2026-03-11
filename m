Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F40218AB9
	for <linux-acpi@vger.kernel.org>; Wed, 11 Mar 2026 11:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773229235; cv=none; b=Vao8fl80R605Q9iqa/ybxy2f19vrh40qzq5d0z5DQdtlUIAccQ2gtEq2HQnvsCrq1+UDniQmlYIzsbx8ZAbkYWuKUfHkYywfQQy4Cn8hk0WvQEZUhP72rhtVeZ8TUYUOTjpinH4/NvELCIr0s0IPVEHu6bx+tailfE4+SQSnyeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773229235; c=relaxed/simple;
	bh=f3rHxahP6Kbau+kkIv4mUF2zt7JPFMYKnogFRc6edwY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=scQGzGLxzTcoDmP921xIQGXFHXuNzVv0SIyYOePDRLLzg8eDq3Fg//fSB1NnESigHPrsfbunAotTfsSMx8dqE+dX8u78BtxAlRQmebz8FX8Gc/Ka9IFyIdSWrr9JYtO982DrRKiNeIBhazl9h1oi7dB+HXkLVBTJmIODTt0R3L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A3XwOCLk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A3XwOCLk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7B25C116C6
	for <linux-acpi@vger.kernel.org>; Wed, 11 Mar 2026 11:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773229234;
	bh=f3rHxahP6Kbau+kkIv4mUF2zt7JPFMYKnogFRc6edwY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=A3XwOCLkVTHBcHN7FjccQho6JJSw7Cy+gjJ2hXIKU14ZfmDni728iplnBzUuvQqXk
	 3oILqSvbX0qHPQMx+awvKOwnfRXMFnSaHzmCsM/NlDvr6U/jZOr+Wv6btLucVMZorD
	 hFlRviX4J81LEVY6BHgcopZp23b2eJhwKefz490SmbbbINTFzqbgLY81ECbdJs0wIP
	 rBe4Az0Cba0RkdHAkP3uaL872J6JbCTSZNDmT88/nztMA2h0f1cPtAj5H63FzB5+8r
	 PPHgfpA1vK6kNJwlsItEo2r39LQzr/IQKFARtRkvl/AXsL+rbW+yj+6hrDWwXnOzgq
	 y4qP+SfxAN4ag==
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-466f935a82fso2582739b6e.0
        for <linux-acpi@vger.kernel.org>; Wed, 11 Mar 2026 04:40:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUxD1G/129GnMeUkdL3GL4slyzEsV5V0fEC/a8wYfGGjZEW7z1JvUJY10cseR+S00zIwT4Bt+FsGgj/@vger.kernel.org
X-Gm-Message-State: AOJu0YwIruSlPH8l3/BFn8Sz9qtYTtK1Vg11dsNETrNrUUjwRPWpGLXl
	4U1SBSXCUUpW0ykY/wzcsvYJDqpNNakU+eh4jCSZrRhUCsZb37bQDUaGr1dnIjOOuiFsoijpKMy
	tgCd6WnAFlCjovVN+2Yuw+5fYlEbTHO0=
X-Received: by 2002:a05:6808:1a1d:b0:467:32c1:ad01 with SMTP id
 5614622812f47-467335a6b25mr1116194b6e.50.1773229233865; Wed, 11 Mar 2026
 04:40:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311071334.1494960-1-zhangpengjie2@huawei.com>
In-Reply-To: <20260311071334.1494960-1-zhangpengjie2@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 11 Mar 2026 12:40:21 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0ic6JRSsi7=DYC8EpC8DyvQyVZCZBsc0h=BXzBxQoC_5w@mail.gmail.com>
X-Gm-Features: AaiRm515Z7nCkHPqhyDRY6qB-jzKHsQ0m_LdTbswu3VbtnxZ3-COynEUKh_BbmQ
Message-ID: <CAJZ5v0ic6JRSsi7=DYC8EpC8DyvQyVZCZBsc0h=BXzBxQoC_5w@mail.gmail.com>
Subject: Re: [PATCH] ACPI: CPPC: Fix uninitialized ref variable in cppc_get_perf_caps
To: Pengjie Zhang <zhangpengjie2@huawei.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nathan@kernel.org, zhanjie9@hisilicon.com, 
	zhenglifeng1@huawei.com, lihuisong@huawei.com, yubowen8@huawei.com, 
	linhongye@h-partners.com, linuxarm@huawei.com, jonathan.cameron@huawei.com, 
	wangzhi12@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 8:13=E2=80=AFAM Pengjie Zhang <zhangpengjie2@huawei=
.com> wrote:
>
> Commit 8505bfb4e4ec ("ACPI: CPPC: Move reference performance
> to capabilities") introduced a logical error when retrieving
> the reference performance.
>
> On platforms lacking the reference performance register, the fallback
> logic leaves the local 'ref' variable uninitialized (0). This causes
> the subsequent sanity check to incorrectly return -EFAULT, breaking
> amd_pstate initialization.
>
> Fix this by assigning 'ref =3D nom' in the fallback path.
>
> Fixes: 8505bfb4e4ec ("ACPI: CPPC: Move reference performance to capabilit=
ies")
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Closes: https://lore.kernel.org/all/20260310003026.GA2639793@ax162/
> Tested-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Pengjie Zhang <zhangpengjie2@huawei.com>
> ---
> This is on top of linux-next.
> ---
>  drivers/acpi/cppc_acpi.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 07bbf5b366a4..5ad922eb937a 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1407,12 +1407,11 @@ int cppc_get_perf_caps(int cpunum, struct cppc_pe=
rf_caps *perf_caps)
>          * If reference perf register is not supported then we should
>          * use the nominal perf value
>          */
> -       if (CPC_SUPPORTED(reference_reg)) {
> +       if (CPC_SUPPORTED(reference_reg))
>                 cpc_read(cpunum, reference_reg, &ref);
> -               perf_caps->reference_perf =3D ref;
> -       } else {
> -               perf_caps->reference_perf =3D nom;
> -       }
> +       else
> +               ref =3D nom;
> +       perf_caps->reference_perf =3D ref;
>
>         if (guaranteed_reg->type !=3D ACPI_TYPE_BUFFER  ||
>             IS_NULL_REG(&guaranteed_reg->cpc_entry.reg)) {
> --

Applied, thanks!
