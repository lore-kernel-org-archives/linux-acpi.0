From: "Ow Mun Heng" <ow.mun.heng-Sjgp3cTcYWE@public.gmane.org>
Subject: RE: Processor C states and USB problem
Date: Mon, 19 Jan 2004 18:15:56 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <C386328088ED7F4E9F81AFBABDDF60DA03F9DB41@wdmyexch02.my.asia.wdc.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
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
To: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Michael Guntsche <mike-Z92qn3yYq0hWk0Htik3J/w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org



> -----Original Message-----
> From: Yu, Luming [mailto:luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org]
> > Under 2.4 bus master always shows "ffffffff" on my=20
> notebook. Sometimes
> > shutting down USB helps, sometimes it doesn't.
> > Running under 2.6 I only get full bus master activity if an USB
> > mouse is plugged in.
>=20
> Could you post output from " cat /proc/acpi/processor/CPU0/power"
> I want to check the usage of C3.

RH9 + 2.4.24 + cpufreq patched + D600
No USB attached. USB kernel module is loaded.. I can rmmod all but =
usbcore
(still ffffff)

 # cat /proc/acpi/processor/CPU0/power
 active state:            C2
 default state:           C1
 bus master activity:     ffffffff
 states:
     C1:                  promotion[C2] demotion[--]=20
 latency[000] usage[00212900]
    *C2:                  promotion[C3] demotion[C1]=20
 latency[050] usage[02242678]
     C3:                  promotion[--] demotion[C2]=20
 latency[050] usage[00000000]




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
