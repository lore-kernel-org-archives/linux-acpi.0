From: "M. Warner Losh" <imp-uzTCJ5RojNnQT0dZR+AlfA@public.gmane.org>
Subject: Re: not all irqs detected
Date: Sat, 24 Aug 2002 12:17:03 -0600 (MDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020824.121703.52419660.imp@bsdimp.com>
References: <200208241717.g7OHH1X19234@mailgate5.cinetic.de>
	<20020824200511.G587@brodo.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20020824200511.G587-JhLEnvuH02M@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: devel-JhLEnvuH02M@public.gmane.org
Cc: joerg.beyer-htSm2yLGOjU@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

In message: <20020824200511.G587-JhLEnvuH02M@public.gmane.org>
            Dominik Brodowski <devel-JhLEnvuH02M@public.gmane.org> writes:
: On Sat, Aug 24, 2002 at 07:17:01PM +0200, joerg.beyer-htSm2yLGOjU@public.gmane.org wrote:
: > My bios has not many things to adjust, but I can disable the
: > psaux (mouse) and the bios says, if I disable psaux, then irq 12
: > will be available. I attached a dmesg, with disabled psaux, and
: > I would expect to see IRQ 12 used - but it isn't.
: > 
: > could anybody tell me, if it is correct to expect IRQ 12 used this
: > way? 
: It _may_ be available for other, i.e. PCI users then.
: > 
: > I tried to read & understand the driver/acpi/pci_*.c code, but I need
: > some help to get started: how are the free/usable IRQs found
: > and mapped?
: The usable IRQs are set down in the DSDT table, the Detailed System
: Description Table (which is more or less fixed in the BIOS). And as all PCI
: IRQs are expected to be non-exclusive, all should be "free". However, the
: ACPI code tries to use the available IRQs most effectively.

Actually, that's not the case ('all shoule be free').  The truth of
the matter is that you have to look up in the interrupt routing table
to find what slots can have which interrupts.  Sometimes you are lucky
and can have any interrupt to any pin.  Other times you are SOL and
all the interrupts are wired to one or two pins (toshiba laptops are
notorious for one pin designs).  Pre-acpi, you'd look in the $PIR
table to find what could be routed where.  ACPI has a similar
mechanism, but I'm haivng troube recalling it to mind.

So maybe IRQ 5 and IRQ 10 is all you get, and irq 12 can't be routed
to the pins in the original poster's question.

Warner

P.S.  Most of my experience on this is being the FreeBSD pccard dude
and having to deal with the fact that the choices for IRQs, routed to
INTA of the cardbus bridge, are very very limited in most laptops.


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
