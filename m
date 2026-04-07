Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573521F37D3
	for <linux-acpi@vger.kernel.org>; Tue,  7 Apr 2026 13:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775568984; cv=none; b=jVKXtQ80+Pj7vRNFXLyXrI+eCYamkkCGCxNprIOTpFIes0UQ6fzqv2XiQcyXb1XpH7u7OJbGxosLc5WSe/8oxIF7jTAKd01qnIOvID1pacdMdVFI34tcCpwTOFxzn5OhCgNswP10Htkg+fMN3iY+f+uhpetcuFokIwZdvXsrnOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775568984; c=relaxed/simple;
	bh=t4+6y+QheVrGV2I8uaLoNpw7AcOSpqEBFQWhZWZte4I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AIMlSCVDfTsZxoEXeYPJwXBvYFRM8mPeSn+A7voNsoczXYhA8BD1qx0jjP/CdX0orhI3kmbSW04hzAlv7WcQ5a2KsI6xCm5Q1W1cAwDzZ51sNWT2ynpfXhEY4Rpv9wffw+7XNzza5XCVs5MNHXQOuf59n6R/Iq+QmQMR/K2Yr4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eYplDhKq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eYplDhKq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10528C2BCB3
	for <linux-acpi@vger.kernel.org>; Tue,  7 Apr 2026 13:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775568984;
	bh=t4+6y+QheVrGV2I8uaLoNpw7AcOSpqEBFQWhZWZte4I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eYplDhKqLw2H2/IP4V8gg19gj95mAgL9RQw1SVPnZMhU00mdOjFFdv4pTLrGy0JUr
	 zKbho+x9iTk5wkkLHSErLR8vrUaRPl7O2IjLGrbQpHQDC3Cbmdz4TtWZr6TeG7kAU1
	 Fv3voSuyhQcbow+xRHbBBdYvJavILLkRM3R8riYPKMFkMlWeA974czNGYWaBR27C6E
	 P4sp4N7WWIcqowyREfdSUAPl1Sp8xdoaO0LBctKGIsI63Ih8ZLEGxEnZO5D22rpPuE
	 y9qVgVC5JELVig701pLynYikJWJHfMnfAmNoB2vci07T+FJVvtdcMcpFJ7MxJlCwuz
	 OTW5kQp1Z5lIg==
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-463f00cda04so2740476b6e.2
        for <linux-acpi@vger.kernel.org>; Tue, 07 Apr 2026 06:36:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXYJrtVAl9e0e6g/57ayNdHqXhSl9kUIy0wCK1Zk9fRZCt7FD3rS5Ec+UONGTCaqfLQxl3ti1mZX9uJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzGbkZFOHGAoaUVoArRfY0rQKIhHwiFeWoA2H6m48mTWMlweMY5
	QsXwHzRdY7uEibAwOCkZTTM61e4BlZjxp+b+Xjr4hXNJxUquGWGIdJYHxoZctC7wBOj2I3RA/mq
	xsjOZamPCrRTM165F7Bp60jUFdvFrVo0=
X-Received: by 2002:a05:6808:23c7:b0:46a:cd63:96ca with SMTP id
 5614622812f47-46ef7919ed6mr9088986b6e.27.1775568982903; Tue, 07 Apr 2026
 06:36:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407081141.2493581-1-lihuisong@huawei.com> <20260407081141.2493581-2-lihuisong@huawei.com>
In-Reply-To: <20260407081141.2493581-2-lihuisong@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 7 Apr 2026 15:36:11 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i6eTz2EyKAd9jKK6V8S-qUhGHM7Dk+f-FYLzSrBJ0A0g@mail.gmail.com>
X-Gm-Features: AQROBzC34aLtYLQg37BiQCL892AXHpLihD85F1-lwckm4XWgoDEAxHeSgmJtGoo
Message-ID: <CAJZ5v0i6eTz2EyKAd9jKK6V8S-qUhGHM7Dk+f-FYLzSrBJ0A0g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] cpuidle: Extract and export no-lock variants of cpuidle_unregister_device
To: Huisong Li <lihuisong@huawei.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linuxarm@huawei.com, 
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com, zhenglifeng1@huawei.com, 
	yubowen8@huawei.com, wangzhi12@huawei.com, zhangpengjie2@huawei.com, 
	wanghuiqiang@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 7, 2026 at 10:11=E2=80=AFAM Huisong Li <lihuisong@huawei.com> w=
rote:
>
> The cpuidle_unregister_device() function always acquire the internal
> cpuidle_lock (or pause/resume idle) during their execution.
> However, in some power notification scenarios (e.g., when old idle
> states may become unavailable), it is necessary to efficiently disable
> cpuidle first, then remove and re-create all cpuidle devices for all
> CPUs. To avoid frequent lock overhead and ensure atomicity across the
> entire batch operation, the caller needs to hold the cpuidle_lock once
> outside the loop.
>
> To address this, extract the core logic into the new function
> cpuidle_unregister_device_no_lock() and export it.
>
> Signed-off-by: Huisong Li <lihuisong@huawei.com>
> ---
>  drivers/cpuidle/cpuidle.c | 22 +++++++++++++++-------
>  include/linux/cpuidle.h   |  2 ++
>  2 files changed, 17 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index c7876e9e024f..1a55542efead 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -714,16 +714,12 @@ int cpuidle_register_device(struct cpuidle_device *=
dev)
>
>  EXPORT_SYMBOL_GPL(cpuidle_register_device);
>
> -/**
> - * cpuidle_unregister_device - unregisters a CPU's idle PM feature
> - * @dev: the cpu
> - */
> -void cpuidle_unregister_device(struct cpuidle_device *dev)
> +void cpuidle_unregister_device_no_lock(struct cpuidle_device *dev)
>  {
>         if (!dev || dev->registered =3D=3D 0)
>                 return;
>
> -       cpuidle_pause_and_lock();
> +       lockdep_assert_held(&cpuidle_lock);
>
>         cpuidle_disable_device(dev);
>
> @@ -732,10 +728,22 @@ void cpuidle_unregister_device(struct cpuidle_devic=
e *dev)
>         __cpuidle_unregister_device(dev);
>
>         cpuidle_coupled_unregister_device(dev);
> +}
> +EXPORT_SYMBOL_GPL(cpuidle_unregister_device_no_lock);
> +
> +/**
> + * cpuidle_unregister_device - unregisters a CPU's idle PM feature
> + * @dev: the cpu
> + */
> +void cpuidle_unregister_device(struct cpuidle_device *dev)
> +{
> +       if (!dev || dev->registered =3D=3D 0)
> +               return;
>
> +       cpuidle_pause_and_lock();
> +       cpuidle_unregister_device_no_lock(dev);
>         cpuidle_resume_and_unlock();
>  }
> -
>  EXPORT_SYMBOL_GPL(cpuidle_unregister_device);
>
>  /**
> diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
> index 4073690504a7..2ead2d8c57e6 100644
> --- a/include/linux/cpuidle.h
> +++ b/include/linux/cpuidle.h
> @@ -188,6 +188,7 @@ extern void cpuidle_driver_state_disabled(struct cpui=
dle_driver *drv, int idx,
>  extern void cpuidle_unregister_driver(struct cpuidle_driver *drv);
>  extern int cpuidle_register_device(struct cpuidle_device *dev);
>  extern void cpuidle_unregister_device(struct cpuidle_device *dev);
> +extern void cpuidle_unregister_device_no_lock(struct cpuidle_device *dev=
);
>  extern int cpuidle_register(struct cpuidle_driver *drv,
>                             const struct cpumask *const coupled_cpus);
>  extern void cpuidle_unregister(struct cpuidle_driver *drv);
> @@ -226,6 +227,7 @@ static inline void cpuidle_unregister_driver(struct c=
puidle_driver *drv) { }
>  static inline int cpuidle_register_device(struct cpuidle_device *dev)
>  {return -ENODEV; }
>  static inline void cpuidle_unregister_device(struct cpuidle_device *dev)=
 { }
> +static void cpuidle_unregister_device_no_lock(struct cpuidle_device *dev=
) {}
>  static inline int cpuidle_register(struct cpuidle_driver *drv,
>                                    const struct cpumask *const coupled_cp=
us)
>  {return -ENODEV; }
> --

Both patches applied as 7.1 material, though I'm somewhat nervous
about removing sysfs entries under cpus_read_lock().

Note that I've changed the subject of the second patch to "ACPI:
processor: idle: Reset cpuidle on C-state list changes".

Thanks!
