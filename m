From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: pmtools at intel
Date: Thu, 13 Mar 2003 19:46:34 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030313184634.GA1428@elf.ucw.cz>
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
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

Hmm, Intel asked me to fill in survey when trying to download
pmtools. Weird.

Then pmtools will not compile:

gcc -Wall -fno-strength-reduce -fomit-frame-pointer -D__KERNEL__
-DMODULE -I/usr/src/linux/include -Wall -Wno-unused -Wno-multichar
-c -o pmtest.o pmtest.c
pmtest.c: In function `pmtest_devices':
pmtest.c:53: warning: int format, long int arg (arg 5)
/tmp/ccCy61dB.s: Assembler messages:
/tmp/ccCy61dB.s:522: Error: `%al' not allowed with `movl'
/tmp/ccCy61dB.s:526: Error: `%al' not allowed with `xorl'
/tmp/ccCy61dB.s:611: Warning: using `%eax' instead of `%ax' due to `l'
suffix
/tmp/ccCy61dB.s:615: Warning: using `%eax' instead of `%ax' due to `l'
suffix
/tmp/ccCy61dB.s:615: Warning: using `%eax' instead of `%ax' due to `l'
suffix
make[1]: *** [pmtest.o] Error 1
make[1]: Leaving directory
`/linux_hdc2/usr/src/pmtools-20010730/pmtest'
make: *** [all] Error 2
root@amd:/usr/src/pmtools-20010730#

fortunately I do not need pmtest :-).

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]


-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
