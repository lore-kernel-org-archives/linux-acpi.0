From: Michael Wahlbrink <linux.wali-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: IBM Thinkpad R32 and ACPI
Date: Tue, 15 Apr 2003 11:05:41 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030415110541.469a64e9.linux.wali@gmx.de>
References: <20030412173357.1e4ea127.linux.wali@gmx.de>
	<200304121812.h3CIC6g18608@throb.netspace.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200304121812.h3CIC6g18608-7GtV0IYKK74tA4QZiFxQkx2eb7JE58TQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sat, 12 Apr 2003 14:12:06 -0400
bperkins-ooduxAEi7gVg9hUCZPvPmw@public.gmane.org wrote:

> This problem is supposed to be fixed in the next release(see the archives).
> 
> The problem was solved for me (on my R32) by going to 
> drivers/acpi/events/evxfregn.c
> and removing one of the 
> 
> acpi_ut_remove_reference (handler_obj);
> 
> lines (there are two). 
> This might also help other Thinkpad users who have similar problems.
> 
> 
> Let me know how it goes.  Sleep functionality seems pretty broken at
> the moment.
> 
Hi Brian,
Hmm, it have the same effect like commenting out these "if (ec_ecdt && ec_ecdt->uid == uid) {...}" block in acpi_ec_add() of ec.c. No errormessages anymore but also no events from the powerbutton...
I'll no try for testing a kernel with both hacks ;-) ...
And I'll give 2.5.66 a shot to see if it makes a difference ....
thanks for the quick response
regards
micha

ps: which BIOS revision are you running on your R32?


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
