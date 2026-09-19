Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66340318EC5
	for <linux-acpi@vger.kernel.org>; Sat, 19 Sep 2026 14:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789827566; cv=none; b=UTmB/i+BfKgti+YwOyAeJ9js//VfWCW1U0qKKfyCt8FNofWbFOVXfog6wkM9eiAx0qjMf/OlIgS2TSA/dRGyCxLI5p3s1Gzx308mM1DK9pHrnTJWQaRKVqrMf/3Kv3ZPpjqZR3rlo5tiamHiGGaD2FumLZ3QWgFg9PRruGjI8u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789827566; c=relaxed/simple;
	bh=/uQ99vUQtjbQarfdJLlDAvWZrnwsEPm4Ad8wyjZcGDs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uML+Le0eZML7LRilQpu1AS0dHkGiePYqKwS9PBGDraT8ZLSrEf3c23sjhytuRYVG70bgUAgsNseCgOTHctPx+wJJeKd2G/0nI7to4v78hEC3DwMLCM56Qv7s06rQr6qk60+jtXKaff1+7ml2XZzh6I4e3mglgeq7FD/i9kva0Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kXKlfFdZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kXKlfFdZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BC2C1F0089A
	for <linux-acpi@vger.kernel.org>; Sat, 19 Sep 2026 14:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789827565;
	bh=0xY1KKBPrXrqE6vxKVzmss2EmA6q2njOUlJk68SzIKk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=kXKlfFdZBQZdw3ZJ40yUP+1qzuW6JHxO/cAXzUSnlw8n6PWT36ek3vV9u1TQzhpaq
	 TcwGHd8Lri16UlRjQyQTnHL8VfftFAJ2KHHAH9gQF7J2fxcLioKjd/A59U0SUlZX8w
	 gCHfuBc7uaYeqdYYu72kEffhVyhisC2vsmQEisOlv4waSDkusqz6XV8ZU1FKquFDup
	 uJkTz/6gGt8YXxnHG3r5L70Zsq3SBPcZPLPA4IGw2UzAZwDgtTYIPc4QtiLc/f/6QJ
	 dvN7ykt7bXfTA65WDT7X30nuI0EGw9Lype5uLhEuCNFTsh833vUGpy1o0x5imozAyr
	 pEiXADRRE63Qw==
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a9984f9a59so2347213a12.0
        for <linux-acpi@vger.kernel.org>; Sat, 19 Sep 2026 07:19:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzXJyYCIKMfvOwuIdMH6t8C7gWHHcuvVN0MeZL6EStcSs3ccJ/Ri7nR5XfIBSwJMuo9f9pwvnzLk0J1@vger.kernel.org
X-Gm-Message-State: AFuF++lqOHemLN1pEvVfZCCkxp/yaq1+6PfeorVnXxMaYU9VwRHW5zSF
	1qBL5zdBkVFtjZC0AFcujbIjMng2nHdajCa/5JadW2aVdN7hC4Y2gyTGQVCOCtrh/xSn84cF9OU
	2geClhiD12YmbdW86qIKVS+yEYxKbyS8=
X-Received: by 2002:a05:6402:46c6:b0:6aa:96f:bb2f with SMTP id
 4fb4d7f45d1cf-6aa5312510emr3704633a12.12.1789827563834; Sat, 19 Sep 2026
 07:19:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915032627.2796747-1-maobibo@loongson.cn> <20260915032627.2796747-5-maobibo@loongson.cn>
In-Reply-To: <20260915032627.2796747-5-maobibo@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 19 Sep 2026 22:19:15 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5TEPKXjZNDzObDJmpa=GHeeVZv+1ry0=uZHiWCXCqL5Q@mail.gmail.com>
X-Gm-Features: AcwNN1VrM5r2Ez9d6qSwRfJyq-pHPMNjcZBLi5imstkm5cd_5EE3eqBzArPuVB8
Message-ID: <CAAhV-H5TEPKXjZNDzObDJmpa=GHeeVZv+1ry0=uZHiWCXCqL5Q@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] MAINTAINERS: Add entry for drivers/acpi/loongarch
To: Bibo Mao <maobibo@loongson.cn>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, 
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, 
	Pawel Chmielewski <pawel.chmielewski@intel.com>, Len Brown <lenb@kernel.org>, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
	lixianglai@loongson.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Bibo,

On Tue, Sep 15, 2026 at 11:34=E2=80=AFAM Bibo Mao <maobibo@loongson.cn> wro=
te:
>
> ACPI defines few LoongArch specific tables which need parsing code
> added in drivers/acpi/loongarch. Add maintainer entries for this newly
> created folder.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  MAINTAINERS            | 9 +++++++++
>  arch/loongarch/Kconfig | 1 +
>  2 files changed, 10 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c2414447892c..e19be0c1654e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -347,6 +347,15 @@ S: Maintained
>  F:     drivers/acpi/riscv/
>  F:     include/linux/acpi_rimt.h
>
> +ACPI FOR LoongArch (ACPI/LoongArch)
Similar to others, I think this should be: ACPI FOR LOONGARCH (ACPI/LoongAr=
ch).

> +M:     Bibo Mao <maobibo@loongson.cn>
> +R:     Huacai Chen <chenhuacai@kernel.org>
If this series can be merged to the loongarch tree, then it is better
to mark me as M.

> +L:     linux-acpi@vger.kernel.org
> +L:     loongarch@lists.linux.dev
> +S:     Maintained
> +F:     drivers/acpi/loongarch/
> +F:     include/linux/acpi_iovt.h
> +
>  ACPI PCC(Platform Communication Channel) MAILBOX DRIVER
>  M:     Sudeep Holla <sudeep.holla@kernel.org>
>  L:     linux-acpi@vger.kernel.org
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index 2067d1f2ad7a..d7f8e4fec952 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -6,6 +6,7 @@ config LOONGARCH
>         select ACPI_GENERIC_GSI if ACPI
>         select ACPI_MCFG if ACPI
>         select ACPI_HOTPLUG_CPU if ACPI_PROCESSOR && HOTPLUG_CPU
> +       select ACPI_IOVT if ACPI
>         select ACPI_PPTT if ACPI
>         select ACPI_SYSTEM_POWER_STATES_SUPPORT if ACPI
>         select ARCH_BINFMT_ELF_STATE
I think this part should be in Patch#2.


Huacai
> --
> 2.39.3
>
