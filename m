From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: vaio pcg-v505ap
Date: Fri, 11 Jul 2003 15:56:38 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030711135638.GD22636@poupinou.org>
References: <1057573470.983.17.camel@lana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1057573470.983.17.camel-c5SRAS+BrbU@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Federico Di Gregorio <fog-NGVKUo/i/6DYtjvyW6yDsg@public.gmane.org>
Cc: ACPI Devel Mailing List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, Jul 07, 2003 at 12:24:30PM +0200, Federico Di Gregorio wrote:
> hi *,
> 
> my old asus S1300 died and i am experimenting with a new sony vaio
> pcg-v505ap. i am having a little problem that i don't know if can be
> caused by acpi. i'll try to explain with as much information as i can
> and i'll attach dmesg log and dsdt table to this mail and hope... :)
> 
> basically both when using an external usb mouse or the builtin touchpad
> the left button gets "stuck" even when not actively using the mouse.
> e.g., i am writing in emacs and i get a selection or i am moving the
> mouse and windows get moved or shaded as if someone was clicking like
> fool. this stops when i click the left button once.
> 
> the problem gets worse as devices using the same irq are used. heavy
> network traffic makes the problem worser.  also note that this vaio
> assigns *everything* to irq 9, but i don't know if this is the problem.

Perhaps, but I have some doubt.  Normally, a ps mouse will get
interrupt 12.  could you cat /proc/interrupts

> 
> dmesg show two problems, imho:
> 
> Transparent bridge - Intel Corp. 82801BAM/CAM PCI Bridge
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB_._PRT]
> ACPI: Embedded Controller [EC0] (gpe 28)
> schedule_task(): keventd has not started
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Nothing related to your mouse problem.
The embedded controller receive an interrupt, but can not handle
it yet, because keventd is used for that.

> ACPI: PCI Interrupt Link [LNKA] (IRQs *9)
> 
> and:
> 
> ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 9
>  pci_irq-0297 [23] acpi_pci_irq_derive   : Unable to derive IRQ for
> device 00:1f.1
> PCI: No IRQ known for interrupt pin A of device 00:1f.1 - using IRQ 255

This one is related to the IDE controller.  Still not related
to the mouse trouble.

> sorry for providing so little information on a problem that can be
> completely independent from acpi. 

Do you have the same trouble without acpi, then?

Cheers,

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
