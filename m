From: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Subject: Patches version problem
Date: Sat, 06 Mar 2004 14:12:47 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <4049CE4F.9090409@pca.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

I download again the latest patches for 2.6.3 and 2.6.4 and I've a funny (and
IMHO *very-problematic*) situation:
=====
gismo:/usr/src# ls -l kernel/v2.6/acpi-20040220-2.6.*
- -rw-r--r--    1 luca     luca         9470 Mar  1 08:15
kernel/v2.6/acpi-20040220-2.6.3.diff.bz2
- -rw-r--r--    1 luca     luca        12582 Mar  2 12:24
kernel/v2.6/acpi-20040220-2.6.4.diff.bz2
gismo:/usr/src#

gismo:/usr/src# ls -l /home/luca/download/acpi-20040220-2.6.*
- -rw-------    1 luca     luca        15554 Mar  6 13:56
/home/luca/download/acpi-20040220-2.6.3.diff.bz2
- -rw-r--r--    1 luca     luca        12569 Mar  6 13:56
/home/luca/download/acpi-20040220-2.6.4.diff.bz2
gismo:/usr/src#
=====

So, there're 2 different patches with the same name and this can cause
inconsistency: if you release a patch at 20040305 (the last nigth), why do you
call it 'acpi-20040220'??? I mean, I use 'acpi-20040220' since 20040301 (as from
the 'ls -l') and now I'll use 'acpi-20040220' from 20040305: they are different,
as the size suggests, but from a 'cat /proc/acpi/info' I don't have any way to
know which one I'm using (the 20040301 or 20040305).

Again, why the same name?

Thx, bye,
Gismo / Luca
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQFASc5OVAp7Xm10JmkRAiqqAJ4twhxRmJlrLVubOR/NeYmnYx+5agCfQ+te
RbZlgJiAeXpcddzwTFluz2I=
=s3uL
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
