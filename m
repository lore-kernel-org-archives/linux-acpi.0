From: Nigel Cunningham <ncunningham-oKK1aGe2n869koe0gwxAeg@public.gmane.org>
Subject: Re: 1.1-rc9 acpi_disabled==0x30 on resume
Date: Sat, 27 Sep 2003 08:02:24 +1200
Sender: swsusp-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1064606502.5722.2.camel@laptop-linux>
References: <200309270135.43786.mhf@linuxmail.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <swsusp-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <200309270135.43786.mhf-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org>
Errors-To: swsusp-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:swsusp-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:swsusp-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/swsusp-devel>,
	<mailto:swsusp-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/swsusp-devel>,
	<mailto:swsusp-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=swsusp-devel>
To: Michael Frank <mhf-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org>
Cc: swsusp-devel <swsusp-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi.

In arch/i386/kernel, acpi_disabled is declared __init_data. If you
remove that attribute, is the issue fixed?

Regards,

Nigel

On Sat, 2003-09-27 at 05:35, Michael Frank wrote:
> Hi Nigel,
> 
> I found that acpi modules can't be inserted on resume
> because acpi ends up disabled with acpi_disabled==0x30 .
> 
> Setting acpi_disabled to 0 using kdb fixes it.
> 
> Regards
> Michael
> 
> 
> 
> -------------------------------------------------------
> This sf.net email is sponsored by:ThinkGeek
> Welcome to geek heaven.
> http://thinkgeek.com/sf
> _______________________________________________
> swsusp-devel mailing list
> swsusp-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/swsusp-devel
-- 
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

You see, at just the right time, when we were still powerless,
Christ died for the ungodly.
	-- Romans 5:6, NIV.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
