From: Jens Haug <haug-X6ztD3ggwzuBAmxm6OvjtTjhTm2NLCe8@public.gmane.org>
Subject: Re: System hang when trying to enter sleep/standby state
Date: Thu, 13 Feb 2003 17:28:17 +0100 (MET)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200302131628.h1DGSID27482@ikffws2.ikff.uni-stuttgart.de>
Reply-To: Jens Haug <haug-X6ztD3ggwzuBAmxm6OvjtTjhTm2NLCe8@public.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-MD5: UdWZ8rdX/HCM8YPdsHHQZg==
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: mochel-3NddpPZAyC0@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> > > I would recommend never, ever doing 'echo 5 > /proc/acpi/sleep',=20
> > > especially if you're trying to suspend the system.=20
> >=20
> > It's not worse than pushing the power button on a normal system
> > (or hold the power button on an ACPI system).
>=20
> You're absolutely right. But, most people do those things deliberately,=
=20
> and know the consequences.=20

Do you think someone becomes root and does an "echo 5 > /proc/acpi/sleep"
by accident? ;-)

> Think about how this thread started: $Random User sees his system doesn't
> suspend when writing '4' to that file, so he tries every other value.

This is not a random user. This is someone who plays around with his
system while testing beta kernel drivers.=20
The random user at this stage doesn't know about acpi at all. The
random user in the future (when acpi comes with Suse or RedHat Linux=20
out of the box) will only use the GUIs to suspend and such. So there's
no problem at all, I think.

> That's a perfectly valid thing to do, and the kernel has no right to cras=
h
> when he does something like that.=20

The kernel has the right to do what the specs say. There might be=20
systems where this is wanted (which boot from read only medium and
need a really fast poweroff).

> Which is possible, but ludicrous. If you want to halt your system, use
> halt(1). We do not need to invent new ways to do old things, especially=
=20
> when they are dangerous.=20

This is a new thing: You can power off in less than a second.

> > The regular user can't write anything to that file - this must be
> > root. He's supposed to know what he's doing. If he wants to turn the
> > machine off without halting the system, then that's his choice. Think
> > of something like an embedded system to control a machine. Many=20
> > machines have an emergency off whith a huge red button. This is the
> > software version of this red button. Your software can press this
> > if you thing that's necessary.
>=20
> That's crap.=20

You're too kind.

> For one, most systems are single-user systems.=20

Do you want a kernel for most systems or a general purpose, scalable
OS? You're thinking the windows way. I'm glad that Linux is better.

> That was=20
> certainly the case for the guy that crashed his system by writing to that=
=20
> file. So, by definition, root knows only as much as the most knowledgable=
=20
> user.=20

No, by definition root is the administrator and knows what he's doing.
It might be true that there are many people out there who do not know
what they are doing - but they hardly ever become root in the console
and echo numbers anywhere in /proc. And if they do so - well, that's
their fault.=20

> For another, as mentioned before, we have safe mechanisms for halting a=
=20
> system. See 'man 1 halt'.=20

You have *no* other mechanism to turn your box off in less than one
second.

> > I'd like to have it in. I don't know what I could ever use it for,
> > but I'd really prefer to have this possibility.
>=20
> Listen to yourself. Also, take into account your design philosophies=20
> concerning Linux and other operating systems. This comment is poorly=20
> thought out and completely invalid.

Will you just keep on saying my comment was no good or could you
maybe tell me what exactly is wrong with it?

> We don't keep features around because they might be useful to someone at=
=20
> some point in the future. We do what is necessary and nothing more.=20

Oh, do we? We don't even know what people are doing. This is not a
set top box. This is an operating system. People build all kinds of
stuff from this. Do you think you know what is necessary for *all*
the things that can be done with Linux?

> We also don't leave gaping holes for users to accidentally screw=20
> themselves. Deliberately, sure. But, not on accident, that's just rude.=
=20

Oops, I typed "sudo echo 5 > /proc/acpi/sleep" by accident again.
Sometimes it just happens. ;-)


Jens

--=20
Jens Haug
IKFF Universit=E4t Stuttgart              Tel. 0711/685-6422
Pfaffenwaldring 9                       Fax  0711/685-6356
70550 Stuttgart=09                haug-X6ztD3ggwzuBAmxm6OvjtTjhTm2NLCe8@public.gmane.org



-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
