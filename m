Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339EA35F611
	for <linux-acpi@vger.kernel.org>; Mon, 27 Jul 2026 13:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785158894; cv=none; b=rd/UAW0UEwunzmfAEtbD7blCk8OhKGnrAtqaR0YbDx57FznaEsQY40K5pFMKuI9+U415lisPAj5SpW6PMhu1f6XCpBMs/LdjxrcgBg5/cvZULKwLsubfKSJUEw6ntOqxMI/WP7WlVllSHen/Qye8IXXmyREbaMk3AGmWoA5R1pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785158894; c=relaxed/simple;
	bh=MjOLtdbnHINQiZsUbyUdq0JT2ExAvNVto4UrqMDkKXI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IQ2Oc1paY77bmqO62p32FrkwdwsuRa3kio/0QuykOUWzA6dFiHYAkDWihl9QrFCUYg93Jp2JSfHbmsYiNysPNe1/Mps31vtiKh5ojaF6jW4nIW9Bx2I8Q+9YHw0RZ1nKN/ILozZbmdZpZN19HqR1rmgsAeU4o8fDGp+F78wQSK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a0wXjZON; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a0wXjZON"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 460A41F0155B
	for <linux-acpi@vger.kernel.org>; Mon, 27 Jul 2026 13:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785158877;
	bh=jo1uDciI4hvqGlusKkjXRbJpZ2yEY32stvntK0agl24=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=a0wXjZONqRUfwF8IFBW1Ed9ylkWDBJ9tPy5PYtFwEfD3Uv6ER6mE+dBgq7qI/q7PM
	 pulbUIOQeQdzm7Vi1em59Iuq+Py1wCXD1h2iFuw5B3yPorb6Osv3Q3qgiXkXq0rb/j
	 UVih/N/2Cj706niYtyRU9eq/ozayy5lTjiPcq78EzMtxyKxztX0xlaAw6PwGMbQXa+
	 X/BYZJE0DEiQHKoEsVz4ZFW4NOQLsQealE/fxQboeY8dy+GCCKFoW/np3IeLK22Bda
	 L1BkrOpTgw8/Z1eaG9Dspl6L3QIZTw2yjNOv9OZpKEFOPMyPPjxXvn5/y7K1jLGi+X
	 8VGFQ0HTx1kFw==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-39dbe684115so31566611fa.1
        for <linux-acpi@vger.kernel.org>; Mon, 27 Jul 2026 06:27:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqAJ+DhuCRpsHxxH0uXnE5Ul4gZhMV6rXqsHg5WavID9Vv8TmaNqgZS/dwBCAutW8sH8v6mGao75h5a@vger.kernel.org
X-Gm-Message-State: AOJu0YzR8A9fDloEdm18okohRiMURrX8GK6XAxHyVNfAn696qVzvIbIP
	IMMUfeoO8EYLho/mGSD8x3Q8buLZmRZsJHCS8cxA2EhamebfAs+vOsYbZH9mhQRgJ/foFAghFhQ
	IEXlf9rwrbfOdrsZ2VmXLuPfXLUDhxmg=
X-Received: by 2002:a05:6512:3d21:b0:5b2:b08a:ef9 with SMTP id
 2adb3069b0e04-5b2c19a2600mr1455909e87.0.1785158875656; Mon, 27 Jul 2026
 06:27:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260717215330.2215058-1-sumitg@nvidia.com>
In-Reply-To: <20260717215330.2215058-1-sumitg@nvidia.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 27 Jul 2026 15:27:42 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jdF+PYjxTqUSp_oJiCcPR4UUrQdBPt0K3f08BLRB4L4g@mail.gmail.com>
X-Gm-Features: AUfX_mziGygpLsC-M2M15skm83Ku8CRgNdaAig39SbPrrccs_TRF337AG_LqlDs
Message-ID: <CAJZ5v0jdF+PYjxTqUSp_oJiCcPR4UUrQdBPt0K3f08BLRB4L4g@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] ACPI / cpufreq: CPPC: Add ospm_nominal_perf support
To: Sumit Gupta <sumitg@nvidia.com>, christian.loehle@arm.com, pierre.gondois@arm.com
Cc: viresh.kumar@linaro.org, ionela.voinescu@arm.com, zhenglifeng1@huawei.com, 
	zhanjie9@hisilicon.com, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com, 
	vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com, 
	mochs@nvidia.com, bbasu@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 17, 2026 at 11:54=E2=80=AFPM Sumit Gupta <sumitg@nvidia.com> wr=
ote:
>
> This series adds support for the OSPM Nominal Performance register
> (ACPI 6.6, Section 8.4.6.1.2.6) to the CPPC ACPI and cpufreq drivers.
>
> Unlike the read-only Nominal Performance register, OSPM Nominal
> Performance is writable and lets OSPM request a nominal level below
> the platform-reported nominal. The platform treats performance above
> this level as boost and below as throttle for its power and thermal
> decisions.
>
> Patch 1: adds the cppc_{get,set}_ospm_nominal_perf() helpers, a
> per-policy cpufreq sysfs attribute (ospm_nominal_freq, in kHz), and
> hooks the register into the OSPM-set save/restore table.
>
> Patch 2: reflects the OSPM nominal in the cpufreq policy so that boost
> and the frequency limits stay consistent with the register.
>
> This series applies on top of the series
> "cpufreq: CPPC: Preserve OSPM-set registers across hotplug and unload",
> which provides the save/restore table that patch 1 hooks into:
> https://lore.kernel.org/lkml/20260716153820.2007095-1-sumitg@nvidia.com/
>
> v5[5] -> v6:
> - New patch 2: reflect the OSPM nominal in the policy's boost state
>   and frequency limits.
> - Patch 1:
>   - write only policy->cpu instead of looping over policy->cpus with
>     rollback. the register is treated as shared across a policy's CPUs.
>   - add the register to the OSPM-set save/restore table.

Christian, Pierre, any chance to have a look at this, please?

> Sumit Gupta (2):
>   ACPI: CPPC: Add ospm_nominal_perf support
>   cpufreq: CPPC: Reflect ospm_nominal_perf in boost and limits
>
>  .../ABI/testing/sysfs-devices-system-cpu      |  26 +++
>  drivers/acpi/cppc_acpi.c                      |  32 ++++
>  drivers/cpufreq/cppc_cpufreq.c                | 166 +++++++++++++++++-
>  include/acpi/cppc_acpi.h                      |  10 ++
>  4 files changed, 226 insertions(+), 8 deletions(-)
>
> v5: https://lore.kernel.org/lkml/20260615185934.2383514-1-sumitg@nvidia.c=
om/
> v4: https://lore.kernel.org/lkml/20260527194626.185286-1-sumitg@nvidia.co=
m/
> v3: https://lore.kernel.org/lkml/20260514194822.1841748-1-sumitg@nvidia.c=
om/
> v2: https://lore.kernel.org/lkml/20260430142430.755437-1-sumitg@nvidia.co=
m/
> v1: https://lore.kernel.org/lkml/20260427051823.280419-1-sumitg@nvidia.co=
m/
