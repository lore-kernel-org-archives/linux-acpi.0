From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v2 4/7] acpi: gsi: Always perform an irq domain lookup
Date: Fri, 24 Jul 2015 16:34:34 +0800
Message-ID: <55B1F89A.6020801@linaro.org>
References: <1437656713-9677-1-git-send-email-marc.zyngier@arm.com> <1437656713-9677-5-git-send-email-marc.zyngier@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:35177 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753142AbbGXIer (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Jul 2015 04:34:47 -0400
Received: by pabkd10 with SMTP id kd10so10947267pab.2
        for <linux-acpi@vger.kernel.org>; Fri, 24 Jul 2015 01:34:46 -0700 (PDT)
In-Reply-To: <1437656713-9677-5-git-send-email-marc.zyngier@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Jiang Liu <jiang.liu@linux.intel.com>, Jason Cooper <jason@lakedaemon.net>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>, Graeme Gregory <graeme@xora.org.uk>

On 07/23/2015 09:05 PM, Marc Zyngier wrote:
> Instead of directly passing NULL to the various irq_domain functions,
> start by looking up the domain with a domain_token.
>
> As domain_token is permanently set to NULL, the lookup function will
> return the same value (no domain found) and the default will be used,
> preserving the current behaviour.
>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>   drivers/acpi/gsi.c | 22 +++++++++-------------
>   1 file changed, 9 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/acpi/gsi.c b/drivers/acpi/gsi.c
> index 38208f2..a745880 100644
> --- a/drivers/acpi/gsi.c
> +++ b/drivers/acpi/gsi.c
> @@ -14,6 +14,8 @@
>
>   enum acpi_irq_model_id acpi_irq_model;
>
> +static void *acpi_gsi_domain_token;
> +
>   static unsigned int acpi_gsi_get_irq_type(int trigger, int polarity)
>   {
>   	switch (polarity) {
> @@ -45,12 +47,9 @@ static unsigned int acpi_gsi_get_irq_type(int trigger, int polarity)
>    */
>   int acpi_gsi_to_irq(u32 gsi, unsigned int *irq)
>   {
> -	/*
> -	 * Only default domain is supported at present, always find
> -	 * the mapping corresponding to default domain by passing NULL
> -	 * as irq_domain parameter
> -	 */
> -	*irq = irq_find_mapping(NULL, gsi);
> +	struct irq_domain *d = irq_find_matching_host(acpi_gsi_domain_token);

Typo, should be irq_find_host() or
irq_find_matching_host(acpi_gsi_domain_token, DOMAIN_BUS_ANY),
it removed in later patch, so no compile error happened when
whole patch set applied.

Other than that,

Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun
