From: "Darren Benham" <dbenham-FG1iuTdj8bisTnJN9+BGXg@public.gmane.org>
Subject: Re: System hang when trying to enter sleep/standby state
Date: Thu, 13 Feb 2003 11:00:52 -0800 (PST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <51181.64.164.111.5.1045162852.squirrel@benham.net>
References: <200302131628.h1DGSID27482@ikffws2.ikff.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
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
To: haug-X6ztD3ggwzuBAmxm6OvjtTjhTm2NLCe8@public.gmane.org
Cc: mochel-3NddpPZAyC0@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Oh come on, this is Linux not preschool.

How about making it a .config option, default to "unset" and with a big
warning in the help?
Jens Haug said:
>> > > I would recommend never, ever doing 'echo 5 > /proc/acpi/sleep',
>> > > especially if you're trying to suspend the system.
>> >
>> > It's not worse than pushing the power button on a normal system (or
>> > hold the power button on an ACPI system).
>>
>> You're absolutely right. But, most people do those things
>> deliberately,  and know the consequences.
>
> Do you think someone becomes root and does an "echo 5 >
> /proc/acpi/sleep" by accident? ;-)
>
>> Think about how this thread started: $Random User sees his system
>> doesn't suspend when writing '4' to that file, so he tries every other
>> value.
>
> This is not a random user. This is someone who plays around with his
> system while testing beta kernel drivers.
> The random user at this stage doesn't know about acpi at all. The
> random user in the future (when acpi comes with Suse or RedHat Linux
> out of the box) will only use the GUIs to suspend and such. So there's
> no problem at all, I think.
>
>> That's a perfectly valid thing to do, and the kernel has no right to
>> crash when he does something like that.
>
> The kernel has the right to do what the specs say. There might be
> systems where this is wanted (which boot from read only medium and need
> a really fast poweroff).
>
>> Which is possible, but ludicrous. If you want to halt your system, use
>> halt(1). We do not need to invent new ways to do old things,
>> especially  when they are dangerous.
>
> This is a new thing: You can power off in less than a second.
>
>> > The regular user can't write anything to that file - this must be
>> > root. He's supposed to know what he's doing. If he wants to turn the
>> > machine off without halting the system, then that's his choice.
>> > Think of something like an embedded system to control a machine.
>> > Many  machines have an emergency off whith a huge red button. This
>> > is the software version of this red button. Your software can press
>> > this if you thing that's necessary.
>>
>> That's crap.
>
> You're too kind.
>
>> For one, most systems are single-user systems.
>
> Do you want a kernel for most systems or a general purpose, scalable
> OS? You're thinking the windows way. I'm glad that Linux is better.
>
>> That was
>> certainly the case for the guy that crashed his system by writing to
>> that  file. So, by definition, root knows only as much as the most
>> knowledgable  user.
>
> No, by definition root is the administrator and knows what he's doing.
> It might be true that there are many people out there who do not know
> what they are doing - but they hardly ever become root in the console
> and echo numbers anywhere in /proc. And if they do so - well, that's
> their fault.
>
>> For another, as mentioned before, we have safe mechanisms for halting
>> a  system. See 'man 1 halt'.
>
> You have *no* other mechanism to turn your box off in less than one
> second.
>
>> > I'd like to have it in. I don't know what I could ever use it for,
>> > but I'd really prefer to have this possibility.
>>
>> Listen to yourself. Also, take into account your design philosophies
>> concerning Linux and other operating systems. This comment is poorly
>> thought out and completely invalid.
>
> Will you just keep on saying my comment was no good or could you
> maybe tell me what exactly is wrong with it?
>
>> We don't keep features around because they might be useful to someone
>> at  some point in the future. We do what is necessary and nothing
>> more.
>
> Oh, do we? We don't even know what people are doing. This is not a set
> top box. This is an operating system. People build all kinds of stuff
> from this. Do you think you know what is necessary for *all* the things
> that can be done with Linux?
>
>> We also don't leave gaping holes for users to accidentally screw
>> themselves. Deliberately, sure. But, not on accident, that's just
>> rude.
>
> Oops, I typed "sudo echo 5 > /proc/acpi/sleep" by accident again.
> Sometimes it just happens. ;-)
>
>
> Jens
>
> --
> Jens Haug
> IKFF Universität Stuttgart              Tel. 0711/685-6422
> Pfaffenwaldring 9                       Fax  0711/685-6356
> 70550 Stuttgart	                haug-X6ztD3ggwzuBAmxm6OvjtTjhTm2NLCe8@public.gmane.org
>
>
>
> -------------------------------------------------------
> This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
> are you planning your Web Server Security? Click here to get a FREE
> Thawte SSL guide and find the answers to all your  SSL security issues.
> http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel


-- 
Darren




-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
