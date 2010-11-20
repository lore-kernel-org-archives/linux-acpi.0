From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 1/2] Generic hardware error reporting mechanism
Date: Sat, 20 Nov 2010 10:00:22 +0100
Message-ID: <20101120090022.GA26303@liondog.tnic>
References: <1290154233-28695-1-git-send-email-ying.huang@intel.com>
 <1290154233-28695-2-git-send-email-ying.huang@intel.com>
 <a6a56c8a0426c6e46de1a9361cebcd63.squirrel@www.skyhub.de>
 <AANLkTin9AmJbeHOATyK4M8-MmaDGL4XPiVnTG4X=TEkS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:59816 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751257Ab0KTJA1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 20 Nov 2010 04:00:27 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTin9AmJbeHOATyK4M8-MmaDGL4XPiVnTG4X=TEkS@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: huang ying <huang.ying.caritas@gmail.com>
Cc: Huang Ying <ying.huang@intel.com>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, linux-acpi@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Mauro Carvalho Chehab <mchehab@redhat.com>, Thomas Gleixner <tglx@linutronix.de>

On Sat, Nov 20, 2010 at 10:52:56AM +0800, huang ying wrote:
> On Fri, Nov 19, 2010 at 9:56 PM,  <boris@alien8.de> wrote:
> > Yes, we need a generic error reporting format. Wait a second, this
> > error format structure looks very much like a tracepoint record to =
me -
> > it has common fields and record-specific fields. And we have all th=
at
> > infrastructure in the kernel and yet you've decided to reimplement =
it
> > anew. Remind me again why?
>=20
> You mean "struct trace_entry"? They are quite different on design. Th=
e
> record format in patch can incorporate multiple sections into one
> record, which is meaningful for hardware error reporting.

Nope, I mean a tracepoint and it can do all those things.

> And we do not need the fancy
> "/sys/kernel/debug/tracing/events/<xxx>/<xxx>/format", user space
> error daemon only consumes all error record it recognized and blindly
> log all other records.

Nobody said you needed that - the tracepoint contains all the
information you need.

[..]

> > - why do we need an
> > error field for _every_ device on the system? Looks like a bunch of
> > hoopla for only a few error types...
>=20
> Because every device may report hardware errors, but not every device
> will do it. So just a pointer is added to "struct device" and
> corresponding data structure is only created when needed.
>=20
> >> For example, the
> >> "error" directory for APEI GHES is as follow.
> >>
> >> /sys/devices/platform/GHES.0/error/logs
> >> /sys/devices/platform/GHES.0/error/overflows
> >> /sys/devices/platform/GHES.0/error/throttles
> >>
> >> Where "logs" is number of error records logged; "throttles" is num=
ber
> >> of error records not logged because the reporting rate is too high=
;
> >> "overflows" is number of error records not logged because there is=
 no
> >> space available.
> >>
> >> Not all devices will report errors, so struct dev_herr_info and sy=
sfs
> >> directory/files are only allocated/created for devices explicitly
> >> enable it. =C2=A0So to enumerate the error sources of system, you =
just need
> >> to enumerate "error" directory for each device directory in
> >> /sys/devices.
> >
> > So how do you say which devices should report and which shouldn't r=
eport
> > errors, from userspace with a tool? Default actions? What if you fo=
rget
> > to enable error reporting of a device which actually is important?
>=20
> In general all hardware errors should be reported and logged.

So why the need to enable/disable them? Why add all that code to
enable/disable them when all devices can report hw errors but not all
do it but all should do it... (I can go on forever). Do you see the
spaghetti statement?

> >> One device file (/dev/error/error) which mixed error records from =
all
> >> hardware error reporting devices is created to convey error record=
s
> >> from kernel space to user space. =C2=A0Because hardware devices ar=
e dealt
> >> with, a device file is the most natural way to do that. =C2=A0Beca=
use
> >> hardware error reporting should not hurts system performance, the
> >> throughput of the interface should be controlled to a low level (d=
one
> >> by user space error daemon), ordinary "read" is sufficient from
> >> performance point of view.
> >
> > Right, so no need for a daemon but who does the read? cat? How are =
you
> > going to collect all those errors? How do you enforce policies?
>=20
> Some summary hardware error information can be put into printk. Error
> daemon is needed because we need not only log the the error but the
> predictive recovery. If you really have no daemon, cat can be used to
> log the error. I don't fully understand your words, you want to
> enforce policies without error daemon?

Sorry, I misread your original statement. So it is clear that we need
some kind of daemon to do some error post-processing.

>=20
> > How do you inject errors?
>=20
> We can use another device file to inject error, for example
> /dev/error/error_inject. Just write the needed information to this
> file. The format can be same as the error record defined as above,
> because it is highly extensible.

Same argument as above - you can do that with tracepoints without
duplicating functionality.

[.. ]

> >> A lock-less hardware error record allocator is provided. =C2=A0So =
for
> >> hardware error that can be ignored (such as corrected errors), it =
is
> >> not needed to pre-allocate the error record or allocate the error
> >> record on stack. =C2=A0Because the possibility for two hardware pa=
rts to go
> >> error simultaneously is very small, one big unified memory pool fo=
r
> >> hardware errors is better than one memory pool or buffer for each
> >> device.
> >
> > Yet another bloat winner. Why do we need a memory allocator for err=
or
> > records?
>=20
> The point is lockless not the memory allocator. The lockless memory
> allocator is not hardware error reporting specific, it can be used by
> other part of the kernel too.

Wait a second, are we talking about hardware errors or memory managemen=
t
here? If you want to push your lockless memory allocator, send it in to
linux-mm and let the guys there look at it, but not in conjunction with
hw errors. That's like I'm going for a run and, btw, while I'm at it, I
can buy a coffee machine.

> > You either get a single critical error which shuts down the
> > system and you log it to persistent storage, if possible, or you wo=
rk at
> > those uncritical errors one at a time.
>=20
> Uncritical errors can be reported in NMI handler too. So we need
> lockless data structure for them.

Why? What's wrong with using a single struct on the stack? Are you
afraid that we might blow the NMI stack although NMIs don't nest?

[.. ]

Dude, let me save you the trouble: all everybody is trying to say is
that you can achieve all that with stuff already available in the
kernel. And HW errors are not that special to need a special subsystem
grown for them - you just need to handle them properly. The only thing
you should provide is the backend to persistent storage so that error
info can be put there - everything else is bloat.

--=20
Regards/Gruss,
    Boris.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
