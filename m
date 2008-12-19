From: "Yinghai Lu" <yinghai@kernel.org>
Subject: Re: [PATCH 2/2] ACPI: PCI Interrupt Links -- disable when unused
Date: Fri, 19 Dec 2008 03:57:23 -0800
Message-ID: <86802c440812190357t74dbd18aya6277b3fb1c636b2@mail.gmail.com>
References: <8465ab70c5a17f796380b77ef5a0f5197a9f7c31.1229674227.git.len.brown@intel.com>
	 <c8d8961ad671f84f830bb4e59ccfb689576ecbe0.1229674227.git.len.brown@intel.com>
	 <86802c440812190110v6de03a21q4737dcc76ab6fa11@mail.gmail.com>
	 <alpine.LFD.2.00.0812190430450.1988@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.228]:57132 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752323AbYLSL5Y (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Dec 2008 06:57:24 -0500
Received: by rv-out-0506.google.com with SMTP id k40so880257rvb.1
        for <linux-acpi@vger.kernel.org>; Fri, 19 Dec 2008 03:57:23 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.0812190430450.1988@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

On Fri, Dec 19, 2008 at 1:33 AM, Len Brown <lenb@kernel.org> wrote:
> From: Len Brown <len.brown@intel.com>
> Organization: Intel Open Source Technology Center
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
> Hmmm, look like I confused git-rebase on that one,
> here it is again...
>
> thanks,
> -Len
> ---
>  drivers/acpi/pci_link.c |   11 -----------
>  1 files changed, 0 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
> index 595b131..0f7722d 100644
> --- a/drivers/acpi/pci_link.c
> +++ b/drivers/acpi/pci_link.c
> @@ -693,18 +693,7 @@ int acpi_pci_link_free_irq(acpi_handle handle)
>                printk(KERN_ERR PREFIX "Link isn't initialized\n");
>                return -1;
>        }
> -#ifdef FUTURE_USE
> -       /*
> -        * The Link reference count allows us to _DISable an unused link
> -        * and suspend time, and set it again  on resume.
> -        * However, 2.6.12 still has irq_router.resume
> -        * which blindly restores the link state.
> -        * So we disable the reference count method
> -        * to prevent duplicate acpi_pci_link_set()
> -        * which would harm some systems
> -        */
>        link->refcnt--;
> -#endif
>        ACPI_DEBUG_PRINT((ACPI_DB_INFO,
>                          "Link %s is dereferenced %d\n",
>                          acpi_device_bid(link->device), link->refcnt));
> --

maybe could have one switch in /proc so could not disable that for
some kexec path...

YH
