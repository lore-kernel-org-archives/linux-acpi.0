From: Patrick Mochel <mochel-3NddpPZAyC0@public.gmane.org>
Subject: RE: Runlevel for Sleep?
Date: Mon, 9 Sep 2002 09:36:51 -0700 (PDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.44.0209090926360.1021-100000@cherise.pdx.osdl.net>
References: <EDC461A30AC4D511ADE10002A5072CAD0236DE25@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <EDC461A30AC4D511ADE10002A5072CAD0236DE25-OU+JdkIUtvd9zuciVAfUoVDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


On Mon, 9 Sep 2002, Grover, Andrew wrote:

> > From: Patrick Mochel [mailto:mochel-3NddpPZAyC0@public.gmane.org] 
> > > Having reboot(2) overloaded with suspend functionality is a little
> > > non-intuitive. Just a thought.
> > 
> > That's what I did initially, but I was encouraged instead to overload 
> > reboot. And, it does make quite a bit of sense considering 
> > the following:
> 
> > - reboot(2) is a power transition. suspend(2) is a power transition. 
> > Conceptuallly, they're similar. They are functionally, too. 
> 
> I'm not clear on how reboot is a power transition. Isn't the machine in S0
> the whole time?

Rebooting and powering off seem like power transitions to me. Recall that 
'halt' is implemented using reboot(2). Regardless they are global state 
transitions. They may not be recognized by ACPI, but the system is in a 
new state after it's been rebooted. 

> Suspend seems closer to poweroff, to me at least.

Oh well. We don't get a new syscall; we get to overload reboot(2). 

> Although...why does this stuff need a syscall at all? Isn't driverfs enough?

Yes, driverfs would definitely suffice for this solution. But, using a
syscall divorces the mechanism from the volatility of the implementation.  
Syscalls are much more stable and be much more easily ported to other
kernel versions. The userspace application has to rely on only a hardcoded
number (that, using reboot(2) will likely _never_ change).


	-pat



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
