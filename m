From: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Subject: Re: Re: [Ipw2100-devel] [susp-resume] ipw2100 suspend patch
 for 0.54 (version 3)
Date: Wed, 15 Sep 2004 02:04:28 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <4147870C.9090003@pca.it>
References: <3ACA40606221794F80A5670F0AF15F8403BD570F@pdsmsx403> <413EE1EA.2070307@pca.it> <413F02E7.3060005@pca.it> <20040914222905.GA17380@elf.ucw.cz>
Reply-To: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040914222905.GA17380-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
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

Hello Pavel,

on 09/15/04 00:29, Pavel Machek wrote:
>> BTW is 'echo 4 > /proc/acpi/sleep' = 'echo disk > /sys/power/state'?
> Yes, it should be equivalent.
the same I supposed. But in this case, there's an error somewhere: I can
never resume properly if I use 'echo disk > /sys/power/state' and I get
a kernel panic with these words:

Resuming from /dev/hda7
Resuming from unknown-block(3,7)
Kernel panic - not syncing: Resume Machine: Unable to find
suspending-data signature (pmdisk-swa - mispelled?

Usually, my lilo is configured to append 'resume=/dev/hda7' and I tried
even at boot with 'pmdisk=/dev/hda7', but it doesn't matter. So probably
the code is different in the 2 cases. Can someone check, please? I
suppose the /sys call is better, as all the /proc fs is being ported to
/sys, am I right?

On the other hand, using the /sys call the machine power off correctly
in suspending, while using the /proc call actually I should press 4-sec
the power button after 15-20sec the latest suspending screen.

BTW, I'm on 2.6.9-rc2 with no other patches.

Thx, bye,
Gismo / Luca
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQFBR4cMVAp7Xm10JmkRAsDAAJ9dq5WlwwGRc1kFGD5TgjWTQ4FvHACeNoqj
o8CPipEfsMNMNa2NRul4W/A=
=LjO0
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by: thawte's Crypto Challenge Vl
Crack the code and win a Sony DCRHC40 MiniDV Digital Handycam
Camcorder. More prizes in the weekly Lunch Hour Challenge.
Sign up NOW http://ad.doubleclick.net/clk;10740251;10262165;m
