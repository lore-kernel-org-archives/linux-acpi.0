From: Alessandro <alessandro-qt5M+3XYwT4sV2N9l4h3zg@public.gmane.org>
Subject: can i try a merge of two dsdt?
Date: Fri, 02 Apr 2004 18:20:33 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1080930033.752.5.camel@dagon.lovecraft.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: Quoted-Printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi devel mlist <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

hi,=20
i have a problem (a problem? many problems.. =3D\) with my acer aspire
1703SM on freeBSD with ACPI.
If I don't overwrite the DSDT with the one i found for acer aspire
1703SC i get the floppy and the temperature indicator to work but the
batery status is always at zero.=20
If I overwrite my real DSDT whit the DSDT for aspire 1703SC I found that
the batery method work properly.. but the system cannot recognize the
floppy and the temperature indicator is always at 0.0=B0C.=20
My idea is: can i merge my DSDT and the aspire 1703SC DSDT and then
recompile the resultant DSDT?
If it is possible.. where can i get more documentation about it?

thankyou all.
Ale.





-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
