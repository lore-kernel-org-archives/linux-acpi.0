From: <Stuart_Hayes-DYMqY+WieiM@public.gmane.org>
Subject: question about acpi device info
Date: Tue, 18 May 2004 17:07:14 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <7A8F92187EF7A249BF847F1BF4903C040AFB61@ausx2kmpc103.aus.amer.dell.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Class: urn:content-classes:message
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


I have recently come upon a problem where I need to determine the HID & =
UID of a particular PCI NIC that's in my system.  I am also interested =
in finding out what PCI bridges are between the processor and this NIC.

I know all of this information is in the DSDT, which Linux parses when =
it comes up... but... is this information obtainable by a user space =
program?  Or would my best bet be to grab the ACPI code from the kernel =
and make it into a user space program, so I can do what I want (it could =
just access /proc/acpi/dsdt or wherever the ACPI driver makes the dsdt =
available)?  Or, is there perhaps already a userspace program to do =
this?

It looks like, in 2.6, the info is almost there:  I can see a directory =
for each ACPI device in /sys/firmware/ACPI/something-or-other.  However, =
there isn't actually any information in the directories.  If the =
directories had files HID, UID, ADR, and so forth... and even what bus =
the device was on (if it is a PCI bus), that would be perfect!

Thanks!
Stuart




-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
