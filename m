From: Huw Hawkins <hrhawk-JGs/UdohzUI@public.gmane.org>
Subject: RE: Re: making progress with ACPI was: ACPI small patch up
	date
Date: 30 Oct 2002 03:17:54 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1035944274.1275.32.camel@U414>
References: <EDC461A30AC4D511ADE10002A5072CAD04C7A489@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
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

> We can fix bugs, the problem is *diagnosing* the issue. There's only so much
> diagnosis that can be done without the hardware. If you say "line 444 of
> ec.c is acquiring a semaphore at interrupt level" that's probably enough. If
> you post a patch, we'll apply it. If you just say "my system hangs" then
> it's a lot harder. Sometimes the dmesg or DSDT are enough that other people
> can suss out what might be the problem -- sometimes not.

I've given this some though. What you're trying to say, basically, is
the sf bugtracker isn't suitable because you need at least a DSDT/dmesg
with the bug report and preferably access to ask further questions, so
unless someone has that implimented in a bug-track system (with hosting
to match) it's a nightmarish task.  

> Part of this whole open source "gift" economy is that it's polite to not
> turn one's nose up a gift. Even if it wasn't all that you wanted. And
> especially if you haven't reciprocated.

Owch. Personally I've tried to submit what
patches/bugreports/information I could. Usually, I'm not sure if its
helpful, whether its important or got missed in the rush. To me
ACPI-development is a "black-box" system. You post something to the list
and either get a flaming, a pat on the head, a useful bit of help or
dead silence. Other projects have roadmaps, FAQ's, etc to at least give
people the option to inform themselves as to whats a priority, why
bugtracking is a mailling list or what's currently being neglected. A
few lines of html might save constant "are you insane, it'd be easier
if.." and "why isn't...." threads when you've thought it through and
have good reasons others might not immediately otherwise see.




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
