From: Michael Frank <mhf-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org>
Subject: Re: [ACPI] Re: 1.1-rc9 acpi_disabled==0x30 on resume
Date: Sat, 27 Sep 2003 13:29:26 +0800
Sender: swsusp-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200309271316.45398.mhf@linuxmail.org>
References: <200309270135.43786.mhf@linuxmail.org> <20030927000908.GB8008@hell.org.pl> <1064621813.3322.0.camel@laptop-linux>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <swsusp-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1064621813.3322.0.camel-udXHSmD1qAy4CTf7w+cZoA@public.gmane.org>
Content-Disposition: inline
Errors-To: swsusp-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:swsusp-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:swsusp-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/swsusp-devel>,
	<mailto:swsusp-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/swsusp-devel>,
	<mailto:swsusp-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=swsusp-devel>
To: Nigel Cunningham <ncunningham-oKK1aGe2n869koe0gwxAeg@public.gmane.org>, Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Cc: swsusp-devel <swsusp-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

  mhf76 2.4.22 
    +kdb
    +win4lin +win4lin-option 
    +acpi-option
    +/acpi-20030916-2.4.22.diff
    +swsusp-1.1-rc9

arch/i386/kernel/acpi.c:

#ifdef	CONFIG_ACPI_INTERPRETER
	int acpi_disabled __initdata = 0;
#else
	int acpi_disabled __initdata = 1;
#endif

This should be irrelevant anyway as that kernel 
is overwritten...

I find the value 0x30 strange. Are we hunting phantoms?

Regards
Michael


On Saturday 27 September 2003 08:16, Nigel Cunningham wrote:
> Ah. Ok. I was looking at 2.4.22, not my bk tree. Michael, what are you
> running?
> 
> Regards.
> 
> Nigel
> 
> On Sat, 2003-09-27 at 12:09, Karol Kozimor wrote:
> > Thus wrote Nigel Cunningham:
> > > Hi.
> > > 
> > > In arch/i386/kernel, acpi_disabled is declared __init_data. If you
> > > remove that attribute, is the issue fixed?
> > 
> > I believe the patch is already merged. I wonder how could this bug be 
> > present for that long without anyone noticing...
> > Best regards,
> -- 
> Nigel Cunningham
> 495 St Georges Road South, Hastings 4201, New Zealand
> 
> You see, at just the right time, when we were still powerless,
> Christ died for the ungodly.
> 	-- Romans 5:6, NIV.
> 
> 
> 




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
