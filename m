From: Alexander Hoogerhuis <alexh-rpjHciJLgqZBDgjK7y7TUQ@public.gmane.org>
Subject: Re: ACPI vs. PCMCIA on Compaq Evo N800c
Date: 28 Apr 2003 11:03:12 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <87el3nj8of.fsf@lapper.ihatent.com>
References: <3EAB29E2.5030702@woogie.net>
	<20030427100023.A16436@fermat.unipv.it>
	<1051436106.2388.9.camel@calvin.hjblocal.nl>
	<20030427142438.A16678@fermat.unipv.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030427142438.A16678-xzhXYMPkGmXoPXhRcRtihA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Daniele Boffi <boffi-piYtxHxN1XRAly3Pu9w1wA@public.gmane.org>
Cc: Hilbert Barelds <h.j.barelds-XfCjptVMDKWuyJwMYI9mNQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Daniele Boffi <boffi-piYtxHxN1XRAly3Pu9w1wA@public.gmane.org> writes:

> > kernel 2.5.68 no display on my radeon
> 
> Never tried. For me the graphic card was detected out of the box (with nice
> resolution 1400x1050).
> Only annoying thing: screen looses horizontal sincronization when switching
> between different virtual consoles crt-alt-F1/8, if you keep switching it
> comes back to the good sincronization.
> 
> You can download my X config at
> 
> www-dimat.unipv.it/~boffi/compaq/XF86Config
> 
> > -Fn F7 and Fn F8 not working
> 
> This works fine for me (didn't work with RH9)
> 
> > -lidswitch not working, but if working display doesn't come back
> 
> This works fine. With RH9 I think the display didn't come back, but switching
> to a different console made it work.
> 

I'm running on Gentoo 1.4rc1 (with updates) and I can confirm that
XFree 4.2.1 in various releases has had problems with the lid switch
on my 800c. Basically once it's pressed it would not turn on
again. Loosing sync when switching the display to/from text-mode and
graphics was also a problem. I'm now running with XFree 4.3.0 with up
to date drm-modules for 4.3.0 and lid switch and sync problems are
gone. 

I still have a problem what when i press the log out button in Gnome
2.2 and the scren is faded, then the machine will isntantly do a hard
reset. 

My kernel is 2.4.21-pre7 with ACPI 20030328 and preempt applied to
it. Also running with a custom DSDT that makes most stuff work,
including turning the brightness up and down :)

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
