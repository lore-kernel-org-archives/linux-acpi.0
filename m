From: Paul Ionescu <paul-f7LjuT9/YZU@public.gmane.org>
Subject: Re: [rfc] generic testing ACPI module
Date: Sat, 13 Mar 2004 15:31:07 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1079184667.5429.158.camel@t40>
References: <1079038411.18351.25.camel@t40>
	 <20040311211005.GM2148@parcelfarce.linux.theplanet.co.uk>
	 <1079041694.5429.58.camel@t40> <20040311225032.GN28592@poupinou.org>
	 <20040312144241.GA1236@openzaurus.ucw.cz>
	 <20040312175724.GP28592@poupinou.org>
	 <20040312195912.GA2153@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040312195912.GA2153-u08AdweFZfgxtPtxi4kahqVXKuFTiq87@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>, acpi <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi Pavel,

That should be ok.
For the long term, it sounds reasonable to do it this way if kernel
developers agree this usage of sysfs filesystem.
I just remembered one discution from last weeks, that files in sysfs
have to accept only one value, and output only one value (or something
like this).
I don't know if I got it right, but if this is the case, we should
either move this tree in /proc/acpi/somewhere, or create some other
files under each method like {parm1,parm2,parmN,result1,result2,resultN}
depending of what that particular method takes as arguments and values
it return.
Some locking mecanism should be used to be sure that only one program is
unsing it a a time.
Anyway, this will take time to implement it, but it may have a future.
What I am looking for right now, is to have a VERY SMALL module template
of an acpi driver for accessing a method with some parameters, and for
installing a notify handler on an object in order to receive some events
in acpid when that object receives a notify. And it should operate with
full path ACPI objects.

I don't even want it to be included in main kernel, it can live at acpi
site, like the patch for putting your own DSDT table in kernel.

I am willing to develop one, but I need a small template because I don't
know much about acpi in kernel, and I don't really have a lot of free
time to learn it.
But if a template would exist, it would be much easyer for me to just
modify it to suit my needs.




On Fri, 2004-03-12 at 21:59, Pavel Machek wrote:
> Hi!
> 
> > > But ioctls are even worse. Why not simply
> > > 	open METHOD
> > > 	write PARAMETERS
> > > 	read RESULTS
> > > 	close
> > > 
> > 
> > Because I'm too stupid to thing of your solution, I guess.
> 
> Well, instead of doing ioctls on special file, you can simply do
> write syscall (telling driver parameters for the method) then read
> syscall on same filedescriptor. That is not racy, and it is
> less hacky then ioctl()
> 				Pavel



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
