From: Mattia Dongili <dongili-vcC760zL2fQ1GQ1Ptb7lUw@public.gmane.org>
Subject: Re: [PATCH 1/4] properly create kobjects in acpi/scan.c
Date: Tue, 24 Aug 2004 18:15:45 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040824161545.GD2657@inferi.kami.home>
References: <200408240134.16962.dtor_core@ameritech.net> <87zn4ky2zr.wl%miura@da-cha.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <87zn4ky2zr.wl%miura-yiisDzvROlQdnm+yROfE0A@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Aug 25, 2004 at 12:23:04AM +0900, Hiroshi Miura wrote:
> Hi,
> 
> At Tue, 24 Aug 2004 01:34:15 -0500,
> Dmitry Torokhov wrote:
> > 04-acpi-multiple-readers.patch
> > 	- allow multiple readrs access /proc/acpi/event, every event is
> > 	  delivered to all readers. Also limit number of pending events
> > 	  to 64 (per reader) so if reader is stuck ACPI does not consume
> > 	  all memory.
> > 
> > 	  Can be user by various daemons, I could see cpufreqd listening
> > 	  for battery insertion/removal events and debugging is much
> > 	  easier too.
> 
> 'acpid' has soket interface for other daemon/utillities.
> 
> from man acpid
>        In  addition  to  rule  files, acpid also accepts connections on a UNIX
>        domain socket (/var/run/acpid.socket by default).  Any application  may
[...]
> I think it is enough.

but relying on the availability of acpid is not a good approach. And why
can acpid hijack /proc/acpi/event?
Allowing multiple readers is much better for every daemon that needs to
get acpi events.

just my 0.2 :)
-- 
mattia
:wq!


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
