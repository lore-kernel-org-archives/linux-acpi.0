From: Nils Faerber <nils-t93Ne7XHvje5bSeCtf/tX7NAH6kLmebB@public.gmane.org>
Subject: Re: Not enough IRQs for multiple PCMCIA cards
Date: Sat, 10 May 2003 16:06:10 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030510160610.4cb621e6.nils@kernelconcepts.de>
References: <200305100148.12713.chrish@gmx.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200305100148.12713.chrish-puGfsi27rH1aa/9Udqfwiw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Chris Howells <chrish-puGfsi27rH1aa/9Udqfwiw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sat, 10 May 2003 01:48:07 +0100
Chris Howells <chrish-puGfsi27rH1aa/9Udqfwiw@public.gmane.org> wrote:
> Hi,
Hi!

> I'm having huge problems trying to get enough IRQs for me to be able
> to use a PCMCIA modem (D-Link 560) and a Wifi card (Netgear MA401)
> simultaneously.

For the record:
	I have exactly the same problem.

[...]
> For example, if I plug my modem in, it gets assigned IRQ 7. If I
> remove it, and plug the Wifi card in, it gets assigned IRQ 7. If I put
> both in simultaneously, the last one to be inserted does not get an
> IRQ.
> 
> I have tried with ACPI enabled and with pci=noacpi.

> Regrettably, my BIOS (Award Asus L3800C BIOS) does not give me any
> control how IRQs are designed or PnP OS settings.

I have even the same machine :)

[...]
> Thanks for any ideas

OK.
It is quite important to know a litle more about your setup.
Why?
I have tried with several kernels, pcmcia packages and configurations.
Some worked, some not.
Do you use kernel pcmcia or the PCMCIA drivers from pcmcia-cs?
	I currently use kernel pcmcia which currently does not work with twi
cards.

Which PCMCIA (cardbus) chipset driver do you use?
	I strongly recommend to use the kernel yenta socket driver! This gives
best results with cardbus cards.

Some earlier kernel version with ACPI patch applied worked with
pci=noacpi but this seems to have almost no effect on more recent
kernels. I currently use 2.4.21-pre4 with ACPI 20030228.

Then there are some problems with certain PCMCIA drivers.
In theory they should be able to share the one assigned interrupt. The
serial_cs driver does so AFAIK. But many other drivers don't, like
ide_cs. So some combinations may work, some not.

This whole situation is, like you said, very unsatisfying :(
It is a real pain that there is no decent APIC in uniprocessor systems
in order to have more than those shitty 15 IRQs... it's a shame... x86
hardware is really crappy at times but there is not much of an
alternative especially for notebooks :( (Oh oh ... no flame war start
please!)

> Cheers, Chris Howells -- chris-NvB7AskkBIqIudiWw5vspbVCufUGDwFn@public.gmane.org, howells@kde.org
CU
  nils faerber

-- 
kernel concepts          Tel: +49-271-771091-12
Dreisbachstr. 24         Fax: +49-271-771091-19
D-57250 Netphen          D1 : +49-170-2729106
--


-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
