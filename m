From: "Don Langworthy" <dbl-t4aQvBRgbK03GDxJruMu3g@public.gmane.org>
Subject: RE: S3 and S4: nothing happens
Date: Sun, 13 Oct 2002 14:58:20 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <000001c27303$bce537f0$46ffff0a@DigitalCog>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
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
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I have similar symptoms:

echo 5 > /proc/acpi/sleep causes an immediate ungraceful power off.

All other values seem to have no effect on the system power state.

I've noticed 3 different behaviors for performance and throttling (under
/proc/acpi/processor).

1 No effect
2 Change state for a few seconds then reverts back to full power mode 3
Changes state permanently.

The system seems to pick one behavior at boot time and stick with it
until the next boot time. 

I'm using the 20020918 patch to the 2.4.18 kernel. I can't get the
20021002 patch to the 2.4.20pre8 kernel to patch (or compile) cleanly.

Hardware is a Sony Vaio pcg-fx370

I'd be happy to help debug the problem if someone would point me in the
right direction or where to start looking. 


Don Langworthy
dbl-t4aQvBRgbK03GDxJruMu3g@public.gmane.org

> -----Original Message-----
> From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel- 
> admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Joshua Lauricha
> Sent: Thursday, October 10, 2002 7:23 PM
> To: Roy
> Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: Re: [ACPI] S3 and S4: nothing happens
> 
> Same thing happen here, using 2.4.20-pre8 w/acpi-20021002-pre8, 
> /proc/acpi/sleep gives S0 S3 S4 S5, but "echo 3 > /proc/acpi/sleep", 
> or 4. Give nothing.
> 
> Also, /proc/acpi/processor/CPU0/performance gives not supported. Is 
> that simply for 2.4.xx or some error?
> 
> I have a Fujitsu C-6631 w/a P3-1Ghz.
> 
> On Thu, 10 Oct 2002, Roy wrote:
> 
> > Anyone can help me with this:
> > If I do a "echo 3 > /proc/acpi/sleep" or a "echo 4 > 
> > /proc/acpi/sleep" nothing happens (using 2.5.41 and 
> > 2.4.20-pre8-acpi). There isn't any message in /var/log/messages.
> >
> > A "cat /proc/acpi/sleep" gives me: S0 S3 S4 S5
> >
> > Any suggestions?
> > Thanks, Roy!
> >
> >
> >
> > -------------------------------------------------------
> > This sf.net email is sponsored by:ThinkGeek
> > Welcome to geek heaven.
> > http://thinkgeek.com/sf 
> > _______________________________________________
> > Acpi-devel mailing list
> > Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org 
> > https://lists.sourceforge.net/lists/listinfo/acpi-devel
> >
> 
> 
> 
> -------------------------------------------------------
> This sf.net email is sponsored by:ThinkGeek
> Welcome to geek heaven.
> http://thinkgeek.com/sf 
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org 
> https://lists.sourceforge.net/lists/listinfo/acpi-devel



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
