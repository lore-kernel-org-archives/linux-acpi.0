From: "Black, Richard" <Richard.Black-VXdhtT5mjnY@public.gmane.org>
Subject: RE: Dell Inspiron 2650
Date: Tue, 6 Aug 2002 15:48:21 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <D8C1802AADD0D346BE5C0A1D117075CC02C1C98C@cceexc17.americas.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Baris Metin <baris-HcGUqKqhBWRyhfBGqJeJzQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

>>I've seen the page
>>http://www.intel.com/technology/IAPC/acpi/bios_override.htm but=20
>>could not download the ad.exe utility. The link seems to be=20
>>broken. Is there an other way to disassemble th DSDT ?

(See steps #3 and #4)

As a user do this:

1) mkdir /tmp/acpi && cd /tmp/acpi
2) cat /proc/acpi/dsdt > dsdt.dat    (root power needed here)
3) build people.freebsd.org/~takawata/pacpidump.tar.gz (modify the =
Makefile to build on linux)
4) ./pacpidump/acpidump > dsdt.asl   (need root power here)
5) fix dsdt.asl     (this is specific to your individual problem)
6) unpack =
www.intel.com/technology/iapc/acpi/downloads/iasl-linux-20020725.tar.gz
7) ./iasl-linux-20020725/iasl -tc dsdt.asl (Compilation complete. 0 =
errors 0 warnings)
8) cat linux-2.4.18.tar.bz2 | bunzip2 | tar -xvf -
9) cd linux
10) zcat ../acpi-20020726-2.4.18.diff.gz | patch -p1 (looks clean) (from =
www.sf.net)
11) cat ../linux-2.4.18-acpi-20020709-dsdt.patch.bz2 | bunzip2 | patch =
-p1 (looks clean) (from =
dude.noc.clara.net/~faye/compaq2701ea/linux-2.4.18-acpi-20020709-dsdt.pat=
ch.bz2)
12) cp -a ../dsdt.hex drivers/acpi/tables/acpi_dsdt.c
13) follow standard kernel building procedures =
(http://www.cpqlinux.com/kernel.html)

Sincerely,
Richard Black
http://www.cpqlinux.com
http://www.geocities.com/rlcomp_1999
http://www.compaq.com/linux

P.S.  Also a ACPI newbie


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
