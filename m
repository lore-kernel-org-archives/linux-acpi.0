From: Paul Ionescu <paul-f7LjuT9/YZU@public.gmane.org>
Subject: Re: [rfc] generic testing ACPI module
Date: Sat, 13 Mar 2004 15:41:12 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1079185271.5429.169.camel@t40>
References: <1079038411.18351.25.camel@t40>
	 <20040311211005.GM2148@parcelfarce.linux.theplanet.co.uk>
	 <1079041694.5429.58.camel@t40> <20040311225032.GN28592@poupinou.org>
	 <20040312144241.GA1236@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040312144241.GA1236-u08AdweFZfgxtPtxi4kahqVXKuFTiq87@public.gmane.org>
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

On Fri, 2004-03-12 at 16:42, Pavel Machek wrote:
> > > Each object/device should have his methods as files in
> > > /sys/firmware/acpi/ hierarchy.
> > > To access a method, we should first "echo <arg1> ... <argn> > METHOD" to
> > > set the arguments for that method, and when we "cat" the method, it
> > > actually executes the method with our arguments, and return the result.
> 
> Does not work; what if two people attempt to run the method
> at same time?
Well, my proposal was not for production kernels, it was simply a
testing module that would help people play with various ACPI
methods/events on their machines to find out what works and what not,
and that is only enabled when ACPI debugging is compiled in and maybe
some other option like "acpi testing".
So, this should not be an issue, however, if really neccesary, one can
implement file locking like for serial ports.

The result of playing with this module should be an ACPI driver for that
machine/family of machines.
Now, I realize there are a lot of different types of machines outthere,
and a kernel module for each of them is not practical, so we need to
think in the future what to implement in kernel in order to make
possible user space acpi drivers.
But this is another story.

Best regards,
Paul Ionescu



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
