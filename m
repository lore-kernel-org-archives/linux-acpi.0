Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E0E3148D2
	for <linux-acpi@vger.kernel.org>; Mon,  3 Aug 2026 14:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785767945; cv=none; b=XlqOxmU2AG/4SRnAiayzRtShHjmL89QHfEoV32rFv71qYwutqz7Xp0Y8SrVO6BABJjY/qCZBheHtlPKBXpVrZ6oIK2qFV4VSY2h0dtRkB2xQNlz28cup43RcyTACJcSJBkIO6bCC58aYjBaFSJa755+61BRKYc4+THP97qtKhRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785767945; c=relaxed/simple;
	bh=iMeqXMRGjrp0Nq0PPQPzg3zyRAhYXmQcpV1GxGO0n5k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=obcCojgiH7jVHm7JkuqXVoLXO6FIdnHEyqBD6AY3DjQl8ktxllEd+9T8CGrvTaPLJMQ4b2wXqrKwHLs6HhK4FbG7+IGT6gzs+uy56cH3i/tvWMHG12jDtNayymmyCkBc5OTICkteYqR5pY3xDBI+dX07A8owKm3VYG2VpxolkZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fjr+lZgA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fjr+lZgA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A79C01F00ADB
	for <linux-acpi@vger.kernel.org>; Mon,  3 Aug 2026 14:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785767943;
	bh=6ChJKbexhrQNNjYD8D2rQ6cUBDqXzgYhjKV+NCQQdyg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Fjr+lZgAUmQQQfylxIcmZcNdSMi9heXAPnYqKrZGrkYep3n6z6lQO8a4jhq+Zao26
	 sOnlb80A2JJ3tOuXFmml0Oqldfu9eTI9TZHm4uP8WMo2Wp9SWYKG5K+XUV04A9TD3k
	 QVz7H/zO7m3wJKwZ3zCc8RNovEvxhtKWdRf7L195TMHCo7vGSKVKS+TVu/2+rca2o2
	 m9gaR8QkwjW15NcxbT8xfjJ5xXqcN6ngUwHV20i/z9yCS86v/NExQ4PENUxZN+zjwz
	 l2VipuYPib0NRELvbtfT6be3g6ymBCpXfym2DbCvBqzwJNM/42O8OaR/jpELR35A75
	 bGGPLBIUJ5ipg==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5aeb2bc82ccso4042507e87.2
        for <linux-acpi@vger.kernel.org>; Mon, 03 Aug 2026 07:39:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rpk1gfvyHteaxoRbmwXFxrQZpBxCcqPJHgIRZ43os2VodV/mn3GfTAZ5KYVY+t1ZENOBfzwa7BVQknQ@vger.kernel.org
X-Gm-Message-State: AOJu0YziSfzomOxcgiaCtbiK5OiyaUnjlGgT3SgrtXOb8jxiABUNd+pp
	kBtLhMBr5Gl9bZ5jyJ0b/j9AuLCSeZk+qLGr4jlmGxvFdhTxdj88uTDniasg/ZH5/H1mO2/MaDW
	NvnOivrdDWK0PBippNw/2w1Pf7o2ZNhM=
X-Received: by 2002:ac2:5b5b:0:b0:5b2:a89f:bcf8 with SMTP id
 2adb3069b0e04-5b2e4f933b2mr1478355e87.57.1785767942052; Mon, 03 Aug 2026
 07:39:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729100245.2628302-1-christian.loehle@arm.com>
 <cover.1785749175.git.christian.loehle@arm.com> <18ee922e97441b99b9ab346fe559d837d05eb5e7.1785749175.git.christian.loehle@arm.com>
In-Reply-To: <18ee922e97441b99b9ab346fe559d837d05eb5e7.1785749175.git.christian.loehle@arm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 3 Aug 2026 16:38:49 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iDuOJ2C_P8G9xD9BV7XEpQroyPecqM30ZxfEL=PzROAg@mail.gmail.com>
X-Gm-Features: AUfX_mwfoznVKLWmN2Gr2TjX8Ryjzp2eaIbW19kByFsIwyJLfld5ror2HFqbop0
Message-ID: <CAJZ5v0iDuOJ2C_P8G9xD9BV7XEpQroyPecqM30ZxfEL=PzROAg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] ACPI: CPPC: Reject desired_perf reads on ACPI 6.6+
To: Christian Loehle <christian.loehle@arm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jie Zhan <zhanjie9@hisilicon.com>, Lifeng Zheng <zhenglifeng1@huawei.com>, 
	Pierre Gondois <pierre.gondois@arm.com>, Sumit Gupta <sumitg@nvidia.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, Ionela Voinescu <ionela.voinescu@arm.com>, 
	zhongqiu.han@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026 at 12:03=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> When CPPC feedback counters cannot provide a usable sample, cppc-cpufreq
> calls cppc_get_desired_perf() because some platforms repurpose Desired
> Performance to report actual delivered performance.
>
> The fallback was added for platforms on which Desired Performance reflect=
s
> delivered performance. ACPI 6.6 defines the register as write-only, so
> invoking that workaround on an ACPI 6.6 or later platform would require a=
n
> invalid register read.
>
> Make cppc_get_desired_perf() return -EOPNOTSUPP in that case. When checki=
ng
> the FADT minor revision, mask off its upper errata-generation bits and
> compare only the specification minor version.

I'm wondering if the _CPC revision can be used for this instead of the
spec revision?

The _CPC revision changed from 3 to 4 between ACPI 6.5 and ACPI 6.6,
so doing that should be straightforward.

> The FADT revision may not accurately describe the semantics implemented b=
y
> _CPC. If a nominally pre-6.6 platform implements Desired Performance as
> write-only, a read may return zero and make cppc_cpufreq_get_rate() repor=
t
> 0 kHz. Treat a zero read as unusable and fall back to the cached OSPM
> request, just as for a failed read.
>
> Fixes: c47195631960 ("cppc_cpufreq: Use desired perf if feedback ctrs are=
 0 or unchanged")
> Cc: stable@vger.kernel.org
> Suggested-by: Sumit Gupta <sumitg@nvidia.com>
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> ---
>  drivers/acpi/cppc_acpi.c       | 15 ++++++++++++++-
>  drivers/cpufreq/cppc_cpufreq.c |  2 +-
>  2 files changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 53d09ca98f06..6e5381f8de38 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1316,15 +1316,28 @@ static int cppc_set_reg_val(int cpu, enum cppc_re=
gs reg_idx, u64 val)
>         return cpc_write(cpu, reg, val);
>  }
>
> +static bool cppc_desired_perf_readable(void)
> +{
> +       u8 minor_revision =3D acpi_gbl_FADT.minor_revision & 0x0f;
> +
> +       return acpi_gbl_FADT.header.revision < 6 ||
> +              (acpi_gbl_FADT.header.revision =3D=3D 6 && minor_revision =
< 6);
> +}
> +
>  /**
>   * cppc_get_desired_perf - Get the desired performance register value.
>   * @cpunum: CPU from which to get desired performance.
>   * @desired_perf: Return address.
>   *
> - * Return: 0 for success, -EIO otherwise.
> + * Return: 0 for success, -EOPNOTSUPP for ACPI 6.6 or later, and a negat=
ive
> + * errno otherwise.
>   */
>  int cppc_get_desired_perf(int cpunum, u64 *desired_perf)
>  {
> +       /* ACPI 6.6 no longer specifies Desired Performance as readable. =
*/
> +       if (!cppc_desired_perf_readable())
> +               return -EOPNOTSUPP;
> +
>         return cppc_get_reg_val(cpunum, DESIRED_PERF, desired_perf);
>  }
>  EXPORT_SYMBOL_GPL(cppc_get_desired_perf);
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufre=
q.c
> index 6fe0e972952a..80893844353c 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -836,7 +836,7 @@ static unsigned int cppc_cpufreq_get_rate(unsigned in=
t cpu)
>          * value first as some platforms may update the actual delivered =
perf
>          * there; if failed, resort to the cached desired perf.
>          */
> -       if (cppc_get_desired_perf(cpu, &delivered_perf))
> +       if (cppc_get_desired_perf(cpu, &delivered_perf) || !delivered_per=
f)
>                 delivered_perf =3D cpu_data->perf_ctrls.desired_perf;
>
>         return cppc_perf_to_khz(&cpu_data->perf_caps, delivered_perf);
> --
> 2.34.1
>
