From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: type vs descriptor
Date: Mon, 17 Mar 2003 10:21:59 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A84725A1FC@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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
To: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

> From: Matthew Wilcox [mailto:willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org] 
> I'm trying to write a routine which invokes an ACPI function 
> which takes
> `0' as its parameter.  So I looked to see how it's done already, and I
> think I found a bug.
> 
> Here's how it's done in battery.c:
> 
>         union acpi_object       arg0 = {ACPI_TYPE_INTEGER};
>         struct acpi_object_list arg_list = {1, &arg0};
>         arg0.integer.value = alarm;
> 
>         status = acpi_evaluate_object(battery->handle, 
> "_BTP", &arg_list, NULL);
> 
> This looks wrong to me.  All the acpi_objects start with
> ACPI_OBJECT_COMMON_HEADER which is:

The naming may perhaps be a little confusing, but the ACPI interpreter
has both internal and external data structures.
ACPI_OBJECT_COMMON_HEADER is used on internal data structures, many of
which are named acpi_object_*. However, the one external data structure
in question, union acpi_object, is defined in actypes.h, and is
different.

As a point of reference, the code in utcopy.c does conversions between
the external and internal data representations.

Regards -- Andy


-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
