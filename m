From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI / hotplug / PCI: Drop unnecessary parentheses
Date: Tue, 29 Aug 2017 16:51:37 +0200
Message-ID: <115700876.gpB9EJdWjG@aspire.rjw.lan>
References: <20170829115605.33643-1-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:56165 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751237AbdH2PAS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 29 Aug 2017 11:00:18 -0400
In-Reply-To: <20170829115605.33643-1-mika.westerberg@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On Tuesday, August 29, 2017 1:56:05 PM CEST Mika Westerberg wrote:
> There is no need for them and it makes the code look uglier than it
> should. Remove them.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/pci/hotplug/acpiphp_glue.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
> index 5ed2dcaa8e27..4e07441660e6 100644
> --- a/drivers/pci/hotplug/acpiphp_glue.c
> +++ b/drivers/pci/hotplug/acpiphp_glue.c
> @@ -527,7 +527,7 @@ static void disable_slot(struct acpiphp_slot *slot)
>  	list_for_each_entry(func, &slot->funcs, sibling)
>  		acpi_bus_trim(func_to_acpi_device(func));
>  
> -	slot->flags &= (~SLOT_ENABLED);
> +	slot->flags &= ~SLOT_ENABLED;
>  }
>  
>  static bool slot_no_hotplug(struct acpiphp_slot *slot)
> 


