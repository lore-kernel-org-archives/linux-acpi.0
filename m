From: Nigel Cunningham <ncunningham-oKK1aGe2n869koe0gwxAeg@public.gmane.org>
Subject: Re: [ACPI] Re: 1.1-rc9 acpi_disabled==0x30 on resume
Date: Sat, 27 Sep 2003 18:37:07 +1200
Sender: swsusp-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1064644626.17857.1.camel@laptop-linux>
References: <200309270135.43786.mhf@linuxmail.org>
 <20030927000908.GB8008@hell.org.pl> <1064621813.3322.0.camel@laptop-linux>
 <200309271316.45398.mhf@linuxmail.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <swsusp-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <200309271316.45398.mhf-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org>
Errors-To: swsusp-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:swsusp-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:swsusp-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/swsusp-devel>,
	<mailto:swsusp-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/swsusp-devel>,
	<mailto:swsusp-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=swsusp-devel>
To: Michael Frank <mhf-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org>
Cc: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>, swsusp-devel <swsusp-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

My guess would be that the memory is being freed and reused, and that's
where the 0x30 comes from. Could you use kdb to check it prior to
suspending?

Regards,

Nigel

On Sat, 2003-09-27 at 17:29, Michael Frank wrote:
>   mhf76 2.4.22 
>     +kdb
>     +win4lin +win4lin-option 
>     +acpi-option
>     +/acpi-20030916-2.4.22.diff
>     +swsusp-1.1-rc9
> 
> arch/i386/kernel/acpi.c:
> 
> #ifdef	CONFIG_ACPI_INTERPRETER
> 	int acpi_disabled __initdata = 0;
> #else
> 	int acpi_disabled __initdata = 1;
> #endif
> 
> This should be irrelevant anyway as that kernel 
> is overwritten...
> 
> I find the value 0x30 strange. Are we hunting phantoms?
> 
> Regards
> Michael




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
