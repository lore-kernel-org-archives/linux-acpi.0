From: Patrick Mochel <mochel-3NddpPZAyC0@public.gmane.org>
Subject: RE: Runlevel for Sleep?
Date: Sat, 7 Sep 2002 12:56:58 -0700 (PDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.44.0209071251410.1021-100000@cherise.pdx.osdl.net>
References: <EDC461A30AC4D511ADE10002A5072CAD0236DE22@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <EDC461A30AC4D511ADE10002A5072CAD0236DE22-OU+JdkIUtvd9zuciVAfUoVDQ4js95KgL@public.gmane.org>
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


On Fri, 6 Sep 2002, Grover, Andrew wrote:

> > From: Patrick Mochel [mailto:mochel-3NddpPZAyC0@public.gmane.org] 
> > [1] Once upon a time (last May), I implemented a patch that 
> > overloaded the
> > reboot(2) system call to initiate suspend transitions in a
> > platform-specific manner (as per Linus's suggestion). This is in the
> > resurrection queue and will probably resurface soon. 
> 
> Hmm.
> 
> Maybe it would be cleaner to give sleep its own system call.
> 
> Having reboot(2) overloaded with suspend functionality is a little
> non-intuitive. Just a thought.

That's what I did initially, but I was encouraged instead to overload 
reboot. And, it does make quite a bit of sense considering the following:

- syscall numbers are few and very difficult to get. We'd be taking one
that only makes sense on a subset of the x86 platforms out there and on a
subset of the total architectures (though this subset accounts for
probably 95% of the install base).

- reboot(2) is a power transition. suspend(2) is a power transition. 
Conceptuallly, they're similar. They are functionally, too. 

- swsusp already has a hook in it.


	-pat



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
