From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: [rfc] generic testing ACPI module
Date: Fri, 12 Mar 2004 15:42:41 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040312144241.GA1236@openzaurus.ucw.cz>
References: <1079038411.18351.25.camel@t40> <20040311211005.GM2148@parcelfarce.linux.theplanet.co.uk> <1079041694.5429.58.camel@t40> <20040311225032.GN28592@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20040311225032.GN28592-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: Paul Ionescu <paul-f7LjuT9/YZU@public.gmane.org>, Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>, acpi <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

> > > There's actually something much better that could be done.  Look in
> > > /sys/firmware/acpi/.  There's no files created in this hierarchy
> > > currently.  What we should do is create a file for each method.
> > > Reading from it should execute that method and return the result.
> > > This is useful in so many ways, it's not even funny.
> > 
> > Yes, your remark is good.
> > I was thinking of that too, but I thought it is more difficult to
> > implement it than a single separate module which can be disabled if
> > neccessary(or buggy).
> > Now that you mentioned it, I preffer your approach, because is more
> > logical and streamlined than the dirty hack I proposed, and I came with
> > the following additions:
> > 
> > Each object/device should have his methods as files in
> > /sys/firmware/acpi/ hierarchy.
> > To access a method, we should first "echo <arg1> ... <argn> > METHOD" to
> > set the arguments for that method, and when we "cat" the method, it
> > actually executes the method with our arguments, and return the result.

Does not work; what if two people attempt to run the method
at same time?

> Ugly.  Better I guess is to implement an ioctl in order to execute method.
> At least, that will give you atomic access to that method.

But ioctls are even worse. Why not simply
	open METHOD
	write PARAMETERS
	read RESULTS
	close

its slightly more tricky from shell, but doable too...
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
