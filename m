From: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Subject: Re: ACPI stops working after memory upgrade vpr Matrix 175b4
Date: Mon, 9 Feb 2004 12:21:10 -0800 (PST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040209121854.H74314@root.org>
References: <20040204073941.05d71e0b.rddunlap@osdl.org> <20040204172852.GL882@poupinou.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040204172852.GL882-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: "Randy.Dunlap" <rddunlap-3NddpPZAyC0@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, 4 Feb 2004, Bruno Ducrot wrote:
> On Wed, Feb 04, 2004 at 07:39:41AM -0800, Randy.Dunlap wrote:
> > > My ACPI stopped working when I added an additional 256mb RAM to my vpr
> > > Matricx 174b4 laptop. It has 256mb already, I added 256mb to make it
> > > 512mb and I got a bunch of AE_NO_MEMORY errors in the ACPI code.
> > >
> > > I took the extra RAM out, and the ACPI support works.
> > >
> > > I am using kernel 2.6.1 with acpi patches. I had the same problem on
> > > 2.6.0. On 2.4.20 with acpi patches the machine would not even boot with
> > > the extra memory.
> > >
> > > I have a custom DSDT file that I fixed errors in. When it was working on
> > > 2.4.20 It looked like all the ACPI features were active and functional.
> >
> > < Recompile your DSDT. Since the amount of RAM changed and you're probably
> > < using old DSDT containing wrong addresses, no wonder you're hitting
> > < errors.
> >
> > Is this correct?  If a user adds or removes memory, then the
> > DSDT must be rebuilt?  Sheesh!!  That's bad if this is correct.
>
> Most DSDT are actually build on POST stage.

To clarify this further, most AML I've seen uses various named regions to
store information about the platform that is dynamic.  For instance, the
actual clock rates and power consumption of the various ACPI performance
states on my Thinkpad are set up at boot time by an _INI method under the
Processor object.  That way if I plugged in a different CPU, it would be
detected at boot time, not hard coded in the AML.  For the case of memory
size and this laptop, that should really be done through the E820 table by
the BIOS and not hardcoded in the AML.

-Nate


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
