From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: ACPI patches updated (20021111)
Date: Wed, 13 Nov 2002 12:54:50 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <B9ECACBD6885D5119ADC00508B68C1EA0D19B8F0@orsmsx107.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: 'Andy Dustman' <andy-gRfBfDTKyCbR7s880joybQ@public.gmane.org>
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Try this:  Set the acpi debug level to 0x0000003F, this will display the
_STA and _INI methods as they are being executed.



-----Original Message-----
From: Andy Dustman [mailto:andy-gRfBfDTKyCbR7s880joybQ@public.gmane.org] 
Sent: Wednesday, November 13, 2002 12:25 PM
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
Subject: RE: [ACPI] ACPI patches updated (20021111)

On Wed, 13 Nov 2002, Moore, Robert wrote:

> 
> Try putting a "Store ("Local3 == Local2 path", Debug) in your new Else
> clause.

OK, I've seen this a couple times now, and it seems to be working whether 
it appears or not, so yippie.

But as long as I'm on a bug hunt: S3 sleep doesn't work. It appears to 
suspend (power light flashes on front), but after hitting a key, it 
revives only partially. For one, the backlight doesn't come on. SysRq 
doesn't seem to work and nothing gets logged so I assume the system is 
locked. (S4 doesn't work either, but that's a swsusp bug.)

Also... I had another case where I got to:

Executing all Device _STA and_INI 
methods:.........................................................

and the system froze.



-------------------------------------------------------
This sf.net email is sponsored by: Are you worried about 
your web server security? Click here for a FREE Thawte 
Apache SSL Guide and answer your Apache SSL security 
needs: http://www.gothawte.com/rd523.html
_______________________________________________
Acpi-devel mailing list
Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This sf.net email is sponsored by: Are you worried about 
your web server security? Click here for a FREE Thawte 
Apache SSL Guide and answer your Apache SSL security 
needs: http://www.gothawte.com/rd523.html
