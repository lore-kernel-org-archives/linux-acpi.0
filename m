From: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: suspend.c vs driver-model.txt
Date: Wed, 24 Jul 2002 19:38:09 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020724173809.10194@192.168.4.1>
References: <Pine.LNX.4.44.0207241100080.954-100000@cherise.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44.0207241100080.954-100000-yZQdDDOm3n9ZQn2sFP3R7eTW4wlIGRCZ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Patrick Mochel <mochel-3NddpPZAyC0@public.gmane.org>, Lyle <lwspm-RAHWjsxJnJUdnm+yROfE0A@public.gmane.org>
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


>
> .../...
>
>So, there needs to be a platform driver. See include/linux/platform.h and 
>kernel/platform.c for the start of this effort. There needs to be one of 
>these for each platform type. They need to be registered on startup, and 
>there needs to be prevention against multiple drivers being registered. 
>
>The platform drivers need to then do whatever device transitions they 
>need, using the device_suspend() helpers, then put the system to sleep 
>using their platform-speciifc method.

Good ! I've had my home-made bunch of stuff on pmac that looked just
like a platform driver dealing with all sort of things (basically
abtracting motherboard IOs to help drivers that need to toggle whatever
reset pin or power their device up/down physically).
(See include/asm-ppc/pmac_feature.c and arch/ppc/kernel/pmac_feature.c)

On PPC, we also have that _huge_ flat ppc_md structure that contains
pointers to functions like platform init, cpuinfo hooks, get/set_rtc_time,
irq hooks, etc... that get filled depending on the type of machine a
given kernel is booted (we support currently prep, chrp and pmac with
a single kernel binary).
(see include/asm-ppc/machdep.h)

What about generalizing the platform driver to do just those things ?

I'm not too sure about how the API would look like though. For the
ppc_md stuff, there is a fixed, well defined, but still arch specific
set of hooks to fill.

For the pmac_feature, I use a single ppc_md. hook with variable arg
list (though I do use it in a well defined format) to call a list
of "feature" functions that is usually exetended on every new kind
of motherboard I add support for. Not every machine support all
functions, etc... it would probably be a pain to define this as a
flat list of function pointers.

Anybody has better ideas on how to deal with those platform specific
things while still making them fit in a platform driver (their logical
place, especially if the platform driver ends up in driverfs, a nice
way to expose some motherboard specific settings/tweaks to userland ?

>The ACPI code that is in there is relatively close. I did that on purpose, 
>thinking that this stuff will be generalized someday. However, whatever 
>end solution that exists _must_ not be designed the behavior of ACPI. In 
>fact, I am hesitant talking about this general model on this list for fear 
>that someone that is already brainwashed by the Great Firmware Abomination 
>will say either "We can already do this!" or "I'll do it (in ACPI first 
>and generalize it)." 

I don't know ACPI well enough to talk, but the mecanism I use on PPC
is pretty basic today. The sleep procedure is dealt with by the driver
of the Power Management chip when it gets a sleep request from userland,
but that can (should be) moved to the platform driver.

Then, it does my own version of looping all devices sending them
suspend events etc... (did we ever write down what we defined during
OLS for those events semantics ?)

Then, calls the platform driver to deal with lower level motherboard
stuffs that haven't be done by any drivers and need to be done last

Finally it deals with the CPU (flushing caches, etc...).

I omitted intentionally the fact that it has to send a special command
to the power manager chip just before the low level mother board stuff,
that will cause that chip to shut the CPU down the next time it goes
to SLEEP state, which we do in the last step.

So most of this scenario is arch/platform specific cuisine. That is, all
but the first step has to be self contained somewhere in the platform
driver, those are arch/platform/cpu specific, nothing good we can do
about them.

This end up breaking the scenario into 2 main phases

 1) Looping around all drivers doing the suspend dance (suspend request,
save_state & suspend, ...) as we discussed. This is mostly (completely ?)
platform independant (except for the exact state a given device has to
be put to, oh well, let's deal that inside the device driver for now)

 2) Doing whatever additional arch specific code is needed to snooze
the machine.

1) is generic. 2) is arch/platform code.

The nice thing here, I beleive, is that suspend to disk could then just
be an additional generic step between 1) and 2) that takes care of
dumping memory content to disk.

As far as suspend to disk is concerned, we have all sort of nasty issues
we discussed that I don't feel like resuming right now, so I would rather
have the lowest level driver able to play the backing store export a
couple of "hooks" used to dump the pages to the medium, those would work
synchronously, without VM activity, etc... The driver that is target for
that would have pre-allocated what it needs, pre-mapped DMA mappings it
needs etc...
Though, thinking as I write, injecting requests via the BIO layer may
be a nicer solution, provided we make sure the driver won't get any
request _but_ the ones we feed it. I don't trust a mecanism that would
selectively stop given kernel threads, then just hope nobody will push
requests any more. That's way too fragile to my taste. I'd rather freeze
the request queue for real like any other device, then eventually provide
a special pass-through.

><harshness>
>The ACPI subsystem has a tendency to duplicate existing interfaces, or 
>come up with completely new ones, intending to be applicable to the rest 
>of the kernel. The are highly ACPI-centric, yet they expect them to be 
>standard. They aren't publicized or discussed on any list but this one. 
>But, they're left to be fixed up and cleaned up by the other people in the 
>community. 
>
>I refuse to lay blame on anyone for my inability to work faster or harder. 
>But, a lot of people complain that I've been working on this for a year, 
>and they still can't suspend their laptop. My rebuttal is that if I had 
>actually gotten cooperation and compromise at the source level, in many 
>areas, we probably wouldn't still be dealing with this. 
></harshness>

I'm probably to blame for not writing code here as I mostly only
contributed with speetch and ideas (and my old pmac code) so far.
I'm sorry, i'm not even been able to find time to convert the pmac
drivers to driverfs yet :( My time dedicated to linux is spare, and
so variable, and it tends to be quite small nowadays.

>So, someone needs to do it. I don't have time. And, I don't trust anyone 
>related to ACPI to do it right (except maybe Andy in a different context, 
>but he's overworked as it is). 

I've subscribed to this list, it may be a good oportunity to use it
for discussing & defining things at the API level now.

Regards,
Ben.




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
