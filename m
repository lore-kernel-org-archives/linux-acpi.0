From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] ACPI poweroff fixes for 2.4.26-pre2
Date: Thu, 11 Mar 2004 11:51:32 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040311105132.GI28592@poupinou.org>
References: <20040308163452.GE5352@openzaurus.ucw.cz> <Pine.LNX.4.44.0403081515190.10436-100000@dmt.cyclades> <20040308183228.GD484@elf.ucw.cz> <20040308201411.GA18636@alpha.home.local> <20040308205444.GH484@elf.ucw.cz> <20040309233325.GA22953@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20040309233325.GA22953-HkMpAodKYdnXX8ko2wsARw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Willy Tarreau <willy-tRhHnHjXm5DYtjvyW6yDsg@public.gmane.org>
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Marcelo Tosatti <marcelo.tosatti-3EexvZdKGZRWk0Htik3J/w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Mar 10, 2004 at 12:33:25AM +0100, Willy Tarreau wrote:
> Hi Pavel,
> 
> On Mon, Mar 08, 2004 at 09:54:44PM +0100, Pavel Machek wrote:
> > Can you replace
> > 
> > acpi_system_save_state() with
> > 
> >         pm_send_all(PM_SAVE_STATE, (void *)3);
> >         pm_send_all(PM_SUSPEND, (void *)3);
> > 
> > ?
> > 
> > That should fix it, too, and does not depend on CONFIG_ACPI_SLEEP.
> 
> Just checked, and I still can poweroff (which was a bit expected anyway, but
> now confirmed). So with this little patch against 2.4.26-pre2, poweroff does
> not depend on CONFIG_ACPI_SLEEP anymore, as you fairly requested (thank you
> for having insisted).

IMHO, that is much likely a bug somewhere in the notifer_reboot chain
than an ACPI problem.  For example, IDE disks would all been in standby
modes, and IDE hwif will be 'cleaned up' before even calling the
poweroff callback, yet with your patch the pm_send_all with
PM_SAVE_STATE would actually hang some of those IDE hwif.

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
