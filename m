From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: S3 resume problems on HP compaq nc4010
Date: Mon, 10 May 2004 01:28:57 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040509232856.GA2504@atrey.karlin.mff.cuni.cz>
References: <1083777804.4093.71.camel@descent.netsplit.com> <20040509015516.GA5487@elf.ucw.cz> <1084117826.2372.32.camel@syndicate> <20040509213919.GA13603@atrey.karlin.mff.cuni.cz> <1084139548.14657.4.camel@syndicate> <20040509215621.GB15307@atrey.karlin.mff.cuni.cz> <1084140024.14657.8.camel@syndicate>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1084140024.14657.8.camel-ImmFMecdQhGzQB+pC5nmwQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Scott James Remnant <scott-Umf49k1wg4FWk0Htik3J/w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> > * use ext2. At least it has working fsck. [If something seemes to go
> >   wrong, force fsck when you have a chance]
> > 
> Would the filesystem really make a difference to whether it can or can't
> come back?

It should not... but if you damage your reseir/whatever don't come
back to me ;-).

> > * due to video issues, swsusp should be easier to get working than
> >   S3. Try that first.
> > 
> Doesn't work either.  I got swsusp2 to work, but that has to shut down X
> and unload all the modules otherwise it won't resume; and that takes
> longer than a simple shutdown and boot -- so I abandoned it.  Plus it
> scared me -- too much pretty :)

Can you try just without dri/agp with swsusp2? That might do the
trick. Try to locate exactly which modules cause problems.

dri/agp are known offenders, and fix is known by now.

Complain to Nigel about prettyness... I certainly did ;-).
								Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.


-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
