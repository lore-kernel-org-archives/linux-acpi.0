From: Patrick Mochel <mochel-3NddpPZAyC0@public.gmane.org>
Subject: Re: Runlevel for Sleep?
Date: Sat, 7 Sep 2002 12:51:35 -0700 (PDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.44.0209071232170.1021-100000@cherise.pdx.osdl.net>
References: <1031374944.1530.44.camel@rodan.monsters.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1031374944.1530.44.camel-EWEM0Crkbjs/2vX+WiJxEB2eb7JE58TQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Stephen L Johnson <sjohnson-WpdXj7kV/NVg9hUCZPvPmw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


On 7 Sep 2002, Stephen L Johnson wrote:

> I've been involved with the Linux on PDAs/handheld computers over at
> http://www.handhelds.org/. They have to deal with the exact same issues
> suspend/resumes issues with drivers and user-space issues. Although they
> major concern is just with suspending in memory.
> 
> Over the past several versions of Familiar (a linux distrubution for
> handhelds) a method for dealing with user space suspend and resume
> issues have been developer. It is working quite well. 
> 
> The kernel calls a user space program called pmhelper with a "suspend"
> or "resume" parameter. On a suspend, pmhelper is called before the
> kernel  suspends the drivers. And on a resume it's called after the
> kernel resumes the drivers. 

That's not bad, but I see two problems:

- The suspend transition is usually initiated from user input, i.e. 
userspace. So, userspace would be calling into the kernel, which would be 
calling back to userspace, and returning back to the kernel to finish it 
up. 

It seems much easier to do the work you need in userspace, then transfer 
control over to the kernel once and for all.

- The standard mechanism for calling into userspace is /sbin/hotplug. 
There is NWIH you'll be able to sneak another mechanism into the kernel. 
So, being stuck with /sbin/hotplug, you run into the problem that it 
executes asynchronously. You want to wait for the userspace stuff to 
finish before you continue suspending, so you'd have to add yet more code 
to wait for notification from userspace...

> The pmhelper program on familiar calls a series of scripts in
> /etc/suspend-scripts/ or /etc/resume-scripts/ (depending on the pending
> state). The scripts are run in a SysV boot-script way. The scripts are
> named nnScriptName where nn are numbers. 

For Midori Linux (a distro for the all-but-dead x86 internet appliance
market), we rewrote the init script hoo-haw to be similar to this thing
called simpleinit. (A dependency graph was constructed so we could execute
the init scripts in parallel). Suspend was initiated via a GUI or script, 
which triggered init to run, passing 'suspend' to all the init scripts 
(and 'resume' on Resume).

In essence, we're going to be doing something similar. It's just a matter 
of how we articulate it. Also, remember that we must do the converse 
action on resume (call all the init scripts again). But, is that really a 
runlevel transition? We'd be transferring back from 7 (or whatever) to 3 
or 5. But, we don't want to restart everything; only the stuff that we 
suspended.

Are there any ideas from some of the older-school people? How exactly does 
APM do it? 


	-pat



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
