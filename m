From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: ACPI config options
Date: Wed, 20 Aug 2003 18:42:48 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE009FC92@hdsmsx402.hd.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Andy,

Safe to say it was a mistake for me to have "CONFIG_ACPI_HT be a
pre-requisite for CONFIG_ACPI".  Too many people were confused when they
ran config; and those without HT were downright preplexed...

Going going back to the CONFIG_ACPI controls all ACPI scheme....

In the 2.4.22 case, CONFIG_ACPI_HT_ONLY pulls in acpitables.o, which are
completely self-contained.  As CONFIG_ACPI is defined for the HT_ONLY
case,  CONFIG_ACPI_BOOT is used to enable building drivers/acpi/

In the 2.4.23/2.6 movie, the options are the same, but  acpitables.o is
gone.  CONFIG_ACPI_BOOT is always set, no matter if HT_ONLY or not.

The rough edge here is that stuff like sony and ipmi use CONFIG_ACPI at
build time, not realizing that HT_ONLY is set until run-time when the
discover acpi_disabled.  They'd still have to check acpi_disabled if
they used something like CONFIG_ACPI_INTERPRETER to indicate run-time
support because it may not load; but at least if it _wasn't_ defined,
they'd know at build time not to assume ACPI.

Cheers,
-Len



-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines
at the same time. Free trial click here:http://www.vmware.com/wl/offer/358/0
