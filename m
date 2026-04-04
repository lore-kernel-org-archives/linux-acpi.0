Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B1033ADAC
	for <linux-acpi@vger.kernel.org>; Sat,  4 Apr 2026 18:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775328253; cv=none; b=WP8+76Npm86AQ+y1dvKgJn+c4/y8vhA5kI/GjZe6vt90+Iny4cDazWc0NmaAG+iY2Yy+8bhFyk0UVRrG8aB8Fe4H7ADo4B2w24TlXHowq4iN1XGqfORyse2dSBZ0cHD87yyGWU3D2lLTA6wGZOeOpP6EZHQcsXot1WR9CNnvUuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775328253; c=relaxed/simple;
	bh=1f7KOEoJ44TQLWaak4ISOnZqIsoel6VUGdkjYhNfDWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=otNtCFNB0izQ0OvrXXFHEUUsOLvTH5ZWBFFNjW4amjlPv/vQW8f5ZTtPsGJ56LzIQxtf24uvTbnhH/GwaTWF9sVG+KOFEjP/oXgc+Y9eHmxEHDfmPs8N3jZW7h74a98U2E3JRvshV82qc5ugiirXiB2fA3jIKUEWpkbVFSCuw+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hEpuzM2V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hEpuzM2V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F166C2BCB3
	for <linux-acpi@vger.kernel.org>; Sat,  4 Apr 2026 18:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775328253;
	bh=1f7KOEoJ44TQLWaak4ISOnZqIsoel6VUGdkjYhNfDWI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hEpuzM2VYPm4KqqUP+U84+yj97OTYhpvAohKAQBY04Nr+maT3irKQS2kN/a1ziIzv
	 a+SglZi1rw3j9mhfHp8fwkIPeTVXsrpYAOOcuxq0oFCPn8oOL3ZgEIL3j0qB4Wmnpe
	 Mqy0OL/IOj/z/jOpSSjBP7hz9MUT4r3u4XMtB1OhE6JzSMgNNkXR5utMGUzcbpnysY
	 uSAP1P04WsUa/EIHrayuX1FJwO0xYrT1aWQcyIx97WxRbAKfb6A6cZ25DTHIZukjGh
	 E2ZogSBynOxM5wXd8hNQ7UFn2+mZDiNnqDzuipl7TbqPeCQ/EOA6Ugh67pQieBSkNy
	 MC3ELE9PLydpQ==
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-470145d7e6fso337812b6e.2
        for <linux-acpi@vger.kernel.org>; Sat, 04 Apr 2026 11:44:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWdOqdlHJSQu2oHu4geiuUJrD3DOAGFH2gGfjI/doCvCJC30i4l81aq37uni1bAu1HIg0QwUC9xL5mk@vger.kernel.org
X-Gm-Message-State: AOJu0Yy58dJfbV/q/FVjlaTq+PsgDqeMvEZJHObs5eGjfl+RYK+ooc+5
	gkebw5pqW3DVUPUCeR32F8IPcRn3p0RddmW97hH14hWzASiA9sTUBi4sFd4wa/6AMoU7kmDvL0i
	ZJuNiPR9pg3pz50LRAOBnQl0aDH8X5go=
X-Received: by 2002:a05:6871:210d:b0:417:359c:292e with SMTP id
 586e51a60fabf-4230fd52b22mr4262567fac.12.1775328252534; Sat, 04 Apr 2026
 11:44:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403090253.998322-1-lihuisong@huawei.com>
In-Reply-To: <20260403090253.998322-1-lihuisong@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sat, 4 Apr 2026 20:44:00 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g+ZThRAJcsmqiEjYdV1i4coVph5Js_vwAMyR6ccdGgNw@mail.gmail.com>
X-Gm-Features: AQROBzA4zqUG8L_8jcLgAKGOyrOnUnyZiAbe11FksDs6lrPhCct_R5tKZXoGCjw
Message-ID: <CAJZ5v0g+ZThRAJcsmqiEjYdV1i4coVph5Js_vwAMyR6ccdGgNw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: processor: idle: Fix NULL pointer dereference in
 hotplug path
To: Huisong Li <lihuisong@huawei.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linuxarm@huawei.com, 
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com, zhenglifeng1@huawei.com, 
	yubowen8@huawei.com, wangzhi12@huawei.com, zhangpengjie2@huawei.com, 
	wanghuiqiang@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 3, 2026 at 11:03=E2=80=AFAM Huisong Li <lihuisong@huawei.com> w=
rote:
>
> A cpuidle_device might fail to register during boot, but the system can
> continue to run. In such cases, acpi_processor_hotplug() can trigger
> a NULL pointer dereference when accessing the per-cpu acpi_cpuidle_device=
.
>
> So add NULL pointer check for the per-cpu acpi_cpuidle_device in
> acpi_processor_hotplug.
>
> Signed-off-by: Huisong Li <lihuisong@huawei.com>
> ---
>  drivers/acpi/processor_idle.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.=
c
> index 479995a4c48a..2adaee0f32ed 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -1267,16 +1267,15 @@ static int acpi_processor_get_power_info(struct a=
cpi_processor *pr)
>
>  int acpi_processor_hotplug(struct acpi_processor *pr)
>  {
> +       struct cpuidle_device *dev =3D per_cpu(acpi_cpuidle_device, pr->i=
d);
>         int ret =3D 0;
> -       struct cpuidle_device *dev;
>
>         if (disabled_by_idle_boot_param())
>                 return 0;
>
> -       if (!pr->flags.power_setup_done)
> +       if (!pr->flags.power_setup_done || !dev)
>                 return -ENODEV;
>
> -       dev =3D per_cpu(acpi_cpuidle_device, pr->id);
>         cpuidle_pause_and_lock();
>         cpuidle_disable_device(dev);
>         ret =3D acpi_processor_get_power_info(pr);
> --

Applied as 7.1 material, thanks!
