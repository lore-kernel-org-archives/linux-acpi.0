From: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Subject: RE: cvs commit: src/sys/contrib/dev/acpica acfreebsd.h
Date: Thu, 11 Mar 2004 20:10:26 -0800 (PST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040311200951.O67848@root.org>
References: <CFF522B18982EA4481D3A3E23B83141C01E63981@orsmsx407.jf.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <CFF522B18982EA4481D3A3E23B83141C01E63981-sBd4vmA9Se6SsB6bSF6DdVDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

THANK YOU.  0311 looks like an EXCELLENT release.

-Nate

> -----Original Message-----
> From: Nate Lawson [mailto:nate-Y6VGUYTwhu0@public.gmane.org]
> Sent: Wednesday, March 10, 2004 6:27 PM
> To: Brian Buchanan
> Cc: Moore, Robert; acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: Re: cvs commit: src/sys/contrib/dev/acpica acfreebsd.h
>
> On Tue, 9 Mar 2004, Brian Buchanan wrote:
> > I hacked the ASL for my ThinkPad T40p so that "FreeBSD" was treated as
> an
> > equivalent to "Windows 2001".  After your change, the Fn+F8 screen
> > expansion toggle stopped working.
> >
> > I've attached the acpidump output you requested.  My local
> modification
> > was to add after the check for "Windows 2001":
> >
> > If (LEqual (\SCMP (\_OS, "FreeBSD"), Zero))
> > {
> >     Store (0x02, \WNTF)
> > }
>
> The issue is that we don't support the _OSI method yet, otherwise we
> could
> advertise FreeBSD as being both Windows 2k and XP compatible.  Your best
> workaround is to just unconditionally store 0x02 into \WNTF at the end
> of
> the \_SB._INI function.  Since the custom AML will only be loaded by
> FreeBSD, you won't affect other OS's with this change.
>
> Bob, any word on _OSI implementation?
>
> -Nate


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
