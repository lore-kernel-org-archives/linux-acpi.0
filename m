From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Re: making progress with ACPI was: ACPI small patch up
	date
Date: Tue, 29 Oct 2002 15:50:03 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD04C7A489@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "'eric.valette=GANU6spQydw@public.gmane.org'" <eric.valette-GANU6spQydw@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Jan Rychter <jan-JAsPCFd0eodBDgjK7y7TUQ@public.gmane.org>, Huw Hawkins <hrhawk-JGs/UdohzUI@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

> From: Valette Eric [mailto:eric.valette-GANU6spQydw@public.gmane.org] 
> I complained about that in the list in the past and got an 
> answer saying 
> politely to shut up, to *not* use sourceforge tool, and post 
> problem to 
> the mailling list. Fortunately dominik spend some time 
> helping me until 
> it worked.
> 
> I also complained about acpi patches beeing done for 2.4 pre releases 
> and not applying cleanly on 2.4.X official kernels.

If we have a prayer of ever getting into official 2.4, we need to track the
pre kernels. People in the past have done backports to the non-pre kernels,
but that really depends on what other people are willing to do.

> > I strongly believe that the ACPI project would make much 
> more progress
> > if Andy and Robert put a little effort into tracking bugs and making
> > releases.
> 
> I do agree. The more people do not want other to look/critic 
> their code, 
> the more they pretend what they do is a kind of black art, and do not 
> document it or make design document :-) Fixing bug is 
> annoying, making a 
> new release and advising to report a problem on it is so more fun.

We can fix bugs, the problem is *diagnosing* the issue. There's only so much
diagnosis that can be done without the hardware. If you say "line 444 of
ec.c is acquiring a semaphore at interrupt level" that's probably enough. If
you post a patch, we'll apply it. If you just say "my system hangs" then
it's a lot harder. Sometimes the dmesg or DSDT are enough that other people
can suss out what might be the problem -- sometimes not.

Part of this whole open source "gift" economy is that it's polite to not
turn one's nose up a gift. Even if it wasn't all that you wanted. And
especially if you haven't reciprocated.

Regards -- Andy


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
