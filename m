From: Dmitry Torokhov <dtor_core-yWtbtysYrB+LZ21kGMrzwg@public.gmane.org>
Subject: Re: [PATCH 1/4] properly create kobjects in acpi/scan.c
Date: Tue, 24 Aug 2004 12:03:48 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200408241203.48881.dtor_core@ameritech.net>
References: <200408240134.16962.dtor_core@ameritech.net> <87zn4ky2zr.wl%miura@da-cha.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <87zn4ky2zr.wl%miura-yiisDzvROlQdnm+yROfE0A@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Hiroshi Miura <miura-yiisDzvROlQdnm+yROfE0A@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tuesday 24 August 2004 10:23 am, Hiroshi Miura wrote:
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
>        connect  to  this  socket.  Once connected, acpid will send the text of
>        all ACPI events to the client.  The client has  the  responsibility  of
>        filtering  for messages about which it cares.  acpid will not close the
>        client socket except in the case of a SIGHUP or acpid exiting.
> 
> I think it is enough.

I do not think that present implementation of acpid has to be a prerequisite
for all setups. Plus, tunneling events through acpid introduces unwanted (IMHO)
dependencies: acpid has to be started first, restarting it can mess up other
processes reading from it's socket, etc, etc...

Given how cheap multiple readers implementation is and the fact that exclusive
only access only causes troubles (think psaux in older kernels) I think it
should go in.
 
> If allow multiple readers, acpid and other tool need some lock facility to avoid 
> unwanted multiple event handling.
> 

Well, since acpid manifests that it will pass _all_ events to its readers the
same issue exists right now.

-- 
Dmitry


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
