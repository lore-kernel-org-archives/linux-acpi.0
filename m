From: pinotj-fBIn7JHAfCbUKx/7vDf7Bw@public.gmane.org
Subject: FIX: ACPI break USB detection on i386 (linux-2.4.22)
Date: Fri,  5 Sep 2003 02:35:17 CEST
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <mnet1.1062722117.10046.pinotj@club-internet.fr>
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
To: adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

>De: Andrew de Quincey
>A: Jerome Pinot
=5B...=5D
>Date: Thu, 4 Sep 2003 19:02:43 +0100
>
>Weird, I'm not quite sure why you're seeing the behaviour you are. Can yo=
u try this patch, which is my latest general ACPI patch, which may already=
 fix the problem.
=5B...=5D

OK, the linux-2.4.22-acpi-picmode-5.patch solve my problem. I'm happy abou=
t this (but a little bit sad that my work was quite useless).

Summary:
ACPI break USB detection on K7S5A mainboard (SiS735) since kernel 2.4.22-r=
c3 (tested on 2.4.22-rc3, 2.4.22, 2.4.23-pre2, 2.4.23-pre3, 2.6.0-test4). =
Patch solve problem for 2.4.x kernels.

More information about patching:
2.4.22: patch OK, compilation OK, USB detection OK
2.4.23-pre3: patch OK (but failed hunk in ../X64=5F86/mpparse.c), compilat=
ion OK, USB detection OK.
2.6.0-test4 (for fun): patch OK (but failed hunk in ../X64=5F86/mpparse.c)=
, compilation failed at ../i386/mpparse.c

Thanks, you're doing a good work. Will this patch be in 2.4.23-pre4 ?

Jerome Pinot



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
