From: <Stuart_Hayes-DYMqY+WieiM@public.gmane.org>
Subject: RE: stack overflow
Date: Mon, 22 Mar 2004 11:40:09 -0600
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <CE41BFEF2481C246A8DE0D2B4DBACF4F128AB2@ausx2kmpc106.aus.amer.dell.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Len Brown wrote:
> On Wed, 2004-03-10 at 08:32, Andi Kleen wrote:
>=20
>> If you have some recursion either fix it or at least add an error
>> out when the stack gets too low. We can add an "stack_left" function
>> exported by the architecture.
>=20
> I think we'll want to put some fun-time sanity checks for illegal
> recursion into the interpreter.  That should be less invasive than
> doing the full blown stack check -- which can be enabled as a
> separate DEBUG test when needed.
>=20
>>> Sorting the list of stack frame sizes below shows
>>> acpi_evaluate_integer() is the winner with 320 bytes on the stack.=20
>>> Note that this isn't from passing structures, but from allocating
>>> local structures.  On i386 acpi_parse_object is 124 bytes, on
>>> x86_64 it will be bigger...
>>=20
>> I would suggest to fix anything > 100 bytes at least
>> (and double check anything that could be expanded on 64bit)
>=20
> Agreed, Bob and I will fix the big stack users.
>=20
> thanks,
> -Len

Thanks for all the help.  Robert Moore identified a big part of the=20
problem (recursion):

(quoting Robert)
"The issue is how PCI_Config operation regions are initialized.

1) a _STA accesses a PCI_Config space field

2) This eventually causes transfer to ev_pci_config_region_setup

3) ev_pci_config_region_setup attempts to resolve the _ADR object

4) The implementation of _ADR in the ASL accesses PCI_Config space

5) This in turn causes another call to ev_pci_config_region_setup"
(end of quote)

Turning off ACPI debug messages seems to fix my problem for now. =20
With debug messages enabled, the stack usage seems to be roughly 64=20
extra bytes for each function called (presumably from the extra local=20
variables defined in some of the debug macros in acmacros.h).  I have=20
modified my DSDT so that only one layer of recursion happens, and,=20
with this, the *difference* in kernel stack usage between having ACPI=20
debug enabled and disabled is 2776 bytes.  Even with this better DSDT,=20
the kernel stack overflows by 616 bytes (I used a larger kernel stack=20
to figure that out...) if I have debug messages enabled.  FYI, the=20
kernel stack on my system is 5408 bytes total (8K - size of the=20
task_struct).

With debug messages disabled, I have a good 2K of margin on the stack=20
with my modified DSDT.

Thanks!
Stuart


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
