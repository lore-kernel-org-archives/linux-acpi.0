From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: ACPI very nearly working on Thinkpad 240x
Date: Wed, 16 Apr 2003 17:42:52 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3ACA40606221794F80A5670F0AF15F8427229A@pdsmsx403.ccr.corp.intel.com>
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
To: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Would you please collect debug message for each of below issues.=20

That will help me better understand these issues, and help us to know =
the status of current ACPI.

Thanks,
Luming
-----Original Message-----
From: Matthew Garrett [mailto:mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org]
Sent: 2003?3?3? 2:48
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Subject: [ACPI] ACPI very nearly working on Thinkpad 240x


Having upgraded my BIOS to the latest available from IBM, I've very=20
nearly got working ACPI.

1) S1 usually works correctly, but the backlight doesn't get switched=20
off. Is there any trivial way of dealing with this?

2) S3 suspends and resumes. On resume, the backlight comes back on the
machine is responsive from the network. The keyboard and mouse don't
work, though - if I use modular input drivers, a rmmod i8042 && modprobe
i8042 brings things back to life. Switching on the Toshiba keyboard=20
kicking code doesn't result in any change in behaviour. The symptoms are =

that no input results in an increase in interrupts until I reload the=20
module.=20

The other problem is that the screen doesn't come back. The backlight
comes on but no text appears. This is the case with both vesafb and=20
vgacon - sometimes (but not predictably) a small amount of text is=20
printed, but it looks like it's left over from lilo or something. The=20
screen seems to be in 640x480 text mode, rather than the 800x600 it=20
should be in when I'm using the VESA driver. Killing X and restarting it =

results in X starting up, but I can't switch back to a text console=20
(they're just garbage). Passing acpi_sleep=3Ds3_bios or s3_mode doesn't=20
seem to make any difference.

3) S4 with SWSUSP sometimes works, but usually I hit the BUG() in=20
ide-disk that others have reported. Is there any understanding behind=20
why that one's happening?

It certainly seems a lot better than things have been before now.
--=20
Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Acpi-devel mailing list
Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
