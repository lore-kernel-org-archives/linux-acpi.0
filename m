Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D63C49DBB0
	for <linux-acpi@vger.kernel.org>; Mon, 14 Sep 2026 18:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789409329; cv=none; b=m4ShWkwJnM+kOK6cx2+vXy5LAhqNOiUEKjUzLL6YNBX2BVlyMQhQZkrVnL28XTAScvbsvzJ1LVvTqWq+182HnthAPl5weyq3chms8yB4d83LAqs0SCjNAJQaouPslIeZHV+mbx3j6fmLFD0vH8zeI6WtDTy8Y5lHm0NJaO+mekM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789409329; c=relaxed/simple;
	bh=gDF41yFOx97tFaKt9yMu/p6cesJWQOWXVPEIlKJajH8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K1XGHcJKzH32CPbM2pn/8R0Pk6OpIWMBxiet8ZrfAHAsMUdOeEzN4W5T4QGrZp8KpHQTPciHJ06YJyGY0u2cLM8pCRWCF+YO/aTLBhq+uCveJTuR0pCCROraVOjBXPzCA8VteeULlpYMGxiwXdKSJH4F/IJoC0Agmk4r1WXou+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D4y88Y5h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D4y88Y5h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F05051F000FF
	for <linux-acpi@vger.kernel.org>; Mon, 14 Sep 2026 18:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789409322;
	bh=2ckh5BO9D7YjyzIptMOKhEMsCpTGi957ZDuM/npht24=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=D4y88Y5hFeBNdnRwxIWrAcGDezT3gNgkSEyi63ibNicHZEKGis/6R3WVdUz2nRaQn
	 Bz+Hkb1bYmgaorstkHLP6Fl0WLnlcVvkrbWsT47IE1ZJCdT1gNqN6ZdUbETCNSaMKY
	 CB0K2ubsjQhPnkYCHzr1fklDvriPZbBK+AUpIkK38htSyhvoK/H9jGj5pyJCUgdEDE
	 6UqxIyByTCSOf56CuxYckjDA0hM3xrNXFVQkcH1bSAfreFAaR7C7RUfzY665EC9IEL
	 KQF0KPcXayb8Evy58L9d9KrUEx+ozAtAK3Wku1D6K3IsqBi2guo+WMMraMuabBII8r
	 7cQWzJiCk7wVA==
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b5e4f1651cso1898175e87.0
        for <linux-acpi@vger.kernel.org>; Mon, 14 Sep 2026 11:08:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzxfQ4XeCPyEbf4xiXLafgkTiRzDjvCmNVCx9faZ1oROa6o4QjZUtp6ZLTqY2p6T2tsUlxEoPBFbcES@vger.kernel.org
X-Gm-Message-State: AFuF++nzKVKOm/MMEx86No1t15immwuFUGTez/n/0/gGpNUj2uUxAr+w
	Wh7F4/kDU6eU1BFCdDDsr3tJVdnSaGdxuhMVXliRiRnxRanNznuPcPK2qZ67UJnLJi4RTW+e93S
	jd9nLPGgx5E5Ukyu4Rv319xbSbB5Ng8Q=
X-Received: by 2002:a05:6512:10cb:b0:5b7:674f:caba with SMTP id
 2adb3069b0e04-5b8ae684479mr1027893e87.13.1789409320375; Mon, 14 Sep 2026
 11:08:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260912113355.644238-1-lgs201920130244@gmail.com>
In-Reply-To: <20260912113355.644238-1-lgs201920130244@gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 14 Sep 2026 20:07:22 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jiC=DOerVh+erOi204a_NN+30SYgD+a5o7eUZY=0z+Hw@mail.gmail.com>
X-Gm-Features: AcwNN1VKf-MOOpTNz8RYadkIbdxxLgqXjwA8RxlTIM9B9768ANAzCbGe900qBnw
Message-ID: <CAJZ5v0jiC=DOerVh+erOi204a_NN+30SYgD+a5o7eUZY=0z+Hw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: SBS: Fix NULL pointer dereference on allocation failure
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 12, 2026 at 1:34=E2=80=AFPM Guangshuo Li <lgs201920130244@gmail=
.com> wrote:
>
> acpi_sbs_probe() jumps to the common error path when kzalloc_obj()
> fails, but platform_set_drvdata() is only called after the allocation
> succeeds.
>
> The error path calls acpi_sbs_remove(), which retrieves the unset
> driver data and dereferences the resulting NULL pointer when locking
> sbs->lock, causing a NULL pointer dereference.
>
> Return -ENOMEM directly when the allocation fails, since no resources
> have been initialized at that point and there is nothing to clean up.
>
> This issue was found by manual code inspection.
>
> Fixes: 9460eaae2ee42 ("ACPI: SBS: Convert the driver to a platform one")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/acpi/sbs.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
> index 86b7c7975852..4b84b3cd11e3 100644
> --- a/drivers/acpi/sbs.c
> +++ b/drivers/acpi/sbs.c
> @@ -639,10 +639,8 @@ static int acpi_sbs_probe(struct platform_device *pd=
ev)
>                 return -ENODEV;
>
>         sbs =3D kzalloc_obj(struct acpi_sbs);
> -       if (!sbs) {
> -               result =3D -ENOMEM;
> -               goto end;
> -       }
> +       if (!sbs)
> +               return -ENOMEM;
>
>         mutex_init(&sbs->lock);
>
> --

Applied as 7.4 material, thanks!
