From: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Subject: Re: 2.4.24 patch apply failed on vanilla kernel
Date: Thu, 08 Jan 2004 11:52:51 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3FFD3683.5070208@pca.it>
References: <3ACA40606221794F80A5670F0AF15F8401720CA3@PDSMSX403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8401720CA3-SRlDPOYGfgogGBtAFL8yw7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

IMHO there's an error errors...
on 01/08/04 10:46, Yu, Luming wrote:
| 		printf("%.4x \n", (1ul << bit)));
this should be
	printf("%.4x \n", (1ul << bit));

With this correction, the output is
| luca-HSB4nKSusd8@public.gmane.org:~$ gcc foo.c
| luca-HSB4nKSusd8@public.gmane.org:~$ ./a.out
| 10000000
| 20000000
| 40000000
| 80000000
| 0001
| 0002
| luca-HSB4nKSusd8@public.gmane.org:~$
| luca-HSB4nKSusd8@public.gmane.org:~$ gcc -v
| Reading specs from /usr/lib/gcc-lib/i486-linux/3.3.3/specs
| Configured with: ../src/configure -v
- --enable-languages=c,c++,java,f77,pascal,objc,ada,treelang --prefix=/usr
- --mandir=/usr/share/man --infodir=/usr/share/info
- --with-gxx-include-dir=/usr/include/c++/3.3 --enable-shared
- --with-system-zlib --enable-nls --without-included-gettext
- --enable-__cxa_atexit --enable-clocale=gnu --enable-debug
- --enable-java-gc=boehm --enable-java-awt=xlib --enable-objc-gc i486-linux
| Thread model: posix
| gcc version 3.3.3 20031229 (prerelease) (Debian)

Thx, bye,
Gismo / Luca
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQE//TaCVAp7Xm10JmkRAk5UAJ466yD8w+fxWoKkQWHIR6XGlCBC3QCeMO0e
3q2RsO7FcmL/592kLSuO7P4=
=SkCq
-----END PGP SIGNATURE-----



-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
