From: Philippe =?iso-8859-1?q?Cl=E9ri=E9?= <philippe-vlmYvWlZpDU@public.gmane.org>
Subject: Kernel 2.4.20 hangs when loading ACPI on K7SEM mobo
Date: Thu, 3 Apr 2003 10:47:03 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200304031047.03566.philippe@gcal.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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

Kernel 2.4.20 hangs while loading ACPI. The last few lines of=20
the boot sequence are:

Parsing methods....................
Table [DSFT] - 414 objects with 41 devices 117 methods 28=20
regions
ACPI namespace successfully loaded at c033a59c

Hangs there and it takes a cold reboot to get the system back to=20
life. I made no changes in the default BIOS settings except to=20
turn off the Floppy drive.

ECS K7SEM motherboard with the original BIOS. Kernel is=20
gentoo-sources-2.4.20-r1. (I am not certain of which ACPI patch=20
was applied to these sources, but I think it is the one that=20
came out in November 2002).=20

TIA

=2D-=20
Best regards,
Philippe Cl=E9ri=E9


-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
