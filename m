From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Re: fix ACPI poweroff in 2.4.25-rc2
Date: Mon, 8 Mar 2004 20:58:19 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040308195819.GG484@elf.ucw.cz>
References: <20040308183228.GD484@elf.ucw.cz> <Pine.LNX.4.44.0403081539370.13683-100000@dmt.cyclades>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0403081539370.13683-100000-N7x2SXzAOustNcHCoTQCcg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Marcelo Tosatti <marcelo.tosatti-3EexvZdKGZRWk0Htik3J/w@public.gmane.org>
Cc: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>, willy-tRhHnHjXm5DYtjvyW6yDsg@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> > > > > The recent 2.4 patch breaks the build for ia64 because we don't
> > > > > set CONFIG_ACPI_SLEEP, and acpi_system_save_state() is only
> > > > > defined under #ifdef CONFIG_ACPI_SLEEP.  Can you add the following
> > > > > patch to deal with this?
> > > > 
> > > > Original patch should be reverted. Having different
> > > > behaviour of poweroff depending on ACPI_SLEEP would
> > > > be wrong.
> > > 
> > > Hi Pavel,
> > > 
> > > Original patches fixes a real problem, so its not as easy as "lets revert 
> > > it", yes? 
> > 
> > To put it simply:
> > 
> > there's broken machine where calling acpi_system_save_state() with
> > invalid argument fixes it by accident.
> > 
> > It can do random stuff on any other machine...
> 
> What random stuff ?

Okay, I was wrong. acpi_system_save_state does not do what I thought.

Anyway, #ifdef CONFIG_ACPI_SLEEP around acpi_system_sleep_state is
wrong fix. If its needed, its needed regardless of
CONFIG_ACPI_SLEEP...

Replacing it with
	pm_send_all(PM_SAVE_STATE, (void *)3);
	pm_send_all(PM_SUSPEND, (void *)3);
should do the trick.

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
