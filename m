From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Sneaking patches in (was Re: System hang when trying to enter sleep/standby state)
Date: Tue, 18 Feb 2003 09:15:56 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030218081556.GB137@elf.ucw.cz>
References: <20030217131922.GC4704@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.33.0302171016320.1034-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0302171016320.1034-100000-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
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

> > Even with the changelogs, I can't decide which one of these it
> > is. Probably 2.19, but as it also moves files, commit list is useless
> > because it represent moves as delete all lines, add all lines, and any
> > change is hidden.
> 
> As a personal choice, I _never_ make changes when I move files. I've been 
> so pissed at Andy for unintentionally obscuring changes this way that I 
> swore I would never do it myself. :)

Okay...

> > -
> > -	/* Install the soft-off (S5) handler. */
> > -	if (sleep_states[ACPI_STATE_S5]) {
> > -		pm_power_off = acpi_power_off;
> > -
> > -		/* workaround: some systems don't claim S4 support,
> > but they
> > -                   do support S5 (power-down). That is all we need,
> > so
> > -		   indicate support. */
> > -		sleep_states[ACPI_STATE_S4] = 1;
> > -	}
> >  
> >  	return_VALUE(0);
> > 
> > Are you sure about this one?
> 
> Definitely. The setting of pm_power_off was moved to poweroff.c. 
> 
> The other part is bogus. S5 is not a sleep state, and shouldn't be treated 
> as such. You can still do a swsusp-style suspend and enter S5, in which 
> case I wouldn't recommend going through ACPI at all. You simply don't need 
> it. You need to save state, etc, then just call pm_power_off(). 

Yes but I need S4 to be enabled, i.e. sleep_states[ACPI_STATE_S4] =
1;. OTOH it might be usefull to enable S4 even if S5 is not there, it
is usefull for old machines, too, user just has to turn it off
manually.

> The only thing you lack is a way to trigger swsusp w/o ACPI, right? 

Actually you can trigger swsusp using syscall, but few people do that.

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]


-------------------------------------------------------
This SF.net email is sponsored by: SlickEdit Inc. Develop an edge.
The most comprehensive and flexible code editor you can use.
Code faster. C/C++, C#, Java, HTML, XML, many more. FREE 30-Day Trial.
www.slickedit.com/sourceforge
