From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Summary: Machines that have issues w/o ACPI
Date: Thu, 15 Aug 2002 13:49:58 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD0236DD9E@orsmsx119.jf.intel.com>
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
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is the summary of responses I received from my question this morning.

Generally, systems appear to boot, but some devices don't work due to
incorrect irq routing, and APM may be absent.

Thanks everyone! If anyone knows of any more (especially ones that don't
boot at ALL without ACPI) please let me know.

Sony Vaio FX403 (that's at least what it's called in Europe):
- USB doens't work without ACPI due to IRQ routing problems
- no powermanagment without ACPI (BIOS lacks APM support)

Toshiba 1005-S157 (and presumably 1005-S158, 1000-S157, 1000-S158)
does not have any apm functionality AFAIK.  These are fairly recent
models (late 2001/early 2002) entry-level laptops.

Toshiba 5005

Gericom 1st Supersonic M6-T (a FIC A380 OEM)
	System does not have APM; without ACPI, no power
	management is available. Also, without ACPI,
	some builtin devices (sound, NIC, Modem, FireWire,
	PCMCIA) do not funtion properly due to missing
	IRQ routing/initialization.

Fujitsu-Siemens C6155, the power-button doesn't work.

compaq 2701ea, APM not supported

Dell Inspiron 2500, APM support only for shutdown, not battery/suspend.

Regards -- Andy



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
