From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Sneaking patches in (was Re: System hang when trying to enter sleep/standby state)
Date: Mon, 17 Feb 2003 14:19:22 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030217131922.GC4704@atrey.karlin.mff.cuni.cz>
References: <20030217150005.GA6429@zaurus.ucw.cz> <Pine.LNX.4.33.0302161742160.1039-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0302161742160.1039-100000-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Patrick Mochel <mochel-3NddpPZAyC0@public.gmane.org>
Cc: ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

> > I have not seen any patch on the lists, *and*
> > you also moved big blocks of code to hide your
> > changes. That's pretty nasty behaviour.
> 
> That's not true. The patch to make that change is here: 
> 
> http://marc.theaimsgroup.com/?l=acpi4linux&m=104508487609853&w=2
> 
> And the accusation about moving large blocks of code to cover it up is 
> completely unfair. It's not a conspiracy. 

While I agree it is not a conspiracy, the change is still well
hidden. Relevant changesets are:

ChangeSet 1.1003.12.2, 2003/02/13 11:51:15-06:00, mochel-3NddpPZAyC0@public.gmane.org

	acpi: Split i386 support up. 
	
	- Created arch/i386/kernel/acpi/
	- Split file into boot.c and sleep.c.
	- Moved acpi_wakeup.S into there.


ChangeSet 1.1003.2.19, 2003/02/12 19:35:58-06:00, mochel-3NddpPZAyC0@public.gmane.org

	acpi sleep: divorce sleep functionality from power off
functionality.
	
	When ACPI turns the system off on shutdown, it actually enters
S5, a sleep
	state. This functionality is dependent on CONFIG_ACPI_SLEEP,
which is 
	dependent on CONFIG_SOFTWARE_SUSPEND.
	
	This patch breaks the power off functionality into a separate
file, and 
	removes the dependency on the above-mentioned crap. Finally,
power off works
	for me again. 
	
	Thanks to Tobias Ringstrom for the original patch.


ChangeSet 1.1003.2.2, 2003/02/12 15:26:39-06:00, mochel-3NddpPZAyC0@public.gmane.org

	acpi sleep: move sleep support into own subdirectory. 

Even with the changelogs, I can't decide which one of these it
is. Probably 2.19, but as it also moves files, commit list is useless
because it represent moves as delete all lines, add all lines, and any
change is hidden.

@@ -285,16 +271,6 @@
 	printk(")\n");
 
 	acpi_sleep_proc_init();
-
-	/* Install the soft-off (S5) handler. */
-	if (sleep_states[ACPI_STATE_S5]) {
-		pm_power_off = acpi_power_off;
-
-		/* workaround: some systems don't claim S4 support,
but they
-                   do support S5 (power-down). That is all we need,
so
-		   indicate support. */
-		sleep_states[ACPI_STATE_S4] = 1;
-	}
 
 	return_VALUE(0);

Are you sure about this one?

> It was also explained, along with every other change in the changelog
> entries. I know that you are opposed to using BitKeeper, so I recommend 
> that you subscribe to, or read, the bk-commits-head list, which has every 
> patch Linus commits, with diffstat output and full changelogs for
> each. 

Well, in the past we tried to catch bugs *before* they got to the
tree.

								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
