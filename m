From: Matthew Harrell <lists-sender-12e533-bmWjYudjZeGERhycZ4x6Ig@public.gmane.org>
Subject: Re: odd irq routing errors?
Date: Thu, 13 Mar 2003 17:13:21 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030313221321.GA21296@bittwiddlers.com>
Reply-To: Matthew Harrell <mharrell-dated-1048025602.5b63c9-bmWjYudjZeGERhycZ4x6Ig@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
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
To: ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


So is this problem listed below the same as the one I'm having on my laptop?
I cannot boot any 2.5.6? kernels with acpi turned on since once acpid starts
the laptop slows down horrendously, many programs seg fault or the scripts
give bizarre results, and the ide controller spits out numerous messages.  Is
there anything I can do to fix this problem?  



: Faye Pearson writes:
: > This is for the IRQ allocation gurus.
: > More information on http://dude.noc.clara.net/~faye/
: >
: > All refer to the IDE controller...
: >
: > PCI: Ignoring BAR0-3 of IDE controller 00:1f.1
: >  pci_irq-0297 [09] acpi_pci_irq_derive   : Unable to derive IRQ for
: >  device 00:1f.1
: > PCI: No IRQ known for interrupt pin A of device 00:1f.1 - using IRQ 255
: > ICH3M: IDE controller at PCI slot 00:1f.1
: > PCI: Enabling device 00:1f.1 (0005 -> 0007)
: >  pci_irq-0297 [12] acpi_pci_irq_derive   : Unable to derive IRQ for
: >  device 00:1f.1
: > PCI: No IRQ known for interrupt pin A of device 00:1f.1 - using IRQ 255
: >
: > But then:
: >
: > ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
: > ide1 at 0x170-0x177,0x376 on irq 15
: >
: > Looks like it has the correct IRQs.
: 
: I've had the same problem with acpi assigning IRQ 255 to some devices
: but in my case I wasn't even able to boot. All of this was explained
: in my last mail to this list. My ide controller is a ICH2M.

-- 
  Matthew Harrell                          Programmer - a red-eyed mumbling
  Bit Twiddlers, Inc.                       mammal capable of conversing with
  mharrell-bmWjYudjZeGERhycZ4x6Ig@public.gmane.org                 inanimate objects.


-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
