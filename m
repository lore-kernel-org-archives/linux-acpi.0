From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] ACPI: print PCI root names the same way the rest of
 thekernel does
Date: 09 Mar 2005 00:22:01 -0500
Message-ID: <1110345721.9337.15.camel@d845pe>
References: <1108768508.25491.44.camel@eeyore>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <1108768508.25491.44.camel@eeyore>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Cc: ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Applied.

thanks,
-Len

On Fri, 2005-02-18 at 18:15, Bjorn Helgaas wrote:
> The rest of the kernel uses %04x:%02x for PCI domain:bus;
> ACPI should do the same.
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
> 
> ===== drivers/acpi/pci_root.c 1.23 vs edited =====
> --- 1.23/drivers/acpi/pci_root.c        2004-11-11 23:29:46 -07:00
> +++ edited/drivers/acpi/pci_root.c      2005-02-15 14:10:14 -07:00
> @@ -258,7 +258,7 @@
>         /* TBD: Locking */
>         list_add_tail(&root->node, &acpi_pci_roots);
> 
> -       printk(KERN_INFO PREFIX "%s [%s] (%02x:%02x)\n",
> +       printk(KERN_INFO PREFIX "%s [%s] (%04x:%02x)\n",
>                 acpi_device_name(device), acpi_device_bid(device),
>                 root->id.segment, root->id.bus);
> 
> @@ -272,7 +272,7 @@
>         root->bus = pci_acpi_scan_root(device, root->id.segment,
> root->id.bus);
>         if (!root->bus) {
>                 ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
> -                       "Bus %02x:%02x not present in PCI
> namespace\n",
> +                       "Bus %04x:%02x not present in PCI
> namespace\n",
>                         root->id.segment, root->id.bus));
>                 result = -ENODEV;
>                 goto end;
> 
> 
> 
> 



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
