From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: updated ACPI patch against 2.6.13-rc1
Date: 03 Jul 2005 16:59:42 -0400
Message-ID: <1120424381.28075.21.camel@d845pe.worldpath.net>
References: <1120148192.23586.15.camel@d845pe.worldpath.net>
	 <20050703201706.GB27204@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050703201706.GB27204-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Sun, 2005-07-03 at 16:17, Pavel Machek wrote:
> Hi!
> 
> > This patch includes all the dusty patches that have been
> > waiting in BK me for 2.6.13 to open.
> > It applies against 2.6.13-rc1.
> >
> >
> ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6.13/acpi-20050408-2.6.13-rc1.diff.gz
> >
> > Please give it a go, and if nothing explodes I'll git it to Linus
> for
> > 2.6.13-rc2 and we'll move onto the batch that is waiting in line
> behind
> > this one:-)
> 
> 
> >  drivers/pci/pci.c                                 |   18
> 
> Does it still do ugly stuff with placing pci_power_t into u32?

pci/pci.c doesn't manipulate pci_power_t -- just passes it along.

drivers/pci/pci-acpi.c uses it as an index to convert it into
and acpi_state:


+static int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t
state)
+{
+       acpi_handle handle = DEVICE_ACPI_HANDLE(&dev->dev);
+       static int state_conv[] = {
+               [0] = 0,
+               [1] = 1,
+               [2] = 2,
+               [3] = 3,
+               [4] = 3
+       };
+       int acpi_state = state_conv[(int __force) state];
+
+       if (!handle)
+               return -ENODEV;
+       return acpi_bus_set_power(handle, acpi_state);
+}




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
