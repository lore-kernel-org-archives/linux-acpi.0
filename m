From: "Scott T. Smith" <scott-j3vAvQ9dNB9ByuSxxbvQtw@public.gmane.org>
Subject: Re: RE: ACPI -- Workaround for broken DSDT
Date: Wed, 04 Feb 2004 18:18:49 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1075947529.5947.38.camel@tinny.home.foo>
References: <BF1FE1855350A0479097B3A0D2A80EE0CC8A9F@hdsmsx402.hd.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <BF1FE1855350A0479097B3A0D2A80EE0CC8A9F-N2PTB0HCzHJF3Yvz3xaN/VDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, 2004-02-03 at 23:22, Brown, Len wrote:
> > From Brown, Len on Sunday, 01 February, 2004:
> > >The vendor should supply a correct DSDT with their BIOS.
> > >In the case of Dell, you might inquire here: http://linux.dell.com/
> > >For non-vendor supplied solutions, you might also follow the 
> > DSDT link
> > >here: http://acpi.sourceforge.net/  
> > 
> > Hmm.  Do vendors generally release these?  I know Dell's very shaky on
> >   the Linux support front, at least for desktop/laptop.
> > Also, how do non-vendor supplied ones get made?  Seems like something
> >   you need NDA'ed docs for.
> 
> Non-vendor supplied DSDTs are created by end-users who bought machines
> that don't work.  Per the DSDT link above, one can extract,
> dis-assemble, modify a DSDT -- and tell Linux to use your copy instead
> of the version burned into PROM.

what's the long term strategy for ACPI on Linux?  If there are so many
broken DSDT's, and we want ACPI to be accessible to non-programmers,
then what's the ultimate solution?  Is it to include patches for every
possible platform, and have the ACPI subsystem autodetect and fix at
boot time?

Since thus far the ability to override the DSDT tables has not been
included in the vanilla ACPI distribution, then it seems you guys have
something else in mind.

What does Windows do?  Is it just that their DSDT
parser/executer/whatever operates differently (in which case a Windows
emulation mode could be added to the Linux subsystem), or is it that
Laptop manufacturers ship a corrected DSDT as part of their driver set?

	Scott



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
