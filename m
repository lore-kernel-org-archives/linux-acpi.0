From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: ACPI source patches updated (20021101)
Date: Fri, 1 Nov 2002 14:31:05 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD04C7A49E@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi all,

20021101 is now released at http://sf.net/projects/acpi . It includes a fix
for the proc/thermal missing bug, as well as a few others. Non-Linux
releases will be posted most likely by tonight.

Regards -- Andy

----------------------------------------
01 November 2002.  Summary of changes for version 20021101.

1) Linux

Fixed a problem introduced in the previous release where the
Processor and Thermal objects were not recognized and
installed in /proc.  This was related to the scope type change
described below.

2) ACPI CA Core Subsystem:

Fixed a problem where platforms that have a GPE1 block but no
GPE0 block were not handled correctly.  This resulted in a
"GPE overlap" error message.  GPE0 is no longer required.

Removed code added in the previous release that inserted nodes
into the namespace in alphabetical order.  This caused some
side-effects on various machines.  The root cause of the
problem is still under investigation since in theory, the
internal ordering of the namespace nodes should not matter.

Enhanced error reporting for the case where a named object is
not found during control method execution.  The full ACPI
namepath (name reference) of the object that was not found is
displayed in this case.

Note: as a result of the overhaul of the namespace object
types in the previous release, the namespace nodes for the
predefined scopes (_TZ, _PR, etc.) are now of the type
ACPI_TYPE_LOCAL_SCOPE instead of ACPI_TYPE_ANY.  This
simplifies the namespace management code but may affect code
that walks the namespace tree looking for specific object
types.


-----------------------------
Andrew Grover
Intel Labs / Mobile Architecture
andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org



-------------------------------------------------------
This sf.net email is sponsored by: See the NEW Palm 
Tungsten T handheld. Power & Color in a compact size!
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0001en
