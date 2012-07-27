From: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/5] acpi : move the acpi_idle_driver variable declaration
Date: Fri, 27 Jul 2012 11:16:52 +0530
Message-ID: <50122B4C.3030509@linux.vnet.ibm.com>
References: <1343213162-8064-1-git-send-email-daniel.lezcano@linaro.org> <1343213162-8064-2-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e28smtp09.in.ibm.com ([122.248.162.9]:35026 "EHLO
	e28smtp09.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751860Ab2G0FrS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 27 Jul 2012 01:47:18 -0400
Received: from /spool/local
	by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-acpi@vger.kernel.org> from <deepthi@linux.vnet.ibm.com>;
	Fri, 27 Jul 2012 11:17:07 +0530
In-Reply-To: <1343213162-8064-2-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, linaro-dev@lists.linaro.org

Hi Daniel,


On 07/25/2012 04:15 PM, Daniel Lezcano wrote:

> This variable is only used in the in processor_driver.c.
> This patch reduces the scope of the variable by moving it
> to this file.
>


This is true after applying your second patch .
Maybe you can check the sequencing of patches in the series.
As a thumb rule one should be able to build the kernel
by applying each and every patch in the series .
There would be a build break after applying this one as
acpi_idle_driver is still used in processor_idle.c by applying
just this patch.

Cheers,
Deepthi

 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/acpi/processor_driver.c |    2 +-
>  include/acpi/processor.h        |    1 -
>  2 files changed, 1 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
> index 7048b97..017b39d 100644
> --- a/drivers/acpi/processor_driver.c
> +++ b/drivers/acpi/processor_driver.c
> @@ -113,7 +113,7 @@ static struct acpi_driver acpi_processor_driver = {
> 
>  DEFINE_PER_CPU(struct acpi_processor *, processors);
>  EXPORT_PER_CPU_SYMBOL(processors);
> -
> +extern struct cpuidle_driver acpi_idle_driver;
>  struct acpi_processor_errata errata __read_mostly;
> 
>  /* --------------------------------------------------------------------------
> diff --git a/include/acpi/processor.h b/include/acpi/processor.h
> index db427fa..8b2c39a 100644
> --- a/include/acpi/processor.h
> +++ b/include/acpi/processor.h
> @@ -332,7 +332,6 @@ int acpi_processor_power_exit(struct acpi_processor *pr,
>  			      struct acpi_device *device);
>  int acpi_processor_suspend(struct device *dev);
>  int acpi_processor_resume(struct device *dev);
> -extern struct cpuidle_driver acpi_idle_driver;
> 
>  /* in processor_thermal.c */
>  int acpi_processor_get_limit_info(struct acpi_processor *pr);


