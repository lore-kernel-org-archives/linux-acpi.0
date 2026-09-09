Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C6F569F26
	for <linux-acpi@vger.kernel.org>; Wed,  9 Sep 2026 15:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788966143; cv=none; b=mUqY6T1iKFa2iiZ0t4qxjyFrSWOggHYt7UOwT24SWSyXdlhpbXmdfLdHC1AGP71drc4I44JHp96WPq3Mp7IJTnnRaWxbSRD+vQ0V8s8PyeHcVgdGIkYPTQe2CAPKm7g/VpwUlZSvdlNUedsXPhqd8p5pKYc3mfgbCkRY9cdWeaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788966143; c=relaxed/simple;
	bh=JXh+ySSFBwAVApj9Le/1zUflHyghydT0UQICyaCuXFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZMA30Dc15ViqyAR0kZB/oo3NukWoC6Xyt+R/78ADURxFKQV2FT60GizSe19gSHQhOE/zIk/IOEEz5z7ZtwOT2FEzfiDaWdmcBIAMPEpJcUNpGR7HaPS1jlzM5sjIvKAIHw8Z/0ipspSGDa7wsJgcj12EyGXxVUiwwkXWqa73vUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=La5ODMex; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="La5ODMex"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0916F1F00A3A
	for <linux-acpi@vger.kernel.org>; Wed,  9 Sep 2026 15:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788966141;
	bh=2xNgHJwejj9KDK/89gxoVNYRjmzMQPLmYU0vVkFjyko=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=La5ODMexIFZ/DUCfb1UN5y4q12JDJCRpxsBqJcK8GjO7Ff5Vbb6QD5Vw8evMgDjuZ
	 qX58J3kgK7zUspRPFhb8CdSy9HV+YHzkLo1J+e49ufA4GwvRO0zBl/nxFxIlDudmqi
	 mHXm8kNoOMEMHdAOYCP9SACbJ9mMD/d2t3LNrUb+A2vqidmIgZvpmX+RmRkv4Vq6JQ
	 /6PRa5KA9BDV2vgPJK0OBsIvb8WcNwAmGQ28i94VDcwZJ8Cyx/m6OObxpQYGsVDeRW
	 6Kzwk/DtiIzKFBqQWqiqlBJSp4I7ga5Um9f88NPoJxWVVI1QA3ReLp7kHIGLTLoY91
	 2XJfdx5jyEzlA==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3a49a7f2dcaso7313001fa.0
        for <linux-acpi@vger.kernel.org>; Wed, 09 Sep 2026 08:02:20 -0700 (PDT)
X-Gm-Message-State: AFuF++nEHkJqW8SDMEDwIzGwsSeHdWEkR1SDoIWk78fFyINmsl0ZgmPc
	B0Agj3yuY4pzR/3hNSx+5Wif8E+1sqaVQQoLxS5OTz2Rnrl7aWrUAj4wWCrAbHXw5NuZAcC3PvM
	fcqhDUFAP+Bejn2gaEyTOFZ7myZ8xgho=
X-Received: by 2002:a05:651c:2113:b0:3a3:7681:6d5a with SMTP id
 38308e7fff4ca-3a37681747cmr30184461fa.18.1788966139364; Wed, 09 Sep 2026
 08:02:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820034848.1693724-1-triet.hoang.dev@gmail.com>
In-Reply-To: <20260820034848.1693724-1-triet.hoang.dev@gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 9 Sep 2026 17:01:08 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ieReSLYvjDxvNSV=y=xjjpjznADYOvTMtqScDh8XWVtw@mail.gmail.com>
X-Gm-Features: AcwNN1V5IPj8BXRbpSe5osSjYV_7c1dwwuONej-bxlZ9LamUyLywpKSQZZNKzlw
Message-ID: <CAJZ5v0ieReSLYvjDxvNSV=y=xjjpjznADYOvTMtqScDh8XWVtw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: SBS: use DEFINE_SIMPLE_DEV_PM_OPS
To: Triet Hoang <triet.hoang.dev@gmail.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026 at 5:49=E2=80=AFAM Triet Hoang <triet.hoang.dev@gmail.=
com> wrote:
>
> Convert the deprecated SIMPLE_DEV_PM_OPS
> to DEFINE_SIMPLE_DEV_PM_OPS
>
> Also use pm_sleep_ptr() when assigning the ops to the driver.
> This allows the removal of the ifdef CONFIG_PM_SLEEP.
>
> Signed-off-by: Triet Hoang <triet.hoang.dev@gmail.com>
> ---
>  drivers/acpi/sbs.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
> index 86b7c7975852..543ca5f0defa 100644
> --- a/drivers/acpi/sbs.c
> +++ b/drivers/acpi/sbs.c
> @@ -692,17 +692,13 @@ static void acpi_sbs_remove(struct platform_device =
*pdev)
>         kfree(sbs);
>  }
>
> -#ifdef CONFIG_PM_SLEEP
>  static int acpi_sbs_resume(struct device *dev)
>  {
>         acpi_sbs_callback(dev_get_drvdata(dev));
>         return 0;
>  }
> -#else
> -#define acpi_sbs_resume NULL
> -#endif

So the function above is going to be unused when CONFIG_PM_SLEEP is
unset if I'm not mistaken.

Is this really an improvement?

> -static SIMPLE_DEV_PM_OPS(acpi_sbs_pm, NULL, acpi_sbs_resume);
> +static DEFINE_SIMPLE_DEV_PM_OPS(acpi_sbs_pm, NULL, acpi_sbs_resume);
>
>  static struct platform_driver acpi_sbs_driver =3D {
>         .probe =3D acpi_sbs_probe,
> @@ -710,7 +706,7 @@ static struct platform_driver acpi_sbs_driver =3D {
>         .driver =3D {
>                 .name =3D "acpi-sbs",
>                 .acpi_match_table =3D sbs_device_ids,
> -               .pm =3D &acpi_sbs_pm,
> +               .pm =3D pm_sleep_ptr(&acpi_sbs_pm),
>         },
>  };
>
> --
> 2.53.0
>
