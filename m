From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: RE: [Bug 5227] mounted usb block devices don't work after resume
 from S3
Date: Sat, 12 Nov 2005 11:02:56 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0511121054500.31052-100000@netrider.rowland.org>
References: <F7DC2337C7631D4386A2DF6E8FB22B30052349BD@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B30052349BD-N2PTB0HCzHKkrb+BlOpmy7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, 11 Nov 2005, Brown, Len wrote:

> 
> 
> > Can you or anyone on the mailing list offer some advice on this bug?
> 
> > http://bugzilla.kernel.org/show_bug.cgi?id=5227
> 
> > Only the last few comments are relevant, from #37 on.  Basically the
> > uhci-hcd driver turns off an interrupt-enable bit in the USB controllers'
> > PCI configuration space during suspend-to-memory, and then during resume
> > it finds that the interrupt-enable bit has already been turned back on.
> 
> > Since the driver didn't do it, I can only guess that the BIOS or ACPI is
> > responsible.  However it's an unlikely sort of thing for the BIOS to do,
> > since it should never touch that enable bit.  The bit tells the controller
> > to use normal O/S-driven interrupts; there's a different set of bits used
> > for Legacy mouse & keyboard emulation by the BIOS.
> 
> > When the user tried booting with "acpi=off" on the command line, his 
> > system get a segmentation fault when suspending.  So I don't know how to 
> > track this down any further, or what can be done to fix it.
> 
> > Any ideas?
> 
> > Alan Stern
> 
> S3 with acpi=off -- that is something I'd never considered.
> Unfriendly of us to fault when that is attempted, but by
> definition it isn't ACPI code doing it:-)
> 
> The driver is responsible for saving/restoring the state of
> PCI configuration space for the device -- ACPI doesn't touch it.
> However, it is possible that the BIOS, the BIOS via some
> Linux-executed ACPI AML method, or the hardware itself
> has changed that bit on the transition into or out of S3.
> 
> One possibility would be to disassemble the acpidump output
> to see if the BIOS is touching that bit in AML...
> However, I don't think we're calling the device D3/D0
> methods on suspend/resume yet -- so it is unlikely
> that is the cause.

Thanks for the help.  I'll try sending the user a patch to print out the 
state of the enable bit just before entering and just after leaving the 
low-power state in drivers/acpi/sleep/main.c:acpi_pm_enter.  That should 
suffice to pin down where the bit is getting set, right?

Alan Stern



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
