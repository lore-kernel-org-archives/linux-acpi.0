From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: ACPI does not work since acpi-20021022-2.4.20-pre11.di
	ff
Date: Mon, 4 Nov 2002 10:19:30 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD04C7A4A6@orsmsx119.jf.intel.com>
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
To: 'PSI-Systems' <PSI-Systems-hi6Y0CQ0nG0@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> From: PSI-Systems [mailto:PSI-Systems-hi6Y0CQ0nG0@public.gmane.org] 
> and its still in the newest rc1-release!
> 
> please can anyone help me in fixing this?
> ACPI: Found ECDT
> ACPI: Could not use ECDT

Your BIOS is broken. We just started looking at the EC_ID field in the ECDT,
and unfortunately your machine's is wrong.

A little explanation...

Your laptop has an Embedded Controller. The ECDT table is supposed to
describe the EC, so that AML can use operation regions in the EC before the
EC device is actually found by the walking of the namespace.

The ECDT-enumerated EC and the EC in the namespace are linked because there
is a field (EC_ID) in the ECDT that gives the path to the EC in the
namespace. If this is wrong, then we abort.

As with so many things ACPI-related, the *right* answer is that IBM fixes
their BIOS...but since this works under Windows, we may end up applying a
yet-to-be-devised workaround. :(

Regards -- Andy


-------------------------------------------------------
This SF.net email is sponsored by: ApacheCon, November 18-21 in
Las Vegas (supported by COMDEX), the only Apache event to be
fully supported by the ASF. http://www.apachecon.com
