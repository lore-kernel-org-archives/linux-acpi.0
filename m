From: Daniele Boffi <boffi-piYtxHxN1XRAly3Pu9w1wA@public.gmane.org>
Subject: Re: ACPI vs. PCMCIA on Compaq Evo N800c
Date: Sun, 27 Apr 2003 14:24:38 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030427142438.A16678@fermat.unipv.it>
References: <3EAB29E2.5030702@woogie.net> <20030427100023.A16436@fermat.unipv.it> <1051436106.2388.9.camel@calvin.hjblocal.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1051436106.2388.9.camel-PDBFyMGeMq1aCPxV5EPtfPP6llvjuJOh@public.gmane.org>; from h.j.barelds-XfCjptVMDKWuyJwMYI9mNQ@public.gmane.org on Sun, Apr 27, 2003 at 11:35:07AM +0200
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Hilbert Barelds <h.j.barelds-XfCjptVMDKWuyJwMYI9mNQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Hilbert,

> I also have an Evo N800v RedHat 9

I am using RH 8, I tried RH9 for a while, but some things did not work as
before... didn't have much time and came back to 8.

> ATI.2 XFree patch

I am not using it. What is that for?

> Still with kernel 2.4.21-pre4 and its acpi version, cpufreq patch.

I am using 2.4.20 with acpi-20021212-2.4.20 and custom dsdt. You can download
my custom dsdt (with the usual "use at your own risk" disclaimer) at

www-dimat.unipv.it/~boffi/compaq/custom-dsdt.hex

> With the latest version 2.4.21-rc1 and latest acpi patch the laptop gets
> really hot.

For me (2.4.20) this is not the case. The fan control seems OK.
(CPU temperature usually is around 50 C, other two thermal zones much cooler
BTW does anybody know what the other two thermal zones are?;
CPU reached once 70 C during heavy work... critical temperature is 93 C)

> kernel 2.5.68 no display on my radeon

Never tried. For me the graphic card was detected out of the box (with nice
resolution 1400x1050).
Only annoying thing: screen looses horizontal sincronization when switching
between different virtual consoles crt-alt-F1/8, if you keep switching it
comes back to the good sincronization.

You can download my X config at

www-dimat.unipv.it/~boffi/compaq/XF86Config

> -Fn F7 and Fn F8 not working

This works fine for me (didn't work with RH9)

> -lidswitch not working, but if working display doesn't come back

This works fine. With RH9 I think the display didn't come back, but switching
to a different console made it work.

> -irda not working

Never tried, don't need it

> -acpi performance not working (known problem)

Well, it works but you cannot monitor it or change its status.

In addition to that, I have, in particular, swsusp working fine; power, lid,
suspend buttons working OK.

I would like to have some hotkeys working (in particular the volume control),
but I don't think this is a acpi related problem.

Daniele


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
