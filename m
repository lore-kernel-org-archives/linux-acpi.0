From: Patrick Mochel <mochel-3NddpPZAyC0@public.gmane.org>
Subject: Re: System hang when trying to enter sleep/standby state
Date: Thu, 13 Feb 2003 10:46:39 -0600 (CST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.33.0302131031290.1133-100000@localhost.localdomain>
References: <200302131628.h1DGSID27482@ikffws2.ikff.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200302131628.h1DGSID27482-sBhUd1W9t4xfrO0PeCDDO4ECbGbo6+O1OOFObY0sJ7w@public.gmane.org>
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


> > You're absolutely right. But, most people do those things deliberately, 
> > and know the consequences. 
> 
> Do you think someone becomes root and does an "echo 5 > /proc/acpi/sleep"
> by accident? ;-)

Definitely. By, trying a range of values, they stumble on one that crashes 
their system. 

> > Think about how this thread started: $Random User sees his system doesn't
> > suspend when writing '4' to that file, so he tries every other value.
> 
> This is not a random user. This is someone who plays around with his
> system while testing beta kernel drivers. 
> The random user at this stage doesn't know about acpi at all. The
> random user in the future (when acpi comes with Suse or RedHat Linux 
> out of the box) will only use the GUIs to suspend and such. So there's
> no problem at all, I think.

The GUIs should not, and will not, support writing directly to that file. 
In the perfect, abstract future, we will not even have /proc/acpi/sleep, 
we will have an abstracted for entering sleep states. 

Note that GUIs already support shutting down safely. 

> > That's a perfectly valid thing to do, and the kernel has no right to crash
> > when he does something like that. 
> 
> The kernel has the right to do what the specs say. There might be 
> systems where this is wanted (which boot from read only medium and
> need a really fast poweroff).

The kernel does what the specs say. Read the code. The system is placed 
into S5 when doing off from a shutdown sequence, exactly what the spec 
intended to be done. 

As a whole, we do enforce a minimum amount of policy we do not want to 
lose users data. And that will happen. 

Let me repeat, and try and get you to listen: 

You *will* corrupt your data if you do not flush the disk buffers. 
You *will* corrupt your data if you do not flush the disk buffers. 
You *will* corrupt your data if you do not flush the disk buffers. 

That's why it's so slow when you do a normal shutdown. That's why 
immediately putting the system into S5 is so fast - we don't flush the 
buffers. 

If you boot from a read-only medium and you want a fast poweroff, guess 
what you use? halt(1). The same mechanism works, and it's faster because 
there are no buffers to flush. 

> > For one, most systems are single-user systems. 
> 
> Do you want a kernel for most systems or a general purpose, scalable
> OS? You're thinking the windows way. I'm glad that Linux is better.

This is not a philosophical issue. It's fact. The disabling of this 
'feature' is good for single-user systems. It's better for multi-user 
systems. It prevents a user from not only screwing themselves, but 
screwing every other user.

> > That was 
> > certainly the case for the guy that crashed his system by writing to that 
> > file. So, by definition, root knows only as much as the most knowledgable 
> > user. 
> 
> No, by definition root is the administrator and knows what he's doing.
> It might be true that there are many people out there who do not know
> what they are doing - but they hardly ever become root in the console
> and echo numbers anywhere in /proc. And if they do so - well, that's
> their fault. 

Wrong. More and more systems are desktop systems, with one user attached 
to them. That is a fact. That's the space that ACPI power management is 
most important, and the area that we're most concerned with ATM. 

You are right, though, if they start writing random values into /proc, it 
is their fault. But, the random range of numbers to be written to  
/proc/acpi/sleep is small, and not that random. The documentation suggests 
that some values work and others don't. It's human nature to exercise 
curiosity and experiment with other close values. If they do, which they 
are so likely to, I do not want to see them cause any harm to themselves. 

> > For another, as mentioned before, we have safe mechanisms for halting a 
> > system. See 'man 1 halt'. 
> 
> You have *no* other mechanism to turn your box off in less than one
> second.

Then concentrate on that, and don't encourage dangerous features in the 
kernel. 

> > We don't keep features around because they might be useful to someone at 
> > some point in the future. We do what is necessary and nothing more. 
> 
> Oh, do we? We don't even know what people are doing. This is not a
> set top box. This is an operating system. People build all kinds of
> stuff from this. Do you think you know what is necessary for *all*
> the things that can be done with Linux?

That is not the Linux design philosophy. You are welcome to implement a 
patchset incorporates every feature known to man. There is at least one 
project that does that. But, the mainstream kernel is not a trawling barge 
for random features, useful or not. This particular item is dangerous and 
will be removed from the kernel. 


	-pat



-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
