From: Sourav K Mandal <smandal-DPNOqEs/LNQ@public.gmane.org>
Subject: Re: Runlevel for Sleep?
Date: Tue, 03 Sep 2002 19:38:38 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200209032338.TAA23439@buzzword-bingo.mit.edu>
References: <200209032316.g83NGXl07988@pfn1.pefnos>
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: Your message of "Wed, 04 Sep 2002 02:13:22 +0300."
             <200209032316.g83NGXl07988-a1J+ToZc0kR3t0M9ZKkFCQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


> Let me explain:
> It may be one of the first times a linux system can properly sleep, given 
> that current boxes use lots of weird hardware, which may need special 
> handling. The init scripts handle just that, transitions between power states
 * 
> of the system. Should we 'reserve' one or two runlevels (say: 7, 8) for sleep
 * 
> and write init-scripts accordingly? (we may need to differentiate between S3 
> and S4)

I would second this idea.  Right now, when i suspend I have to do
a bunch of module loading/unloading cycles to keep my hardware from
freaking out.  I think a bunch of scripts in the init tree is better
than a bunch of scripts in root's home directory.


Sourav


> 
> In my personal case, I found I should set the clock and run 'anacron' 
> whenever I wake from sleep. A shell script is more than enough for them. I 
> should also unmount the nfs bafore sleeping, since it will time-out while 
> sleeping. Each user may add his own entries, according to his hw (including 
> bug cases where re-init at wake is needed) and software daemons. For example,
 * 
> bring down a ppp Internet connection..
> 
> Using special daemons and binaries to handle sleep preparation and wake 
> restoration may not be enough and will add extra running processes to the 
> system. Init is already there and has a suitable functionality.
> 
> 
> 
> -------------------------------------------------------
> This sf.net email is sponsored by: OSDN - Tired of that same old
> cell phone?  Get a new here for FREE!
> https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
