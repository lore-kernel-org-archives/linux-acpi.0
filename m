From: Andrew de Quincey <adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
Subject: More and more weirdness
Date: Fri, 25 Jul 2003 00:46:26 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200307250046.26322.adq_dvb@lidskialf.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

OK, heres the latest on my weird IRQ problems. I'm posting this in case it 
rings a bell with anyone...

All my onboard devices work fine.
I've just installed my first PCI addon card. A Netgear MA311 wavelan card 
(this is a "proper" PCI card, not a PCMCIA->PCI bridge)

If I disable ACPI, my APIC does not get found, and the card works.

If I enable ACPI (with my patch), my APIC does get found, and the card doesn't 
work.

When I insert the driver in APCI mode, it sorta hangs about a bit, and then 
claims "interrupt delivery does not seem to work", which definitely sounds 
like the kind of thing I'm trying to fix.

Monitoring /proc/irq/io_apic shows it DOES enable the IRQ during probing, and 
then disables it again afterwards.

The IRQs are set up as my ACPI bios says they should. This sounded like 
exactly the problem I had before. So I played about with the polarity/mode 
settings in the IO APIC again.

I can get the card to work.. sort of. When set to activelow/level, it starts 
up, detects the card OK, and gives its normal output. Problem is after that 
happens, I immediately get one of those "IRQ #18: nobody cared messages", and 
the kernel disables IRQ 18. I'm assuming the card did not say it had issued 
an IRQ, so the driver did not return IRQ_HANDLED to the kernel. (IRQ 18 is 
the IRQ assigned to the card BTW)

Anyway, this shows (a) my patch is not yet complete and (b) something is up 
with the ACPI settings for IO-APIC mode/polarity for addon cards.




-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
