From: Dominik Brodowski <devel-JhLEnvuH02M@public.gmane.org>
Subject: Re: not all irqs detected
Date: Sat, 24 Aug 2002 20:05:11 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020824200511.G587@brodo.de>
References: <200208241717.g7OHH1X19234@mailgate5.cinetic.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200208241717.g7OHH1X19234-pb599fR3TxVkExQqqHjIK3sFFmKitW5W@public.gmane.org>; from joerg.beyer-htSm2yLGOjU@public.gmane.org on Sat, Aug 24, 2002 at 07:17:01PM +0200
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: joerg.beyer-htSm2yLGOjU@public.gmane.org
Cc: acpilist <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Sat, Aug 24, 2002 at 07:17:01PM +0200, joerg.beyer-htSm2yLGOjU@public.gmane.org wrote:
> My bios has not many things to adjust, but I can disable the
> psaux (mouse) and the bios says, if I disable psaux, then irq 12
> will be available. I attached a dmesg, with disabled psaux, and
> I would expect to see IRQ 12 used - but it isn't.
> 
> could anybody tell me, if it is correct to expect IRQ 12 used this
> way? 
It _may_ be available for other, i.e. PCI users then.
> 
> I tried to read & understand the driver/acpi/pci_*.c code, but I need
> some help to get started: how are the free/usable IRQs found
> and mapped?
The usable IRQs are set down in the DSDT table, the Detailed System
Description Table (which is more or less fixed in the BIOS). And as all PCI
IRQs are expected to be non-exclusive, all should be "free". However, the
ACPI code tries to use the available IRQs most effectively.

Dominik


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
