From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: ACPI hangs at boot sometimes
Date: 14 May 2004 21:52:10 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1084585930.12354.317.camel@dhcppc4>
References: <200405140852.02383.meaton@vasco.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200405140852.02383.meaton-tw97OP0PknkAvxtiuMwx3w@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Mark Eaton <meaton-tw97OP0PknkAvxtiuMwx3w@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, 2004-05-13 at 18:51, Mark Eaton wrote:

> When booting my system it sometime hangs right after giving me the message 
> Edge set to Level Trigger. but most times it works fine. Is this a known 
> bug ? possibly a buggy ACPI implementation ?
> I have included the ACPI portion of a successful boot below. If you want/need 
> more information just ask.
> 
> May 12 08:33:14 beldin kernel: ACPI: Subsystem revision 20040326
> May 12 08:33:14 beldin kernel: spurious 8259A interrupt: IRQ7.
> May 12 08:33:14 beldin kernel: ACPI: IRQ10 SCI: Edge set to Level Trigger.
> May 12 08:33:14 beldin kernel: ACPI: Interpreter enabled
> May 12 08:33:14 beldin kernel: ACPI: Using PIC for interrupt routing            
> May 12 08:33:14 beldin kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
> May 12 08:33:14 beldin kernel: PCI: Probing PCI hardware (bus 00)
> May 12 08:33:14 beldin kernel: ACPI: PCI Interrupt Routing Table 
> [\_SB_.PCI0._PRT]
> May 12 08:33:14 beldin kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs *4)
> May 12 08:33:14 beldin kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs *5)
> May 12 08:33:14 beldin kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs *9)
> May 12 08:33:14 beldin kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs *11)
> May 12 08:33:14 beldin kernel: ACPI: Embedded Controller [EC0] (gpe 1)

Yes, I'd like to see if the complete dmesg includes this line:
Local APIC disabled by BIOS -- reenabling.

Yes, the problem is known, but the solution is not.

We've seen this problem go away many times with a BIOS upgrade,
are you running the latest?

There is also a workaround here to temporarily disable the APIC timer:
http://bugme.osdl.org/show_bug.cgi?id=1269

Perhaps you can update that bug report to say if the workaround
helps your system or not.

thanks,
-Len




-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
