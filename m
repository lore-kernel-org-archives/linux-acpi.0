From: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Subject: Re: [rfc] generic testing ACPI module
Date: Thu, 11 Mar 2004 21:10:05 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040311211005.GM2148@parcelfarce.linux.theplanet.co.uk>
References: <1079038411.18351.25.camel@t40>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1079038411.18351.25.camel-LjAuIDrFwz0@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Paul Ionescu <paul-f7LjuT9/YZU@public.gmane.org>
Cc: acpi <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, Mar 11, 2004 at 10:53:31PM +0200, Paul Ionescu wrote:
> I have this idea and I want your comments about it.
> I think it would be nice and usefull to have a generic acpi testing
> module like other testing modules in kernel (scsi and pci hotplug just
> came to my mind, but maybe there are some others too).
> 
> The proposition is this:
> A module that exports some files in let say /proc/acpi/testing/
> directory.
> One of the files could be a file where we can insert the full path name
> of a method we want to run, and after that the driver will make that
> full path another file in /proc/acpi/testing/ and when we access that
> file, we actualy run the acpi method.
> 
> Example: 
> echo \_SB_.PCI0.LPC_.EC__._Q13 > /proc/acpi/testing/new_method
> and a new file with the name \_SB_.PCI0.LPC_.EC__._Q13 is created in
> /proc/acpi/testing/ directory. When we cat this new file, we'll get the
> resut of executing that method.

There's actually something much better that could be done.  Look in
/sys/firmware/acpi/.  There's no files created in this hierarchy
currently.  What we should do is create a file for each method.
Reading from it should execute that method and return the result.
This is useful in so many ways, it's not even funny.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
