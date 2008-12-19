From: "Yinghai Lu" <yinghai@kernel.org>
Subject: Re: [PATCH 2/2] ACPI: PCI Interrupt Links -- disable when unused
Date: Fri, 19 Dec 2008 01:10:51 -0800
Message-ID: <86802c440812190110v6de03a21q4737dcc76ab6fa11@mail.gmail.com>
References: <8465ab70c5a17f796380b77ef5a0f5197a9f7c31.1229674227.git.len.brown@intel.com>
	 <c8d8961ad671f84f830bb4e59ccfb689576ecbe0.1229674227.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.31]:28256 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752465AbYLSJKx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Dec 2008 04:10:53 -0500
Received: by yw-out-2324.google.com with SMTP id 9so324153ywe.1
        for <linux-acpi@vger.kernel.org>; Fri, 19 Dec 2008 01:10:51 -0800 (PST)
In-Reply-To: <c8d8961ad671f84f830bb4e59ccfb689576ecbe0.1229674227.git.len.brown@intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>

On Fri, Dec 19, 2008 at 12:22 AM, Len Brown <lenb@kernel.org> wrote:
> From: Len Brown <len.brown@intel.com>
>
> We start the system off with disabled links.
> Here we enable the reference counting
> on the links so that when drivers free IRQs
> the links can return to the disabled state.
>
> Drivers free their IRQ and reference on a link
> when they unload.  They may also do so upon
> suspend.  However, if they don't, irqrouter_resume()
> will still resume any links that were
> not disabled before suspend.
>
> Signed-off-by: Len Brown <len.brown@intel.com>
> ---
>  drivers/acpi/pci_link.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
> index 595b131..7d12762 100644
> --- a/drivers/acpi/pci_link.c
> +++ b/drivers/acpi/pci_link.c
> @@ -693,6 +693,7 @@ int acpi_pci_link_free_irq(acpi_handle handle)
>                printk(KERN_ERR PREFIX "Link isn't initialized\n");
>                return -1;
>        }
> +<<<<<<< HEAD:drivers/acpi/pci_link.c
>  #ifdef FUTURE_USE
>        /*
>         * The Link reference count allows us to _DISable an unused link
> @@ -703,8 +704,9 @@ int acpi_pci_link_free_irq(acpi_handle handle)
>         * to prevent duplicate acpi_pci_link_set()
>         * which would harm some systems
>         */
> +=======
> +>>>>>>> 683984a... ACPI: PCI Interrupt Links -- disable when unused:drivers/acpi/pci_link.c
>        link->refcnt--;
> -#endif

looks like merge conflicts fix.

YH
