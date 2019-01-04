From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v5 04/11] platform/x86: intel_ips: make PCI dependency explicit
Date: Fri, 4 Jan 2019 16:13:42 +0200
Message-ID: <CAHp75VdnAACNQEKxfe5c3k4JrCuPNiJA2y8zWO5Q9CCQFV9W6A@mail.gmail.com>
References: <20190102181038.4418-1-okaya@kernel.org> <20190102181038.4418-5-okaya@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190102181038.4418-5-okaya@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sinan Kaya <okaya@kernel.org>
Cc: linux-next <linux-next@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Jan 2, 2019 at 8:10 PM Sinan Kaya <okaya@kernel.org> wrote:
>
> After 'commit 5d32a66541c4 ("PCI/ACPI: Allow ACPI to be built without
> CONFIG_PCI set")' dependencies on CONFIG_PCI that previously were
> satisfied implicitly through dependencies on CONFIG_ACPI have to be
> specified directly. Ipss driver is a PCI device driver but this has
> not been mentioned anywhere in Kconfig.
>

Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Fixes: 5d32a66541c46 ("PCI/ACPI: Allow ACPI to be built without CONFIG_PCI set")
> Signed-off-by: Sinan Kaya <okaya@kernel.org>
> ---
>  drivers/platform/x86/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index e3b62c2ee8d1..b36ea14b41ad 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -1009,7 +1009,7 @@ config INTEL_MFLD_THERMAL
>
>  config INTEL_IPS
>         tristate "Intel Intelligent Power Sharing"
> -       depends on ACPI
> +       depends on ACPI && PCI
>         ---help---
>           Intel Calpella platforms support dynamic power sharing between the
>           CPU and GPU, maximizing performance in a given TDP.  This driver,
> --
> 2.19.0
>


-- 
With Best Regards,
Andy Shevchenko
