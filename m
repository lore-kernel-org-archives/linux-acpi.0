From: "Ow Mun Heng" <ow.mun.heng-Sjgp3cTcYWE@public.gmane.org>
Subject: "TSC cannot be used as a timesource" when on battery
Date: Mon, 1 Mar 2004 10:39:09 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <C386328088ED7F4E9F81AFBABDDF60DA045C6D54@wdmyexch02.my.asia.wdc.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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
To: "Acpi-List (E-mail)" <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi All,

D600 + RH9 + kernel 2.6.3+acpi20040211

Was seeing these error messages when booting from battery.=20
I've searched through google and the only thing It came up with=20
was a reference that asks to use ACPI PM as the timesource.

I'm currently using RTC (real time clock)

I'm still trying to figure out what is the difference between ACPI=20
PM timesource/RTC.

I've not investigated further to determine if my clock is indeed=20
running slower.=20

=3D=3D=3D=3Dstart kernel message=3D=3D=3D=3D=3D=3D=3D
TSC cannot be used as a timesource.
 <4> Possible reasons for this are
You're running with speedstep
You don't have DMA enabled for your hard drive (See hdparm)
Incorrect TSC synchronization on an SMP system (dee dmesg)
Falling back to sane timesource now.
=3D=3D=3D=3D=3D=3D=3Dend kernel messages=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

HDparm shows all my hd and cdrom are on dma
This is uniprocessor laptop

Yes.. running on speedstep.
When on AC power, I don't see this error.


Cheers,                                                 .^.
Mun Heng, Ow                                            /V\
H/M Engineering                                       /(   )\
Western Digital M'sia                                  ^^-^^
DID : 03-7870 5168                          The Linux Advocate

       =20


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
