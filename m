From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb-5ng0By4jB+/QUPosyRRdSA@public.gmane.org>
Subject: apci 20021126 with kernel 2.4.20
Date: 30 Nov 2002 17:29:56 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1038677398.1865.10.camel@darkstar.portugal>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
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
To: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

After boot my compaq 706EA without ac Adapter plugged.
I plugged the ac adapter and this new messages appears, but everything
working normally.
this messages just appears on first time that I plug AC adapter.
if I unplug and plug again second time this error messages doesn't
appears.

hope can help something.
S=E9rgioMB=20

Nov 30 17:08:26 darkstar kernel: [ACPI Debug] String: AC Adapter In/Out
Nov 30 17:08:26 darkstar kernel: [ACPI Debug] Integer: 0000000000000001
Nov 30 17:08:26 darkstar kernel: [ACPI Debug] String: ---------------------=
------- AC _STA
Nov 30 17:08:28 darkstar kernel: [ACPI Debug] String: Battery In/Out
Nov 30 17:08:28 darkstar kernel: [ACPI Debug] String: --------- VIA SOFTWAR=
E SMI PMIO 2Fh ------------
Nov 30 17:08:28 darkstar kernel: [ACPI Debug] String: --------- VIA SOFTWAR=
E SMI PMIO 2Fh ------------
Nov 30 17:08:28 darkstar kernel: [ACPI Debug] String: ---------------- NABT=
 < 6
Nov 30 17:08:28 darkstar kernel: [ACPI Debug] String: ---------------- Li B=
attery
Nov 30 17:08:28 darkstar kernel:  utalloc-0683: *** Error: Ut_track_allocat=
ion: Allocation already present in list! (cb71fd40)
Nov 30 17:08:28 darkstar kernel:  utalloc-0686 [21] Ut_track_allocation   :=
 Element cb71fd40 Address cb71fd40
Nov 30 17:08:28 darkstar kernel:  utalloc-0683: *** Error: Ut_track_allocat=
ion: Allocation already present in list! (cb71fd40)
Nov 30 17:08:28 darkstar kernel:  utalloc-0686 [21] Ut_track_allocation   :=
 Element cb71fd40 Address cb71fd40
Nov 30 17:08:28 darkstar kernel: [ACPI Debug] String: ---------------------=
 DC >=3D 3000
Nov 30 17:08:28 darkstar kernel:  utalloc-0683: *** Error: Ut_track_allocat=
ion: Allocation already present in list! (cb71fd40)
Nov 30 17:08:28 darkstar kernel:  utalloc-0686 [20] Ut_track_allocation   :=
 Element cb71fd40 Address cb71fd40
Nov 30 17:08:28 darkstar kernel:  utalloc-0683: *** Error: Ut_track_allocat=
ion: Allocation already present in list! (cb71fd40)
Nov 30 17:08:28 darkstar kernel:  utalloc-0686 [20] Ut_track_allocation   :=
 Element cb71fd40 Address cb71fd40
Nov 30 17:08:28 darkstar kernel:  utalloc-0683: *** Error: Ut_track_allocat=
ion: Allocation already present in list! (cb71fd40)
Nov 30 17:08:28 darkstar kernel:  utalloc-0686 [20] Ut_track_allocation   :=
 Element cb71fd40 Address cb71fd40
Nov 30 17:08:28 darkstar kernel:  utalloc-0683: *** Error: Ut_track_allocat=
ion: Allocation already present in list! (cb71fd40)
Nov 30 17:08:28 darkstar kernel:  utalloc-0686 [20] Ut_track_allocation   :=
 Element cb71fd40 Address cb71fd40
Nov 30 17:08:28 darkstar kernel:  utalloc-0683: *** Error: Ut_track_allocat=
ion: Allocation already present in list! (cb71fd40)
Nov 30 17:08:28 darkstar kernel:  utalloc-0686 [18] Ut_track_allocation   :=
 Element cb71fd40 Address cb71fd40
Nov 30 17:08:28 darkstar kernel:  nsalloc-0384: *** Error: Ut_remove_alloca=
tion: Empty allocation list, nothing to free!




-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
