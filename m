From: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Subject: Re: Re: [Ipw2100-devel] [susp-resume] ipw2100 suspend patch
 for 0.54 (version 3)
Date: Wed, 15 Sep 2004 12:23:01 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <41481805.8020106@pca.it>
References: <3ACA40606221794F80A5670F0AF15F8403BD570F@pdsmsx403> <413EE1EA.2070307@pca.it> <413F02E7.3060005@pca.it> <20040914222905.GA17380@elf.ucw.cz> <4147870C.9090003@pca.it> <20040915083734.GA17317@hell.org.pl>
Reply-To: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040915083734.GA17317-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello Karol,

on 09/15/04 10:37, Karol Kozimor wrote:
> Append noresume. swsusp1 kicks in earlier than pmdisk.
this works indeed.

Now, my situation:
- - ASUS M6N with BIOS 0209A
- - kernel 2.6.9-rc2 with no other patches
- - quite all the possible modules for my machine loaded
- - Debian GNU/Linux experimental
- - Debian XFree86-4.3.0.dfsg.1-7 (using the native radeon driver)
- - Debian GNOME 2.7.92-1

I can *successfully* suspend/resume with the 2 calls (/proc or /sys),
directly from XFree86 and with all the modules loaded. As already
reported, the only difference is that with the /sys call, in suspending
I've always the machine which powers off, while with the /proc call I
should power off the machine by pressing 4-sec the power button.

Simple question: which should be the best method to use? /sys or /proc?

Another thing: why for the /sys call I should use 'append=noresume',
while I want to *resume*? I mean, it's not so clear...

Thx, bye,
Gismo / Luca
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQFBSBgFVAp7Xm10JmkRAi8CAJ9mL0FRj3oGsvJRQ2hxaZ4ZFXSyiQCaA3Vo
ljpK7b0WuGf9VMa5Z2SjiD0=
=ONtH
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by: thawte's Crypto Challenge Vl
Crack the code and win a Sony DCRHC40 MiniDV Digital Handycam
Camcorder. More prizes in the weekly Lunch Hour Challenge.
Sign up NOW http://ad.doubleclick.net/clk;10740251;10262165;m
