From: Alvaro Lopes <alvieboy-JkNoWtNHh5AAvxtiuMwx3w@public.gmane.org>
Subject: ACPI Lock after resume from S3 [2.5.59+latest ACPI]
Date: Thu, 06 Feb 2003 18:33:30 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3E42AA7A.1030207@alvie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Hi list

here's the problem:

My toshiba enters S3 via acpi_enter_sleep_state(). It goes to sleep=20
right after writing PM1A_CONTROL with SLP_ENABLE.  It resumes then to=20
the caller  [acpi_suspend()] and then calls acpi_restore_system_state()=20
and finally acpi_leave_sleep_state().

The problem is that it enters a deadlock because:

    1- When setting PM1A_CONTROL with flag ACPI_MTX_LOCK, the hardware=20
mutex is locked, the system enters sleep right after writing the=20
register and never unlocks the mutex, because it resumes to a different=20
point;

    2- in acpi_leave_sleep_state() we disable BM artbitration, and here=20
it locks forever, waiting a hardware mutex release.

Disabling APCI_MTX_LOCK on the 1st point seems to go around the problem,=20
and the system resumes almost OK, only HDD DMA is disabled:

Feb  6 18:19:26 supernova kernel: hda: status timeout: status=3D0x80 { Bu=
sy }
Feb  6 18:19:26 supernova kernel: hda: DMA disabled
Feb  6 18:19:26 supernova kernel: hda: drive not ready for command
Feb  6 18:19:27 supernova kernel: ide0: reset: master: error (0x00?)

=C1lvaro

--=20

=C1lvaro Lopes=20
---------------------
A .sig is just a .sig




-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
