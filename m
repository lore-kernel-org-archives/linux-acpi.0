From: =?ISO-8859-1?Q?Lenar_L=F5hmus?= <lenar-w3PkqIkA8A2zQB+pC5nmwQ@public.gmane.org>
Subject: Re: 2.6.2-mm1 aka "Geriatric Wombat"
Date: Fri, 06 Feb 2004 10:39:05 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <402352A9.7090705@vision.ee>
References: <20040205014405.5a2cf529.akpm@osdl.org> <200402051357.04005.s0348365@sms.ed.ac.uk> <4022505B.1020900@vision.ee> <200402052130.30344.s0348365@sms.ed.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200402052130.30344.s0348365-Y3tGgqFSo3OFxr2TtlUqVg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: s0348365-Y3tGgqFSo3OFxr2TtlUqVg@public.gmane.org
Cc: Arjen Verweij <A.Verweij2-V356GuK0og6dIhEUFHOBvg@public.gmane.org>, Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, =?ISO-8859-1?Q?Luis_Miguel_Garc=EDa?= <ktech-39ZsbGIQGT7e5aOfsHch1g@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Alistair John Strachan wrote:

>This fix doesn't work for me because I get problems if I disable ACPI IRQ 
>routing and still have apic enabled. Normally these problems would be 
>gracefully solved, but my USB HCD complains about not having been assigned an 
>IRQ.
>  
>
Actually it's exactly the same here I'm just not bothered by my USB HCD 
not having an IRQ since
my USB mouse still works.

It says this when booting:

PCI: No IRQ known for interrupt pin A of device 0000:00:02.0. Please try 
using pci=biosirq.
drivers/usb/core/hcd-pci.c: Found HC with no IRQ.  Check BIOS/PCI 
0000:00:02.0 setup!

All I can say is that in 2.6.1-rc1-mm1 it worked and I could have all my 
interrupts off the XT-PIC.

Lenar


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
