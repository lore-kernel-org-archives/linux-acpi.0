From: Patrick Mochel <mochel-3NddpPZAyC0@public.gmane.org>
Subject: Re: Runlevel for Sleep?
Date: Fri, 6 Sep 2002 14:40:43 -0700 (PDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.44.0209061411390.1021-100000@cherise.pdx.osdl.net>
References: <20020906122153.F39@toy.ucw.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20020906122153.F39-muQmgwBScQHrBKCeMvbIDA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Cc: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "'P. Christeas'" <p_christ-U04EIuiosng@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


On Fri, 6 Sep 2002, Pavel Machek wrote:

> Hi!
> 
> > Right now I am leaning towards no. We don't have a runlevel for APM's
> > suspend, why would we for ACPI sleep?
> 
> I believe we should have it for APM, too.
> 
> umounting nfs seems like good idea, and no ammount of drivers will fix that.
>
> > I think we'll know better once we have working device power management if a
> > new runlevel is needed or not.
> 
> I believe 3 of them are needed - S1, S3 and S4. 

I agree that we need to do some amount of user-level work before we go to 
sleep, but I'm not sure that a runlevel is the proper way to implement it. 

Unless you implemented a new runlevel for every possible sleep state for 
every possible platform suspend mechanism, how would pass what suspend 
state you wanted to enter? 

You don't really want to have a different one for S1, S3, and S4 because 
they are ACPI specific, both in terms of their names and what they mean. 
I don't think you could create a clean, sensible solution like that, that 
worked for all platforms...

You could have one runlevel, and pass the state we're entering somehow. 
But, we would need to get that from init(8) to reboot(2) [1]. That way we 
could use standard rc scripts for doing all the dirty little things we 
need to before we sleep. 

	-pat

[1] Once upon a time (last May), I implemented a patch that overloaded the
reboot(2) system call to initiate suspend transitions in a
platform-specific manner (as per Linus's suggestion). This is in the
resurrection queue and will probably resurface soon. 

This allows every platform to use the same mechanism for suspending. Of 
course some suspend states are platform-specific, but a few are generic 
(suspend to ram, suspend to disk). The userspace caller would pass the 
platform-specific state. sys_reboot() simply passes that on to the 
platform-supplied callback..





-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
