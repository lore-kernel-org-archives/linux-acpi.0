From: Li Shaohua <shaohua.li-BWpGI90KOSgAvxtiuMwx3w@public.gmane.org>
Subject: Re: PNPACPI breaks my asus k6-2 parallel port
Date: Tue, 07 Dec 2004 10:37:08 +0800
Message-ID: <1102387027.4860.24.camel@sli10-desk.sh.intel.com>
References: <20041207022133.GB22171@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20041207022133.GB22171-+pPCBgu9SkPzIGdyhVEDUDl5KyyQGfY2kSSpQ9I8OhVaa/9Udqfwiw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Matthew Wilcox <matthew-Ztpu424NOJ8@public.gmane.org>
Cc: ACPI-DEV <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, 2004-12-07 at 10:21, Matthew Wilcox wrote:
> Turning on PNPACPI changes this in my dmesg:
> 
> -parport0: PC-style at 0x378 [PCSPP(,...)]
> -lp0: using parport0 (polling).
> +ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
> +ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
> +parport: PnPBIOS parport detected.
> +parport0: PC-style at 0x378, irq 7 [PCSPP(,...)]
> +lp0: using parport0 (interrupt-driven).
> +pnp: Device 00:08 activated.
> +parport: PnPBIOS parport detected.
> +parport1: PC-style at 0x278, irq 5 [PCSPP(,...)]
> +lp1: using parport1 (interrupt-driven).
> 
> As a result, my parallel port stops working.  Any more information I
> can
> provide?
Looks like one parport is disabled before but re-assign resources by
PNP. Could you please send me the 'acpidmp' output?

Thanks,
Shaohua



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
