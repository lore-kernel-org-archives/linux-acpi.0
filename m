From: liste-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
Subject: Re: Can't poweroff anymore.
Date: Sat, 6 Mar 2004 21:51:46 +0100 (CET)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.58.0403062123360.2855@frog.athome>
References: <20040304180301.GA1754@conectiva.com.br>
 <Pine.LNX.4.58.0403050113230.3779@frog.athome> <Pine.LNX.4.58.0403061054120.1146@frog.athome>
 <4049E76D.4030000@pca.it>
Reply-To: hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <4049E76D.4030000-wlebWZzHoyE@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Cc: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Salut Luca,

On Sat, 6 Mar 2004, Luca Capello wrote:
> I've the same problem on my ASUS M6800N (as reported in the thread called 'ASUS
> M6800N: shutdown doesn't power off the machine' and dated 20040217 at 14:37).
>
> >>>2.6.3. There the patch applys cleanly, but I did not check, if it
> >>>compiles, and fix the regression for 2.6.
> ? are you sure it applys cleanly on 2.6.3? This isn't the case for me:
Yes it applys cleanly against a vanilla 2.6.3.

> =====
> - - (2.6.3 + ACPI 20040220 + ACPI DSDT in initrd + Bruno's _CST)
> gismo:/usr/src/linux-2.6.3-acpi.initrd-processor.cst-hwsleepc2# patch -p1 <
> ../kernel/v2.6/hwsleep.c2-patch
> patching file drivers/acpi/hardware/hwsleep.c
> Hunk #1 FAILED at 249.
As it is only one hunk, this would not have any effect...

Just for you I also tryed 2.6.3 + acpi-20040220 (the version from march
5th - be carefull about different acpi-20040220-versions).
And it also powers-off the machine :-)

But as this regression was introduced with 2.6.3. So I don't think, that
my patch will work for you. But if you get a vanilla-kernel, just have a
try...

> 1 out of 1 hunk FAILED -- saving rejects to file drivers/acpi/hardware/hwsleep.c.rej
> gismo:/usr/src/linux-2.6.3-acpi.initrd-processor.cst-hwsleepc2#
>
> BTW, shutdown doesn't work on 2.6.1 (w/o any patches), not on 2.6.2 (w/o any
> patches) and 2.6.3 or 2.6.4. I attached my .config in order to know if I should
> enable/disable something other.

Cheers
  hartwig felger

Hartwig Felger informatics

- -- 
1024D/339FD693 Hartwig Felger <hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org>
Key fingerprint = FB2F 3EE9 345A D55B 6FF2  0EC1 F5B0 684F 339F D693
For the pulic keys, please visit my page.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQFASjnn9bBoTzOf1pMRAmCKAKCJO+ogRi1sM/eWpp1I2xvX9fU/EQCgsvGS
j0HUsqXkZCRu0OfdpgBN9C4=
=Ob2r
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
