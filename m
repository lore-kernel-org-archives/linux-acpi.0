From: Damien Sandras <damien.sandras-zdNq1GPRXr2akBO8gow8eQ@public.gmane.org>
Subject: ACPI Thermal zone OK in 2.6test 9, but KO in 2.6 test10/11
Date: Thu, 27 Nov 2003 12:12:08 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1069931528.652.6.camel@golgoth01>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello to all,

I'm running kernel 2.6 test 11 on an ACER Aspire 1700. The DSDT has been
patched, but that doesn't matter as I have the same problem with and
without the change to the DSDT.

Actually, I'm running 2.6 kernels since a few months and I had no
problem until 2.6 test 10. The thermal zone was functionning properly
and reporting a correct temperature with kernel 2.6 test 9. Last week, I
upgraded to kernel 2.6 test 10, and today to kernel 2.6 test 11 and as
soon as I load the thermal module, it report a temperature of 255=B0C and
executes an ACPI power_off.

Is there some kind of patch I could revert in the thermal.c file to
determine what is the exact cause of the problem or alternatively any
new patch I could try?

Thank you,

PS: except that, everything works correctly, except that my
/proc/acpi/fan directory is empty with the module loaded, but I guess it
is the same problem.
--=20
 _      Damien Sandras
(o-    =20
//\     It-Optics s.a.
v_/_    GnomeMeeting: http://www.gnomemeeting.org/
        FOSDEM 2004:  http://www.fosdem.org
        H.323 phone:  callto:ils.seconix.com/dsandras-AvcYnRpcIedBDgjK7y7TUQ@public.gmane.org



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
