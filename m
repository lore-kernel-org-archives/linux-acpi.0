From: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Subject: ASUS M3N and sleep states
Date: Sat, 27 Dec 2003 12:52:41 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3FED7289.1070201@pca.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
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

I made some more tests about the sleep states on an ASUS M3N (Centrino
based). Even if I never got a complete resume, here the results:

- - S1
obviously, if I leave the USB module on, the resume process hangs trying
to set the IRQ for the USB controllers. So, I unload the USB modules and
the resume process hangs again. I found that the other problem are the
ALSA modules: if I unload them (and the USB as well), the resume process
goes well, but it automatically enters in INIT 0 (so it reboots). I
don't know how I could get a resume to my previous INIT...

- - S3
without USB and ALSA, the fan turns on suddendly after the 'echo 3 >
/proc/acpi/sleep', as when my OS hangs for other reasons. IMHO this is a
problem with the BIOS (and the DSDT), as once I shut down the PC
pressing 5sec the power-button, I need to press 2 times the power-button
to reach again a boot (the first time I press the power-button, the
laptop powers on and suddenly powers off).

- - S4
without USB and ALSA, I got a clear power-down and for the resume
(passing to the kernel the option 'resume=/dev/hda6' which is my swap
partition), the OS seems to resume correctly, it sees my resume command,
reads the resume partition, but then it reboots and my swap partition is
corrupted (I need a mkswap on my swap partition).

I use a kernel 2.6.0, without any ACPI patch, and I enable all the
'Power Management' options, as in my .config here:
	#
	# Power management options (ACPI, APM)
	#
	CONFIG_PM=y
	CONFIG_SOFTWARE_SUSPEND=y
	CONFIG_PM_DISK=y
	CONFIG_PM_DISK_PARTITION="/dev/hda6"

	#
	# ACPI (Advanced Configuration and Power Interface) Support
	#
	CONFIG_ACPI=y
	CONFIG_ACPI_BOOT=y
	CONFIG_ACPI_INTERPRETER=y
	CONFIG_ACPI_SLEEP=y
	CONFIG_ACPI_SLEEP_PROC_FS=y
	CONFIG_ACPI_AC=m
	CONFIG_ACPI_BATTERY=m
	CONFIG_ACPI_BUTTON=m
	CONFIG_ACPI_FAN=m
	CONFIG_ACPI_PROCESSOR=m
	CONFIG_ACPI_THERMAL=m
	CONFIG_ACPI_ASUS=m
	# CONFIG_ACPI_TOSHIBA is not set
	CONFIG_ACPI_DEBUG=y
	CONFIG_ACPI_BUS=y
	CONFIG_ACPI_EC=y
	CONFIG_ACPI_POWER=y
	CONFIG_ACPI_PCI=y
	CONFIG_ACPI_SYSTEM=y
	CONFIG_ACPI_RELAXED_AML=y

If someone could point me the problems/bugs...

Thx, bye,
Gismo / Luca
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQE/7XKIVAp7Xm10JmkRAuxlAJ9QfenGXhgCBnm2htmoBztQ7yqzawCcCWbP
Hjxd5LkTCuBSUgokIBGqkZs=
=EAkm
-----END PGP SIGNATURE-----



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
