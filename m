From: Greg KH <greg@kroah.com>
Subject: Re: [patch 1/2] acpiphp: allocate resources for adapters with bridges
Date: Fri, 7 Oct 2005 10:59:03 -0700
Message-ID: <20051007175903.GA6925@kroah.com>
References: <1128707147.11020.10.camel@whizzy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030533AbVJGR72@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1128707147.11020.10.camel@whizzy>
Sender: linux-kernel-owner@vger.kernel.org
To: Kristen Accardi <kristen.c.accardi@intel.com>
Cc: pcihpd-discuss@lists.sourceforge.net, linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net, rajesh.shah@intel.com, len.brown@intel.com
List-Id: linux-acpi@vger.kernel.org

On Fri, Oct 07, 2005 at 10:45:46AM -0700, Kristen Accardi wrote:
> Allocate resources for adapters with p2p bridges.
> 
> Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
> 
> diff -uprN -X linux-2.6.14-rc2/Documentation/dontdiff linux-2.6.14-rc2/drivers/pci/hotplug/acpiphp_glue.c linux-2.6.14-rc2-kca1/drivers/pci/hotplug/acpiphp_glue.c
> --- linux-2.6.14-rc2/drivers/pci/hotplug/acpiphp_glue.c	2005-08-28 16:41:01.000000000 -0700
> +++ linux-2.6.14-rc2-kca1/drivers/pci/hotplug/acpiphp_glue.c	2005-09-28 10:43:15.000000000 -0700
> @@ -58,6 +58,9 @@ static LIST_HEAD(bridge_list);
>  
>  static void handle_hotplug_event_bridge (acpi_handle, u32, void *);
>  static void handle_hotplug_event_func (acpi_handle, u32, void *);
> +static void acpiphp_sanitize_bus(struct pci_bus *bus);
> +static void acpiphp_set_hpp_values(acpi_handle handle, struct pci_bus *bus);

These are not static functions, but functions somewhere else in the
kernel.  Please put their function prototypes in a header file
somewhere.  You also need to EXPORT_SYMBOL_GPL() them so that the
hotplug driver can use them when it is loaded as a module.

thanks,

greg k-h
