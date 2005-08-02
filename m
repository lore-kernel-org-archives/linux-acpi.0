From: Marcel Selhorst <acpi-yWjUBOtONefk1uMJSBkQmQ@public.gmane.org>
Subject: Accessing DSDT entries within a kernel device driver
Date: Tue, 02 Aug 2005 21:29:49 +0200
Message-ID: <42EFC9AD.8060607@selhorst.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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
List-Id: linux-acpi@vger.kernel.org

Dear ACPI-List,

I am pretty new to ACPI and I hope that my question is not offending, but I didn't
find an answer in the mailing archive.
I am writing a device driver for a trusted platform module (TPM), which is connected
to the mainboard via the LPC-bus. The corresponding ioports needed to communicate
with the chip are written into the ACPI-table (DSDT) through the BIOS.
So what I would like to do is simply read out the values stored inside the DSDT-table
and gather the information I need to configure the TPM-chip with the correct ioports.
The corresponding DSDT-entry looks like this:

Device (TPM)
        {
            Name (_HID, EisaId ("IFX0101"))
            Name (_UID, 0x01)
            Name (_CRS, ResourceTemplate ()
            {
                IO (Decode16, 0x004E, 0x004E, 0x01, 0x02)
                IO (Decode16, 0x4700, 0x4700, 0x01, 0x0C)
            })
        }

Is there a way to get the information (without userspace disassembling through iasl)?

Thanks a lot,

Marcel Selhorst


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
