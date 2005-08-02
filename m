From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: Re: Accessing DSDT entries within a kernel device driver
Date: Tue, 2 Aug 2005 14:18:40 -0600
Message-ID: <200508021418.40355.bjorn.helgaas@hp.com>
References: <42EFC9AD.8060607@selhorst.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <42EFC9AD.8060607-yWjUBOtONefk1uMJSBkQmQ@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Marcel Selhorst <acpi-yWjUBOtONefk1uMJSBkQmQ@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tuesday 02 August 2005 1:29 pm, Marcel Selhorst wrote:
> I am pretty new to ACPI and I hope that my question is not offending, but I didn't
> find an answer in the mailing archive.
> I am writing a device driver for a trusted platform module (TPM), which is connected
> to the mainboard via the LPC-bus. The corresponding ioports needed to communicate
> with the chip are written into the ACPI-table (DSDT) through the BIOS.
> So what I would like to do is simply read out the values stored inside the DSDT-table
> and gather the information I need to configure the TPM-chip with the correct ioports.

Use 8250_pnp.c as a template, specifically serial_pnp_probe().

You should be able to claim the TPM device using a PNP driver that
claims IFX0101 devices.  Then the PNP subsystem will take care of
extracting your IO port information from the ACPI namespace.

> The corresponding DSDT-entry looks like this:
> 
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
> Is there a way to get the information (without userspace disassembling through iasl)?


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
