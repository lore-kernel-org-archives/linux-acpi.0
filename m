From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: Re: kern 2.6.1 - suspend/resume still malfunctioning
Date: Fri, 16 Jan 2004 20:39:01 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040116193901.GC924@elf.ucw.cz>
References: <40069161.4040703@lorenz.eu.org> <20040115135532.GA11298@message-id.gmane0305.slipkontur.de> <4006A96F.1020502@lorenz.eu.org> <4006B0DD.4020801@lorenz.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4006B0DD.4020801-2WKW0nu+7nMiq3RsQ1AnAw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Martin Lorenz <martin-2WKW0nu+7nMiq3RsQ1AnAw@public.gmane.org>
Cc: Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> >>>Dear all,
> >>>
> >>>well I am playing around to get suspend/resume working on my PC-MM10 for
> >>>quite a while now, and have run from one failing into the next...
> >>
> >>
> >>>all the data, i reported about my laptop is recorded with bug #1773
> >>>http://bugme.osdl.org/show_bug.cgi?id=1773
> >>
> >>
> >>have you tried S4, e.g. "echo 4 > /proc/acpi/sleep"?
> >>S3 is probably harder to get working than S4, so try S4 first.
> >>
> > 
> > well...
> > 
> > with S4 i get a message, saying that my drive was not ready for that
> > command and it keeps telling me (lines by lines and never ending)
> > 
> > end_request: I/O error, dev hda, sector 1596164

What about few lines before this?  mdelay(1000) into printk if you
must.

> > so i it doesent even go to suspend(off)
> > 
> 
> just tried to boot into /bin/bash and gave it another chance there
> guess what: it suspended to ram and resumed without any
> jinxes and oopses :-)
> 
> but what is this going to tell me as a kernel-imbecile???

Well, search which process breaks that.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
