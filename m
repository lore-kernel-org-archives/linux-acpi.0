From: sjb <ottaky-XuTx12Z7TonQT0dZR+AlfA@public.gmane.org>
Subject: Re: best acpi solution
Date: Thu, 22 May 2003 14:03:56 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3ECCD8CC.80704@ottaky.com>
References: <3ECB3CE2.5000400@ottaky.com> <01db01c31f90$84ae6840$3746028e@bio.dfo.ca> <3ECB8ADF.5020108@ottaky.com> <20030521142117.GX346@poupinou.org> <3ECB9BB8.9070700@ottaky.com> <20030521150233.GY346@poupinou.org> <3ECBA777.9090100@ottaky.com> <20030521154428.GZ346@poupinou.org> <3ECBB096.3070207@ottaky.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3ECBB096.3070207-XuTx12Z7TonQT0dZR+AlfA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Thanks to everyone who helped out with my question from yestrday.

Following the suggestions, I'm trying to build a new kernel based on 
Alan Cox's patches to 2.4.21-rc2

Everything goes fine until I try to make the modules, when I get the 
attached error.

I know this isn't striclty an ACPI question, but I guess many of you 
have been down this route before so I thought I'd ask here in case 
somebody had seen this before.

My gcc version is

linux:/usr/src/linux # gcc -v
Reading specs from /usr/lib/gcc-lib/i486-suse-linux/3.3/specs
Configured with: ../configure --enable-threads=posix --prefix=/usr 
--with-local-prefix=/usr/local --infodir=/usr/share/info 
--mandir=/usr/share/man --libdir=/usr/lib 
--enable-languages=c,c++,f77,objc,java,ada --disable-checking 
--enable-libgcj --with-gxx-include-dir=/usr/include/g++ 
--with-slibdir=/lib --with-system-zlib --enable-shared 
--enable-__cxa_atexit i486-suse-linux
Thread model: posix
gcc version 3.3 20030226 (prerelease) (SuSE Linux)

Any help gratefully received since I'm now almost there ;-)

sjb



make -C atm modules
make[2]: Entering directory `/usr/src/linux-2.4.21-rc2-ac2/drivers/atm'
gcc -D__KERNEL__ -I/usr/src/linux-2.4.21-rc2-ac2/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 
-malign-functions=0 -malign-jumps=0 -malign-loops=0 -DMODULE 
-DMODVERSIONS -include 
/usr/src/linux-2.4.21-rc2-ac2/include/linux/modversions.h -g -nostdinc 
-iwithprefix include -DKBUILD_BASENAME=ambassador  -c -o ambassador.o 
ambassador.c
cc1: warning: -malign-loops is obsolete, use -falign-loops
cc1: warning: -malign-jumps is obsolete, use -falign-jumps
cc1: warning: -malign-functions is obsolete, use -falign-functions
In file included from 
/usr/src/linux-2.4.21-rc2-ac2/include/linux/atmdev.h:212,
                  from ambassador.c:31:
/usr/src/linux-2.4.21-rc2-ac2/include/linux/skbuff.h: In function 
`__pskb_pull':
/usr/src/linux-2.4.21-rc2-ac2/include/linux/skbuff.h:855: warning: 
comparison between signed and unsigned
/usr/src/linux-2.4.21-rc2-ac2/include/linux/skbuff.h: In function 
`pskb_may_pull':
/usr/src/linux-2.4.21-rc2-ac2/include/linux/skbuff.h:871: warning: 
comparison between signed and unsigned
In file included from ambassador.c:31:
/usr/src/linux-2.4.21-rc2-ac2/include/linux/atmdev.h: In function 
`atm_may_send':
/usr/src/linux-2.4.21-rc2-ac2/include/linux/atmdev.h:450: warning: 
comparison between signed and unsigned
ambassador.c:301:21: pasting "." and "start" does not give a valid 
preprocessing token
ambassador.c:305:23: pasting "." and "regions" does not give a valid 
preprocessing token
ambassador.c:310:20: pasting "." and "data" does not give a valid 
preprocessing token
ambassador.c: At top level:
/usr/src/linux-2.4.21-rc2-ac2/include/linux/module.h:299: warning: 
`__module_kernel_version' defined but not used
/usr/src/linux-2.4.21-rc2-ac2/include/linux/module.h:302: warning: 
`__module_using_checksums' defined but not used
ambassador.c:2588: warning: `__module_license' defined but not used
make[2]: *** [ambassador.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.4.21-rc2-ac2/drivers/atm'
make[1]: *** [_modsubdir_atm] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.21-rc2-ac2/drivers'
make: *** [_mod_drivers] Error 2



-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
