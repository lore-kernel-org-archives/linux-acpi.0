From: "Tim Carr" <tdot-joG6AkTDxNd+xww9+oMsTAC/G2K4zDHf@public.gmane.org>
Subject: Toshiba laptop ACPI crash on resume only if PCMCIA/USB
Date: Tue, 24 Feb 2004 17:56:08 -0500 (EST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <28866.204.138.115.3.1077663368.squirrel@tdot-uw.dyndns.org>
Reply-To: tdot-joG6AkTDxNd+xww9+oMsTAC/G2K4zDHf@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello all,

I'm a Gentoo user, and i'm having problems with ACPI and linux.

My system: KDE 3.2, kernel 2.6.3 with the TOSHIBA and TOSHIBA_ACPI
modules, Toshiba Satellite 4100XDVD using ACPI, *NOT* APM. Latest Gentoo. 
My userspace ACPI4LINUX programs would be gentoo's latest versions, i'm
not sure what version that is.

The problem is that i can't resume from either a suspend or a standby if
i've ever used my USB mouse or PCMCIA card since bootup. If I haven't used
them, the resume is fine.

Reproducible: Always
Steps to Reproduce:
1. Plug in a USB mouse, or use a PCMCIA card
2. Suspend or standby
3. Try to resume - crash.

Actual Results:
Crash

Expected Results:
Shouldn't have crashed.


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
