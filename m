From: Brad Parker <brad-2nKKSigPee+ibv+y4V69FXNtEUiqdi9I@public.gmane.org>
Subject: Re: Acpi_load_tables: Could not load namespace: AE_NOT_FOUND
Date: Tue, 17 Sep 2002 21:08:44 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200209180108.g8I18iS29958@p2.parker.boston.ma.us>
References: <berndp@optonline.net>
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: Message from Bernd Pfrommer <berndp-p32f3XyCuykqcZcGjlUOXw@public.gmane.org>
   of "Tue, 17 Sep 2002 15:18:52 EDT." <3D87801C.3010007-p32f3XyCuykqcZcGjlUOXw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: berndp-p32f3XyCuykqcZcGjlUOXw@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Bernd Pfrommer wrote:
...
>after many fruitless attempts to get ACPI working with the 2.4.18 or 
>2.4.19 kernel, I'm posting this in case somebody can help.
>The hardware is an Intel manufactured SRMK2 server with a ServerWorks 
>ServerSet IIILE chipset (CNB30LE North Bridge and OSB4 South Bridge), 
>dual PIII 1GHz 256K cache, with 1GB memory. The bios is an AMIBIOS by 
>American Megatrends Inc.
...

Did you try fixing the DSDT table by hand?  There is a great page on
how to do this which was posted to this list recently.

http://www.cpqlinux.com/acpi-howto.html

Basically you dump the table into AML source and then recompile it
using Intels AML compiler.  Intel's compiler is more strict and
catches errors which Microsoft's does not.  The page has many good
tips on how to fix up broken AML code.

Once it compiles clean there is a small patch to 2.4.19+acpi to read
the table from a file. (the intel aml compiler outputs a hex table as
C code).

I did this and it some missing features magically reappeared (like the
ac-adapter and the battery).

might be worth a shot...  seems like some/many/most DSDT tables have
bugs.

-brad


-------------------------------------------------------
This SF.NET email is sponsored by: AMD - Your access to the experts
on Hammer Technology! Open Source & Linux Developers, register now
for the AMD Developer Symposium. Code: EX8664
http://www.developwithamd.com/developerlab
