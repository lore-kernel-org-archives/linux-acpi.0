From: Patrick Mochel <mochel-3NddpPZAyC0@public.gmane.org>
Subject: Re: suspend.c vs driver-model.txt
Date: Wed, 24 Jul 2002 11:25:13 -0700 (PDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.44.0207241100080.954-100000@cherise.pdx.osdl.net>
References: <20020724163701.D99F714808@o-o.yi.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20020724163701.D99F714808-RAHWjsxJnJUdnm+yROfE0A@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Lyle <lwspm-RAHWjsxJnJUdnm+yROfE0A@public.gmane.org>
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


On Wed, 24 Jul 2002, Lyle wrote:

> 
> > You're right, there should be an explicit call to disable I/O for the 
> > devices. 
> > 
> > On a side, though related, note, while we were in Ottawa, several of us 
> > had a chance to sit down and hammer out exactly what needs to take place. 
> > The results exist in a notebook (a real, pencil-driven one), but have not 
> > had a chance to be expressed in ASCII text yet. (Frankly, it's a low 
> > priority right now: -EPLATEFULL). 
> 
> Is there any chance that I can transcribe the notes into ASCII for you?  
> Or are they too arcane?  Could you at least scan them?

I don't do the scanning thing. :) 

I would love to pass it off on someone, but there's a lot of context 
involved. 

Basically, what we need is for someone to develop a general power 
management model for the kernel. The path to implementation is partially 
complete, but someone needs to fill in the blanks, and make sure that 
other platforms are accounted for. 

The mechanism for transition should be a driverfs file which a user or app 
can write to. There could also be a hook into the sys_reboot() call. 

The handler for this is generic. There will likely be generic power 
management transitions, like swsusp. But, there will always be 
platform-specific transitions, and platform-specific operations for even 
the generic transitions. So, the generic handler needs to pass the command 
to the "platform driver". 

So, there needs to be a platform driver. See include/linux/platform.h and 
kernel/platform.c for the start of this effort. There needs to be one of 
these for each platform type. They need to be registered on startup, and 
there needs to be prevention against multiple drivers being registered. 

The platform drivers need to then do whatever device transitions they 
need, using the device_suspend() helpers, then put the system to sleep 
using their platform-speciifc method.

The ACPI code that is in there is relatively close. I did that on purpose, 
thinking that this stuff will be generalized someday. However, whatever 
end solution that exists _must_ not be designed the behavior of ACPI. In 
fact, I am hesitant talking about this general model on this list for fear 
that someone that is already brainwashed by the Great Firmware Abomination 
will say either "We can already do this!" or "I'll do it (in ACPI first 
and generalize it)." 

<harshness>
The ACPI subsystem has a tendency to duplicate existing interfaces, or 
come up with completely new ones, intending to be applicable to the rest 
of the kernel. The are highly ACPI-centric, yet they expect them to be 
standard. They aren't publicized or discussed on any list but this one. 
But, they're left to be fixed up and cleaned up by the other people in the 
community. 

I refuse to lay blame on anyone for my inability to work faster or harder. 
But, a lot of people complain that I've been working on this for a year, 
and they still can't suspend their laptop. My rebuttal is that if I had 
actually gotten cooperation and compromise at the source level, in many 
areas, we probably wouldn't still be dealing with this. 
</harshness>

So, someone needs to do it. I don't have time. And, I don't trust anyone 
related to ACPI to do it right (except maybe Andy in a different context, 
but he's overworked as it is). 


	-pat



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
