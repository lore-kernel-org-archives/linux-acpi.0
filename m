From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: RE: ACPI -- Workaround for broken DSDT
Date: Thu, 5 Feb 2004 11:00:25 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040205100025.GP882@poupinou.org>
References: <BF1FE1855350A0479097B3A0D2A80EE0CC8AB6@hdsmsx402.hd.intel.com> <1075964148.5017.7.camel@tinny.home.foo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1075964148.5017.7.camel-3lu5YwujmwObGSPjaX/RoA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Scott T. Smith" <scott-j3vAvQ9dNB9ByuSxxbvQtw@public.gmane.org>
Cc: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Feb 04, 2004 at 10:55:49PM -0800, Scott T. Smith wrote:
> On Wed, 2004-02-04 at 21:15, Brown, Len wrote: 
> > The strategy is to improve ACPI on Linux such that all Linux distros are
> > able to successfully ship ACPI enabled kernels.
> > 
> > When we reach that stage, the OEMs will use these commercial Linux
> > products when they validate their platforms -- fixing DSDT problems
> > themselves before the 1st BIOS is released to the public.
> 
> realistically, that's 3-5+ years away.  In the meantime, what are
> existing users to do?  (i.e. those of us who don't like reading 430+
> pages of the spec)

ACPI is multiplatfrom anyway, you really think that people will
install Windows on a Itanium or Opteron servers?  Good luck then
for the technical support of that vendor..

> 
> > Windows doesn't have to do anything.  By being first to ship ACPI, that
> > implementation provided the defacto ACPI compliance test to which all
> > BIOS' are tested -- even if that implementation is not ACPI spec
> > compliant.  No, only under dire circumstances will we emulate Windows
> > bugs in Linux.
> 
> So basically we shouldn't use ACPI then, and instead use APM?
> 
> If Linux ACPI could emulate the bugs that Windows has, then ACPI would
> work on Linux on most platforms right away.  That would make Linux more
> accessible to people.  Linux already has a bunch of hacks to support
> broken hardware which presumably Windows can work around; this seems to
> be just another one of those.
> 
> While it would be great if BIOS' used correct DSDT's, then what would
> happen if those DSDT's didn't work on Windows?  Which version do you
> think they'd ship?  Methinks not the one that works on Linux.
> 
> OTOH, what happens when Microsoft tries to fix their existing bugs --
> they'll either stick with their buggy version forever, or have to
> support several versions, depending on how many bugs are fixed and when
> they are fixed.  Or you'll end up with some versions of Windows that
> won't run on older or newer laptops.
> 

Simple.  When Windows 2000 or WindowsXP (I don't remember correctly
which one) came out, suddenly a lot of BIOS upgrades due
to ACPI incompatibility issues were made by most OEMs...

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
