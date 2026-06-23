Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8238332B136
	for <linux-acpi@vger.kernel.org>; Tue, 23 Jun 2026 13:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782221211; cv=none; b=TZu/nUYvD6Rai99J0kcJcj5y1JQ/Xs2KVDzBgZzCF/dvpjFSjQ1YYvwOJo3zscjnySXamjlHNf2GMFwirNUpSU6agpS33RdapthhYownZF+nqxKF37fEZEeLPNgEZPaLa+SM94XtNhaXHnissa7pjdEl6sZNHoxVukuVLmfbAtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782221211; c=relaxed/simple;
	bh=1Ys3E7FYRjZPKVvN0383OiwdOrH3Xr/Z4SXugfRNeVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TcrFSeou/y38z3GMV7wH5qxlgneg6uzZ3DCcjzcNEpI1/8Ly6DSVp+wI+Bhu8+i5/PB+8pHqdY/sWQr4WHk6bi3Tzs+wThrPZUpZh65nvZY0fcPYlt1rgK+/V4yoTvqdQMRARfcVw6x6ZXlSDaImA/k2tVrhqF++YnBWxXLVydM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hE9korR8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hE9korR8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3F161F00ACA
	for <linux-acpi@vger.kernel.org>; Tue, 23 Jun 2026 13:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782221207;
	bh=3AnIX67gwpDXgs2xfF71Q85BjqAjzJUjZy1Ec4RJuKQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=hE9korR8A+W6z0ToBhbljhuQyd3RiH/hkr0E+F0bP5aioqF/S11Cc1CvsuXC0oNpN
	 wg2fVFMD+oyXxlrH93Sdy2Velcfk1Ev5oBLpGdMeoP7u3wI7Fp+V1MWh7EMzg5xc1u
	 GBX06HhbSf0DT1hxnkceoYyvseptWX/+ZFeMsS17XuhfZ2DRQal+tz5NkxxRSRYmoA
	 72Y+t6qvcz5aTQDXr3qXxbqnkNuhKiPUZVzU3FODKtBxnS0pexJiJW7bCbBtXG/9vC
	 57EME8hnrF9iAiZLvNu1L44J3L+kTo5/J0ex+NadoEmpsa0QkCxQq57FhM2E84dQb7
	 Hjl89gEXE8qJg==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5aa68d9dc18so5523523e87.2
        for <linux-acpi@vger.kernel.org>; Tue, 23 Jun 2026 06:26:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9Url3Brl8TOMIGdrqPFWojEvhvgXLlqXpcTZFMk6xf0pFD9awe/3GDAHWnmn8o7hn/YNY/UAm0BMRN@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6sUxUUkJcw9CCZgJa7drw8j+KVxySAp+KQkN7qnRPXtSo3w8T
	YbNNUddtmv5kKff223TByHyUUEf/MsoVLojFKSsTmw+gEb0e+/6PEowQdEiphhxOPWUfYmgNXgq
	K0i8P4SEe7gKhZwiJjAao+cebLWWNMlI=
X-Received: by 2002:a05:6512:405a:b0:5aa:6128:dfc4 with SMTP id
 2adb3069b0e04-5ade4743759mr763886e87.24.1782221206215; Tue, 23 Jun 2026
 06:26:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616072617.2272-1-lirongqing@baidu.com>
In-Reply-To: <20260616072617.2272-1-lirongqing@baidu.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 23 Jun 2026 15:26:33 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j3Wnn3exbji-6PzwjCnOCJDe_pUJU9R25Bhvh1ZE3E5A@mail.gmail.com>
X-Gm-Features: AVVi8CfUFJ5lTgNtBPM1lrdpB9DxQD6gZtS_qaKI2d26_aigyG6oBHGkBNUnWFs
Message-ID: <CAJZ5v0j3Wnn3exbji-6PzwjCnOCJDe_pUJU9R25Bhvh1ZE3E5A@mail.gmail.com>
Subject: Re: [PATCH][v2] ACPI: processor_idle: Mark LPI enter functions as __cpuidle
To: Li RongQing <lirongqing@baidu.com>
Cc: Sunil V L <sunilvl@ventanamicro.com>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Sudeep Holla <Sudeep.Holla@arm.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Huisong Li <lihuisong@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 9:26=E2=80=AFAM lirongqing <lirongqing@baidu.com> w=
rote:
>
> From: Li RongQing <lirongqing@baidu.com>
>
> When function tracing or Kprobes is enabled, entering an ACPI Low
> Power Idle (LPI) state triggers the following RCU splat:
>
>   RCU not on for: acpi_idle_lpi_enter+0x4/0xd8
>   WARNING: CPU: 8 PID: 0 at include/linux/trace_recursion.h:162 function_=
trace_call+0x1e8/0x228
>
> The acpi_idle_lpi_enter() function is invoked within the cpuidle
> path after RCU has already been disabled for the current local CPU.
> Consequently, ftrace's function_trace_call() expects RCU to be
> actively watching before recording trace data, emitting a warning
> if it is not.
>
> Fix this by annotating acpi_idle_lpi_enter(), the generic __weak
> stub, and the RISC-V implementation of acpi_processor_ffh_lpi_enter()
> with __cpuidle. This moves these functions into the '.cpuidle.text'
> section, implicitly disabling ftrace instrumentation (notrace) along
> this sensitive path and preventing trace-induced RCU warnings during
> idle entry.
>
> Fixes: a36a7fecfe60 ("ACPI / processor_idle: Add support for Low Power Id=
le(LPI) states")
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
> Diff with v1: add __cpuidle to acpi_processor_ffh_lpi_enter
>
>  drivers/acpi/processor_idle.c | 4 ++--
>  drivers/acpi/riscv/cpuidle.c  | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.=
c
> index 390ab5f..4482cf2 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -1143,7 +1143,7 @@ static int acpi_processor_get_lpi_info(struct acpi_=
processor *pr)
>         return 0;
>  }
>
> -int __weak acpi_processor_ffh_lpi_enter(struct acpi_lpi_state *lpi)
> +int __weak __cpuidle acpi_processor_ffh_lpi_enter(struct acpi_lpi_state =
*lpi)
>  {
>         return -ENODEV;
>  }
> @@ -1156,7 +1156,7 @@ int __weak acpi_processor_ffh_lpi_enter(struct acpi=
_lpi_state *lpi)
>   *
>   * Return: 0 for success or negative value for error
>   */
> -static int acpi_idle_lpi_enter(struct cpuidle_device *dev,
> +static int __cpuidle acpi_idle_lpi_enter(struct cpuidle_device *dev,
>                                struct cpuidle_driver *drv, int index)
>  {
>         struct acpi_processor *pr;
> diff --git a/drivers/acpi/riscv/cpuidle.c b/drivers/acpi/riscv/cpuidle.c
> index 624f9bb..c76dbab 100644
> --- a/drivers/acpi/riscv/cpuidle.c
> +++ b/drivers/acpi/riscv/cpuidle.c
> @@ -66,7 +66,7 @@ int acpi_processor_ffh_lpi_probe(unsigned int cpu)
>         return acpi_cpu_init_idle(cpu);
>  }
>
> -int acpi_processor_ffh_lpi_enter(struct acpi_lpi_state *lpi)
> +int __cpuidle acpi_processor_ffh_lpi_enter(struct acpi_lpi_state *lpi)
>  {
>         u32 state =3D lpi->address;
>
> --

Sashiko says that this change may not be sufficient to fully address the is=
sue

https://sashiko.dev/#/patchset/20260616072617.2272-1-lirongqing%40baidu.com

and that appears to be a valid concern.
