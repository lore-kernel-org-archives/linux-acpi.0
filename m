From: David Douard <douard-m7abxLq4WJJQFI55V6+gNQ@public.gmane.org>
Subject: Re: Re: kacpid and my daemon
Date: Wed, 24 Jul 2002 01:00:07 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200207240100.07822.douard@pl.ecp.fr>
References: <200204051427.g35ERYM20814@foobar.pps.jussieu.fr> <200207221802.52785.douard@pl.ecp.fr> <87bs8y768s.fsf@trurl.cs.unibo.it>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <87bs8y768s.fsf-ijrYHC+MxHL85LLnhfSrOV6hYfS7NtTn@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Juliusz Chroboczek <jch-klhGwnj84BUD5ynB6aAmlA@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Le Mardi 23 Juillet 2002 18:34, Juliusz Chroboczek a écrit :
> DD> But, I have written a little user space deamon (fansd) which
> periodically DD> check themperature, and decide wether or not turn on/off
> fan. Because that DD> feature does not work out of my (very patched DSDT)
> ACPI system.
>
> That's weird -- it would appear that ACPI does properly export thermal
> zones and fans to userspace, but OSPM (the kernel-side
> power-management code) doesn't manage them?  I'd be curious to know
> how that can happen.

Yes it seems things happen like that. Note that I had to patch my DSDT to get 
batt and thermal working (among others). I think the problem comes from the 
bios/hardware, and not from OSPM (the ASL code is sooo buggy, I always thinks 
problems come from it. A buggy code like that is really some piece of art !). 
Because it seems that when temperature cross a limit (a trip point), no event 
is send to or catched by the EC. 
My trip-points are (active cooling mode): 

critical (S5):           98 C
passive:                 90 C: tc1=2 tc2=3 tsp=40 devices=0xc12f88e8
active[0]:               75 C: devices=0xc12f1e68
active[1]:               59 C: devices=0xc12f1868

And it is correctly updated if I change the cooling mode.
For instance, I am now compiling QT/embedded, so CPU is burning full speed, my 
temperature is 68 C, and my current thermal_zone state :
state:                   active[0]

which does not cerrespond to anything since my fan is on (low speed) only 
thanks to my dirty little daemon.

Now I've let temperature fall down to 57 C, and the thermal_zone state is 
still the same... 

And I never get thermal zone events (in my logfile,debugs on). 

>
> DD> The strange thing is that every time my deamon decide to change
> DD> the state of the fans, I have a zombi process which ps trace is :
>
> DD> note that 4609 is the PID of my fan daemon. I cannot make those process
> be DD> collected and eliminated but my killing my deamon...
>
> I've noticed this too, and I believe it's a bug in either ACPI's or
> the kernel's code for dealing with /proc; I haven't found the time to
> debug it, though.
>
> Could you check (with strace) whether all the ``close'' system calls
> in your code are successful?

I'll do that as soon as I can.

Thanks,
David


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
