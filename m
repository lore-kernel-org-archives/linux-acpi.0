From: Stefan Lutz <Operating-Systems-Team1-/ixSogHR0HOS/tZ4Wjpou0EOCMrvLtNR@public.gmane.org>
Subject: Segmentationfault with iasl
Date: Wed, 14 Apr 2004 11:32:56 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <407D0548.9070208@fujitsu-siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

I use the current available version of Intel's DSTD=20
compiler/disasembler under Linux (Vanilla 2.6.5). The Disassemblation=20
of a dsdt file works fine and as far as I can check also correct. But=20
'iasl -tc dsdt.dsl' crashes with a 'segmentationfault'. I not exactly=20
sure where to search for the reason but there are two posibilities:

1) iasl does not 'like' my Linux environment.

2) my disassembled dsdt file is not fully valid or has some other errors.

Can anybody help me out with this problem? Any help would be=20
appreciated. Thank you in advance.

Yours,

Stefan

--=20
Stefan Lutz
Fujitsu Siemens VP BC E SW OS
B=FCrgermeister-Ulrich-Strasse 100
86199 Augsburg GERMANY


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
