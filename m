From: Patrick Mochel <mochel-3NddpPZAyC0@public.gmane.org>
Subject: Re: System hang when trying to enter sleep/standby state
Date: Thu, 13 Feb 2003 10:01:36 -0600 (CST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.33.0302130946280.1133-100000@localhost.localdomain>
References: <200302130659.h1D6x7D22714@ikffws2.ikff.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200302130659.h1D6x7D22714-sBhUd1W9t4xfrO0PeCDDO4ECbGbo6+O1OOFObY0sJ7w@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jens Haug <haug-X6ztD3ggwzuBAmxm6OvjtTjhTm2NLCe8@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


On Thu, 13 Feb 2003, Jens Haug wrote:

> > I would recommend never, ever doing 'echo 5 > /proc/acpi/sleep', 
> > especially if you're trying to suspend the system. 
> 
> It's not worse than pushing the power button on a normal system
> (or hold the power button on an ACPI system).

You're absolutely right. But, most people do those things deliberately, 
and know the consequences. 

Think about how this thread started: $Random User sees his system doesn't
suspend when writing '4' to that file, so he tries every other value.
That's a perfectly valid thing to do, and the kernel has no right to crash
when he does something like that. In order not to crash, and to guarantee
that data does not get corrupted, we should execute sys_reboot() from
inside the kernel. 

Which is possible, but ludicrous. If you want to halt your system, use
halt(1). We do not need to invent new ways to do old things, especially 
when they are dangerous. 

> > ACPI should not allow a user to write '5' to that file. It used to be that 
> > way, but someone clever decided that that interface should support _all_ 
> > sleep states. (It might have been me, in one of my finer moments). 
> 
> The regular user can't write anything to that file - this must be
> root. He's supposed to know what he's doing. If he wants to turn the
> machine off without halting the system, then that's his choice. Think
> of something like an embedded system to control a machine. Many 
> machines have an emergency off whith a huge red button. This is the
> software version of this red button. Your software can press this
> if you thing that's necessary.

That's crap. For one, most systems are single-user systems. That was 
certainly the case for the guy that crashed his system by writing to that 
file. So, by definition, root knows only as much as the most knowledgable 
user. 

For another, as mentioned before, we have safe mechanisms for halting a 
system. See 'man 1 halt'. 

> > Andy, I recommend removing that from 2.4, and I'll send you a patch for 
> > 2.5..
> 
> I'd like to have it in. I don't know what I could ever use it for,
> but I'd really prefer to have this possibility.

Listen to yourself. Also, take into account your design philosophies 
concerning Linux and other operating systems. This comment is poorly 
thought out and completely invalid.

We don't keep features around because they might be useful to someone at 
some point in the future. We do what is necessary and nothing more. 

We also don't leave gaping holes for users to accidentally screw 
themselves. Deliberately, sure. But, not on accident, that's just rude. 

There is no freedom in anarchy. Just because you can have something 
doesn't mean that you should. This is not about enforcing policy or 
behavior, or knowing 'what is best' for a user. This is about saving users 
heartache and valuable data, and developers from saying 'don't do that' a 
thousand times. 

End of story. 

	-pat



-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
