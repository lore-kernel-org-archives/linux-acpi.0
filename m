From: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Subject: Re: [PATCH] bug in acpi_os_wait_semaphore
Date: Sat, 06 Mar 2004 14:34:49 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <4049D379.3000107@pca.it>
References: <20040303143725.GA1657@ergo.gotdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040303143725.GA1657-nlVyBo/8EO9N0TnZuCh8vA@public.gmane.org>
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

on 03/03/04 15:37, Sebastian Seifert wrote:
> I have found a tiny bug in acpi_os_wait_semaphore, which has caused my mutex
> problems. If Acquire is called on a mutex with a non-zero, non-infinity
> timeout, a bad return value check will cause the timeout to expire instantly.
I've a problem with 'acpi_os_wait_semaphore':
=====
luca-HSB4nKSusd8@public.gmane.org:/usr/src$ dmesg | tail -n 5
     osl-0909 [1212919] os_wait_semaphore     : Failed to acquire
semaphore[dff3e600|1|0], AE_TIME
     osl-0909 [1213627] os_wait_semaphore     : Failed to acquire
semaphore[dff3e600|1|0], AE_TIME
     osl-0909 [1213649] os_wait_semaphore     : Failed to acquire
semaphore[dff3e600|1|0], AE_TIME
     osl-0909 [1219462] os_wait_semaphore     : Failed to acquire
semaphore[dff3e600|1|0], AE_TIME
     osl-0909 [1219483] os_wait_semaphore     : Failed to acquire
semaphore[dff3e600|1|0], AE_TIME
luca-HSB4nKSusd8@public.gmane.org:/usr/src$
=====

Could your patch solve it?

Thx, bye,
Gismo / Luca
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQFASdN4VAp7Xm10JmkRAu3oAJwLev6mvIlrkNsEWHM+HwmybuVtqACfWeHp
UayMAyMXnm5xF08cn2FXqeI=
=cXYE
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
