From: "Karasyov, Konstantin A" <konstantin.a.karasyov-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: ACPI Thermal Zones and unwanted reset of Trip Points
Date: Fri, 9 Dec 2005 18:13:41 +0300
Message-ID: <E124AAE027DA384D8B919F93E4D8C708D2DE96@mssmsx402nb>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Olaf Conradi <oohlaf-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

It looks like your trip points are getting reset on thermal
notifications.
Your DSDT implements hysteresis for passive and active cooling (i.e.
when the temperature raises above the trip point, the trip point value
is decreased to avoid too frequent trip point crossing), so hardware
sends the notification to the system to update the trip points, when the
trip point is being crossed.=20

So, it's not a bug, it is a firmware implementation, but your DSDT could
be slightly modified to set higher trip points values:

-------------------------------------------------------------------
--- DSDT_oth.dsl.orig	2005-12-09 18:08:12.000000000 +0300
+++ DSDT_oth.dsl	2005-12-09 18:09:57.000000000 +0300
@@ -178,10 +178,10 @@
     Name (TMAD, 0x9C)
     Name (TSAD, 0x90)
     Name (TRNG, 0x00)
-    Name (TP1H, 0x0D04)
+    Name (TP1H, 0x0CD2)
     Name (ACTT, 0x3C)
     Name (TP1L, 0x0C28)
-    Name (TP2H, 0x0D68)
+    Name (TP2H, 0x0D04)
     Name (PAST, 0x46)
     Name (TP2L, 0x0C64)
     Name (TPC, 0x0DCC)
-------------------------------------------------------------------

TP1H - trip point default for active cooling (changed from 60 to 55)
TP2H - trip point default for active cooling (changed from 70 to 60)
TPC - critical trip point default


Regards.
Konstantin.

>-----Original Message-----
>From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-
>admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Olaf Conradi
>Sent: Monday, December 05, 2005 12:40 AM
>To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>Subject: [ACPI] ACPI Thermal Zones and unwanted reset of Trip Points
>
>Hello,
>
>I'm running Debian Unstable on my laptop and have a question about
>trip points in ACPI thermal zones.
>
>My laptop gets too hot very quickly, for example when I compile a
>kernel, or in font generation during installation of a latex font.
>This causes the laptop to shutdown.
>
>On my laptop (Asus L8400K) the trip points are:
>
># cat /proc/acpi/thermal_zone/THRM/trip_points
>critical (S5):           80 C
>passive:                 70 C: tc1=3D1 tc2=3D4 tsp=3D300 =
devices=3D0xc127cb60
>active[0]:               60 C: devices=3D0xc127b800
>
>When I set them to the following I get much better results and it
>doesn't get overheated much.
>
># echo -n "80:0:60:55:0" > /proc/acpi/thermal_zone/THRM/trip_points
># cat /proc/acpi/thermal_zone/THRM/trip_points
>critical (S5):           80 C
>passive:                 60 C: tc1=3D1 tc2=3D4 tsp=3D300 =
devices=3D0xc127cb60
>active[0]:               55 C: devices=3D0xc127b800
>
>But, for some reason, the trip points get reset every now and then
>(usually within 30 mintes or so, don't know the exact interval).
>
>Does anyone know what causes the trip point setting to be reset?
>
>I'm using debian kernel 2.6.14 from unstable. I attached the dmesg,
>dmidecode, acpidump, lspci and interrupts output.
>
>Thanks,
>Olaf


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
