From: Birger Peer =?iso-8859-15?q?K=FCpper?= <kuepper-juygj+9FDkuELgA04lAiVw@public.gmane.org>
Subject: Compilation error acpi-20020725-2.4.18
Date: Fri, 26 Jul 2002 16:19:05 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020726141906.3578.qmail@gonicus.de>
Reply-To: kuepper-juygj+9FDkuELgA04lAiVw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Hello,
I`ve patched a 2.4.18 vanilla Kernel with the acpi-20020725-2.4.18.diff Patch.

During compilation I got some errors like:
----------------------------------------------------------------------
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common 
-pipe -mpreferred-stack-boundary=2 -march=i686  -D_LINUX 
-I/usr/src/linux/drivers/acpi/include -DACPI_DEBUG -DKBUILD_BASENAME=dswexec  
-c -o dswexec.o dswexec.c
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common 
-pipe -mpreferred-stack-boundary=2 -march=i686  -D_LINUX 
-I/usr/src/linux/drivers/acpi/include -DACPI_DEBUG -DKBUILD_BASENAME=dswload  
-c -o dswload.o dswload.c
dswload.c: In function `acpi_ds_load2_end_op':
dswload.c:451: structure has no member named `name'
make[4]: *** [dswload.o] Error 1
make[4]: Leaving directory `/usr/src/linux/drivers/acpi/dispatcher'
make[3]: *** [first_rule] Error 2
make[3]: Leaving directory `/usr/src/linux/drivers/acpi/dispatcher'
make[2]: *** [_subdir_dispatcher] Error 2
make[2]: Leaving directory `/usr/src/linux/drivers/acpi'
make[1]: *** [_subdir_acpi] Error 2
make[1]: Leaving directory `/usr/src/linux/drivers'
make: *** [_dir_drivers] Error 2
Bay:/usr/src/linux#
--------------------------------------------

Has anyone any Idea what`s wrong?

Thanks a lot....


Birger


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
