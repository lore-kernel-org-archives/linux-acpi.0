From: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Subject: Re: odd irq routing errors?
Date: 20 Feb 2003 21:36:28 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1045776987.3790.36.camel@irongate.swansea.linux.org.uk>
References: <20030220124445.GA3709@clara.net>  <87vfzfx8zn.fsf@gnulinux.dk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <87vfzfx8zn.fsf-VYFdHW3tBKJknbxzx/v8hQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Anders Rune Jensen <anders-VYFdHW3tBKJknbxzx/v8hQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, 2003-02-20 at 15:33, Anders Rune Jensen wrote:
> > PCI: No IRQ known for interrupt pin A of device 00:1f.1 - using IRQ 255
> > ICH3M: IDE controller at PCI slot 00:1f.1
> > PCI: Enabling device 00:1f.1 (0005 -> 0007)
> >  pci_irq-0297 [12] acpi_pci_irq_derive   : Unable to derive IRQ for
> >  device 00:1f.1
> > PCI: No IRQ known for interrupt pin A of device 00:1f.1 - using IRQ 255

This is the ACPI version of a bug I fixed in 2.4 base. If both channels are
in legacy mode its wrong to ask the ACPI layer or the PCI BIOS layer or
indeed anyone in PCI where the chip IRQ is routed. Legacy irq routing doesn't
go via PCI.



-------------------------------------------------------
This SF.net email is sponsored by: SlickEdit Inc. Develop an edge.
The most comprehensive and flexible code editor you can use.
Code faster. C/C++, C#, Java, HTML, XML, many more. FREE 30-Day Trial.
www.slickedit.com/sourceforge
