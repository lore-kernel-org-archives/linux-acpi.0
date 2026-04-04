Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723A133CEB0
	for <linux-acpi@vger.kernel.org>; Sat,  4 Apr 2026 18:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775328362; cv=none; b=V1qBpz3A3rN3FWb1uZvHmbgQkUunVCtb1O5iY3Zyq1A52DPtBK5Uc4dZk4x4M58JolbbbecUrOFVWnO/cvp2kk+d3i9OlJoMOSdw5DdhCNlaKAz7OrZ+W0e+F+UKxwhI2Zlr0bD79lXqPHj/3vP+cyxzxyP/I6NemBQyYMVZh8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775328362; c=relaxed/simple;
	bh=O+ajCS4JdsfTKNyRZfL19PMofQ5kZOn0M5HKOhixziE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=el/M5BezFR8+LgKkQ59HPQUx5ZuguFi6DD3dTHB+dE/+5kAI6OirdtqLPcSqIWkBHKDbdkWmjMdfj9SvqaakU4Wg+6kGElYSKM95RVrhLwN3cVhi/+JMFxWYAWpClzQtF9qg6sAwDnBP9QWRMRbyzvpEXqayuQFdUaU8h/X1kdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nkDVt9ZP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nkDVt9ZP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A11BC2BCB5
	for <linux-acpi@vger.kernel.org>; Sat,  4 Apr 2026 18:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775328362;
	bh=O+ajCS4JdsfTKNyRZfL19PMofQ5kZOn0M5HKOhixziE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nkDVt9ZPJkvPayjIPnXPTjSnX5Il4EgRqRK1iiSGhBrilyhTFPohsJ0nxIEAyf804
	 P9emOxEiIoyJV2tc8bzq4uJxoGp1r57JVGWQBvXwgp5+f7gVv/wHvNn025sqcYUpb5
	 qS+OaJAzGL2tTYQbuIed2r6kE4QaSiUAEzJX4KkpqYNQRmVmXGLlWMAqa+uWd/Kmey
	 Az89ByjDsfPLP7PWmeS1sj/hSEIt1HrPIQP/QiWSTa0YZqJcQ2U6pUpwIJsiTWZKtq
	 AOBNJtbKWiB+O5fff0MHClHnHmze9nQQ3JxLs8kHI7wbXeMSfm/ZJv1i7zSVZvS0MW
	 fx/ZPYBm22K3g==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-415b23dd6e5so1117238fac.3
        for <linux-acpi@vger.kernel.org>; Sat, 04 Apr 2026 11:46:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWUNh+8eS9T0fepkbzbVL+wlIklDAoTmjwoWA914UfxeQMcW1t3UU1IiUDjeNxxtrmnrx++wO6RO//X@vger.kernel.org
X-Gm-Message-State: AOJu0YxbI7VdwN8TspcGO7mc3/xzyGGiSFXZqHy3vstAXK1QHHYpOKH9
	lPVw4dqQvV5KIcy72S1ntAuUXAWkwZWyrAm98eQLJySh2EyVrCqrCxekNrhVWcFhMRHyslz9phe
	5EB/LR/N9EmQIulGbLhJQyTda+WVXJkg=
X-Received: by 2002:a05:6870:c43:b0:41c:880:f9b7 with SMTP id
 586e51a60fabf-4230fd0bb23mr4014120fac.7.1775328361149; Sat, 04 Apr 2026
 11:46:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403084542.708104-1-lihuisong@huawei.com>
In-Reply-To: <20260403084542.708104-1-lihuisong@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sat, 4 Apr 2026 20:45:50 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hkgrG4wyGEYgq0m0L42L_pu7w9knT9v7xJUa2oCMJQJA@mail.gmail.com>
X-Gm-Features: AQROBzB0g-SoPk5nbm_Y1AMndiH8BSUvCi-ZYw4FSzjm50EC6XIWhWwwRmiGgXw
Message-ID: <CAJZ5v0hkgrG4wyGEYgq0m0L42L_pu7w9knT9v7xJUa2oCMJQJA@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: Simplify cpuidle_register_device() with guard()
To: Huisong Li <lihuisong@huawei.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linuxarm@huawei.com, 
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com, zhenglifeng1@huawei.com, 
	yubowen8@huawei.com, wangzhi12@huawei.com, zhangpengjie2@huawei.com, 
	wanghuiqiang@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 3, 2026 at 10:45=E2=80=AFAM Huisong Li <lihuisong@huawei.com> w=
rote:
>
> Use guard() macro for mutex to simplify the control flow in
> cpuidle_register_device().
>
> Signed-off-by: Huisong Li <lihuisong@huawei.com>
> ---
>  drivers/cpuidle/cpuidle.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index c7876e9e024f..8c037db46792 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -679,16 +679,16 @@ int cpuidle_register_device(struct cpuidle_device *=
dev)
>         if (!dev)
>                 return -EINVAL;
>
> -       mutex_lock(&cpuidle_lock);
> +       guard(mutex)(&cpuidle_lock);
>
>         if (dev->registered)
> -               goto out_unlock;
> +               return ret;
>
>         __cpuidle_device_init(dev);
>
>         ret =3D __cpuidle_register_device(dev);
>         if (ret)
> -               goto out_unlock;
> +               return ret;
>
>         ret =3D cpuidle_add_sysfs(dev);
>         if (ret)
> @@ -700,16 +700,14 @@ int cpuidle_register_device(struct cpuidle_device *=
dev)
>
>         cpuidle_install_idle_handler();
>
> -out_unlock:
> -       mutex_unlock(&cpuidle_lock);
> -
>         return ret;
>
>  out_sysfs:
>         cpuidle_remove_sysfs(dev);
>  out_unregister:
>         __cpuidle_unregister_device(dev);
> -       goto out_unlock;
> +
> +       return ret;
>  }
>
>  EXPORT_SYMBOL_GPL(cpuidle_register_device);
> --

Applied as 7.1 material, thanks!
