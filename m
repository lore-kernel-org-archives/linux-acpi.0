Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69A13358BE
	for <linux-acpi@vger.kernel.org>; Sat,  4 Apr 2026 18:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775328116; cv=none; b=gf7QO/GgH4/XTFEeh9JbFta2cUS72muzbDZDEePBxI0ltO63Q7us01mJChmrvCIG7N5TKwvBOoVTK7SbJMYRims4QWlXLUl7LWIaGPsTgjcn9DL0gPNkqvT67AvdMWWzhRcikZ2bZ8kN5oJ8auF6LK7xmyaN6MmwB8ViauuMXtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775328116; c=relaxed/simple;
	bh=MWfcc451QSIHGrpVZc9PzHDEtY0/laVmfZUl5PaawKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mdDFbYo7NiFNgftJbp0emkWOOOTMqIRhiTyMzaF7/wvn+DGS+l9bHgeUj85xO+/KnXgScv07cbKkJ8XRcNZ2yflgEbwJIuq186VjcHKxDZleb7C0sf6hYnBT+hpkrptNzTszBfFAwAZDZqaD6uoYjtR6MCZIDYwU4rAmmjh51gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PPOVPYgx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PPOVPYgx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68994C4AF09
	for <linux-acpi@vger.kernel.org>; Sat,  4 Apr 2026 18:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775328116;
	bh=MWfcc451QSIHGrpVZc9PzHDEtY0/laVmfZUl5PaawKQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PPOVPYgxRucHr3ekDuF2Tg5a3A9GBU/5wAAYJu5Hhl9skmXZlIUK2s9ZMrYHOw85g
	 f8tyLOLGJCLSPRBMaYHKfrGkMbl4+4edSB4gNSc9ca6qbMOBuhyHxiojHy1iMcHFF4
	 oBwY9xzqo37RHqo0kY+7JfPDQ6qWc7gmbnyeu5evUDoEP2b0RZ7T7QIxdE7BZBHSOG
	 pl6j1ETWv4KENQIzb18iXTnidvsAPMoSejPYMpDSeF47o+LjNh44vtH3tCns4gzAzT
	 7n5GHOx+46yhPo/JzYGkoU2S0rdJkBZ8xdNPX8gsliJDFdEvoyyyGH74ti2ioutXqG
	 TnGKWJIrIdoSA==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-415c8a4d2e6so1151923fac.0
        for <linux-acpi@vger.kernel.org>; Sat, 04 Apr 2026 11:41:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVIFrNWGZWuEeYl7bGqDZX518TkdSwj08YaBSjSy8CGUWOzxNE6EWvUYndvLC0p1gaPgjYM9vteMnvc@vger.kernel.org
X-Gm-Message-State: AOJu0YwATc3RawTOj7cr/JaXT0BPtDRw4D4uyJgTcCNY/jK3fPztxnGn
	Dg6I1cjQFdkm2emj3llTAlBojS4RKJIEF+QrdQM2rDslOSgSFm0uaoEiwHmh3qyyv3/2fcErjn2
	y0yyI/GLP9HguB6wdu1Su8n1HoUme7JY=
X-Received: by 2002:a05:6870:c189:b0:417:9244:d168 with SMTP id
 586e51a60fabf-423100197c9mr3889251fac.41.1775328115404; Sat, 04 Apr 2026
 11:41:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403085343.866440-1-lihuisong@huawei.com>
In-Reply-To: <20260403085343.866440-1-lihuisong@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sat, 4 Apr 2026 20:41:44 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j=dxags+X_dpqdQ_u3gY0QAtFiGbza+2VraoWip1x3Rw@mail.gmail.com>
X-Gm-Features: AQROBzBZnje0LwVU0QiXgJJP_0hIuRPhHXG2uWxvWTFsOy6WrYJoGn0uZBLhi-E
Message-ID: <CAJZ5v0j=dxags+X_dpqdQ_u3gY0QAtFiGbza+2VraoWip1x3Rw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: processor: idle: Reset power_setup_done flag on
 initialization failure
To: Huisong Li <lihuisong@huawei.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linuxarm@huawei.com, 
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com, zhenglifeng1@huawei.com, 
	yubowen8@huawei.com, wangzhi12@huawei.com, zhangpengjie2@huawei.com, 
	wanghuiqiang@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 3, 2026 at 10:53=E2=80=AFAM Huisong Li <lihuisong@huawei.com> w=
rote:
>
> The 'power_setup_done' flag is a key indicator used across the ACPI
> processor driver to determine if cpuidle are properly configured and
> available for a given CPU.
>
> Currently, this flag is set during the early stages of initialization.
> However, if the subsequent registration of the cpuidle driver in
> acpi_processor_register_idle_driver() or the per-CPU device registration
> in acpi_processor_power_init() fails, this flag remains set. This may
> lead to some issues where other functions in ACPI idle driver use these
> flags.
>
> Fix this by explicitly resetting this flag to 0 in these error paths.
>
> Signed-off-by: Huisong Li <lihuisong@huawei.com>
> ---
>  drivers/acpi/processor_idle.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.=
c
> index 2adaee0f32ed..c1cddb4a5887 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -1378,6 +1378,7 @@ void acpi_processor_register_idle_driver(void)
>
>         ret =3D cpuidle_register_driver(&acpi_idle_driver);
>         if (ret) {
> +               pr->flags.power_setup_done =3D 0;
>                 pr_debug("register %s failed.\n", acpi_idle_driver.name);
>                 return;
>         }
> @@ -1386,7 +1387,16 @@ void acpi_processor_register_idle_driver(void)
>
>  void acpi_processor_unregister_idle_driver(void)
>  {
> +       struct acpi_processor *pr;
> +       int cpu;
> +
>         cpuidle_unregister_driver(&acpi_idle_driver);
> +       for_each_possible_cpu(cpu) {
> +               pr =3D per_cpu(processors, cpu);
> +               if (!pr)
> +                       continue;
> +               pr->flags.power_setup_done =3D 0;
> +       }
>  }
>
>  void acpi_processor_power_init(struct acpi_processor *pr)
> @@ -1423,6 +1433,7 @@ void acpi_processor_power_init(struct acpi_processo=
r *pr)
>          */
>         if (cpuidle_register_device(dev)) {
>                 per_cpu(acpi_cpuidle_device, pr->id) =3D NULL;
> +               pr->flags.power_setup_done =3D 0;
>                 kfree(dev);
>         }
>  }
> --

Applied as 7.1 material, thanks!
