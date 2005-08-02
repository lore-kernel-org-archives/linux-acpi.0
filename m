From: Alex Williamson <alex.williamson-VXdhtT5mjnY@public.gmane.org>
Subject: Re: Accessing DSDT entries within a kernel device driver
Date: Tue, 02 Aug 2005 14:38:35 -0600
Message-ID: <1123015115.5110.28.camel@tdi>
References: <42EFC9AD.8060607@selhorst.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <42EFC9AD.8060607-yWjUBOtONefk1uMJSBkQmQ@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Marcel Selhorst <acpi-yWjUBOtONefk1uMJSBkQmQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, 2005-08-02 at 21:29 +0200, Marcel Selhorst wrote:

> Device (TPM)
>         {
>             Name (_HID, EisaId ("IFX0101"))
>             Name (_UID, 0x01)
>             Name (_CRS, ResourceTemplate ()
>             {
>                 IO (Decode16, 0x004E, 0x004E, 0x01, 0x02)
>                 IO (Decode16, 0x4700, 0x4700, 0x01, 0x0C)
>             })
>         }
> 

   I was looking at this recently too.  I believe IFX0101 is the HID
specifically for an Infineon TPM.  There's a driver for it in -mm, but
it uses hard coded address (blech) and doesn't work on my laptop.  The
code to find it and extract the resources through ACPI is pretty simple,
but Bjorn's idea of using the ACPI PNP framework is probably the right
way to do it.  I got sidetracked from the problem after trying to figure
out why the TPM drivers have such a strange attachment to a PCI device.
There will be systems that have a TPM, but don't have an LPC bus exposed
via a PCI device.  Seems like the LPC stuff needs to be separated into
it's own driver and TPM needs to be more independent.  In any case, we
definitely need to move these drivers over to ACPI discovery, I can't
imagine they work for a very broad audience given their current
discovery code.

	Alex

-- 
Alex Williamson                             HP Linux & Open Source Lab



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
