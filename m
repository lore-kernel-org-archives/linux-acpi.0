From: Adrian Bunk <bunk-HeJ8Db2Gnd6zQB+pC5nmwQ@public.gmane.org>
Subject: Re: [2.6 patch] drivers/serial/8250_acpi.c: fix a warning
Date: Sat, 16 Apr 2005 04:38:52 +0200
Message-ID: <20050416023852.GI4831__39562.4660807245$1113620147$gmane$org@stusta.de>
References: <20050415151053.GM5456@stusta.de> <E1DMTPC-000ASo-00.adobriyan-mail-ru@f13.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Resent-Message-ID: <20050416025712.GK4831-HeJ8Db2Gnd6zQB+pC5nmwQ@public.gmane.org>
Resent-To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Content-Disposition: inline
In-Reply-To: <E1DMTPC-000ASo-00.adobriyan-mail-ru-NYYus2/DmUsox3rIn2DAYQ@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Alexey Dobriyan <adobriyan-JGs/UdohzUI@public.gmane.org>
Cc: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>, rmk+serial-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uv+2+P5yyue3@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Apr 15, 2005 at 08:10:54PM +0400, Alexey Dobriyan wrote:
> On Fri, 15 Apr 2005 17:10:53 +0200, Adrian Bunk wrote:
> 
> > This patch fixes the following warning:
> 
> >   CC      drivers/serial/8250_acpi.o
> > drivers/serial/8250_acpi.c: In function `acpi_serial_ext_irq':
> > drivers/serial/8250_acpi.c:51: warning: implicit declaration of function `acpi_register_gsi'
> 
> > --- linux-2.6.12-rc2-mm1-full/drivers/serial/8250_acpi.c.old
> > +++ linux-2.6.12-rc2-mm1-full/drivers/serial/8250_acpi.c
> 
> > +#include <linux/config.h>
> 
> drivers/serial/8250_acpi.c doesn't use CONFIG_ symbols.

8250_acpi.c #include's <acpi/acpi_bus.h> which requires config.h .

In the Linux kernel, it's more common to put such header dependencies 
for header files into the C files, but if the ACPI people agree a patch 
to add the #include <linux/config.h> to acpi_bus.h is the other possble 
correct solution for this issue.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
