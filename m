From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI: processor: use dev_dbg() instead of dev_warn() when CPPC probe failed
Date: Fri, 28 Jul 2017 01:52:36 +0200
Message-ID: <4659175.jQJ2plZSbM@aspire.rjw.lan>
References: <1501065612-45769-1-git-send-email-guohanjun@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:61871 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751708AbdG1AAi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 27 Jul 2017 20:00:38 -0400
In-Reply-To: <1501065612-45769-1-git-send-email-guohanjun@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <guohanjun@huawei.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, Alexey Klimov <alexey.klimov@arm.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

On Wednesday, July 26, 2017 06:40:12 PM Hanjun Guo wrote:
> From: Hanjun Guo <hanjun.guo@linaro.org>
> 
> _CPC is a optinal object for processor device so it's
> fine for processor devices in DSDT without CPPC data,
> but when booting the system with CPPC enabled in the
> kernel but without its support in the firmware, I got
> lots of warnings on a 64 core system:
> 
> [    6.346016] acpi ACPI0007:00: CPPC data invalid or not present
> [    6.346028] acpi ACPI0007:01: CPPC data invalid or not present
> [    6.346039] acpi ACPI0007:02: CPPC data invalid or not present
> [    6.346050] acpi ACPI0007:03: CPPC data invalid or not present
> [    6.346063] acpi ACPI0007:04: CPPC data invalid or not present
> ...
> [    6.346737] acpi ACPI0007:3f: CPPC data invalid or not present
> 
> This isn't much useful and a little bit noise, so
> switch the dev_warn() to dev_dbg().
> 
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> Cc: Alexey Klimov <alexey.klimov@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/acpi/processor_driver.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
> index 591d1dd..9d6aff2 100644
> --- a/drivers/acpi/processor_driver.c
> +++ b/drivers/acpi/processor_driver.c
> @@ -237,7 +237,7 @@ static int __acpi_processor_start(struct acpi_device *device)
>  
>  	result = acpi_cppc_processor_probe(pr);
>  	if (result && !IS_ENABLED(CONFIG_ACPI_CPU_FREQ_PSS))
> -		dev_warn(&device->dev, "CPPC data invalid or not present\n");
> +		dev_dbg(&device->dev, "CPPC data invalid or not present\n");
>  
>  	if (!cpuidle_get_driver() || cpuidle_get_driver() == &acpi_idle_driver)
>  		acpi_processor_power_init(pr);
> 

Applied, thanks!

