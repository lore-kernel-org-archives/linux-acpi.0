From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v8 02/21] acpi: fix acpi_os_ioremap for arm64
Date: Mon, 02 Feb 2015 23:14:39 +0100
Message-ID: <2422968.Es7R0p3loO@vostro.rjw.lan>
References: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org> <1422881149-8177-3-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:60369 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S933531AbbBBVvq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 2 Feb 2015 16:51:46 -0500
In-Reply-To: <1422881149-8177-3-git-send-email-hanjun.guo@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Grant Likely <grant.likely@linaro.org>, Will Deacon <will.deacon@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Graeme Gregory <graeme.gregory@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Jon Masters <jcm@redhat.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Robert Richter <rric@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Charles.Garcia-Tobin@arm.com, phoenix.liyi@huawei.com, Timur Tabi <timur@codeaurora.org>, Ashwin Chaugule <ashwinc@codeaurora.org>, suravee.suthikulpanit@amd.com, Mark Langsdorf <mlangsdo@redhat.com>, wangyij

On Monday, February 02, 2015 08:45:30 PM Hanjun Guo wrote:
> From: Mark Salter <msalter@redhat.com>
> 
> The acpi_os_ioremap() function may be used to map normal RAM or IO
> regions. The current implementation simply uses ioremap_cache(). This
> will work for some architectures, but arm64 ioremap_cache() cannot be
> used to map IO regions which don't support caching. So for arm64, use
> ioremap() for non-RAM regions.
> 
> CC: Rafael J Wysocki <rjw@rjwysocki.net>
> Signed-off-by: Mark Salter <msalter@redhat.com>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
>  include/acpi/acpi_io.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/include/acpi/acpi_io.h b/include/acpi/acpi_io.h
> index 444671e..9d573db 100644
> --- a/include/acpi/acpi_io.h
> +++ b/include/acpi/acpi_io.h
> @@ -1,11 +1,17 @@
>  #ifndef _ACPI_IO_H_
>  #define _ACPI_IO_H_
>  
> +#include <linux/mm.h>
>  #include <linux/io.h>
>  
>  static inline void __iomem *acpi_os_ioremap(acpi_physical_address phys,
>  					    acpi_size size)
>  {
> +#ifdef CONFIG_ARM64
> +	if (!page_is_ram(phys >> PAGE_SHIFT))
> +		return ioremap(phys, size);
> +#endif

I don't want to see #ifdef CONFIG_ARM64 in this file.

There are multiple examples of how things like this are done.  Generally,
the logic is "If the architecture provides its own function for this, use
that one, or use the generic one provided here otherwise."

> +
>         return ioremap_cache(phys, size);
>  }
>  
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
