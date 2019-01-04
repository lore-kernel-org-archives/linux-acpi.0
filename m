From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v5 06/11] platform/x86: apple-gmux: Make PCI dependency explicit
Date: Fri, 4 Jan 2019 16:12:20 +0200
Message-ID: <CAHp75Ve0Ex245yt1efqSUS7tUuh6RnUdTowLebvJr-CtKkQSZA@mail.gmail.com>
References: <20190102181038.4418-1-okaya@kernel.org> <20190102181038.4418-7-okaya@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190102181038.4418-7-okaya@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sinan Kaya <okaya@kernel.org>
Cc: linux-next <linux-next@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Jan 2, 2019 at 8:10 PM Sinan Kaya <okaya@kernel.org> wrote:
>
> After 'commit 5d32a66541c4 ("PCI/ACPI: Allow ACPI to be built without
> CONFIG_PCI set")' dependencies on CONFIG_PCI that previously were
> satisfied implicitly through dependencies on CONFIG_ACPI have to be
> specified directly. This driver depends on the PCI infrastructure but
> the dependency has not been explicitly called out.
>
> Fixes: 5d32a66541c46 ("PCI/ACPI: Allow ACPI to be built without CONFIG_PCI set")
> Signed-off-by: Sinan Kaya <okaya@kernel.org>
> ---
>  drivers/platform/x86/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 7afb96cb1cd6..89f4b86244a7 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -1136,6 +1136,7 @@ config SAMSUNG_Q10
>  config APPLE_GMUX
>         tristate "Apple Gmux Driver"

>         depends on ACPI
> +       depends on PCI

Can you stick with the same pattern you have used for the rest in this series?
I.e.
         depends on ACPI && PCI


>         depends on PNP
>         depends on BACKLIGHT_CLASS_DEVICE
>         depends on BACKLIGHT_APPLE=n || BACKLIGHT_APPLE
> --
> 2.19.0
>


-- 
With Best Regards,
Andy Shevchenko
