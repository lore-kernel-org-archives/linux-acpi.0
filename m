From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: _OSI (Re: Re: cvs commit: src/sys/contrib/dev/acpica
	acfreebsd.h)
Date: 12 Mar 2004 01:39:16 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1079073556.3868.37.camel@dhcppc4>
References: <3ACA40606221794F80A5670F0AF15F8401CBB748@PDSMSX403.ccr.corp.intel.com>
	 <20040311200031.J67848@root.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040311200031.J67848-Y6VGUYTwhu0@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Cc: Luming Yu <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Robert Moore <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, 2004-03-11 at 23:00, Nate Lawson wrote:
> On Thu, 11 Mar 2004, Yu, Luming wrote:
> > > On Wed, 11 Mar 2004, Len Brown wrote:
> > > > On Wed, 2004-03-10 at 21:26, Nate Lawson wrote:
> > > > > Bob, any word on _OSI implementation?
> > > >
> > > > Bob sent me an initial implementation for review today;-)
> > > >
> > > > I'm uncomfortable, however, at claiming to be compatible
> > > with Windows,
> > > > since I don't really have a definition of exactly what that means...
> > > >
> > > > -Len
> > >
> > > Doesn't matter to me.  I plan on claiming to be everything from Win 2k
> > > onward and sort out the rest on the mailing list.  :)
> > >
> > > We already fixed some problems by claiming to be Win 2k for _OS.
> > >
> >
> > Cool! what kind of problems?  :)
> 
> PCI routing.
> 
> -Nate

You don't need to tempt me any more than that!;-)

While I don't like blindly claiming compatibility with something that is
neither specified nor visible, I *do* like the idea of causing the AML
to follow the *tested* path that it follows under Windows.

thanks,
-Len
 



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
