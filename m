From: Paul Ionescu <paul-f7LjuT9/YZU@public.gmane.org>
Subject: Re: [rfc] generic testing ACPI module
Date: Thu, 11 Mar 2004 23:48:14 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1079041694.5429.58.camel@t40>
References: <1079038411.18351.25.camel@t40>
	 <20040311211005.GM2148@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040311211005.GM2148-+pPCBgu9SkPzIGdyhVEDUDl5KyyQGfY2kSSpQ9I8OhVaa/9Udqfwiw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Cc: acpi <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, 2004-03-11 at 23:10, Matthew Wilcox wrote:

> There's actually something much better that could be done.  Look in
> /sys/firmware/acpi/.  There's no files created in this hierarchy
> currently.  What we should do is create a file for each method.
> Reading from it should execute that method and return the result.
> This is useful in so many ways, it's not even funny.

Hi Matthew,

Yes, your remark is good.
I was thinking of that too, but I thought it is more difficult to
implement it than a single separate module which can be disabled if
neccessary(or buggy).
Now that you mentioned it, I preffer your approach, because is more
logical and streamlined than the dirty hack I proposed, and I came with
the following additions:

Each object/device should have his methods as files in
/sys/firmware/acpi/ hierarchy.
To access a method, we should first "echo <arg1> ... <argn> > METHOD" to
set the arguments for that method, and when we "cat" the method, it
actually executes the method with our arguments, and return the result.

Each event capable object/device should have 2 additional files:
"system" and "device", and echo-ing 0 or 1 in this files should
install/deinstall a handler for this device for system or device events.

What do you think ?






-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
