From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: VIA KT333 acpi DSDT bug
Date: Fri, 6 Feb 2004 21:09:24 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040206200924.GD13262@poupinou.org>
References: <3ACA40606221794F80A5670F0AF15F8401CBB66C@PDSMSX403.ccr.corp.intel.com> <200402031758.03901.chp.dekker@hsdrenthe.nl> <20040204095737.GG882@poupinou.org> <200402061359.47026.chp.dekker@hsdrenthe.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200402061359.47026.chp.dekker-OdOgJZujJHXcqV2Q6a4srg@public.gmane.org>
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

On Fri, Feb 06, 2004 at 01:59:46PM +0100, CHP.Dekker wrote:
> I didn't see this before (because fglrx act's like a semafore error generator 
> for last 10 weeks) but it looks like my computer doesn't resolve 
> \_SB.PCI0.SBRG.EC0.
> 
...


I think I'm stupid sometimes..

> On Wednesday 04 February 2004 10:57, Bruno Ducrot wrote:
> > On Tue, Feb 03, 2004 at 05:58:03PM +0100, CHP.Dekker wrote:
> > > I couldn't help but to see that the source file is incomplete, I don't
> > > know how it can be because I send the whole thing, if some one is willing
> > > to fix my DSDT file than please mail me so that I can send it.
> > >
> > > On Tuesday 03 February 2004 08:24, Yu, Luming wrote:
> > > > > I use a VIA KT333 motherboard.
> > > > >
> > > > > It hase some bugs in the DSDT file and I don't know how to fix them.
> > > > > Once when I had xp installed on it (2 days long ;) I had S0
> > > > > t/m S5 (Ofcourse
> > > > > not called that way by M$cro)
> > > > > No ACPI (sleep) say I only have S0 S3 S4 S5
> > > > > Some time none of them work becuase "one process didn't stop"
> > > > > But now it "at
> > > > > least I can "use S3", all that it does is putting my computer
> > > > > in 1/10000 sec
> > > > > to sleep (S3) mode and can be re-awakend. The lid switch
> > > > > doesn't do any
> > > > > thing.
> > > >
> > > > Do you have any hints to let us know this kind of symptom is due
> > > > to DSDT bug?
> > >
> > > Well the thing is compile by the micros..  compiler and it has 2 error's
> > >
> > >                     Name (_PCL, Package (0x01)
> > >                     {
> > >                         \_SB.PCI0.SBRG.EC0
> > >                     })
> > > It says that I doesn't know the object EC0 from the line
> > > \_SB.PCI0.SBRG.EC0 The 2nd error (identical I think)
> > >
> > >                     Name (_PCL, Package (0x01)
> > >                     {
> > >                         \_SB.PCI0.SBRG.EC0
> > >                     })
> >
> > There is good luck then that the EC0 is implemented in a SSDT table,
> > not in the DSDT table.

In fact, that one is at
	\_SB.PCI0.EC0

But I'm wondering if actually the EC0 (and btw some devices under that
PCI0) should be child of SBRG.  I think there is a kind of design error here.

> > > and 1 warning saying that a function doesn't return something every time.
> >
> > Sometimes iasl report 'false positive' for that, but sometime this
> > may be a real problem.
> 
That one is more problematic that I though at first.

This method is like that:



                Method (STM, 0, Serialized)
                {
                    If (REGF) {}
                    Else
                    {
                        Return (TMD0)
                    }
                    ...
                    ...
		}

and never return something after the Else path.

But, it is called in two methods.  One look like that:

                    Method (_STM, 3, NotSerialized)
                    {
                        Store (Arg0, Debug)
                        Store (Arg0, TMD0)
                        Store (SMPT, GMPT)
                        Store (SMUE, GMUE)
                        Store (SMUT, GMUT)
                        Store (SMCR, GMCR)
                        Store (SSPT, GSPT)
                        Store (SSUE, GSUE)
                        Store (SSUT, GSUT)
                        Store (SSCR, GSCR)
                        STM ()
                        Store (GMPT, SMPT)
                        Store (GMUE, SMUE)
                        Store (GMUT, SMUT)
                        Store (GMCR, SMCR)
                        Store (GSPT, SSPT)
                        Store (GSUE, SSUE)
                        Store (GSUT, SSUT)
                        Store (GSCR, SSCR)
                        Store (GTF (0x00, Arg1), ATA2)
                        Store (GTF (0x01, Arg2), ATA3)
                    }


Looking a little bit more the REGF, I think that node
is used in order to allow access to the PCI config space
of the ide hwif, and SMPT, SMUE, SMUT... are actually
registers of this PCI config space.  Therefore, I guess
that the BIOS vendor was aware of the (in)famous bug
under Windows, where when a Method called by another
method return "something", then abort the execution of
the caller...  Therefore, you may have trouble for configuration
of the IDE hwif, which will likely hangs upons resume. 

A way to workaround that is maybe to replace the _STM() with something
like that:

                    Method (_STM, 3, NotSerialized)
                    {
                        Store (Arg0, Debug)
                        Store (Arg0, TMD0)
                        Store (SMPT, GMPT)
                        Store (SMUE, GMUE)
                        Store (SMUT, GMUT)
                        Store (SMCR, GMCR)
                        Store (SSPT, GSPT)
                        Store (SSUE, GSUE)
                        Store (SSUT, GSUT)
                        Store (SSCR, GSCR)
			If (REGF) {
				STM ()
				Store (GMPT, SMPT)
				Store (GMUE, SMUE)
				Store (GMUT, SMUT)
				Store (GMCR, SMCR)
				Store (GSPT, SSPT)
				Store (GSUE, SSUE)
				Store (GSUT, SSUT)
				Store (GSCR, SSCR)
				Store (GTF (0x00, Arg1), ATA2)
				Store (GTF (0x01, Arg2), ATA3)
			}
                    }

There are two _STM that look like that, remember..


You should also replace the begining for STM() itself with something
like that:

before:

                Method (STM, 0, Serialized)
                {
                    If (REGF) {}
                    Else
                    {
                        Return (TMD0)
                    }

                    Store (0x00, GMUE)
                    Store (0x07, GMUT)
                    Store (0x00, GSUE)
                    Store (0x07, GSUT)
                    ...
                 }

after:
                Method (STM, 0, Serialized)
                {
                    Store (0x00, GMUE)
                    Store (0x07, GMUT)
                    Store (0x00, GSUE)
                    Store (0x07, GSUT)
                    ...
                 }

Since anyway STM () will be called only by two methods from AML, there
is no real need to check for REGF in STM() now.


-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
