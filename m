From: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Subject: Re: Method for resetting embedded controller?
Date: Thu, 9 Oct 2003 14:33:26 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031009123326.GC13739@hell.org.pl>
References: <1065661576.1807.7.camel@laptop-linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1065661576.1807.7.camel-udXHSmD1qAy4CTf7w+cZoA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nigel Cunningham <ncunningham-oKK1aGe2n869koe0gwxAeg@public.gmane.org>
Cc: ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Thus wrote Nigel Cunningham:
> I'm particularly noticing this when a lid event occurs during suspend,
> whether or not button.o is insmod'd. If acpid is running, it shows
> thousands of lid events per second. Another swsusp user has reported
> similar issues.

I experienced the same problem a couple of times. I wouldn't really blame
lid, as I'm almost sure I had the lid event overflow when the lid button
was not touched at all during the cycle. From what I understand, the 
situation is connected with thermal zone handling, I can almost be sure
that if an active thermal trip point is hit during the resume process, the 
lid events will appear. I don't yet know if it's connected with bug #1185.

FYI:
1) There *was* something in swsusp code that caused keventd to spit those
   events at resume specifically when the lid was closed during suspend,
   but that was an ancient version of the code and AFAIR you fixed it right
   away,
2) I've had this problem occasionally occuring for months and I remember I
   once managed to calm keventd down by suspending and resuming again,
3) This may indeed be somehow related to swsusp, as the occurence rate of
   this problem has risen with recent versions of swsusp (but there's too
   many variables to confirm that and trying to reproduce the problem is a 
   tedious task).

Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
