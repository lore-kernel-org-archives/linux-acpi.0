From: Stuart_Hayes-DYMqY+WieiM@public.gmane.org
Subject: stack overflow
Date: Mon, 8 Mar 2004 10:43:13 -0600
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <CE41BFEF2481C246A8DE0D2B4DBACF4F128AA4@ausx2kmpc106.aus.amer.dell.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=iso-8859-1
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
Cc: Stuart_Hayes-DYMqY+WieiM@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Hello!

I'm using the x86_64 architecture with Linux, and I'm getting what =
appear to be
stack overflows while the ACPI stuff is being initialized (all the _STA=20
methods are being executed).

Just wondering if anyone has taken a look at stack usage with the ACPI =
stuff,=20
and what could be done to fix this (other than simplifying the ACPI =
tables!). =20
I suspect this problem might become an issue with a large number of =
people as=20
the x86_64 architecture becomes more common, since it uses ACPI by =
default (and=20
i386 did not).

Here are some of the reasons I believe the stack is overflowing:

I've added some "printk"s to the kernel, and I've found that the stack =
pointer=20
goes down by ~6K between namespace/nseval.c:acpi_ns_evaluate_relative() =
and=20
executer/exstore.c:acpi_ex_store().

If I disable local interrupts while the ACPI stuff is being initialized, =
it=20
seems to make it through without failing.

If I simplify some of the methods, it seems to work ok.

Thanks
Stuart



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
