From: Paul Ionescu <paul-f7LjuT9/YZU@public.gmane.org>
Subject: Re: [rfc] generic testing ACPI module
Date: Sat, 13 Mar 2004 23:31:54 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1079213514.8073.36.camel@t40>
References: <1079038411.18351.25.camel@t40>
	 <20040311211005.GM2148@parcelfarce.linux.theplanet.co.uk>
	 <1079041694.5429.58.camel@t40> <20040311225032.GN28592@poupinou.org>
	 <20040312144241.GA1236@openzaurus.ucw.cz> <1079185271.5429.169.camel@t40>
	 <20040313140059.GA3764@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040313140059.GA3764-u08AdweFZfgxtPtxi4kahqVXKuFTiq87@public.gmane.org>
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

The quick hack is for beginnig with something, which I think should
evolve in some interface to control the ACPI from userspace.
Will this be the way of making specific vendor ACPI drivers, or the
kernel based modules approach ?
We don't know yet, but if is not critical, kernel guys tend to push
things out of kernel space. And sometimes they are right.
So I considered the RFC for both quick hack and for the evolving
interface.
If I was wrong, please excuse my wasting of your time.

Best regards,

On Sat, 2004-03-13 at 16:00, Pavel Machek wrote:
> Hi!
> 
> > > Does not work; what if two people attempt to run the method
> > > at same time?
> > Well, my proposal was not for production kernels, it was simply a
> > testing module that would help people play with various ACPI
> > methods/events on their machines to find out what works and what not,
> 
> Well, if your goal is quick hack, then you should not bother 
> with requesting comments ([RFC]) and just post a patch...



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
