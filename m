From: "P. Christeas" <p_christ-U04EIuiosng@public.gmane.org>
Subject: Re: Runlevel for Sleep?
Date: Sat, 7 Sep 2002 02:18:56 +0300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200209062322.g86NM7j05108@pfn1.pefnos>
References: <20020906122153.F39@toy.ucw.cz> <Pine.LNX.4.44.0209061411390.1021-100000@cherise.pdx.osdl.net> <20020906222930.GE8827@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-7"
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20020906222930.GE8827-jyMamyUUXNJG4ohzP4jBZS1Fcj925eT/@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> Hi!
>
> > > I believe 3 of them are needed - S1, S3 and S4.
> >
It might be, but that way we are reserving all unimplemented runlevels, which 
looks really bad. I wish we could safely (for all systems) pass sth like an 
argument to the runlevel, indicating which sleep state we 're getting into.

> > I agree that we need to do some amount of user-level work before we go to
> > sleep, but I'm not sure that a runlevel is the proper way to implement
> > it.
My "original" idea is to use the init mechanism instead of any custom scripts 
and code, mainly just to avoid having extra binaries in our kernel.

> >
> > Unless you implemented a new runlevel for every possible sleep state for
> > every possible platform suspend mechanism, how would pass what suspend
> > state you wanted to enter?

If you do that, you're certainly ACPI-specific.

> >
> > You don't really want to have a different one for S1, S3, and S4 because
> > they are ACPI specific, both in terms of their names and what they mean.
> > I don't think you could create a clean, sensible solution like that, that
> > worked for all platforms...
>
> Okay, we can probably forget S1 and create arch-neutral
> "suspend-to-disk" and "suspend-to-ram".
>

IMHO you couldn't skip S1. I'm using that (in fact S3 works for me much 
worse) and I surely have to run some scripts before entering that.

We could easily agree with APM developers to have a common implementation, 
which gives the runlevel implementation an advantage. The runlevel business 
should not be ACPI specific for sure.

P. Christeas


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
