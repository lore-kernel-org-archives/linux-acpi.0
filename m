From: Patrick Mochel <mochel-3NddpPZAyC0@public.gmane.org>
Subject: Re: suspend.c vs driver-model.txt
Date: Mon, 29 Jul 2002 15:36:13 -0700 (PDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.44.0207291525560.22697-100000@cherise.pdx.osdl.net>
References: <20020724173809.10194@192.168.4.1>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20020724173809.10194-Q0ErXNX1RuY/GWcAdfcqrQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Sorry about the delay in responding...

> >The platform drivers need to then do whatever device transitions they 
> >need, using the device_suspend() helpers, then put the system to sleep 
> >using their platform-speciifc method.
> 
> Good ! I've had my home-made bunch of stuff on pmac that looked just
> like a platform driver dealing with all sort of things (basically
> abtracting motherboard IOs to help drivers that need to toggle whatever
> reset pin or power their device up/down physically).
> (See include/asm-ppc/pmac_feature.c and arch/ppc/kernel/pmac_feature.c)
> 
> On PPC, we also have that _huge_ flat ppc_md structure that contains
> pointers to functions like platform init, cpuinfo hooks, get/set_rtc_time,
> irq hooks, etc... that get filled depending on the type of machine a
> given kernel is booted (we support currently prep, chrp and pmac with
> a single kernel binary).
> (see include/asm-ppc/machdep.h)
> 
> What about generalizing the platform driver to do just those things ?
> 
> I'm not too sure about how the API would look like though. For the
> ppc_md stuff, there is a fixed, well defined, but still arch specific
> set of hooks to fill.
> 
> For the pmac_feature, I use a single ppc_md. hook with variable arg
> list (though I do use it in a well defined format) to call a list
> of "feature" functions that is usually exetended on every new kind
> of motherboard I add support for. Not every machine support all
> functions, etc... it would probably be a pain to define this as a
> flat list of function pointers.
> 
> Anybody has better ideas on how to deal with those platform specific
> things while still making them fit in a platform driver (their logical
> place, especially if the platform driver ends up in driverfs, a nice
> way to expose some motherboard specific settings/tweaks to userland ?

That's what the platform_notify() function pointer is for - to have the 
platform/firmware driver set device-specific information when it's 
registered. How you want to implement is up to you, and unfortunately 
there are no examples (yet). 

When you do get the call, you can simply create driverfs files with common 
handlers for the platform-specific attributes. How you map the device 
pointer that you get to the data is left as an exercise to the reader. ;)

> I don't know ACPI well enough to talk, but the mecanism I use on PPC
> is pretty basic today. The sleep procedure is dealt with by the driver
> of the Power Management chip when it gets a sleep request from userland,
> but that can (should be) moved to the platform driver.
> 
> Then, it does my own version of looping all devices sending them
> suspend events etc... (did we ever write down what we defined during
> OLS for those events semantics ?)

Yes. I'll try and get to them this week. (Operative word: try).

> This end up breaking the scenario into 2 main phases
> 
>  1) Looping around all drivers doing the suspend dance (suspend request,
> save_state & suspend, ...) as we discussed. This is mostly (completely ?)
> platform independant (except for the exact state a given device has to
> be put to, oh well, let's deal that inside the device driver for now)
> 
>  2) Doing whatever additional arch specific code is needed to snooze
> the machine.
> 
> 1) is generic. 2) is arch/platform code.

Yes, that's basically what we discussed, and the right way to go. We have
helper functions that walk the device list, doing what ever
platform-speciifc stuff in the meantime. (Similar to how ACPI does it 
today). 

There are just other details, like actually getting it right, and having 
the transition functions get called from a common place. And, making sure 
it looks the same to userspace. 

> As far as suspend to disk is concerned, we have all sort of nasty issues
> we discussed that I don't feel like resuming right now, so I would rather
> have the lowest level driver able to play the backing store export a
> couple of "hooks" used to dump the pages to the medium, those would work
> synchronously, without VM activity, etc... The driver that is target for
> that would have pre-allocated what it needs, pre-mapped DMA mappings it
> needs etc...
> Though, thinking as I write, injecting requests via the BIO layer may
> be a nicer solution, provided we make sure the driver won't get any
> request _but_ the ones we feed it. I don't trust a mecanism that would
> selectively stop given kernel threads, then just hope nobody will push
> requests any more. That's way too fragile to my taste. I'd rather freeze
> the request queue for real like any other device, then eventually provide
> a special pass-through.

I'm not going to comment, because I don't know the stuff well enough. 

> I'm probably to blame for not writing code here as I mostly only
> contributed with speetch and ideas (and my old pmac code) so far.
> I'm sorry, i'm not even been able to find time to convert the pmac
> drivers to driverfs yet :( My time dedicated to linux is spare, and
> so variable, and it tends to be quite small nowadays.

No need to apologize. I cc'ed you because you've always been incredibly 
helpful in keeping me honest. As much as I think you should quit your job 
and dedicate your life to getting Linux power management right, I realize 
that I'm being a bit unrealistic, and I have to life with the intermittent 
code. 

	-pat



-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
