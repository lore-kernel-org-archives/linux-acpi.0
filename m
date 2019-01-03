From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] ACPI: Fix build failure when CONFIG_NLS is set to 'n'
Date: Thu, 3 Jan 2019 11:07:39 +0100
Message-ID: <CAJZ5v0joc+aTU3g6ySgyXa3qPkB1OcPL4EzF5iWZ_t5YZv5SVA@mail.gmail.com>
References: <20181230204005.6397-1-okaya@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181230204005.6397-1-okaya@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sinan Kaya <okaya@kernel.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Sun, Dec 30, 2018 at 9:40 PM Sinan Kaya <okaya@kernel.org> wrote:
>
> Observing link failure as follows when CONFIG_ACPI is set but
> both CONFIG_NLS and CONFIG_PCI are unset.
>
> drivers/acpi/device_sysfs.o: In function `description_show':
> device_sysfs.c:(.text+0x48a): undefined reference to `utf16s_to_utf8s'
>
> This issue has been previously fxed by
> 'commit 8a226e00eeed ("PCI: pci-label: Fix build failure when CONFIG_NLS
> is set to 'm' by allmodconfig")' selecting NLS when ACPI is present.
>
> Now that it is possible to have ACPI without PCI, we need an alternative
> select statement inside the ACPI kconfig.
>
> Fixes: 5d32a66541c46 ("PCI/ACPI: Allow ACPI to be built without CONFIG_PCI set")
> Signed-off-by: Sinan Kaya <okaya@kernel.org>
> ---
>  drivers/acpi/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 7b65a807b3dd..90ff0a47c12e 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -10,6 +10,7 @@ menuconfig ACPI
>         bool "ACPI (Advanced Configuration and Power Interface) Support"
>         depends on ARCH_SUPPORTS_ACPI
>         select PNP
> +       select NLS
>         default y if X86
>         help
>           Advanced Configuration and Power Interface (ACPI) support for
> --

Applied, with some changelog modifications.

Thanks!
