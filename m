From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Changing temperature trip points
Date: Sun, 3 Nov 2002 21:21:30 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021103202130.GB22668@atrey.karlin.mff.cuni.cz>
References: <E187ipj-0001ss-00@usw-sf-list2.sourceforge.net> <000001c28231$b7cae110$c200a8c0@pikachu> <20021102171756.GD1983@elf.ucw.cz> <1036288754.2971.1.camel@localhost.localdomain> <20021103195616.GB27271@elf.ucw.cz> <20021103211607.A1555@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20021103211607.A1555-JhLEnvuH02M@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Dominik Brodowski <linux-JhLEnvuH02M@public.gmane.org>
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Edmund Rhudy <nrhudy-plZrL8KR64B+CIkdHa1UOg@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Hi!

> > > I did in fact try that, and while it lets me change the values, they
> > > don't actually seem to affect the kernel's idea of when the fan should
> > > come on, if at all.  I set the active trip point to 45 C and the passive
> > > to 50 C, then ran a compile to see if the fan triggered.  While the
> > > temperature got above 50 C, the fan never came on.  In fact, I don't
> > > know if the fan would come on even if the originally-specified trip
> > > points were reached.  Either way, this isn't exactly the most comforting
> > > situation to observe.
> > 
> > That's because your fan is driven by hardware, not ACPI. I see it
> > here, too. Passive cooling should work, through.
> 
> Actually, I think the problem is something else: The BIOS is supposed to
> generate ACPI events whenever these trip points are reached. So if you
> change these values (by patching the DSDT, by "hardwiring" it into the
> kernel) you need to use the polling method. Then ACPI will compare the
> current temperature to the specified temperatures with a specified
> frequency. Any chance you can try whether my assuption is correct?


YOU are right that I need to turn the polling on.

But I'm sure fan is done by bios on my machine.

Here is what my cool-it-down script looks like:

root@amd:~# cat watchtemp
#!/bin/bash
echo "83:83:60:70:0" > /proc/acpi/thermal_zone/THRM/trip_points
echo "5" > /proc/acpi/thermal_zone/THRM/polling_frequency
watch '( cat /proc/acpi/processor/CPU0/limit ; cat
/proc/acpi/thermal_zone/THRM/{temperature,state,trip_points} )'
root@amd:~#

						Pavel

-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.


-------------------------------------------------------
This SF.net email is sponsored by: ApacheCon, November 18-21 in
Las Vegas (supported by COMDEX), the only Apache event to be
fully supported by the ASF. http://www.apachecon.com
