From: Marcel Selhorst <acpi-yWjUBOtONefk1uMJSBkQmQ@public.gmane.org>
Subject: Re: Accessing DSDT entries within a kernel device driver
Date: Tue, 02 Aug 2005 23:33:11 +0200
Message-ID: <42EFE697.8030701@selhorst.net>
References: <42EFC9AD.8060607@selhorst.net> <1123015115.5110.28.camel@tdi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1123015115.5110.28.camel@tdi>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Alex Williamson <alex.williamson-VXdhtT5mjnY@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Alex,

>    I was looking at this recently too.  I believe IFX0101 is the HID
> specifically for an Infineon TPM.  

Yes, thats exactly the TPM I am working with.

> There's a driver for it in -mm, 

oh I know, I have written it ;-))

> but it uses hard coded address (blech) and doesn't work on my laptop.

Thats the point why I am trying to use the ACPI-functions in order to
configure the TPM. Until now I assumed, that the ioports are correctly
set into the configuration registers of the TPM through the BIOS (at
least my prototypes did), but the feedback showed me, that it is not
always the case. Currently I am revising the kernel source code to do this
automatically and a new release will follow soon including support for
Infineons new TPM 1.2 chips.

(But you can try the older device driver (version 1.3.2) from
<http://www.prosec.rub.de/tpm>
This version is more hacky and manually assigns (hardcoded) ioports to the TPM, if
the configuration registers are zero. At least this version should work for your laptop.)

> The code to find it and extract the resources through ACPI is pretty simple,
> but Bjorn's idea of using the ACPI PNP framework is probably the right
> way to do it.  

I was looking in the acpi-sourcecode trying to get the "acpi_evaluate_object"-
things working, but wasn't succesful :(
Nevertheless, could you give a hint how to extract the resources through ACPI?

> There will be systems that have a TPM, but don't have an LPC bus exposed
> via a PCI device.  

Right. If you look at newer approaches, some manufacturers like BroadCom are
including their TPMs into their network chips and others are including the TPM
functionality directly into the super-io-controller.

> Seems like the LPC stuff needs to be separated into
> it's own driver and TPM needs to be more independent.  

In the current release of IBMs generic tpm interface (tpm.c/h), the lpc-stuff has
been replaced through pci_enable_device-calls exactly for this reason to make the
interface more flexible and LPC-bus-independent. But enhancing it with
ACPI-functionality would really be great.

Thanks and best regards!

Marcel Selhorst



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
