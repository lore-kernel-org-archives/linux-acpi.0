From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH] ACPI/IORT: fix build regression without IOMMU
Date: Thu, 10 Aug 2017 15:24:30 +0100
Message-ID: <20170810142430.GA17205@red-moon>
References: <20170810121114.2509560-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:33708 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751492AbdHJOWc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 10 Aug 2017 10:22:32 -0400
Content-Disposition: inline
In-Reply-To: <20170810121114.2509560-1-arnd@arndb.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Hanjun Guo <hanjun.guo@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Will Deacon <will.deacon@arm.com>, Tomasz Nowicki <tn@semihalf.com>, Joerg Roedel <jroedel@suse.de>, Sricharan R <sricharan@codeaurora.org>, Robin Murphy <robin.murphy@arm.com>, Geetha Sowjanya <geethasowjanya.akula@cavium.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Aug 10, 2017 at 02:11:00PM +0200, Arnd Bergmann wrote:
> A recent change reintroduced a bug that had previously been
> fixed by commit d49f2dedf33b ("ACPI/IORT: Fix CONFIG_IOMMU_API
> dependency"):
> 
> drivers/acpi/arm64/iort.c: In function 'iort_iommu_configure':
> drivers/acpi/arm64/iort.c:829:26: error: 'struct iommu_fwspec' has no member named 'ops'
> 
> This does the same change again, replacing another direct
> reference to iommu_fwspec->ops with a helper function call.
> 
> Fixes: bc8648d49a95 ("ACPI/IORT: Handle PCI aliases properly for IOMMUs")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/acpi/arm64/iort.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Sorry Arnd, thanks, I will send it to Catalin straight away.

Lorenzo

> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index 9cdd49289786..9565d572f8dd 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -826,7 +826,7 @@ const struct iommu_ops *iort_iommu_configure(struct device *dev)
>  	 * add_device callback for dev, replay it to get things in order.
>  	 */
>  	if (!err) {
> -		ops = dev->iommu_fwspec->ops;
> +		ops = iort_fwspec_iommu_ops(dev->iommu_fwspec);
>  		err = iort_add_device_replay(ops, dev);
>  	}
>  
> -- 
> 2.9.0
> 
