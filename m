From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v3 04/17] ARM64 / ACPI: Introduce early_param for "acpi"
Date: Tue, 9 Sep 2014 11:17:00 -0600
Message-ID: <CAErSpo6G89mkPgas8Wk3ofq__dUo5MKvBjob5D_w5_GaBJWH0w@mail.gmail.com>
References: <1409583475-6978-1-git-send-email-hanjun.guo@linaro.org> <1409583475-6978-5-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1409583475-6978-5-git-send-email-hanjun.guo@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mark Rutland <mark.rutland@arm.com>, Olof Johansson <olof@lixom.net>, Grant Likely <grant.likely@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Sudeep Holla <Sudeep.Holla@arm.com>, Will Deacon <will.deacon@arm.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Robert Richter <rric@kernel.org>, Lv Zheng <lv.zheng@intel.com>, Robert Moore <robert.moore@intel.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Randy Dunlap <rdunlap@infradead.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>linux-arm <linux>
List-Id: linux-acpi@vger.kernel.org

On Mon, Sep 1, 2014 at 8:57 AM, Hanjun Guo <hanjun.guo@linaro.org> wrote:
> From: Al Stone <al.stone@linaro.org>
>
> Introduce one early parameters "off" for "acpi" to disable ACPI on
> ARM64.

It might be worth mentioning the purpose of this in the changelog (and
maybe the documentation).  I don't think this parameter is supported
on ia64, and on x86 it seems like it's mostly used as a "fix" by
Ubuntu users who consider the problem resolved when they find this
parameter.  That just means we don't get a chance to fix the real
underlying problem, so I'm not sure it's a real benefit to have the
parameter.

> Signed-off-by: Al Stone <al.stone@linaro.org>
> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
>  Documentation/kernel-parameters.txt |    3 ++-
>  arch/arm64/kernel/acpi.c            |   15 +++++++++++++++
>  2 files changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
> index 5ae8608..9dfb1d8 100644
> --- a/Documentation/kernel-parameters.txt
> +++ b/Documentation/kernel-parameters.txt
> @@ -165,7 +165,7 @@ multipliers 'Kilo', 'Mega', and 'Giga', equalling 2^10, 2^20, and 2^30
>  bytes respectively. Such letter suffixes can also be entirely omitted.
>
>
> -       acpi=           [HW,ACPI,X86]
> +       acpi=           [HW,ACPI,X86,ARM]
>                         Advanced Configuration and Power Interface
>                         Format: { force | off | strict | noirq | rsdt }
>                         force -- enable ACPI if default was off
> @@ -175,6 +175,7 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
>                                 strictly ACPI specification compliant.
>                         rsdt -- prefer RSDT over (default) XSDT
>                         copy_dsdt -- copy DSDT to memory
> +                       For ARM64, ONLY "acpi=off" is available.
>
>                         See also Documentation/power/runtime_pm.txt, pci=noacpi
>
> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
> index b6940a0..9547275 100644
> --- a/arch/arm64/kernel/acpi.c
> +++ b/arch/arm64/kernel/acpi.c
> @@ -74,3 +74,18 @@ void __init acpi_boot_table_init(void)
>   * TBD when ARM/ARM64 starts to support suspend...
>   */
>  int (*acpi_suspend_lowlevel)(void) = NULL;
> +
> +static int __init parse_acpi(char *arg)
> +{
> +       if (!arg)
> +               return -EINVAL;
> +
> +       /* "acpi=off" disables both ACPI table parsing and interpreter */
> +       if (strcmp(arg, "off") == 0)
> +               disable_acpi();
> +       else
> +               return -EINVAL; /* Core will print when we return error */
> +
> +       return 0;
> +}
> +early_param("acpi", parse_acpi);
> --
> 1.7.9.5
>
