From: "Georg C. F. Greve" <greve-mXXj517/zsQ@public.gmane.org>
Subject: Re: PROBLEM: LCD display dead after ACPI suspend to RAM (S3)
Date: Thu, 22 Jan 2004 23:32:03 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <m3hdynlin0.fsf@reason.gnu-hamburg>
References: <m3hdyo2kce.fsf@reason.gnu-hamburg>
	<20040122140155.GC5194@hell.org.pl>
	<m3d69cj8hb.fsf@reason.gnu-hamburg>
	<1074790450.1585.4.camel@darkstar.portugal>
	<m3ad4fdi02.fsf@reason.gnu-hamburg>
	<20040122220011.GB2293@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040122220011.GB2293-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org> (Karol Kozimor's message of
 "Thu, 22 Jan 2004 23:00:11 +0100")
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: =?iso-8859-15?q?S=E9rgio_Monteiro_Basto?= <sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

 || On Thu, 22 Jan 2004 23:00:11 +0100
 || Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org> wrote: 

 >> How do I properly incorporate the acpi4asus CVS tree in the kernel
 >> sources?

 kk> Swapping the asus_core.c from CVS with kernel's asus_acpi.c found
 kk> in drivers/acpi should suffice (the filename must remain
 kk> asus_acpi.c of course).

I thought that might work, but detected that there is an additional
#include statement for the kernel configuration, at which point I
wasn't entirely sure. 

Decided to do it as a module to exclude the possibility that any
problems I might have been seing were caused by my wrong addition of
the acpi4asus code, not the code itself.


 kk> We'll have a new version released in a couple of days.

Great, thanks. And it seems like the ACPI/APIC bug will be fixed in
the mainstream kernel, soon, too.

Regards,
Georg

-- 
Georg C. F. Greve                                       <greve-mXXj517/zsQ@public.gmane.org>
Free Software Foundation Europe	                 (http://fsfeurope.org)
Brave GNU World	                           (http://brave-gnu-world.org)


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
