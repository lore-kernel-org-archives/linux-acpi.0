From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [Linaro-acpi] [RFC PATCH 2/2] ata: ahci_platform: Add ACPI _CLS matching
Date: Thu, 18 Dec 2014 10:17 +0100
Message-ID: <3408260.hhf4YMy6F6@wuerfel>
References: <1418858195-22857-1-git-send-email-suravee.suthikulpanit@amd.com> <1418858195-22857-3-git-send-email-suravee.suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <1418858195-22857-3-git-send-email-suravee.suthikulpanit@amd.com>
Sender: linux-ide-owner@vger.kernel.org
To: linaro-acpi@lists.linaro.org
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, rjw@rjwysocki.net, lenb@kernel.org, hdegoede@redhat.com, tj@kernel.org, mjg59@srcf.ucam.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wednesday 17 December 2014 17:16:35 Suravee Suthikulpanit wrote:
> +#ifdef CONFIG_ATA_ACPI
> +#include <linux/acpi.h>
> +#endif
>  #include "ahci.h"
>  
>  static const struct ata_port_info ahci_port_info = {
> @@ -71,6 +74,10 @@ static const struct of_device_id ahci_of_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, ahci_of_match);
>  
> +#ifdef CONFIG_ATA_ACPI
> +static const struct acpi_device_cls ahci_cls = {0x01, 0x06, 0x01};
> +#endif
> +
>  static struct platform_driver ahci_driver = {
>         .probe = ahci_probe,
>         .remove = ata_platform_remove_one,
> @@ -78,6 +85,9 @@ static struct platform_driver ahci_driver = {
>                 .name = "ahci",
>                 .owner = THIS_MODULE,
>                 .of_match_table = ahci_of_match,
> +#ifdef CONFIG_ATA_ACPI
> +               .acpi_cls = &ahci_cls,
> +#endif
>                 .pm = &ahci_pm_ops,
> 

It would be better to leave out the various #ifdef here, in particular the
one around the header file inclusion.

	Arnd
