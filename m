From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Running _PRW methods for GPEs
Date: Thu, 8 Apr 2004 13:57:20 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <37F890616C995246BE76B3E6B2DBE0554F1C98@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>, Takayoshi Kochi <kochi-S783fYmB3Ccdnm+yROfE0A@public.gmane.org>, Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>
Cc: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


There is currently a problem with the execution of the _PRW methods
during GPE initialization.  Namely, any _PRW method that accesses an
operation region will currently fail because there are no region
handlers installed at GPE init time.

Therefore, the ACPI CA initialization sequence will require some
modification.  The current sequence is as follows:

    EvInitialize
        FixedEvents
        GPEs
            Run _PRW methods
    EvHandlerInit (SCI, Global Lock)
    EvInitAddressSpaces (Install default OpRegion handlers, run _REG
methods)
    NsInitObjects (OpRegions, Buffers, Packages)
    NsInitDevices (Run _STA, _INI methods)


The proposed new sequence is below.  It takes into consideration the
following (from the ACPI spec):
=20
OSPM must guarantee that the following operation regions must always be
accessible:=20
*	PCI_Config operation regions on a PCI root bus containing a _BBN
object.
*	I/O operation regions.
*	Memory operation regions when accessing memory returned by the
System Address Map reporting interfaces.=20

Also, we now install the SCI handler *before* enabling any GPEs so that
no GPEs are dropped.

    EvInitAddressSpaces=20
        Install default region handlers - I/O, memory, PCI_Config (and
perhaps EC)
    EvHandlerInit=20
        Install SCI and Global Lock handlers
        request_irq()
    EvInitializeEvents
        FixedEvents
        GPEs=20
            Init GPEs and run _PRW methods
            Disable all "wake" GPEs found under device object _PRW
methods
            Enable all "runtime" GPEs
    NsInitOperationRegions=20
        Run all _REG methods for OpRegions
    NsInitObjects=20
        Init Buffers and Packages
    NsInitDevices=20
        Run all Device _STA, _INI methods

Comments welcome.
Bob



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
