From: Michael Notforyou <sqfreak-goaWJWIt5zpWk0Htik3J/w@public.gmane.org>
Subject: Re: thermal module and tzp
Date: Mon, 02 Sep 2002 16:07:42 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <5.1.0.14.0.20020902160705.0341edf0@pop-server.triad.rr.com>
References: <200209021837.g82IbtX28267@mailgate5.cinetic.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200209021837.g82IbtX28267-pb599fR3TxVkExQqqHjIK3sFFmKitW5W@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

My computer doesn't have thermal zones - I can't help.


At 08:37 PM 9/2/2002 +0200, you wrote:
><joerg.beyer-htSm2yLGOjU@public.gmane.org> schrieb am 02.09.02 19:57:55:
> > Hi,
> >
> > I use linux-2.4.20-pre5 and latest acpi patches. If I build thermal 
> (and the
> > other parts of acpi, where it is possible) as module and set the tzp 
> paramter,
> > e.g. modprobe thermal tzp=20 then I get a kernel panic. Does anybody else
> > see this?
>
>because I saw Michael Notforyou's hint not to compile acpi as module (in
>another thread) I tried the same with setting tzp=20 (and 50 on another try)
>and compile the whole acpi part direct in the kernel. The effect was the same.
>
>Does anybody else see this?
>
>
>     Joerg
>
>
>
>-------------------------------------------------------
>This sf.net email is sponsored by: OSDN - Tired of that same old
>cell phone?  Get a new here for FREE!
>https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
>_______________________________________________
>Acpi-devel mailing list
>Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>https://lists.sourceforge.net/lists/listinfo/acpi-devel

*Michael Notforyou*

"My God, I'm full of stars!"
Darmok and Jalad at Tanagra!



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
