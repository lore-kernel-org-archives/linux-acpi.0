From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v9 08/21] ARM64 / ACPI: Introduce PCI stub functions for
 ACPI
Date: Fri, 6 Mar 2015 18:31:57 +0000
Message-ID: <20150306183157.GC26888@e102568-lin.cambridge.arm.com>
References: <1424853601-6675-1-git-send-email-hanjun.guo@linaro.org>
 <1424853601-6675-9-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:60843 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753989AbbCFScF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 6 Mar 2015 13:32:05 -0500
Content-Disposition: inline
In-Reply-To: <1424853601-6675-9-git-send-email-hanjun.guo@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Catalin Marinas <Catalin.Marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Will Deacon <Will.Deacon@arm.com>, Olof Johansson <olof@lixom.net>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <Mark.Rutland@arm.com>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, "jcm@redhat.com" <jcm@redhat.com>, Marc Zyngier <Marc.Zyngier@arm.com>, Mark Brown <broonie@kernel.org>, Robert Richter <rric@kernel.org>, Timur Tabi <timur@codeaurora.org>, Ashwin Chaugule <ashwinc@codeaurora.org>, "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linaro-acpi@lists.linaro.

On Wed, Feb 25, 2015 at 08:39:48AM +0000, Hanjun Guo wrote:

[...]

> diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
> index 6f93c24..4095379 100644
> --- a/arch/arm64/kernel/pci.c
> +++ b/arch/arm64/kernel/pci.c
> @@ -10,6 +10,7 @@
>   *
>   */
>  
> +#include <linux/acpi.h>
>  #include <linux/init.h>
>  #include <linux/io.h>
>  #include <linux/kernel.h>
> @@ -46,3 +47,27 @@ int pcibios_add_device(struct pci_dev *dev)
>  
>  	return 0;
>  }
> +
> +/*
> + * raw_pci_read/write - Platform-specific PCI config space access.
> + */
> +int raw_pci_read(unsigned int domain, unsigned int bus,
> +		  unsigned int devfn, int reg, int len, u32 *val)
> +{
> +	return -ENXIO;
> +}
> +
> +int raw_pci_write(unsigned int domain, unsigned int bus,
> +		unsigned int devfn, int reg, int len, u32 val)
> +{
> +	return -ENXIO;
> +}
> +

It would be nice to see:

https://lkml.org/lkml/2015/2/27/264

merged at the same time, so that the two functions above disappear :)

Lorenzo
