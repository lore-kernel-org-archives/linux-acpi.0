From: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Subject: Re: PROBLEM: LCD display dead after ACPI suspend to RAM (S3)
Date: Thu, 22 Jan 2004 15:38:19 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <400FE05B.8070602@pca.it>
References: <m3hdyo2kce.fsf@reason.gnu-hamburg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <m3hdyo2kce.fsf-glUV91rXKAHWIjgkaejU9x2eb7JE58TQ@public.gmane.org>
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

on 01/22/04 14:17, Georg C. F. Greve wrote:
> Hi all,
>
> on an ASUS M2400N [*] with both plain vanilla Linux Kernel 2.6.1 and
> 2.6.1 + acpi-20031203, the machine appears to suspend to RAM without a
> problem and it also apparently comes back, but the screen is dead.
same here with an ASUS M3N (always a Centrino one), problem already
reported in this list here:

http://sourceforge.net/mailarchive/forum.php?thread_id=3676335&forum_id=6102

> PCI: Enabling device 0000:00:1f.5 (0005 -> 0007)
> PCI: Setting latency timer of device 0000:00:1f.5 to 64
> AC'97 warm reset still in progress? [0xffffffff]
> codec_semaphore: semaphore is not ready [0xff][0xffffffff]
> codec_write 0: semaphore is not ready for register 0x26
> codec_semaphore: semaphore is not ready [0xff][0xffffffff]
> codec_write 0: semaphore is not ready for register 0x0
> codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Finally, another user with my problem: IMHO this is indeed a problem in
te BIOS, because I starting having this error when I upgrade my M3N BIOS
from 0203A to 0205A. With this problem, I got even other errors like:

> gismo:/home/luca# dmesg | tail -n 10
>      osl-0885 [869978] os_wait_semaphore     : Failed to acquire
semaphore[df73e5a0|1|0], AE_TIME
>      osl-0885 [869974] os_wait_semaphore     : Failed to acquire
semaphore[df73e5a0|1|0], AE_TIME
>      osl-0885 [874572] os_wait_semaphore     : Failed to acquire
semaphore[df73e5a0|1|0], AE_TIME
>      osl-0885 [874572] os_wait_semaphore     : Failed to acquire
semaphore[df73e5a0|1|0], AE_TIME
>      osl-0885 [874581] os_wait_semaphore     : Failed to acquire
semaphore[df73e5a0|1|0], AE_TIME
>      osl-0885 [874590] os_wait_semaphore     : Failed to acquire
semaphore[df73e5a0|1|0], AE_TIME
>      osl-0885 [874596] os_wait_semaphore     : Failed to acquire
semaphore[df73e860|1|0], AE_TIME
>      osl-0885 [874617] os_wait_semaphore     : Failed to acquire
semaphore[df73e5a0|1|0], AE_TIME
>      osl-0885 [874618] os_wait_semaphore     : Failed to acquire
semaphore[df73e5a0|1|0], AE_TIME
>      osl-0885 [874628] os_wait_semaphore     : Failed to acquire
semaphore[df73e5a0|1|0], AE_TIME
> gismo:/home/luca#

and when these errors occurred, keyboard doesn't respond, as it you're
keeping a button pressed. This is very annoying, if someone could please
tell me to whom I should address for this problem. On the other hand,
ALSA drivers works quite perfectly (except for some glitches on GNOME
and 'esd').

Thx, bye,
Gismo / Luca
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQFAD+BZVAp7Xm10JmkRAopoAKCDfpB2JcmhkDyEDKJBWwuRU/EphwCdEOCp
xKxrGaxN3o7rYuMOUcz58tA=
=gw9U
-----END PGP SIGNATURE-----



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
