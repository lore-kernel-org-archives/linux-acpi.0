From: Matthew Wilcox <matthew-Ztpu424NOJ8@public.gmane.org>
Subject: Re: [PATCH/RFC 4/4]An experimental implementation for IDE bus
Date: Mon, 8 Nov 2004 15:24:50 +0000
Message-ID: <20041108152450.GB32374@parcelfarce.linux.theplanet.co.uk>
References: <1099887081.1750.249.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1099887081.1750.249.camel-U5EdaLXB8smDugQYiPIPGdh3ngVCH38I@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: ACPI-DEV <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Greg <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, Patrick Mochel <mochel-og82NyAXoxR0I81aPRRTmR2eb7JE58TQ@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, Nov 08, 2004 at 12:11:47PM +0800, Li Shaohua wrote:
> A sample patch to bind IDE devices. I'm not familar with IDE driver, so
> the patch possibly is completely wrong, though it can show correct ACPI
> path in my laptop. This test case just shows the framework works, please
> don't apply it.

> +#ifdef CONFIG_ACPI
> +#include <linux/acpi.h>
> +int generic_ide_platform_bind(struct device *dev)
> +{
> +	acpi_handle parent_handle = NULL;
> +	acpi_integer address;
> +	int i;
> +
> +	/* Seems dev->parent->parent is the PCI IDE controller */
> +        if (dev->parent && dev->parent->parent)
> +                parent_handle = dev->parent->parent->handle;

An IDE struct device is the gendev embedded in the ide_drive_t.  Its parent
is the ide_hwif_t, and its parent is the PCI device (or maybe SBUS
or whatever).  You can see this in /sys:

$ ls /sys/devices/pci0000:00/0000:00:1f.1/ide0/0.0
block  detach_state  power

The '0.0' is the device with an ide_bus_type.  ide0 is the hwif.
0000:00:1f.1 is a pci_dev.  Or in ACPI terms, ACPI/_SB/PCI0/IDEC
is ide0 and ACPI/_SB/PCI0/IDEC/PRID is 0.0

At least, I think that's the mapping.  Are we ever going to do anything
with /sys/firmware/acpi/namespace/ or will it just stay around consuming
inodes and dentries for no good reason?

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
