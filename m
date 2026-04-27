Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754D4402BB6
	for <linux-acpi@vger.kernel.org>; Mon, 27 Apr 2026 19:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777318064; cv=none; b=MVDlOUXQ78/SraxfTyjDdenz56odMtNj86/rl3C9/jmJ4CQ6InPqblLZd+CIDrKm0WkBZwNCulA+Bx1IAUNp7IpVRb1Yp2UqIGHBL7ns3Zf4nxUr9s57tnGdS4WFCNzuH4doxvfT199H02BUf3Jd3jEPOKeRh/abEaneEuD6GKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777318064; c=relaxed/simple;
	bh=HqYLELgj98iLA7JW98UYBb5EDteJRAkKjyhwdcgbrnY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kLTf73ZZMxJE4mTSsdmygv0AiIqK5nuH1gPA6QkiVY5Lcbk3hANcUwKyHoVzpVGvBPZk1SyOTjzJTvY3WM5G9MpSSNNOZgQbU+eRH6r4QI8hB7eRTtVtg/xWkx8m7qU4Gr+7Z5ybn7f+tUDGQabdIc8r9b/XjhoWEF88txwp/AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f/jJwlKR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f/jJwlKR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F15EC2BCC4
	for <linux-acpi@vger.kernel.org>; Mon, 27 Apr 2026 19:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777318064;
	bh=HqYLELgj98iLA7JW98UYBb5EDteJRAkKjyhwdcgbrnY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=f/jJwlKR+tprJBeHbdJVFSTFctYV+Ihh1TUQpqLLra6tK3LYYaCg3T4XDG9vnq58U
	 2IY3W1MTlIbS597tiPv5sQMb91acSAemtGo1aXPA0fSECaJ2PzRQTPNeCvwVYr47Jd
	 UbDO3W/vWXaEe/vQNlzKGntOhbMsqhlWUJlmuXYkz0juK/3+W5T/AXHXpwG5eHH6Kr
	 RdkiFAFaTOm7unXD09Y3jH2ZUYTUp1FqThR/rIg+X+SpblAUy39GTM+auZL26sHrWH
	 dMefqwCrp3Gg7E36zc2DDm3ZshsdILsEG+YzrNRq01qOO/4KFV84q0qcQeGT7b3iLY
	 o2fezb9Zx8ESA==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-59dea72099eso11760348e87.0
        for <linux-acpi@vger.kernel.org>; Mon, 27 Apr 2026 12:27:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8wResoFhLRmX4UqxfhK/M7PQvR5CKaYp5uTYpU1G2G7VdC8RmoAXj2yUXuRmrk/wGwl4HcSa34LqSN@vger.kernel.org
X-Gm-Message-State: AOJu0YzrojNtukeEfJUx9iP9UQfGxBCvbNbITb3nbgGQD/xCHdyh24R1
	xSyAZDycOUN9OyPXix3g7ARsX1Pn0lznyj+wI2rlGqDvPShQJ/F0GCDi4OKxyCPzwIQSB38zmWP
	umchdYzd0AEwW1YWDOklytYvRVkHyuXc=
X-Received: by 2002:a05:6512:1324:b0:5a3:f25f:cc30 with SMTP id
 2adb3069b0e04-5a74662a830mr53832e87.32.1777318062377; Mon, 27 Apr 2026
 12:27:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427-baytrail-real-swnode-v3-0-0003e4c1708c@oss.qualcomm.com> <20260427-baytrail-real-swnode-v3-1-0003e4c1708c@oss.qualcomm.com>
In-Reply-To: <20260427-baytrail-real-swnode-v3-1-0003e4c1708c@oss.qualcomm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 27 Apr 2026 21:27:30 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jv0W=rQXdzLMaMX+xfB2sHbCpQ1921uttyxq6sSsUxBw@mail.gmail.com>
X-Gm-Features: AVHnY4IfDf6M6rzg8a33EYrpiqMEOqTHPOfn9RqnuEXGKZqArxjU7nfpk8B2uYU
Message-ID: <CAJZ5v0jv0W=rQXdzLMaMX+xfB2sHbCpQ1921uttyxq6sSsUxBw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] ACPI: bus: export the acpi_bus_type symbol
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Andy Shevchenko <andy@kernel.org>, Linus Walleij <linusw@kernel.org>, Hans de Goede <hansg@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	brgl@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2026 at 2:19=E2=80=AFPM Bartosz Golaszewski
<bartosz.golaszewski@oss.qualcomm.com> wrote:
>
> In order to allow loadable modules to access the ACPI bus type struct,
> export the relevant symbol.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---
>  drivers/acpi/bus.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index 2ec095e2009e40b0645f654fb051429e5679dc7c..d4da76607905473de2e25e503=
52450c10f598784 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -1174,6 +1174,7 @@ const struct bus_type acpi_bus_type =3D {
>         .remove         =3D acpi_device_remove,
>         .uevent         =3D acpi_device_uevent,
>  };
> +EXPORT_SYMBOL_GPL(acpi_bus_type);

Not really (and I've already said that I think).

Please find a different way.

>  int acpi_bus_for_each_dev(int (*fn)(struct device *, void *), void *data=
)
>  {
>
> --
