From: "Brad Beveridge" <Brad.Beveridge-5jtIG9vRWBhBWQWeTLFoew@public.gmane.org>
Subject: FW: Toshiba 2410 & ACPI
Date: Thu, 12 Feb 2004 10:39:03 +1300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <8285CB7241FCFC4BB721A6F953F9B35ED6026B@nzc-ap-xch-01.ap.trimblecorp.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
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

Hi all, this is my first post.  Firstly - sorry if this has already been
discussed, I searched the archives & couldn't turn much up.  I don't
know if what happened to me is a hardware fault or an ACPI bug :)

Machine : Toshiba Satellite 2410 (I think it's a -404 model) Kernel  :
2.6.1 (unpatched ACPI)

A while ago I upgraded to 2.6.1 (I didn't know I needed further ACPI
patches), and setup all the ACPI stuff so I could play with my laptop's
power management features.  I was pleased to find that everything I
wanted worked : sleep state S3, CPU scaling, backlight control (via
toshiba_acpi driver)

After a couple of days happily entering S3, one day it did not come back
from S3.  So I rebooted & then the laptop hung in the "In Touch with
Toshiba" screen.  I left it off over night & it worked in the morning,
very strange. In the course of my experiments I found
1) If it got stuck in the BIOS screen, leaving it off & unpluged for
more than about 8hrs would fix it.
2) Suspend no longer worked, under ACPI, APM or WinXP
3) It suddenly did work for a couple of days
4) It then stoped working again

The mainboard has been replaced as the local service centre said it was
faulty.  When I got my new main board I monitored the temps that the fan
goes on/off at.  On my broken main board the BIOS was automatically
turning the fan on at 70C and off at 60C.  On the new one it is 55C and
50C - this is just a BIOS setting, but I was previously unaware of it
(and a little concerned by how hot my laptop used to get).

Basically I have the following questions
1) Was the mainboard fault just a coincidence that I was playing with
ACPI and sleep?
2) Is it likely that operating at high temp has caused the original
fault?
3) Can I safely use ACPI sleeping with a ACPI patched 2.6.2 kernel?

Cheers
Brad


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
