From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v3 04/17] ARM64 / ACPI: Introduce early_param for "acpi"
Date: Tue, 9 Sep 2014 17:37:45 +0100
Message-ID: <20140909163745.GB6370@arm.com>
References: <1409583475-6978-1-git-send-email-hanjun.guo@linaro.org>
 <1409583475-6978-5-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1409583475-6978-5-git-send-email-hanjun.guo@linaro.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mark Rutland <Mark.Rutland@arm.com>, Olof Johansson <olof@lixom.net>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Sudeep Holla <Sudeep.Holla@arm.com>, Will Deacon <Will.Deacon@arm.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <Marc.Zyngier@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Robert Richter <rric@kernel.org>, Lv Zheng <lv.zheng@intel.com>, Robert Moore <robert.moore@intel.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Randy Dunlap <rdunlap@infradead.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, Sep 01, 2014 at 03:57:42PM +0100, Hanjun Guo wrote:
> --- a/arch/arm64/kernel/acpi.c
> +++ b/arch/arm64/kernel/acpi.c
> @@ -74,3 +74,18 @@ void __init acpi_boot_table_init(void)
>   * TBD when ARM/ARM64 starts to support suspend...
>   */
>  int (*acpi_suspend_lowlevel)(void) = NULL;
> +
> +static int __init parse_acpi(char *arg)
> +{
> +	if (!arg)
> +		return -EINVAL;
> +
> +	/* "acpi=off" disables both ACPI table parsing and interpreter */
> +	if (strcmp(arg, "off") == 0)
> +		disable_acpi();
> +	else
> +		return -EINVAL;	/* Core will print when we return error */
> +
> +	return 0;
> +}
> +early_param("acpi", parse_acpi);

I forgot about early param, so there is a way to set acpi_disabled to 1
before populating the tables.

-- 
Catalin
