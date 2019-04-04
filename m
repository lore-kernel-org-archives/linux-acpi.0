From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 4/4] perf: arm_spe: Enable ACPI/Platform automatic module
 loading
Date: Thu, 4 Apr 2019 18:04:23 +0100
Message-ID: <20190404170423.GC28932@fuggles.cambridge.arm.com>
References: <20190326223938.5365-1-jeremy.linton@arm.com>
 <20190326223938.5365-5-jeremy.linton@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190326223938.5365-5-jeremy.linton@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, catalin.marinas@arm.com, rjw@rjwysocki.net, lenb@kernel.org, mark.rutland@arm.com, sudeep.holla@arm.com, james.morse@arm.com, lorenzo.pieralisi@arm.com, linuxarm@huawei.com
List-Id: linux-acpi@vger.kernel.org

On Tue, Mar 26, 2019 at 05:39:38PM -0500, Jeremy Linton wrote:
> Lets add the MODULE_TABLE and platform id_table entries so that
> the SPE driver can attach to the ACPI platform device created by
> the core pmu code.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/perf/arm_spe_pmu.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
> index 7cb766dafe85..ffa2c76c08bb 100644
> --- a/drivers/perf/arm_spe_pmu.c
> +++ b/drivers/perf/arm_spe_pmu.c
> @@ -1176,7 +1176,13 @@ static const struct of_device_id arm_spe_pmu_of_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, arm_spe_pmu_of_match);
>  
> -static int arm_spe_pmu_device_dt_probe(struct platform_device *pdev)
> +static const struct platform_device_id arm_spe_match[] = {
> +	{ "arm,spe-v1", 0},

It would be nice if we could avoid duplicating this string from the ACPI
parsing code.

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(platform, arm_spe_match);
> +
> +static int arm_spe_pmu_device_probe(struct platform_device *pdev)
>  {
>  	int ret;
>  	struct arm_spe_pmu *spe_pmu;
> @@ -1236,11 +1242,12 @@ static int arm_spe_pmu_device_remove(struct platform_device *pdev)
>  }
>  
>  static struct platform_driver arm_spe_pmu_driver = {
> +	.id_table = arm_spe_match,
>  	.driver	= {
>  		.name		= DRVNAME,
>  		.of_match_table	= of_match_ptr(arm_spe_pmu_of_match),

Hmm, so some other drivers don't hook .id_table like you do, but instead
hook .acpi_match_table in the driver structure. Is that not better?

Will
