From: Alexander Hoogerhuis <alexh-rpjHciJLgqZBDgjK7y7TUQ@public.gmane.org>
Subject: Re: ACPI vs. PCMCIA on Compaq Evo N800c
Date: 28 Apr 2003 12:08:11 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <87isszhr3o.fsf@lapper.ihatent.com>
References: <3EAB29E2.5030702@woogie.net>
	<20030427100023.A16436@fermat.unipv.it>
	<1051436106.2388.9.camel@calvin.hjblocal.nl>
	<20030427142438.A16678@fermat.unipv.it>
	<87el3nj8of.fsf@lapper.ihatent.com>
	<1051523389.3eacf93e0299f@webmail.freedom2surf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1051523389.3eacf93e0299f-2RFepEojUI2nZ0U1+ra/38PfUJlJv2Hx@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: h.j.barelds-XfCjptVMDKWuyJwMYI9mNQ@public.gmane.org
Cc: Daniele Boffi <boffi-piYtxHxN1XRAly3Pu9w1wA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

h.j.barelds-XfCjptVMDKWuyJwMYI9mNQ@public.gmane.org writes:

> Quoting Alexander Hoogerhuis <alexh-rpjHciJLgqZBDgjK7y7TUQ@public.gmane.org>:
> 
> > I'm running on Gentoo 1.4rc1 (with updates) and I can confirm that
> > XFree 4.2.1 in various releases has had problems with the lid switch
> > on my 800c. Basically once it's pressed it would not turn on
> > again. Loosing sync when switching the display to/from text-mode and
> > graphics was also a problem. I'm now running with XFree 4.3.0 with up
> > to date drm-modules for 4.3.0 and lid switch and sync problems are
> > gone. 
> 
> You took the drm-modules from dri.sf.net? Think I am going to try that one
> 

It's packaged as an "ebuild" in gentoo, taken from
dri.sourceforge.net. I ould assume its up to date and has the
following patches in addition:

xfree-drm-4.3.0-gentoo-Makefile-fixup.patch
xfree-drm-4.3.0-gentoo-ppc-Makefile-fixup.patch
xfree-drm-4.3.0-r2-dristat.patch
xfree-drm-4.3.0-r2-drm-ioremap.patch
xfree-drm-4.3.0-r2-gentoo-Makefile-fixup.patch
xfree-drm-4.3.0-r2-radeon-resume-v8.patch

> > My kernel is 2.4.21-pre7 with ACPI 20030328 and preempt applied to
> > it. Also running with a custom DSDT that makes most stuff work,
> > including turning the brightness up and down :)
> 
> Only mods I made were the '*' in the names, and added some externs. Or are there
> more modifcations available?
> 

Removing *'es and changing a few variable names made most of the stuff
happy. Then a bit of hand patching of osl.c to make it load the
overriding DSDT.

> Hilbert
> 

mvh,
A
-- 
Alexander Hoogerhuis                               | alexh-rpjHciJLgqZBDgjK7y7TUQ@public.gmane.org
CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
"You have zero privacy anyway. Get over it."  --Scott McNealy


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
