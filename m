From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: RE: ACPI -- Workaround for broken DSDT
Date: Thu, 12 Feb 2004 11:19:57 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040212101957.GS13262@poupinou.org>
References: <BF1FE1855350A0479097B3A0D2A80EE0CC8AB6@hdsmsx402.hd.intel.com> <1075964148.5017.7.camel@tinny.home.foo> <20040209122256.K74314@root.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20040209122256.K74314-Y6VGUYTwhu0@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Cc: "Scott T. Smith" <scott-j3vAvQ9dNB9ByuSxxbvQtw@public.gmane.org>, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Feb 09, 2004 at 12:29:45PM -0800, Nate Lawson wrote:
> On Wed, 4 Feb 2004, Scott T. Smith wrote:
> > On Wed, 2004-02-04 at 21:15, Brown, Len wrote:
> > > Windows doesn't have to do anything.  By being first to ship ACPI, that
> > > implementation provided the defacto ACPI compliance test to which all
> > > BIOS' are tested -- even if that implementation is not ACPI spec
> > > compliant.  No, only under dire circumstances will we emulate Windows
> > > bugs in Linux.
> >
> > So basically we shouldn't use ACPI then, and instead use APM?
> >
> > If Linux ACPI could emulate the bugs that Windows has, then ACPI would
> > work on Linux on most platforms right away.  That would make Linux more
> > accessible to people.  Linux already has a bunch of hacks to support
> > broken hardware which presumably Windows can work around; this seems to
> > be just another one of those.
> 
> We're doing something slightly different with ACPI on FreeBSD.  We add
> hacks^Wworkarounds for buggy DSDT whenever possible but they are under a
> kernel option, #ifndef ACPICA_PEDANTIC.  The default is for this option to
> give maximum compatibility with the stock DSDT, at the expense of spec
> correctness.  However, by adding that option and compiling a kernel, OEMs
> could test against ACPI-CA as a reference implementation while ordinary
> users get maximum compatibility.
> 
> I think the ACPI-CA developers should take a similar tact.  Len, who is on
> the Linux side, could suggest distribution maintainers use the option that
> gives maximum Windows compatibility when shipping a distro.  Bob, who is

I strongly discourage that a Linux distribution maintainer will take a kind of
ownership for qualifiyng that say system is compatible with their
distro.  For my 'real' work, we have to work with some distribution that
is somehow 'qualified' for say software, or say hardware driver, even
though that do not make sense.  For example, if you want to install, and
qualify, Oracle under Linux, you have *no choice* for the distribution
to be used.

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
