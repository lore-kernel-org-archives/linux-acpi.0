From: "Ow Mun Heng" <ow.mun.heng-Sjgp3cTcYWE@public.gmane.org>
Subject: ACPI + Laptop Power Management
Date: Fri, 21 Nov 2003 12:01:03 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <C386328088ED7F4E9F81AFBABDDF60DA03386202@wdmyexch02.my.asia.wdc.com>
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
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

	This is a question (not a solution) to determine how to gain maximum
batt life on a laptop.

More details on http://bellet.info/~bellet/laptop/t40.html

Currently, following the recommendations in the link above, I have set
'noatime' for my HDs as well as placing commit=3D600.

so in /etc/fstab

/dev/hda	/	etx3	defaults,noatime,commit=3D600 1 1

The commit=3D600 is supposed to stop Kjournal from committing to disk =
every 5
seconds and to give a chance to the HD to spin down (not happening!) =
(can
check via hdparm -C /dev/hda)

Doing a hdparm -y /dev/hda (to place the disk into standby) will only =
work
for like 10-30 seconds before it spins up again. I have no idea what is
causing it to spin up again.. (what I/O is going on??)

There is the option of changing bdflush as well, changing this (5th & =
6th)
to 6000 & 12000 does not yield anything better

Does anyone has a solution or something like a solution which I can try
out??

Anything would be good.. I want to extend my battery life.. Dell D600 on =
a
4320Mah 6cell Batt with 14.1 SXGA screen

Cheers,                                                 .^.
Mun Heng, Ow                                            /V\
H/M Engineering                                       /(   )\
Western Digital M'sia                                  ^^-^^
DID : 03-7870 5168                          The Linux Advocate

       =20


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
