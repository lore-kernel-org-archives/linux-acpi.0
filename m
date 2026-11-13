Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794582278;
	b=XCOHfhk3LOUDmsy2WfWNTcNSMzRGFByUi0J0XP5I3WK2YxP8DSW8WC992BY7nQGYRNso
	 MnA8yQbRCaP5cbIOFqVmgDQ4TdnlaePiTnZhutnwYpN/u11EPdokB4B1qjMvjXclH83eZ
	 WQYJu8itdkxCOto+MdsOx7lU6av0m0h9tvBHwue+wxbP7QlpCCiBGZfEU6Mu68nzR/gI9
	 xbdyZsMk2Gs1eAMeODMr3Vm5IOFB4yiCQeQEllCcCh1rW1mno9ruceTaOc/2VMryXnzF9
	 Qj2Swii+etZ6hP2fVGQdtXNoCKHG1y3I1cM99ibIoKwFQGn8s3XzuBUSMLB9ySPL2MQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794582278;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=kbBjRgmT9qgWX9JcAIks0NFFYmbsdb28Bgdoa2Ns/l0=;
	b=Vspm1WnR/nLu2xyldUvC8+Navaf+t4JeOSmYvueO/Jkty+DBMPDc69yRZIpGXOyFqQj6
	 iZdVS+BjWwf+3Y2eUiUtvvcSivSy5cJeiIkLhiCZVewWjKyVCQaImwPW4eq6IFHj8fUyM
	 l+W3iHs4D2pvEGMMoM3w6dBvA227Ws1z0Q2vkR6+WW/uN4C6K+lX0uIB8dTOxTvMTK+LR
	 dudZRDfoIdXpLaKkabrX1BmJZpmt90Z+QFz2Y/tSkNc2SnJvET4Ev8thQt9KvJpXumMya
	 Xzl529CfsAyJzu6DgIKFWaUNOZezFZ4fSCwu/PvP2rsu70MuOWjsg7dD7gUUPcAcj+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IrCrDKxV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08E3606A334
	for <linux-acpi@vger.kernel.org>; Fri, 13 Nov 2026 15:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IrCrDKxV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D6E61F000C5
	for <linux-acpi@vger.kernel.org>; Fri, 13 Nov 2026 15:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794582278;
	bh=kbBjRgmT9qgWX9JcAIks0NFFYmbsdb28Bgdoa2Ns/l0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=IrCrDKxV/9wVP7o1A7Uwwq7KjWFyRCJl3dAQ7/g7gWaijgrPjFRCRmhQlBLdWVcBH
	 Y0JBHhUopPngdNXRgzXWeyCUbHm2ANpWsFzJs6UoBzYMjNJ9DuO58pg/jwr8b17Aee
	 MqnJ7Fal6xcUQ6DroTmn7ezlWMbttYPwdkEbnbIMZZClr0LaaNjSyFXp+J/u7zUiEH
	 X6kVqlDG+lBoaY0er8P3dIrFDfdGFRIOI+jmHy8D1rRS8/+xAdIjpZygXcULlQAbxi
	 NxZykgby/i4t778qxSQH6v0jKBhX430t8ut1zBjsQpPQhGn83TTnDiuGmjaKqvwnw1
	 D2VrlneApiEKg==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3adfe77d336so15598371fa.1
        for <linux-acpi@vger.kernel.org>; Fri, 13 Nov 2026 07:04:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFXT4P/ELZE9LSCFQ0JrPI0K/zl5jrFjP5BYxgFp82UR1fUl+B4E2YzmDfMZBTlFS76hRxA+AEPsRJZ@vger.kernel.org
X-Gm-Message-State: APuU4Z8VgoNzLuHtBX+OnKzRuPkRnvrAcRK0WK8qW08OvW0Vk2HltXdc
	D0OJs1KZ/DSj6zBI5QcdVqv2T4U05+P/vqJiIlFoCE76hG8OWzls5Gc4zBE2ZOVND0dhFJa3lqJ
	+2SMN2v9aEd1zKpIBsvtHjnU0nzw9gQQ=
X-Received: by 2002:a05:6512:3c9f:b0:5bf:d0d5:3b12 with SMTP id
 2adb3069b0e04-5c1709e535bmr1462462e87.42.1794582276836; Fri, 13 Nov 2026
 07:04:36 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111220803.3953790-1-sumitg@nvidia.com>
In-Reply-To: <20261111220803.3953790-1-sumitg@nvidia.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 13 Nov 2026 16:04:24 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hJExw-TYyF-TtEeuZ9kw3v5cm=H3Q=vLLqQ51V0Xn8Mg@mail.gmail.com>
X-Gm-Features: AclHuK_uNNKHpJk3ChlalQ1s4LPVs3H0vhMDhZKt2eCu7idDfJ7Nkp1Kg8j37kg
Message-ID: <CAJZ5v0hJExw-TYyF-TtEeuZ9kw3v5cm=H3Q=vLLqQ51V0Xn8Mg@mail.gmail.com>
Subject: Re: [PATCH v6] cpufreq: CPPC: Add autonomous mode boot parameter support
To: Sumit Gupta <sumitg@nvidia.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, zhanjie9@hisilicon.com, 
	zhenglifeng1@huawei.com, christian.loehle@arm.com, 
	maciej.wieczor-retman@intel.com, pawel.chmielewski@intel.com, lenb@kernel.org, 
	corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org, 
	linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, treding@nvidia.com, 
	jonathanh@nvidia.com, vsethi@nvidia.com, ksitaraman@nvidia.com, 
	sanjayc@nvidia.com, mochs@nvidia.com, bbasu@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2026 at 11:08=E2=80=AFPM Sumit Gupta <sumitg@nvidia.com> wr=
ote:
>
> Configuring autonomous selection and Energy Performance Preference (EPP)
> at every boot currently requires per-policy sysfs writes.
>
> Add the 'cppc_cpufreq.auto_sel_mode' boot parameter to enable autonomous
> selection during policy initialization and optionally set EPP. In
> autonomous mode, the platform selects the performance level within the
> MIN and MAX limits, which the driver sets from the policy limits. The EPP
> hint guides that selection.
>
> The parameter accepts:
> - performance: enable autonomous selection and set EPP to 0x00
> - balance_performance: enable it and set EPP to 0x80
> - balance_power: enable it and set EPP to 0xc0
> - power: enable it and set EPP to 0xff
> - default_epp: enable it and preserve firmware EPP
> - disabled: preserve the firmware configuration (default)
>
> Warn about unrecognized values and ignore them.
>
> Skip policies without autonomous-selection support. The driver enables
> autonomous selection before writing EPP, as the platform may ignore EPP
> while autonomous selection is disabled.
>
> Record successful writes so the existing online and resume paths reapply
> the requested values. The offline and suspend paths restore the saved
> firmware values, including during driver unload.
>
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
> This is based on the "Preserve OSPM-set registers" [1] and
> "ospm_nominal_perf" [2] series, which are applied for 7.5.
>
> v5 -> v6:
> - Split "Set CPPC Enable register in cpu_init" into a separate fix [3].
> - Accept strings only (Pierre [4]).
> - Move the setup into cppc_cpufreq_setup_auto_sel_mode() and check
>   autonomous selection support first (Pierre [4]).
> - Drop the last_governor check, as init() now runs only for a new
>   policy (Pierre [4]).
> - Drop the MIN/MAX seeding, Desired hint and policy->min/max override,
>   as init() and the governor already set valid values (Pierre [4]).
> - Apply the parameter at the end of init(), after the usual
>   performance controls write.
> - Save auto_sel and EPP through the saved-register code from [1]
>   (Sashiko [5]).
> - Drop the cppc_cpufreq_exit() loop that cleared auto_sel on all
>   present CPUs (Pierre [4], Sashiko [5]).
> - Enable autonomous selection before writing EPP.
> - Set EPP also when firmware has already enabled autonomous selection.
> - Add the balance_power (0xc0) and power (0xff) modes.
> - Ignore an unrecognized value instead of treating it as disabled.
>
> v5: https://lore.kernel.org/lkml/20260623080652.3353386-1-sumitg@nvidia.c=
om/
> [1] https://lore.kernel.org/lkml/20261106193304.3347374-1-sumitg@nvidia.c=
om/
> [2] https://lore.kernel.org/lkml/20261109195400.3600561-1-sumitg@nvidia.c=
om/
> [3] https://lore.kernel.org/lkml/20261110101246.3665797-1-sumitg@nvidia.c=
om/
> [4] https://lore.kernel.org/lkml/f61f592a-bc9c-4a83-bde1-e999c8101c36@nvi=
dia.com/
> [5] https://sashiko.dev/#/patchset/20260623080652.3353386-1-sumitg@nvidia=
.com
>
>  .../admin-guide/kernel-parameters.txt         |  26 ++++
>  drivers/cpufreq/cppc_cpufreq.c                | 120 ++++++++++++++++++
>  include/acpi/cppc_acpi.h                      |   2 +
>  3 files changed, 148 insertions(+)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
> index 0b3c140babd9..5714c0d30fce 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1015,6 +1015,32 @@ Kernel parameters
>                         Format:
>                         <first_slot>,<last_slot>,<port>,<enum_bit>[,<debu=
g>]
>
> +       cppc_cpufreq.auto_sel_mode=3D
> +                       [ACPI,CPU_FREQ] Enable ACPI CPPC autonomous perfo=
rmance
> +                       selection on all CPUs at boot. In autonomous mode=
, the
> +                       platform selects the performance level within the=
 CPPC
> +                       Minimum and Maximum Performance limits. The drive=
r sets
> +                       these limits from scaling_min_freq and scaling_ma=
x_freq.
> +                       The Energy Performance Preference (EPP) hint guid=
es the
> +                       platform toward performance (0x00) or energy effi=
ciency
> +                       (0xff).
> +                       Requires the ACPI CPPC Autonomous Selection Enabl=
e
> +                       register. EPP is set only if the platform impleme=
nts it.
> +                       Format: <string>
> +                         performance:
> +                                 enable autonomous selection, set EPP to=
 0x00
> +                         balance_performance:
> +                                 enable autonomous selection, set EPP to=
 0x80
> +                         balance_power:
> +                                 enable autonomous selection, set EPP to=
 0xc0
> +                         power:
> +                                 enable autonomous selection, set EPP to=
 0xff
> +                         default_epp:
> +                                 enable autonomous selection, keep firmw=
are EPP
> +                         disabled:
> +                                 keep the firmware configuration (defaul=
t)
> +                       An unrecognized value is ignored with a warning.
> +
>         cpuidle.off=3D1   [CPU_IDLE]
>                         disable the cpuidle sub-system
>
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufre=
q.c
> index a62589c0674f..c9bed93cf0c9 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -238,6 +238,58 @@ static void cppc_cpufreq_apply_saved_regs(struct cpu=
freq_policy *policy,
>                                              saved_type);
>  }
>
> +/* Autonomous Selection boot parameter modes */
> +enum {
> +       AUTO_SEL_MODE_DISABLED,
> +       AUTO_SEL_MODE_PERFORMANCE,
> +       AUTO_SEL_MODE_BALANCE_PERFORMANCE,
> +       AUTO_SEL_MODE_BALANCE_POWER,
> +       AUTO_SEL_MODE_POWER,
> +       AUTO_SEL_MODE_DEFAULT_EPP,
> +};
> +
> +static const char * const auto_sel_mode_names[] =3D {
> +       [AUTO_SEL_MODE_DISABLED]                =3D "disabled",
> +       [AUTO_SEL_MODE_PERFORMANCE]             =3D "performance",
> +       [AUTO_SEL_MODE_BALANCE_PERFORMANCE]     =3D "balance_performance"=
,
> +       [AUTO_SEL_MODE_BALANCE_POWER]           =3D "balance_power",
> +       [AUTO_SEL_MODE_POWER]                   =3D "power",
> +       [AUTO_SEL_MODE_DEFAULT_EPP]             =3D "default_epp",
> +};
> +
> +static int auto_sel_mode;
> +
> +static int auto_sel_mode_set(const char *val, const struct kernel_param =
*kp)
> +{
> +       int *mode =3D kp->arg;
> +       int ret;
> +
> +       ret =3D sysfs_match_string(auto_sel_mode_names, val);
> +       if (ret < 0) {
> +               pr_warn("Invalid auto_sel_mode \"%s\", ignoring it\n", va=
l);
> +               return 0;
> +       }
> +
> +       *mode =3D ret;
> +       return 0;
> +}
> +
> +static int auto_sel_mode_get(char *buffer, const struct kernel_param *kp=
)
> +{
> +       int *mode =3D kp->arg;
> +
> +       return sysfs_emit(buffer, "%s\n", auto_sel_mode_names[*mode]);
> +}
> +
> +static const struct kernel_param_ops auto_sel_mode_ops =3D {
> +       .set =3D auto_sel_mode_set,
> +       .get =3D auto_sel_mode_get,
> +};
> +
> +module_param_cb(auto_sel_mode, &auto_sel_mode_ops, &auto_sel_mode, 0444)=
;
> +MODULE_PARM_DESC(auto_sel_mode,
> +                "Autonomous selection mode: performance, balance_perform=
ance, balance_power, power, default_epp, disabled");
> +
>  #ifdef CONFIG_ACPI_CPPC_CPUFREQ_FIE
>  static enum {
>         FIE_UNSET =3D -1,
> @@ -938,6 +990,72 @@ static u32 cppc_cpufreq_effective_nominal(struct cpu=
freq_policy *policy)
>         return (u32)ospm_nominal;
>  }
>
> +/*
> + * Apply the auto_sel_mode boot parameter in init(). Enable autonomous
> + * selection unless it is already enabled. Then set EPP for the selected=
 mode.
> + *
> + * Enable auto_sel before writing EPP, as the platform may ignore EPP wh=
ile
> + * autonomous selection is disabled. Save each value written, so that on=
line()
> + * and resume() write it again.
> + */
> +static void cppc_cpufreq_setup_auto_sel_mode(struct cpufreq_policy *poli=
cy)
> +{
> +       struct cppc_policy_state *st =3D cppc_cpufreq_policy_state(policy=
);
> +       struct cppc_cpudata *cpu_data =3D policy->driver_data;
> +       unsigned int cpu =3D policy->cpu;
> +       u64 auto_sel, epp;
> +       int ret;
> +
> +       if (auto_sel_mode =3D=3D AUTO_SEL_MODE_DISABLED)
> +               return;
> +
> +       /* U64_MAX means the platform does not implement the register. */
> +       auto_sel =3D st->regs[CPPC_SAVED_AUTO_SEL][CPPC_SAVED_FIRMWARE];
> +       if (auto_sel =3D=3D U64_MAX) {
> +               pr_info_once("Autonomous selection is not supported, igno=
ring auto_sel_mode\n");
> +               return;
> +       }
> +
> +       if (!auto_sel) {
> +               ret =3D cppc_set_auto_sel(cpu, true);
> +               if (ret) {
> +                       pr_warn("Failed to enable auto_sel for CPU%u (%d)=
\n",
> +                               cpu, ret);
> +                       return;
> +               }
> +               cppc_cpufreq_save_requested(policy, CPPC_SAVED_AUTO_SEL, =
true);
> +       }
> +       cpu_data->perf_ctrls.auto_sel =3D true;
> +
> +       switch (auto_sel_mode) {
> +       case AUTO_SEL_MODE_PERFORMANCE:
> +               epp =3D CPPC_EPP_PERFORMANCE_PREF;
> +               break;
> +       case AUTO_SEL_MODE_BALANCE_PERFORMANCE:
> +               epp =3D CPPC_EPP_BALANCE_PERFORMANCE_PREF;
> +               break;
> +       case AUTO_SEL_MODE_BALANCE_POWER:
> +               epp =3D CPPC_EPP_BALANCE_POWER_PREF;
> +               break;
> +       case AUTO_SEL_MODE_POWER:
> +               epp =3D CPPC_EPP_ENERGY_EFFICIENCY_PREF;
> +               break;
> +       default:
> +               /* default_epp keeps the EPP value set by firmware. */
> +               return;
> +       }
> +
> +       /* EPP is optional. */
> +       ret =3D cppc_set_epp(cpu, epp);
> +       if (ret) {
> +               if (ret !=3D -EOPNOTSUPP)
> +                       pr_warn("Failed to set EPP for CPU%u (%d)\n", cpu=
, ret);
> +               return;
> +       }
> +       cpu_data->perf_ctrls.energy_perf =3D epp;
> +       cppc_cpufreq_save_requested(policy, CPPC_SAVED_EPP, epp);
> +}
> +
>  static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  {
>         unsigned int cpu =3D policy->cpu;
> @@ -1058,6 +1176,8 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_pol=
icy *policy)
>         }
>         cpu_data->perf_limits_valid =3D true;
>
> +       cppc_cpufreq_setup_auto_sel_mode(policy);
> +
>         cppc_cpufreq_cpu_fie_init(policy);
>         return 0;
>
> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> index 2cec54b4d2e2..3d47c07f494b 100644
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -42,6 +42,8 @@
>  #define CPPC_AUTO_ACT_WINDOW_SIG_CARRY_THRESH 129
>
>  #define CPPC_EPP_PERFORMANCE_PREF              0x00
> +#define CPPC_EPP_BALANCE_PERFORMANCE_PREF      0x80
> +#define CPPC_EPP_BALANCE_POWER_PREF            0xC0
>  #define CPPC_EPP_ENERGY_EFFICIENCY_PREF                0xFF
>
>  #define CPPC_PERF_LIMITED_DESIRED_EXCURSION    BIT(0)
> --

Applied as 7.5 material, thanks!
