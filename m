From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: pcmcia irq trouble
Date: 24 Mar 2004 02:21:12 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1080112871.18504.74.camel@dhcppc4>
References: <200403232235.46589.justin-psi@affinix.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200403232235.46589.justin-psi-A4HSxAr4s6pBDgjK7y7TUQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Justin Karneges <justin-psi-A4HSxAr4s6pBDgjK7y7TUQ@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Justin,
probably good to file a bug and work with David Shaohua Li on this one.
http://bugzilla.kernel.org/enter_bug.cgi?product=ACPI

component: Config-Hotplug

Please include the output from lspci -v, /proc/interrupts, and dmesg
-s40000

thanks,
-Len

On Wed, 2004-03-24 at 01:35, Justin Karneges wrote:
> Thank you, Matthew and Len, for answering my general questions about 
> acpi-devel.
> 
> Now, I've discovered a problem, and this may or may not be related to ACPI, 
> but I think it is.  If not, I'll be happy to redirect this message to the 
> appropriate target.
> 
> I'm using the Sony VAIO PCG-VX88 laptop.  Without ACPI, almost none of the 
> major peripherals function except for the external PCMCIA slot.  The VX88 has 
> an embedded wi-fi which is detected as a secondary PCMCIA slot, but again, 
> without ACPI this does not work.  If I recall correctly, the driver would 
> report: "RequestIRQ: Resource in use".  I contacted the author of the 
> (orinoco) driver, and he claimed this was outside the scope of the driver.  
> Indeed, looking at the code it appears that the pcmcia subsystem deals with 
> dishing out IRQs, not the actual card drivers.
> 
> With kernel 2.4.26-pre5 + today's ACPI patch, everything seems to work, 
> including the internal wi-fi, _except_ for the external PCMCIA.  Inserting my 
> bluetooth card yields the message: "RequestIRQ: Resource in use".  It's 
> almost as if the pcmcia slots switched roles. :)
> 
> The VX88 uses yenta socket, and I noticed that your latest ChangeLog mentions 
> a fix regarding multiple cards and irqs on a yenta socket, but this does not 
> appear to be the same problem (or the fix was incomplete).
> 
> If this is an ACPI issue, how can I help resolve it?  I'm a competent 
> programmer, and I have no problem with mucking with the source.
> 
> Thanks,
> -Justin




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
