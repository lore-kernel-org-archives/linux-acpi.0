From: Stephan Krings <Stephan.Krings-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: ACPI vs. PCMCIA on Compaq Evo N800c
Date: Mon, 28 Apr 2003 21:18:43 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <16045.32403.175503.231256@hotzenplotz.chateau-neukoelln.de>
References: <3EAB29E2.5030702@woogie.net>
	<20030427100023.A16436@fermat.unipv.it>
	<1051436106.2388.9.camel@calvin.hjblocal.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1051436106.2388.9.camel-PDBFyMGeMq1aCPxV5EPtfPP6llvjuJOh@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Hilbert Barelds <h.j.barelds-XfCjptVMDKWuyJwMYI9mNQ@public.gmane.org>
Cc: Daniele Boffi <boffi-piYtxHxN1XRAly3Pu9w1wA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Hi,

> I also have an Evo N800v RedHat 9

I'm using a N800c, but still some comments:

> -Fn F7 and Fn F8 not working

This is not ACPI related I think: I also had this problem once, and if
I remember correctly it was related to the version of XFree86 I was
using. Try to install the latest 4.3.0 and see if it helps.

> -lidswitch not working, but if working display doesn't come back

Yes, I'm having that problem, too. I can work around it by switching
blindly to a text console and pressing the lid button, again. The text
console will appear then and switching back to X works now. But this
doesn't seem to work if I have the radeon framebuffer enabled. This
still sucks...

I tried to locate and disable the code in the DSDT, which toggles the
backlight off when the lid button is activated, but didn't
succeed. This seems to happen beyong the ACPI realm.

> -irda not working

Can't confirm that. From my modules.conf:

alias irda0 nsc-ircc
options nsc-ircc io=0x03e8 irq=3

I used that to communicate to a mobile phone (Nokia 6210) and it
worked fine.

> -acpi performance not working (known problem)

Same for me. If you manually need to toggle the CPU frequency, try the
cpufreq patch. 

Regards,

Stephan


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
