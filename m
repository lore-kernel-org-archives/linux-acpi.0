From: Willy Tarreau <willy-tRhHnHjXm5DYtjvyW6yDsg@public.gmane.org>
Subject: Re: Re: fix ACPI poweroff in 2.4.25-rc2
Date: Mon, 8 Mar 2004 21:14:11 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040308201411.GA18636@alpha.home.local>
References: <20040308163452.GE5352@openzaurus.ucw.cz> <Pine.LNX.4.44.0403081515190.10436-100000@dmt.cyclades> <20040308183228.GD484@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20040308183228.GD484-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: Marcelo Tosatti <marcelo.tosatti-3EexvZdKGZRWk0Htik3J/w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Pavel,

On Mon, Mar 08, 2004 at 07:32:28PM +0100, Pavel Machek wrote:
 
> there's broken machine where calling acpi_system_save_state() with
> invalid argument fixes it by accident.

In fact it does not fix it by accident, it's the previous code which
broke it by accident. Older ACPI poweroff code has been working well
on this machine, and suddenly stopped working. So i looked at what
changed and noticed that the acpi_poweroff() function changed from
_I don't remember what function_ to acpi_suspend(S5), and that
acpi_system_save_state(), which was called implicitly in the previous
function got lost during the change. Taking it back fixed my problem,
but I cannot say for sure that it will not break anything else, but its
use seems legitimate at first glance.

I agree that disabling local APIC from there would be another alternative,
but it may also be regarded as a workaround because I cannot explain
why this sh*tty notebook doesn't like it.

My intention was to write a more generic machine_prepare_stop() function
which would disable sensible things such as APIC, stop every non-boot CPU
and get the best conditions to stop the system. It could even be used for
the restart and for kexec. But calling it from ACPI and writing a new
arch-specific function for every arch will for sure break some other archs.

Anyway, up to 2.4.24, on the 3 machines I know that support ACPI, none of
them could poweroff. Now, with both this fix and the SMP fix, they all shutdown
cleanly. So I'm hopeful that we're in the right direction.

Cheers,
Willy



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
