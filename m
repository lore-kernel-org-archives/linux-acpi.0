From: "Praveen C" <praveen-8a50ANe9Mx0/NI2e8YfAcJ/QNRX+jHPU@public.gmane.org>
Subject: Re:  Re:  acpi on r40e
Date: Tue, 02 Mar 2004 13:13:19 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <W3258911586142361078233199@mail.mailsnare.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
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

Processor module hangup on R40e

The problem is with processor power management.
In function acpi_processor_add

/*
 * Install the idle handler if processor power management is supported.
 * Note that the default idle handler (default_idle) will be used on
 * platforms that only support C1.
 */

 pr->flags.power=3D0; //My addition to disable power management <=3D=3D=3D=
=3D=3D=3D=3D
 if ( (pr->id=3D=3D0) && (pr->flags.power) ) {
    pm_idle_save =3D pm_idle;
    pm_idle =3D acpi_processor_idle;
 }

With this modification the processor module does not hang. Thermal can al=
so be loaded and gives correct temperature. I would still like to know wh=
y the power management is causing problem and what are the implications o=
f disabling it the way I have done.
Thanks
praveen
http://www.cpraveen.tk




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
