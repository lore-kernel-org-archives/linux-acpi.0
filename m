From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Build PST for AthlonXP
Date: Wed, 4 Feb 2004 12:18:17 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040204111817.GJ882@poupinou.org>
References: <11695.1075891525@www14.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <11695.1075891525-uoI8PbPD7Nlmcu3hnIyYJQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Lukas Schrangl <schrangl-hi6Y0CQ0nG0@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Feb 04, 2004 at 11:45:25AM +0100, Lukas Schrangl wrote:
> Hi!
> 
> I don't know wether this is the right mailinglist for my problem, but at
> least I think here are some people who can help me.

Correct, the mailling list is the CPUFreq mailing list..

> Maybe someone remembers my problem: I have a AMD Athlon XP 2600+ mobile CPU
> but neither ACPI- performance states nor cpufreq/powernow-k7 (no PST matching
> this cpuid) do work.

Retrieving configuration from ACPI is a work in progress.  I do have
some experimental patch for, but not publically available yet
(it depends on others patches from Dominik, I'm not sure if that OK by
now).

> Recently I browsed a bit through the powernow-k7 source and have now an idea
> how it works. It shouldn't be too difficult to set up my own PST for my CPU,
> should it?

Well, not so, especially if you can retrieve the configuration for the different
states.
The key is the control word, in the _PSS packages.

For example, suppose you have that:

Processor(..) {
	...
	Name (_PSS, Package () {	/* this may be a method, btw */
		Package () {
			0x0352,
			0x61A8,
			0x7D,
			0x009C414B,	/* that the control. */
			0x014B
		},
		Package () {
			...,
			...,
		}
	})

For the first one, this is 0x009C414B.
The layout seems to be:
bit 0-5: FID,
bit 6-10: VID,
bit 11-30: SGTC (or in other word 'latency' in 10 time micro second)
bit 31-32: reserved.

Note that this is *not* confirmed by AMD people.

> I know about FIDs and VIDs and what they are good for, but can anyone
> explain me the structure of a PST and the PSB (links to some documents, ...)?
> The second thing: I could get the cpu- frequences that seem work (for my
> FIDs) from my SSDT, but how can I calculate the voltage (for the VIDs) matching
> the frequency, if there are only the mW given in the SSDT?
> 

BTW, I send to CPUFreq ML yesterday a patch in order to get a sysctl
interface for overwritting a powernow k7 table.

http://www.poupinou.org/cpufreq/powernow-k7/

Cheers,

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
