From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: Re: [PATCH] fix(Fix _STA checking in acpi_bus_add)
Date: Thu, 29 Apr 2004 08:46:41 -0600
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200404290846.41647.bjorn.helgaas@hp.com>
References: <Pine.LNX.4.58.0404281525160.30907@daphne.frec.bull.fr> <200404280934.26381.bjorn.helgaas@hp.com> <Pine.A41.4.53.0404291005470.37100@isabelle.frec.bull.fr>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.A41.4.53.0404291005470.37100-uSTK/MBzOD2tas8oWxsmKKkcovwApn/9@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Simon Derr <Simon.Derr-6ktuUTfB/bM@public.gmane.org>
Cc: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thursday 29 April 2004 2:18 am, Simon Derr wrote:
> On Wed, 28 Apr 2004, Bjorn Helgaas wrote:
> 
> > Is your box based on Intel chipsets and/or firmware?  You might be
> Indeed.
> 
> > suffering from the problem I described here:
> >
> >     https://sourceforge.net/mailarchive/message.php?msg_id=6923358
> >
> > Intel firmware seems to describe the PCI root bridge where chipset
> > configuration space lives with _STA==0x8.  The spec says this means
> > "functional, but not present".  The current Linux code ignores things
> > that are "not present".
> 
> I tried your patch and it works perfectly. Thank you.
> This chipset/firmware is probably very common in the ia64 world so I think
> it might be a good idea to include your patch in the stock Linux kernel.

Well, the patch is a gross hack for a special case, and I'd be worried
about it breaking something related to docking or hotplug.  That's why
I posted it as "RFC" first, in the hope that someone could explain the
intent behind the Intel firmware.

Given the current ACPI spec, I'd say it's a bug in the Intel firmware,
and any workaround should be specific to that firmware.  If Intel
figures out good semantics for what they're trying to do, I think that
should be reflected in a future spec.

> This is just your patch with updated line offsets, applies cleanly to
> Linux 2.6.5:
> 
> --- linux-2.6.5-vanilla/drivers/acpi/bus.c	Sun Apr  4 05:37:24 2004
> +++ linux-2.6.5/drivers/acpi/bus.c	Thu Apr 29 09:43:14 2004
> @@ -112,6 +112,14 @@
>  	else
>  		STRUCT_TO_INT(device->status) = 0x0F;
> 
> +	if (device->status.functional && !device->status.present) {
> +		printk(KERN_WARNING PREFIX "Device [%s] status [%08x]: "
> +			"functional but not present; setting present\n",
> +			device->pnp.bus_id,
> +			(u32) STRUCT_TO_INT(device->status));
> +		device->status.present = 1;
> +	}
> +
>  	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Device [%s] status [%08x]\n",
>  		device->pnp.bus_id, (u32) STRUCT_TO_INT(device->status)));
> 
> 

-- 
Bjorn Helgaas - bjorn.helgaas at hp.com
Linux and Open Source Lab
Hewlett-Packard Company


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
