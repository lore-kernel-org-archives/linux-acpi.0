From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: VIA KT333 acpi DSDT bug
Date: Wed, 4 Feb 2004 10:57:37 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040204095737.GG882@poupinou.org>
References: <3ACA40606221794F80A5670F0AF15F8401CBB66C@PDSMSX403.ccr.corp.intel.com> <200402031758.03901.chp.dekker@hsdrenthe.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200402031758.03901.chp.dekker-OdOgJZujJHXcqV2Q6a4srg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "CHP.Dekker" <chp.dekker-OdOgJZujJHXcqV2Q6a4srg@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Feb 03, 2004 at 05:58:03PM +0100, CHP.Dekker wrote:
> I couldn't help but to see that the source file is incomplete, I don't know 
> how it can be because I send the whole thing, if some one is willing to fix 
> my DSDT file than please mail me so that I can send it.
> 
> On Tuesday 03 February 2004 08:24, Yu, Luming wrote:
> > > I use a VIA KT333 motherboard.
> > >
> > > It hase some bugs in the DSDT file and I don't know how to fix them.
> > > Once when I had xp installed on it (2 days long ;) I had S0
> > > t/m S5 (Ofcourse
> > > not called that way by M$cro)
> > > No ACPI (sleep) say I only have S0 S3 S4 S5
> > > Some time none of them work becuase "one process didn't stop"
> > > But now it "at
> > > least I can "use S3", all that it does is putting my computer
> > > in 1/10000 sec
> > > to sleep (S3) mode and can be re-awakend. The lid switch
> > > doesn't do any
> > > thing.
> >
> > Do you have any hints to let us know this kind of symptom is due
> > to DSDT bug?
> >
> 
> Well the thing is compile by the micros..  compiler and it has 2 error's
> 
>                     Name (_PCL, Package (0x01)
>                     {
>                         \_SB.PCI0.SBRG.EC0
>                     })
> It says that I doesn't know the object EC0 from the line \_SB.PCI0.SBRG.EC0
> The 2nd error (identical I think)
> 
>                     Name (_PCL, Package (0x01)
>                     {
>                         \_SB.PCI0.SBRG.EC0
>                     })

There is good luck then that the EC0 is implemented in a SSDT table,
not in the DSDT table.

Note that system sleep states are still developpement stuff (even
though that seems to be more and more stable), so your problem may be
not related to DSDT.  Speaking for myself, I don't care yet for bug reports
about hacking DSDT in order to get Sx states transition support.

> and 1 warning saying that a function doesn't return something every time.

Sometimes iasl report 'false positive' for that, but sometime this
may be a real problem.

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
