From: PSI-Systems <psi-systems-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: Acpi Problem
Date: Tue, 3 Dec 2002 17:15:22 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200212031715.22698.psi-systems@gmx.net>
References: <200212021120.13300.tom@supinfo.com> <200212030935.47545.tom@supinfo.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200212030935.47545.tom-GJzCDJVA6d1BDgjK7y7TUQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: tom-GJzCDJVA6d1BDgjK7y7TUQ@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> Could someone explain me what is ECDT so i could find more informations
> on my problem?

According to Andrew Grover, this is the Problem:

>Your BIOS is broken. We just started looking at the EC_ID field in the 
>ECDT,
>and unfortunately your machine's is wrong.
>
>A little explanation...
>
>Your laptop has an Embedded Controller. The ECDT table is supposed to
>describe the EC, so that AML can use operation regions in the EC before 
>the
>EC device is actually found by the walking of the namespace.
>
>The ECDT-enumerated EC and the EC in the namespace are linked because 
>there
>is a field (EC_ID) in the ECDT that gives the path to the EC in the
>namespace. If this is wrong, then we abort.
>
>As with so many things ACPI-related, the *right* answer is that IBM fixes
>their BIOS...but since this works under Windows, we may end up applying a
>yet-to-be-devised workaround. :(

I've the same Prob with my IBM A31.


-------------------------------------------------------
This SF.net email is sponsored by: Microsoft Visual Studio.NET 
comprehensive development tool, built to increase your 
productivity. Try a free online hosted session at:
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr0003en
