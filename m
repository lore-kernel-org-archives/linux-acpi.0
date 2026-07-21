Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791F91A6807
	for <linux-acpi@vger.kernel.org>; Tue, 21 Jul 2026 12:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784636283; cv=none; b=jvgYgvExxuc7Q2C6qpryMdgElYDg3faYq8iczHwnap3nmSlNTNNZAyMylnf7Tfo5Xv7B0UZzGfGn8cNSJPqglapQxlUsULAblFO+oCSPeKQZi96uneln1euBoxZCqw2Yv3iYFii29a2K2X1iveE7/NVdElKYTVPU81NiMROiGLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784636283; c=relaxed/simple;
	bh=eYIHHwrdPqq6KBvWPj3snaQkgEgsoy1HbYGBc10094Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lLYBjacSrg+3c1TiizcL2NK41Y+2QEogqHej58AGfPqJwqTHqmfiahKnHPn7aXZ11vQoKVMzvxq9YBYIoRY+jD+hi6E72XrACwqUlZFQZyinB+BVVZxTFO6eTl14XIR76OzbpYPhIpsKfkKqinfVYETc6IW5vDa1yrVO3p9jVaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PUtcA9S/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PUtcA9S/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 336D31F00A3E
	for <linux-acpi@vger.kernel.org>; Tue, 21 Jul 2026 12:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784636282;
	bh=7QZEPKLTpNwbB5JngCQVJO2bfUymmruYyPGkLEFAll4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=PUtcA9S//mv1skOXlqKzBQGeWGc7FM7g7MRKrwLb3WDbNSa1W5GhmFJogpbz/qkbI
	 gjuDuPMRnINeNgjFQlEK81tGmraWKFMfCuaLQwNHXDxqMkFLsXD0WEipmOA3CWivZ0
	 Iq6uTNvluG7i9CQoYHwt5MeGTY1Ruex0X1mS9b00jRkM/FpJ4U9J9UTAZVpPxvs0cI
	 iFCTTiZw1QODic7aKPEXD/MXjkjJTjt7eRixMFjztrpz9kgjiwngJxQHGSzAJ+WyXh
	 +Zb4+Hb3zujgb4rJkrcj8QLh1+VjpUb2ghe4gBprDnKVy5wFPqvGGMQb6M4soVxuI6
	 DVSvmcrVzjcDQ==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5b01910b499so4169399e87.0
        for <linux-acpi@vger.kernel.org>; Tue, 21 Jul 2026 05:18:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rq7S8r4+4GgCXwt1DAKIf9qNVgUVYjmn9aQT7omS4v9vq/l4XgKiCzp3fyvVPLk3/I3D+BrwNzjJLMC@vger.kernel.org
X-Gm-Message-State: AOJu0YyciIUHk7W2VkcZkBPaO3dsRAihSohu7Yo1U9M+GP6njQxLPTwQ
	tZVsuk+R/vXT5yiiqNxCJR9GE2Jon/as0+p2XF7vfMPkMlGsO0cyvnvbPdgr9OzovoTNRC5NJlW
	OLDpMGfsfOiCJCyN2QJEbXCTEvYcE+xE=
X-Received: by 2002:a05:6512:2349:b0:5ae:a4a4:b6ca with SMTP id
 2adb3069b0e04-5b28ff880a4mr2711254e87.14.1784636280154; Tue, 21 Jul 2026
 05:18:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708082818.808041-1-zhangpengjie2@huawei.com> <20260708082818.808041-2-zhangpengjie2@huawei.com>
In-Reply-To: <20260708082818.808041-2-zhangpengjie2@huawei.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 21 Jul 2026 14:17:40 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gK6Eyt79NNUwiKhjTKyqGFyV+xd0qbXh=H9LKq-KPwCQ@mail.gmail.com>
X-Gm-Features: AUfX_myA8teaH5y5c3TVDWKLB214sqkMZR3aAiSmyynhvTzz9QApTt5JZeUCam8
Message-ID: <CAJZ5v0gK6Eyt79NNUwiKhjTKyqGFyV+xd0qbXh=H9LKq-KPwCQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ACPI: CPPC: add paired FFH feedback-counter read hook
To: Pengjie Zhang <zhangpengjie2@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org, rafael@kernel.org, 
	lenb@kernel.org, saket.dumbre@intel.com, beata.michalska@arm.com, 
	zhenglifeng1@huawei.com, sumitg@nvidia.com, zhanjie9@hisilicon.com, 
	geert+renesas@glider.be, cuiyunhui@bytedance.com, 
	vanshikonda@os.amperecomputing.com, ionela.voinescu@arm.com, 
	jeremy.linton@arm.com, viresh.kumar@linaro.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, linuxarm@huawei.com, 
	prime.zeng@hisilicon.com, wanghuiqiang@huawei.com, xuwei5@huawei.com, 
	lihuisong@huawei.com, yubowen8@huawei.com, wangzhi12@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 8, 2026 at 10:28=E2=80=AFAM Pengjie Zhang <zhangpengjie2@huawei=
.com> wrote:
>
> cppc_get_perf_ctrs() reads the delivered and reference performance
> counters one at a time.
>
> Allow architectures to provide both FFH feedback counters in one
> operation when that either narrows the sampling window or avoids extra
> cross-CPU reads. Add a small FFH-specific hook for that case and fall
> back to the existing per-register reads when unsupported.
>
> Tested-by: Sumit Gupta <sumitg@nvidia.com>
> Reviewed-by: Sumit Gupta <sumitg@nvidia.com>
> Tested-by: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
> Reviewed-by: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
> Signed-off-by: Pengjie Zhang <zhangpengjie2@huawei.com>

This is fine with me, so

Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

and please route it along with the second patch in the series.

Thanks!

> ---
>  drivers/acpi/cppc_acpi.c | 50 ++++++++++++++++++++++++++++++++++++----
>  include/acpi/cppc_acpi.h |  7 ++++++
>  2 files changed, 52 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 9f572f481241..b6356476a46e 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1004,6 +1004,22 @@ int __weak cpc_read_ffh(int cpunum, struct cpc_reg=
 *reg, u64 *val)
>         return -ENOTSUPP;
>  }
>
> +/**
> + * cpc_read_ffh_fb_ctrs() - Read FFH feedback counters together
> + * @cpunum:    Target CPU
> + * @reg1:      first CPPC register information
> + * @val1:      place holder for first return value
> + * @reg2:      second CPPC register information
> + * @val2:      place holder for second return value
> + *
> + * Return: 0 on success, error code otherwise
> + */
> +int __weak cpc_read_ffh_fb_ctrs(int cpunum, struct cpc_reg *reg1,
> +                               u64 *val1, struct cpc_reg *reg2, u64 *val=
2)
> +{
> +       return -EOPNOTSUPP;
> +}
> +
>  /**
>   * cpc_write_ffh() - Write FFH register
>   * @cpunum:    CPU number to write
> @@ -1496,6 +1512,33 @@ bool cppc_perf_ctrs_in_pcc_cpu(unsigned int cpu)
>  }
>  EXPORT_SYMBOL_GPL(cppc_perf_ctrs_in_pcc_cpu);
>
> +static int cppc_read_fb_ctrs(int cpunum,
> +                            struct cpc_register_resource *delivered_reg,
> +                            struct cpc_register_resource *reference_reg,
> +                            u64 *delivered, u64 *reference)
> +{
> +       int ret;
> +
> +       /*
> +        * For FFH feedback counters, try a paired read first to reduce
> +        * sampling skew between delivered and reference counters. Fall
> +        * back to the existing per-register reads if unsupported.
> +        */
> +       if (CPC_IN_FFH(delivered_reg) && CPC_IN_FFH(reference_reg)) {
> +               ret =3D cpc_read_ffh_fb_ctrs(cpunum,
> +                                       &delivered_reg->cpc_entry.reg, de=
livered,
> +                                       &reference_reg->cpc_entry.reg, re=
ference);
> +               if (ret !=3D -EOPNOTSUPP)
> +                       return ret;
> +       }
> +
> +       ret =3D cpc_read(cpunum, delivered_reg, delivered);
> +       if (ret)
> +               return ret;
> +
> +       return cpc_read(cpunum, reference_reg, reference);
> +}
> +
>  /**
>   * cppc_perf_ctrs_in_pcc - Check if any perf counters are in a PCC regio=
n.
>   *
> @@ -1561,11 +1604,8 @@ int cppc_get_perf_ctrs(int cpunum, struct cppc_per=
f_fb_ctrs *perf_fb_ctrs)
>                 }
>         }
>
> -       ret =3D cpc_read(cpunum, delivered_reg, &delivered);
> -       if (ret)
> -               goto out_err;
> -
> -       ret =3D cpc_read(cpunum, reference_reg, &reference);
> +       ret =3D cppc_read_fb_ctrs(cpunum, delivered_reg, reference_reg,
> +                               &delivered, &reference);
>         if (ret)
>                 goto out_err;
>
> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> index 8693890a7275..5acebe62feac 100644
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -176,6 +176,8 @@ extern int cppc_get_transition_latency(int cpu);
>  extern bool cpc_ffh_supported(void);
>  extern bool cpc_supported_by_cpu(void);
>  extern int cpc_read_ffh(int cpunum, struct cpc_reg *reg, u64 *val);
> +extern int cpc_read_ffh_fb_ctrs(int cpu, struct cpc_reg *reg1, u64 *val1=
,
> +                               struct cpc_reg *reg2, u64 *val2);
>  extern int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val);
>  extern int cppc_get_epp_perf(int cpunum, u64 *epp_perf);
>  extern int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls=
, bool enable);
> @@ -250,6 +252,11 @@ static inline int cpc_read_ffh(int cpunum, struct cp=
c_reg *reg, u64 *val)
>  {
>         return -EOPNOTSUPP;
>  }
> +static inline int cpc_read_ffh_fb_ctrs(int cpu, struct cpc_reg *reg1, u6=
4 *val1,
> +                                      struct cpc_reg *reg2, u64 *val2)
> +{
> +       return -EOPNOTSUPP;
> +}
>  static inline int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val=
)
>  {
>         return -EOPNOTSUPP;
> --
> 2.33.0
>
