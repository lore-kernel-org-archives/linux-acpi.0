From: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Subject: RE: _OSI (Re: Re: cvs commit: src/sys/contrib/dev/acpica
 acfreebsd.h)
Date: Wed, 17 Mar 2004 14:45:27 -0800 (PST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040317144333.G3595@root.org>
References: <3ACA40606221794F80A5670F0AF15F8401CBB748@PDSMSX403.ccr.corp.intel.com>
  <20040311200031.J67848@root.org> <1079073556.3868.37.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1079073556.3868.37.camel-D2Zvc0uNKG8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Robert Moore <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, 12 Mar 2004, Len Brown wrote:
> On Thu, 2004-03-11 at 23:00, Nate Lawson wrote:
> > On Thu, 11 Mar 2004, Yu, Luming wrote:
> > > > On Wed, 11 Mar 2004, Len Brown wrote:
> > > > > On Wed, 2004-03-10 at 21:26, Nate Lawson wrote:
> > > > > > Bob, any word on _OSI implementation?
> > > > >
> > > > > Bob sent me an initial implementation for review today;-)
> > > > >
> > > > > I'm uncomfortable, however, at claiming to be compatible
> > > > with Windows,
> > > > > since I don't really have a definition of exactly what that means...
> > > > >
> > > > > -Len
> > > >
> > > > Doesn't matter to me.  I plan on claiming to be everything from Win 2k
> > > > onward and sort out the rest on the mailing list.  :)
> > > >
> > > > We already fixed some problems by claiming to be Win 2k for _OS.
> > > >
> > >
> > > Cool! what kind of problems?  :)
> >
> > PCI routing.
> >
> > -Nate
>
> You don't need to tempt me any more than that!;-)
>
> While I don't like blindly claiming compatibility with something that is
> neither specified nor visible, I *do* like the idea of causing the AML
> to follow the *tested* path that it follows under Windows.

OSI is different than _OS.  _OS is a static string, OSI means you can
support the behavior of the string passed in.  Since Win2k was the first
OS that really supported ACPI and the tests for strings for Win98 and ME
in the ASL are usually to disable functionality/workaround bugs, I think
it's very reasonable to claim compliance with all Win2k and above
versions.

-Nate


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
