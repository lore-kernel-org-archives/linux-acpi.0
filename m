From: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Subject: Re: ASUS M3N (Centrino)
Date: Thu, 27 Nov 2003 15:26:45 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3FC609A5.8060501@pca.it>
References: <3F9856B8.3080103@pca.it> <3FBF6751.80507@pca.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3FBF6751.80507-wlebWZzHoyE@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

on 11/22/03 14:40, Luca Capello wrote:
| on 10/24/03 00:31, Luca Capello wrote:
| | I downloaded the last kernel 2.6.0-test8 and the last ACPI patched for
| | it. I successfully installed it and it works perfectly, just I get the
| | same "osl / AE_TIME" error I get on kernel 2.4.21, where it was called
| | "osl-8888" and not "osl-8892" (I attached the dmesg to see the exact
| | error message). More, there's another error: "utmisc-0745" that IIRC
| | I've never had on kernel 2.4.21.
| this is an ancient problem never solved.
|
| Now I passed to a new BIOS (version 0205A released 20031117) and to a
| new kernel (2.4.23-rc2, even if I continue using 2.6.0-test9 with the
| same ancient problem as from the attachment). Here the new problems IMHO
| related to ACPI (I attached a part of my 'dmesg' with these errors):
| | ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready
| [0x1][0x700300]
| | ALSA ../../../alsa-kernel/core/seq/oss/seq_oss_init.c:213: no device
| found
| | osl-0898 [9488] os_wait_semaphore     : Failed to acquire
| semaphore[c157b780|1|0], AE_TIME
it seems that no one has a solution for this problem or (worse, but I
don't think so) no one is interested in it. What is real worst is that
other ASUS M3N users reported me the same problem, so it is not linked
to my specific machine.

Could someone help me or at least tell me if this bug is solvable or
not? And if it is an ACPI bug or a DSDT one?

Regards,
Gismo / Luca
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQE/xgmjVAp7Xm10JmkRAjXeAJ9naIlZuIXrIa0v4MpPyiUNH3kvbgCfVuDS
6waZqIgsvBgyzkagZK306wM=
=KWPI
-----END PGP SIGNATURE-----



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
