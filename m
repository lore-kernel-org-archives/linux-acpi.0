From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: Runlevel for Sleep?
Date: Sat, 7 Sep 2002 00:29:30 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020906222930.GE8827@atrey.karlin.mff.cuni.cz>
References: <20020906122153.F39@toy.ucw.cz> <Pine.LNX.4.44.0209061411390.1021-100000@cherise.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209061411390.1021-100000-yZQdDDOm3n9ZQn2sFP3R7eTW4wlIGRCZ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Patrick Mochel <mochel-3NddpPZAyC0@public.gmane.org>
Cc: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "'P. Christeas'" <p_christ-U04EIuiosng@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> > I believe 3 of them are needed - S1, S3 and S4. 
> 
> I agree that we need to do some amount of user-level work before we go to 
> sleep, but I'm not sure that a runlevel is the proper way to implement it. 
> 
> Unless you implemented a new runlevel for every possible sleep state for 
> every possible platform suspend mechanism, how would pass what suspend 
> state you wanted to enter? 
> 
> You don't really want to have a different one for S1, S3, and S4 because 
> they are ACPI specific, both in terms of their names and what they mean. 
> I don't think you could create a clean, sensible solution like that, that 
> worked for all platforms...

Okay, we can probably forget S1 and create arch-neutral
"suspend-to-disk" and "suspend-to-ram".

I'm not 100% sure runlevels are the right way, but they certainly look
better than special-purpose script.

...and we already have one for halt, which is just S5....

> You could have one runlevel, and pass the state we're entering somehow. 
> But, we would need to get that from init(8) to reboot(2) [1]. That way we 
> could use standard rc scripts for doing all the dirty little things we 
> need to before we sleep. 
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
