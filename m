From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: _OSI boot hang
Date: Wed, 17 Mar 2004 14:40:26 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <CFF522B18982EA4481D3A3E23B83141C01F3FD59@orsmsx407.jf.intel.com>
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
To: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Not according to the MS white paper on OSI. =20

http://www.microsoft.com/whdc/hwdev/tech/onnow/_OSI-method.mspx


Yes, \_OS used strings like "Microsoft Windows NT", but apparently not
OSI

Bob


-----Original Message-----
From: Nate Lawson [mailto:nate-Y6VGUYTwhu0@public.gmane.org]=20
Sent: Wednesday, March 17, 2004 2:36 PM
To: Brown, Len
Cc: Moore, Robert; ACPI Developers
Subject: Re: [ACPI] _OSI boot hang

On Sat, 13 Mar 2004, Len Brown wrote:
> _OSI is in the ACPI patch on kernel.org and bkbits right now.
>
> However, I find that on my Toshiba Satellite Pro, it causes boot to
hang
> at Executing all Device _STA and_INI methods.
>
> >From ACPICA, it comes this way:
> drivers/acpi/utilities/utglobal.c
> const char
> *acpi_gbl_valid_osi_strings[ACPI_NUM_OSI_STRINGS] =3D {
>                        "Linux",
>                        "Windows 2000",
>                        "Windows 2001",
>                        "Windows 2001.1"};

That's not the right string for Win2k.  It's:
  "Microsoft Windows NT"

Since this is the most popular string, not emulating it is probably
causing some people problems.

-Nate


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
