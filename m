From: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Subject: ASUS M6800N: shutdown doesn't power off the machine
Date: Tue, 17 Feb 2004 14:37:06 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <40321902.90403@pca.it>
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

I've a simple problem: when I call 'shutdown -h now' or I press the
power button, a clear shutdown is started, but the machine isn't power
off. Here the messages on the console:
=====
Synchronizing SCSI cahce for disk sda:
Power down.
acpi_power_off called
  hwsleep-0265 [36] acpi_enter_sleep_state: Entering sleep state [S5]
=====

At boot, I don't have any problem with 'fsck' or disk checking, so the
shutdown process is ok, but the machine isn't power off. This is on
kernel 2.6.2 with ACPI 20040211. The same happens on kernel 2.6.3-rc4 +
ACPI 20040211 and quite the same on kernel 2.4.24 + ACPI 20040116, the
only difference is that the screen is blank.

I should add that the DSDT of my ASUS M6800N is bad, I mean, there're
some problems about the battery and generally about ACPI modules, but
I'll write another mail about them ASAP.

Please let me know if I should post as kernel bug.

Thx, bye,
Gismo / Luca
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQFAMhkBVAp7Xm10JmkRAi5zAJ9d7yebWO+2RYsvXy1qUXHj9D0UWgCeLrqA
LFaUFFlxBPW/bOb70T5ok9Y=
=JSwj
-----END PGP SIGNATURE-----


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
