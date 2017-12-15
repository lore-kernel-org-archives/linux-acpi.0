From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] MAINTAINERS: Include more PCI files
Date: Sat, 16 Dec 2017 00:30:51 +0100
Message-ID: <CAJZ5v0hssHzZW2m_+sD3b5XJw8BbwwYnixqc-bKLNzRK8ewb6w@mail.gmail.com>
References: <20171215225307.175987.4972.stgit@bhelgaas-glaptop.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ot0-f195.google.com ([74.125.82.195]:35040 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755857AbdLOXaw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 15 Dec 2017 18:30:52 -0500
In-Reply-To: <20171215225307.175987.4972.stgit@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linux PCI <linux-pci@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>

On Fri, Dec 15, 2017 at 11:53 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> Add more PCI files to the PCI subsystem.
>
> I expect Rafael to continue merging things in drivers/acpi/pci*, but it's
> nice to have linux-pci included on patches.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  MAINTAINERS |    4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index aa71ab52fd76..6fcc9b8bab52 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10551,8 +10551,12 @@ T:     git git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
>  S:     Supported
>  F:     Documentation/devicetree/bindings/pci/
>  F:     Documentation/PCI/
> +F:     drivers/acpi/pci*
>  F:     drivers/pci/
> +F:     include/asm-generic/pci*
>  F:     include/linux/pci*
> +F:     include/uapi/linux/pci*
> +F:     lib/pci*
>  F:     arch/x86/pci/
>  F:     arch/x86/kernel/quirks.c
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
