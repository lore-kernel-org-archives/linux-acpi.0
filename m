From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: RE: ACPI -- Workaround for broken DSDT
Date: 09 Feb 2004 16:23:05 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1076361784.4110.120.camel@dhcppc4>
References: <BF1FE1855350A0479097B3A0D2A80EE0CC8AB6@hdsmsx402.hd.intel.com>
	 <1075964148.5017.7.camel@tinny.home.foo>  <20040209122256.K74314@root.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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
Cc: "Scott T. Smith" <scott-j3vAvQ9dNB9ByuSxxbvQtw@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, 2004-02-09 at 15:29, Nate Lawson wrote:
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
> on the ACPI-CA side, could encourage OEMs to test with the option
> disabled.  It might even make sense for a Linux distro maintainer to
> partner with ACPI-CA to provide a reference ISO that OEMs could boot that
> had a /sbin/init that tests the various APIs for correctness.  Both Andy
> and I thought this was a good direction to go and perhaps people are
> already making progress in that area.

I agree 100% with this strategy, Nate.  The users and the OSDs just want
it to work.  The OEMs should have an option to make it into a better
platform test.  Based on the questions I get today, educating the OEMs
to use something other than the stock distro off the shelf, however, is
harder than you might think.  Maybe having the dedicated test ISO is a
good idea.  We'd discussed this in the past, and one benefit is that it
would never be confused with the distro.

Mgr: Did the Linux ACPI Compliance test pass?
Tester: Yes, we booted Red Hat, SuSE, etc
Mgr: No, I said the Linux-based ACPI Compliance Test...

This strategy, however is not incomplete.  The Linux OSDs need to sign
up as ACPI Adopters.  Linux OSDs should have both advanced knowledge and
direct impact on what is being written into the ACPI spec.  Today they
have neither.

-Len




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
