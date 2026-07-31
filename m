Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DADB36196E
	for <linux-acpi@vger.kernel.org>; Fri, 31 Jul 2026 12:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785502176; cv=none; b=bw9nfNrarg9NoASXdetIwpaXXs2zUdFJuUKxvq8s/+s9OM1MYQKSbacv0kmLzLwQ/2f/r8B1+ybMmYJh/N36IBOyJm8I6Y3a+jzU3PbeLzWo8fEd90zNJhGwlB8KFrZTr+21sKzRfFG6c3fAvG/223lvd2CEyEH6gt3NJ8vnUDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785502176; c=relaxed/simple;
	bh=Nxs0IJlMpvvQPkPZCSCHsK69ptqLhyFTIZFUE11+1W0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dVVM5ifoWOPnUg14YIgNNG3UbGhLHv7B/x+0VKXokj8NvM5BuoKy94LieGGO0FqFtalfDz/0gh64Pheeuu1uLTpnWdn4lMGWIbKE/UD6TFGMYHj12YvAyPTYOADI8hdVe/1W5lOSPpep5RSachzSp8MUUL50+I2someWXzQ4lFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Poion0TD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Poion0TD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7E1A1F00ACA
	for <linux-acpi@vger.kernel.org>; Fri, 31 Jul 2026 12:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785502174;
	bh=+bgypQloe09D/SCkqvxtOnLfUh1v9U7opnoYhQHUSkI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Poion0TDFFtqLhXrxFHGeA+BDbVpfZ28x+BFscqTUFD0XoO9xvo52hd8p0u7Xd/DM
	 XPEWTCb40bjloHxLziT0IQ6QanMT27bg1e953IvOXSwbsdA54xB0krou3YxliwaReF
	 pMRaSkEdQA5OBPYltnHGTX/8LANsRmhEjYqJeuOFRAhCgUXmzvnqnNMNCnK+bP8bZ/
	 4lmBxn7xCAdN1ptDQpi5e8GRdBY4iThZBs/oLPF6PtUCscEbYZ0TXUHBVMmnVw2+t6
	 tEywOSFw8ijgREtY86mHayE0QNW2RVOdyj6niQTWxMCmkryxQoTJMI9Qcpr7zQ+eli
	 /ekNK47KQU7Cg==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5aeb2bc82ccso977262e87.2
        for <linux-acpi@vger.kernel.org>; Fri, 31 Jul 2026 05:49:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrNrMcK5CWdiIleezAhd5gux19PKcNt2cb9N8hDbHg8eBMNw9jx6T4GvcarowtptxaIPoon4PbpVfL7@vger.kernel.org
X-Gm-Message-State: AOJu0YxErn+yju4ebUHH5Yz204bg2245Obdq13TByvMLf88L0eFcOYG+
	zofEirsNcVD9zOrquE20khgkBRHClgZqS67zDD0yGpH+61cZFyOxGq2dvzfPNenctpG7gtGgVNc
	d/qVqr2ulcy1NImpoLAs9YHdfOxKQK7s=
X-Received: by 2002:a05:6512:3b11:b0:5ae:b78c:da1 with SMTP id
 2adb3069b0e04-5b2e1fcae73mr470947e87.28.1785502173236; Fri, 31 Jul 2026
 05:49:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729023605.197367-1-pengcan@kylinos.cn>
In-Reply-To: <20260729023605.197367-1-pengcan@kylinos.cn>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 31 Jul 2026 14:49:21 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jHVCtac+=M1Qqzu88ynzjSco9EZVp6+7e=c=2iP1vrsg@mail.gmail.com>
X-Gm-Features: AUfX_mxPOTEXFY7g0ySl6BTtE5r-jjVxinNfcjAPKr3BNnh-J-74VsprdHKCdG0
Message-ID: <CAJZ5v0jHVCtac+=M1Qqzu88ynzjSco9EZVp6+7e=c=2iP1vrsg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: processor: Unregister cpufreq notifier on init failure
To: Can Peng <pengcan@kylinos.cn>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 4:36=E2=80=AFAM Can Peng <pengcan@kylinos.cn> wrote=
:
>
> acpi_processor_driver_init() registers the cpufreq policy notifier before
> registering the ACPI processor driver and setting up CPU hotplug state.
>
> If driver_register() or cpuhp_setup_state() fails, the error path only
> unregisters the ACPI processor driver and the idle driver. The cpufreq
> notifier remains registered even though initialization failed.
>
> Mirror the module exit path on the init failure path and unregister the
> cpufreq notifier when it has been registered.
>
> Fixes: c0e0421a60bf ("ACPI: processor: Reorder acpi_processor_driver_init=
()")
> Signed-off-by: Can Peng <pengcan@kylinos.cn>
> ---
>  drivers/acpi/processor_driver.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_dri=
ver.c
> index cda8fd720000..cdc2ae1632b2 100644
> --- a/drivers/acpi/processor_driver.c
> +++ b/drivers/acpi/processor_driver.c
> @@ -285,6 +285,12 @@ static int __init acpi_processor_driver_init(void)
>  unregister_idle_drv:
>         acpi_processor_unregister_idle_driver();
>
> +       if (acpi_processor_cpufreq_init) {
> +               cpufreq_unregister_notifier(&acpi_processor_notifier_bloc=
k,
> +                                           CPUFREQ_POLICY_NOTIFIER);
> +               acpi_processor_cpufreq_init =3D false;
> +       }
> +
>         return result;
>  }
>
> --

Applied as 7.3 material, thanks!
