From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: suspend.c vs driver-model.txt
Date: Tue, 30 Jul 2002 20:22:55 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020730182255.GC7567@atrey.karlin.mff.cuni.cz>
References: <20020729190219.GD13729@elf.ucw.cz> <20020730080418.11907@192.168.4.1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20020730080418.11907-Q0ErXNX1RuY/GWcAdfcqrQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Cc: Patrick Mochel <mochel-3NddpPZAyC0@public.gmane.org>, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> >There's power cycle and whole kernel bootup. Device state is
> >completely lost during suspend to disk.
> 
> As it is during suspend-to-ram in most cases (most devices except
> a couple of them are actually powered down and the drivers have to
> bring them back up, at least on pmac, though on x86, the APM BIOS
> helps you a bit there).

APM BIOS is irrelevant here (when using APM BIOS, everything is done
by BIOS).

> So basically, drivers are responsible to bring back the device
> in whatever state it was at the save_state step of the suspend,
> in the same way for but suspend to disk and to RAM. What I want to
> make sure is that the driver-side semantics remain the same for
> swsusp and suspend-to-RAM.
> That includes the fact that save state will actually block IOs, and
> that is necessary to have a coherent state among devices.

I actually made suspend-to-RAM working as a side effect of making
suspend-to-disk working.

What I'm doing is "drivers don't have to care about stopping requests
because everything is stopped". If you are willing to go through all
drivers and add stopping in them, thats fine with me, but I believe
its post-2.6.

> Note that you don't need to run the last step of driver notification
> though (the actual "suspend" state), this will save you the disk
> powercycle effect on suspend.

Yep, I can get rid of spindown/spinup..
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.


-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
