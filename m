From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: hotkey/video framework [was: ibm-acpi-0.2]
Date: 18 Aug 2004 00:59:57 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1092805197.25902.119.camel@dhcppc4>
References: <3ACA40606221794F80A5670F0AF15F840533AE98@pdsmsx403>
	 <87acwt8gls.wl%miura@da-cha.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <87acwt8gls.wl%miura-yiisDzvROlQdnm+yROfE0A@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Hiroshi Miura <miura-yiisDzvROlQdnm+yROfE0A@public.gmane.org>
Cc: Luming Yu <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Borislav Deianov <borislav-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>, julien.lerouge-GANU6spQydw@public.gmane.org, John Belmonte <jvb-ZFKsivP1bGvOQU1ULcgDhA@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, 2004-08-17 at 19:55, Hiroshi Miura wrote:
> Hi,
> 
> At Tue, 17 Aug 2004 17:15:17 +0800,
> Yu, Luming wrote:
> > 
> > >> 
> > >> 'Fn key combination' is common on machines,
> > >> so I think we need some abstraction layer or framework on acpi core.
> > >
> > >One possibility is to just agree on the proc file format and ACPI
> > >events for the common features,
> 
> I think it's good start. 

i agree.

> > > then have each driver implement them
> > >separately. This would probably be simpler than trying to come up with
> > >some sort of a wrapper framework as the code involved is fairly simple
> > >and there probably isn't much we can share. Then again, there might
> > >be, I haven't looked.
> > >
> > 
> > I think the proposaled framework/abstraction layer is NOT just for 
> > code sharing. We need to dynamically load the proper hotkey/video driver
> 
> I have read three driver, asus, toshiba, and ibm.
> These are differ each other.
> 
> asus:    notify key event by 'Notify(event num)'
> toshiba: polling some device/method for get key event.
> ibm:     notify key event by 'Notify(DEVICE_NOTIFY)' then get key by some method.
> panasonic: same as ibm but device and method name is differ.
> 
> This means difficulties of sharing driver code. 

Lots of tinkering has been done in this space.
here's the top google hit:
http://www.tuxmobil.org/Mobile-Guide.db/mobile-guide-p2c1s8-ext-keys.html

I'm confident that the platforms will all have different methods to
actually grab the hotkey events, because ACPI doesn't standardize that
part.  Some will not use ACPI at all to get the hotkey events, but for
those that do, I want to make sure that the ACPI interfaces are standard
and sufficient to support somebody building a platform specific driver. 
More important is the stuff that the event handlers call for sending
events to user space, or video control within the kernel -- this should
be shared and not duplicated.

> Dynamic loading is nice propose.
> with this code, i can determine which is that machine.
> 
> 	static struct acpi_table_header *dsdt_info;
>         status = acpi_get_table(ACPI_TABLE_DSDT, 1, &dsdt);
>         if (ACPI_FAILURE(status))
>                 /* error */
> 
> 	dsdt_info = (struct acpi_table_header *) dsdt.pointer;
> 	chek_which_oem_and_invoke_proper_driver (dsdt->oem_id);
> 
> Wrapper driver only need to know oem_ids and driver name mapping.


Your panasonic driver looked like it got it right by using
acpi_bus_register_driver() and a HID.  I don't understand
why mess that up by looking at table headers?

-Len




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
