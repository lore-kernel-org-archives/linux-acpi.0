From: Stephan Krings <stephan-MC3rjLPHZ0jJ0Y7HFzmx4Q@public.gmane.org>
Subject: Re: Hello every boddy, I have a compaq evo 800v any news about any
 dsdt (LONG)
Date: Wed, 12 Feb 2003 23:59:18 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <15946.53702.492433.676382@hotzenplotz.priv>
References: <1045084756.2329.58.camel@calvin.hjblocal.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1045084756.2329.58.camel-PDBFyMGeMq1aCPxV5EPtfPP6llvjuJOh@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Hilbert Barelds <list-XfCjptVMDKWuyJwMYI9mNQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Hello,

> The startup errors about device C03C bother me, also
> Feb 12 19:00:43 suzie kernel: pci_bind-0194 [11] acpi_pci_bind         :
> Device 00:00:1d.00 not present in PCI namespace
> Feb 12 19:00:43 suzie kernel: pci_bind-0194 [11] acpi_pci_bind         :
> Device 00:00:1d.01 not present in PCI namespace
> Feb 12 19:00:43 suzie keytable: Loading system font:=20
> Feb 12 19:00:44 suzie kernel: pci_bind-0194 [11] acpi_pci_bind         :
> Device 00:00:1d.02 not present in PCI namespace
> Feb 12 19:00:44 suzie kernel: pci_bind-0194 [11] acpi_pci_bind         :
> Device 00:00:1d.07 not present in PCI namespace
> 
> Bothers me, but probably related to the first error
> Also the debug statements at the bottom bother me.

As others have already noted, these messages don't seem to represent
critical errors. I get exactly the same messages on an Evo N800c and
don't have any difficulties in using ACPI.

This includes the debug messages: They're in fact part of the Compaq
DSDT. In the disassembled DSDT there are lines like:

Store(Local2, Debug)

which is responsible for the "[ACPI Debug] Integer" message and
there's also:

Store("Hot swap of MultiBay", Debug)

So if you switch devices in your multibay, you might also see this
message in your syslog, Which is really nothing to worry about.

Btw: Is hot swapping IDE devices supposed to work? Ok, I admit, I
should ask that on a different list.

Regards,

Stephan


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
