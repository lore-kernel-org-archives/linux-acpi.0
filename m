From: "Knut Neumann" <knut.neumann-4bfl1RV3iZDOEhgYWvzSCYQuADTiUCJX@public.gmane.org>
Subject: Re: S3 and S4: nothing happens
Date: Sat, 12 Oct 2002 08:37:01 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <014301c271b9$ce797530$5b0aa8c0@TRINITY>
References: <Pine.LNX.4.44.0210101816280.20282-100000@hill.cs.ucr.edu>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: Roy <roy_me-S0/GAf8tV78@public.gmane.org>, Joshua Lauricha <laurichj-OqvYMq7jYtE3uPMLIKxrzw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


> Same thing happen here, using 2.4.20-pre8 w/acpi-20021002-pre8,
> /proc/acpi/sleep gives S0 S3 S4 S5, but "echo 3 > /proc/acpi/sleep", or 4.
> Give nothing.

This _is_ fixed with 20021002-2.5.40 though this patch has not yet been
applied to the linus kernel tree (AFAIK). Thus it is not included with
2.5.41, but you can easily fix it yourself - see [1]on that.

>From 20021002-2.4.20-pre8 - drivers/acpi/system.c - acpi_suspend(..):

        +          /* only support S1 and S5 on kernel 2.4 */

Regards
-Knut

[1] Mail from Pavel Machek with title "acpi sleep: stupid bug reintroduced"



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
