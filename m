From: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Subject: Re: can i try a merge of two dsdt?
Date: Mon, 5 Apr 2004 11:49:21 -0700 (PDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040405114546.K22024@root.org>
References: <1080930033.752.5.camel@dagon.lovecraft.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1080930033.752.5.camel-XQD7E+J2gHDpvm5p2avrnqicDR3qMxSs@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Alessandro <alessandro-qt5M+3XYwT4sV2N9l4h3zg@public.gmane.org>
Cc: acpi devel mlist <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, 2 Apr 2004, Alessandro wrote:
> hi,
> i have a problem (a problem? many problems.. =3D\) with my acer aspire
> 1703SM on freeBSD with ACPI.

The mailing list for FreeBSD acpi issues is acpi-jp-l7ZBCLq5RC066kwqclu8Pg@public.gmane.org
Subscription info is at:
http://www.jp.freebsd.org/acpi/ml.html

> If I don't overwrite the DSDT with the one i found for acer aspire
> 1703SC i get the floppy and the temperature indicator to work but the
> batery status is always at zero.
> If I overwrite my real DSDT whit the DSDT for aspire 1703SC I found that
> the batery method work properly.. but the system cannot recognize the
> floppy and the temperature indicator is always at 0.0=B0C.

> My idea is: can i merge my DSDT and the aspire 1703SC DSDT and then
> recompile the resultant DSDT?
> If it is possible.. where can i get more documentation about it?

You could probably compare the _BST methods for the two and merge the one
in the working DSDT into your stock DSDT.  If that works for you, send me
a diff because I'm curious what the error is in your stock DSDT.  (Perhaps
it can be worked around.)

-Nate


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
