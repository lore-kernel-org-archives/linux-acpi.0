From: Bernd Schubert <bernd-schubert-S0/GAf8tV78@public.gmane.org>
Subject: S1 and S3 on IBM Thinkpad don't work
Date: Wed, 10 Nov 2004 00:01:15 +0100
Message-ID: <200411100001.15678.bernd-schubert@web.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello,=20

I just submitted a bugzilla bugreport=20
(http://bugme.osdl.org/show_bug.cgi?id=3D3723) since the S1 mode doesn't wo=
rk=20
*anymore*, see below for more details. Unfortunately S3 is also not working=
,=20
when it wakes up, it spins up the drive, neither the display nor the networ=
k=20
come up. Any help getting one of the modes working is highly appreciated. I=
'm=20
willing to add any wakeup, sounds, reading documentation, etc. from next=20
Monday on (not earlier as I'm on a conference from Thursday to Sunday).

Thanks a lot in advance,
 Bernd




Details about the S1 mode problem reported in Bugzilla:


Distribution: Debian
Hardware Environment: IBM Thinkpad R31
Software Environment:=20
Problem Description:

Before and with 2.6.2-rc2 S1 was (almost) working fine, only the display=20
didn't switch off. The next kernel I used was 2.6.5 and since this or a=20
version between 2.6.2-rc2 and 2.6.5 waking up from the S1 sleeping mode jus=
t=20
doesn't work anymore.=20
Sending it to sleep mode with "echo 1 >/proc/acpi/sleep" works as usual=20
(the display doesn't switch off as usual), but when it wakes up, the last l=
ine=20
it prints is:

PCI: Setting latency timer of device 0000:00:1f.5 to 64

Afterwards no further keyboard input is possible and only a hard reset by=20
pressing the power button for 5 seconds works.=20
Possibly the other wakeup messages are also important, so I uploaded a digi=
cam=20
screenshot=20

http://www.pci.uni-heidelberg.de/tc/usr/bernd/downloads/R31_acpi/R31_S1_wak=
e_up.jpg


It might be also interesting that this doens't happen, if I enable full=20
debugging via /proc/acpi/debug_level. Well, my whole screen is then=20
overwritten with lots of debugging messages, but after S1 sleeping, it wake=
s=20
up fine.


Steps to reproduce:
echo 1 >/proc/acpi/sleep


The dmesg, dmidecode, acpidmp, lspci and interrups files can be found at=20
http://www.pci.uni-heidelberg.de/tc/usr/bernd/downloads/R31_acpi/


=2D-=20
Bernd Schubert
Physikalisch Chemisches Institut / Theoretische Chemie
Universit=E4t Heidelberg
INF 229
69120 Heidelberg
e-mail: bernd.schubert-VNq4CFrKgK+dPOQpRHQ53DeJuz7u0hKX@public.gmane.org


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
