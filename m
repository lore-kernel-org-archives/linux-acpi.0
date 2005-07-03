From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: updated ACPI patch against 2.6.13-rc1
Date: Sun, 3 Jul 2005 22:17:06 +0200
Message-ID: <20050703201706.GB27204@elf.ucw.cz>
References: <1120148192.23586.15.camel@d845pe.worldpath.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1120148192.23586.15.camel-jRzH0JztI1Dyk6epdUfNT+TW4wlIGRCZ@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

> This patch includes all the dusty patches that have been
> waiting in BK me for 2.6.13 to open.
> It applies against 2.6.13-rc1.
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6.13/acpi-20050408-2.6.13-rc1.diff.gz
> 
> Please give it a go, and if nothing explodes I'll git it to Linus for
> 2.6.13-rc2 and we'll move onto the batch that is waiting in line behind
> this one:-)


>  drivers/pci/pci.c                                 |   18 

Does it still do ugly stuff with placing pci_power_t into u32?

								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
