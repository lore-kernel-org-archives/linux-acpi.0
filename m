From: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Subject: Re: ASUS M6800N: processor has only C1
Date: Wed, 10 Mar 2004 20:17:24 -0800 (PST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040310201438.Y61960@root.org>
References: <404459FD.1000406@pca.it> <40471A4F.2090909@renninger.de>
 <40471F8E.5080308@renninger.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <40471F8E.5080308-smMupaH/RwJM7kwft8N7nw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Thomas Renninger <mail-smMupaH/RwJM7kwft8N7nw@public.gmane.org>
Cc: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, 4 Mar 2004, Thomas Renninger wrote:
> Thomas Renninger wrote:
> > Your machine supports the C4 state.
> > Change the P_BLK  in your DSDT to 0x06
> >
> > e.g.:
> >    Processor (\_PR.CPU0, 0x01, 0x00001010, 0x07)
> > to:
> >    Processor (\_PR.CPU0, 0x01, 0x00001010, 0x06)
> >
> > or use the patch from Pavel, posted on the 28.02.2004, 17:10.
> >
> > Unfortunately this won't enable the C4 state if you have one.
> > What do mainters say about supporting Cn processor states in the future?
>
> I am pretty sure this message will come up more often in future.
> Could it be that new mobile Intel processors support the C4 state ->
> therefore P_BLK = 0x07?
>
> Pavel's patch is a workaround, setting P_BLK back to 6, but isn't it
> worth a critical bug for supporting Cn states,
> as only supporting C0-C3 states offends the specification?

For FreeBSD, I took the approach that throttling requires P_BLK_LEN >= 4,
C2 requires >= 5, and C3 requires >= 6.  Systems with higher values will
get C1-C3 but we will not support C4 on such systems.  There are already
plenty of valid systems with _CST out in the real world (i.e. IBM Centrino
laptops) and so for someone to break the standard now is unacceptable.
Users will get C1-C3 on broken systems, which is good enough.

-Nate


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
