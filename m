From: Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: PNPACPI / 8250 discovery
Date: Tue, 07 Dec 2004 10:33:18 +0800
Message-ID: <1102386798.4860.20.camel@sli10-desk.sh.intel.com>
References: <1098327571.6132.228.camel@sli10-desk.sh.intel.com>
	 <200412061836.38840.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200412061836.38840.bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
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
Cc: ACPI-DEV <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Adam Belay <ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org>, Matthieu <castet.matthieu-GANU6spQydw@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, 2004-12-07 at 09:36, Bjorn Helgaas wrote:
Hi Bjorn,
> I haven't seen much activity on the PNPACPI front recently.
> 
> If/when we switch from 8250_acpi to 8250_pnp, serial device
> names will change (8250_acpi devices are discovered *before*
> 8250_pci, but 8250_pnp is currently *after* 8250_pci in
> drivers/serial/Makefile).
This makes sense to me. Matthieu is working on migrating acpi drivers to
pnp drivers, so I actually didn't look at them.

> Do you plan to switch that around?  I think it makes more
> sense to have PNP/ACPI devices named before PCI, since the
> PNP/ACPI ones are more likely to be built-in.
Currently PNP/ACPI uses some ACPI bus APIs, which only work after ACPI
scan, but the scan is very latter. We need change ACPI driver and PNP
link order for this (at least the PNP driver should be before ACPI PCI
root drvier). The order would be: 
1. ACPI scan bus
2. register PNP drivers
3. register ACPI drivers
I will work on it, but I'd like to listen to Len and Adam's opinion for
it.

Thanks,
Shaohua



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
