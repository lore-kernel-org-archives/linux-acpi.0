From: Major A <andras-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Subject: suspend-to-ram on A7V333
Date: Sat, 17 Aug 2002 02:32:31 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020817013229.GA725@ventus.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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


Hi,

I'm a total newcomer to ACPI, I tried it today because I want to get
the suspend-to-ram feature of my mainboard working. This is what I've
found out:

1. Using a plain linux kernel 2.4.19, the ospm-* drivers cannot be
   used as modules -- they create unresolved symbols. (This is not the
   case with 2.4.18.) Compiling them as static drivers works, and I
   get the relevant files in /proc/acpi, everything seems to work
   fine.

2. Pressing the power button creates an event which is dealt with by
   acpid, seems to work OK.

3. I can get use the S0/1/4/5 states by piping the corresponding
   number into /proc/acpi/sleep, and even S3 seems to work -- it
   prints a line saying something like "entering S3" (I couldn't read
   it because it was only a short time before the machine shut
   down). I suspect this is the S3 mode, with the power light
   flashing, but I cannot get the machine back out of suspend! If I
   press the power button or ctrl-esc (which I have set up as the
   keyboard-on combination) or even the "green button", it boots as if
   it hadn't suspended. Other keys or the (USB) mouse do
   nothing. Using the PS/2 mouse power-on feature doesn't help either.

4. If I disable the "suspend-to-ram" feature in the BIOS, the S3
   option disappears from /proc/acpi/sleep, as expected. The "fast
   resume" BIOS option doesn't seem to make any difference.

Anyway, does anyone have any experience with this? I can't try all
this under Windows (thank God), it seems that the computer just
forgets that it is supposed to be suspended only, whether that be a
BIOS or Linux problem.

One more thing -- I have a SCSI card with a BIOS in the computer,
maybe that makes a difference?

Hardware information: Asus A7V333 board with Athlon XP, Enermax power
supply (plenty of juice on +5VSB), PS/2 keyboard.

Thanks,

  Andras

===========================================================================
Major Andras
    e-mail: andras-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
    www:    http://andras.webhop.org/
===========================================================================


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
