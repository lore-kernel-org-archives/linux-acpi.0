From: J <acpi-bdq14YP6qtSeVB85EesmETSf8X3wrgjD@public.gmane.org>
Subject: Re: Re: making progress with ACPI was: ACPI small patch up date
Date: Wed, 30 Oct 2002 09:55:53 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200210300955.53572.acpi@computerdatasafe.com.au>
References: <EDC461A30AC4D511ADE10002A5072CAD04C7A489@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <EDC461A30AC4D511ADE10002A5072CAD04C7A489-OU+JdkIUtvd9zuciVAfUoVDQ4js95KgL@public.gmane.org>
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

On Wed, 30 Oct 2002 07:50, Grover, Andrew wrote:
> > and not applying cleanly on 2.4.X official kernels.
>
> If we have a prayer of ever getting into official 2.4, we need to track the
> pre kernels. People in the past have done backports to the non-pre kernels,
> but that really depends on what other people are willing to do.

At present I will only use what's in 2.4. What I do for my machines doesn't 
matter a whole lot, but when I maintain machines for others I _much_ prefer 
to use standard source code supplied by my vendor inless there's a good 
reason for something else.

Best too, I think, if I use the platforms I support for others.

> > > I strongly believe that the ACPI project would make much
> >
> > more progress
> >
> > > if Andy and Robert put a little effort into tracking bugs and making
> > > releases.
> >
> > I do agree. The more people do not want other to look/critic
> > their code,
> > the more they pretend what they do is a kind of black art, and do not
> > document it or make design document :-) Fixing bug is
> > annoying, making a
> > new release and advising to report a problem on it is so more fun.
>
> We can fix bugs, the problem is *diagnosing* the issue. There's only so
> much diagnosis that can be done without the hardware. If you say "line 444
> of ec.c is acquiring a semaphore at interrupt level" that's probably
> enough. If you post a patch, we'll apply it. If you just say "my system
> hangs" then it's a lot harder. Sometimes the dmesg or DSDT are enough that
> other people can suss out what might be the problem -- sometimes not.
>
>
> Part of this whole open source "gift" economy is that it's polite to not
> turn one's nose up a gift. Even if it wasn't all that you wanted. And
> especially if you haven't reciprocated.
>
>
> Regards -- Andy

This can be taken two ways.

It's becoming apparent to me this project is in need of some management. I 
think Jan was hinting he might provide some management, maybe only in the 
short term, but who knows? He has some problems he wants fixed, and if he 
finds it enjoyable being part of the team he'll probably stick around. Why 
turn up your nose at the gift?

If you don't like the sourceforge bug tracking system, then how about 
Bugzilla? As a user I don't like it a lot, but it does handle some sizable 
projects so it can't be all bad. Probably someone here could host it.

Even a weblog (or spreadsheet for that matter!) would serve to keep bugs 
visible until they're resolved. I have the impression from what others have 
said that losing track of them is a problem.







-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
