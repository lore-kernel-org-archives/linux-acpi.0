From: "Lukas Schrangl" <schrangl-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: Build PST for AthlonXP
Date: Thu, 5 Feb 2004 15:01:20 +0100 (MET)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <15986.1075989680@www48.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> On Thu, Feb 05, 2004 at 08:17:53AM +0100, Lukas Schrangl wrote:
> > > On Wed, Feb 04, 2004 at 11:45:25AM +0100, Lukas Schrangl wrote:
> > > > Hi!
> > > > 
> > > > I don't know wether this is the right mailinglist for my problem,
> but at
> > > > least I think here are some people who can help me.
> > > 
> > > Correct, the mailling list is the CPUFreq mailing list..
> > > 
> > > > Maybe someone remembers my problem: I have a AMD Athlon XP 2600+
> mobile
> > > CPU
> > > > but neither ACPI- performance states nor cpufreq/powernow-k7 (no PST
> > > matching
> > > > this cpuid) do work.
> > > 
> > > Retrieving configuration from ACPI is a work in progress.  I do have
> > > some experimental patch for, but not publically available yet
> > > (it depends on others patches from Dominik, I'm not sure if that OK by
> > > now).
> > > 
> > > > Recently I browsed a bit through the powernow-k7 source and have now
> an
> > > idea
> > > > how it works. It shouldn't be too difficult to set up my own PST for
> my
> > > CPU,
> > > > should it?
> > > 
> > > Well, not so, especially if you can retrieve the configuration for the
> > > different
> > > states.
> > > The key is the control word, in the _PSS packages.
> > > 
> > > For example, suppose you have that:
> > > 
> > > Processor(..) {
> > > 	...
> > > 	Name (_PSS, Package () {	/* this may be a method, btw */
> > > 		Package () {
> > > 			0x0352,
> > > 			0x61A8,
> > > 			0x7D,
> > > 			0x009C414B,	/* that the control. */
> > > 			0x014B
> > > 		},
> > > 		Package () {
> > > 			...,
> > > 			...,
> > > 		}
> > > 	})
> > > 
> > > For the first one, this is 0x009C414B.
> > > The layout seems to be:
> > > bit 0-5: FID,
> > > bit 6-10: VID,
> > > bit 11-30: SGTC (or in other word 'latency' in 10 time micro second)
> > > bit 31-32: reserved.
> > > 
> > > Note that this is *not* confirmed by AMD people.
> > > 
> > > > I know about FIDs and VIDs and what they are good for, but can
> anyone
> > > > explain me the structure of a PST and the PSB (links to some
> documents,
> > > ...)?
> > > > The second thing: I could get the cpu- frequences that seem work
> (for my
> > > > FIDs) from my SSDT, but how can I calculate the voltage (for the
> VIDs)
> > > matching
> > > > the frequency, if there are only the mW given in the SSDT?
> > > > 
> > > 
> > > BTW, I send to CPUFreq ML yesterday a patch in order to get a sysctl
> > > interface for overwritting a powernow k7 table.
> > > 
> > > http://www.poupinou.org/cpufreq/powernow-k7/
> > > 
> > > Cheers,
> > > 
> > > -- 
> > > Bruno Ducrot
> > > 
> > > --  Which is worse:  ignorance or apathy?
> > > --  Don't know.  Don't care.
> > > 
> > > 
> > > -------------------------------------------------------
> > > The SF.Net email is sponsored by EclipseCon 2004
> > > Premiere Conference on Open Tools Development and Integration
> > > See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
> > > http://www.eclipsecon.org/osdn
> > > _______________________________________________
> > > Acpi-devel mailing list
> > > Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > > https://lists.sourceforge.net/lists/listinfo/acpi-devel
> > > 
> > 
> > Sysctl? I just hard-coded a PST (thanks to your hint with the SSDT-
> > controldwords) and patched powernow-k7.c to make the driver use that PST
> instead of
> > BIOS PSTs. What shall I say? It simply works ;)
> 
> I do not doubt that it work, just that the sysfs things is generic for
> everybody (even if the driver is correctly loaded in fact), and then
> you don't have to worry about to patch the kernel anymore.  Just
> a little rc-script to write...
> 
> > PS.: I found one of the FIDs in the SSDT to be false, so maybe it's not
> save
> > to read the powernow- states from ACPI.
> 
> Let me guess.  The one that is before the latest state, and actually
> you meant the VID value which is a little too high?
> 
> If that's the case, it should be safe to go, but yes, I
> have to workaround that though.  But if that's really the FID
> which is wrong, well, I will be gratefull to get a report.

I think it's really the FID in the state one before the last state which was
too low by one but I will look that up to be shure (I'm not working with my
computer). I will notify you as soon as I have looked that up and got to a
computer with internet access again.

> 
> I saw also one example where the maximum speed was missing (and
> of course, there is no BIOS PST)...

I have all states.

> 
> Note also that the acpi things is only done if and only if
> the laptop is DMI blacklisted (and ACPI processor is compiled,
> of course).

Don't think it is blacklisted, but didn't try your patch yet. Will do that
as soon as possible.

> 
> -- 
> Bruno Ducrot
> 
> --  Which is worse:  ignorance or apathy?
> --  Don't know.  Don't care.
> 

-- 
GMX ProMail (250 MB Mailbox, 50 FreeSMS, Virenschutz, 2,99 EUR/Monat...)
jetzt 3 Monate GRATIS + 3x DER SPIEGEL +++ http://www.gmx.net/derspiegel +++



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
