From: Niel Lambrechts <antispam-T38vF8X/L2bu3wEYkePUmQ@public.gmane.org>
Subject: [Problem] ACPI/madwifi kernel 2.6.4-rc1
Date: Sat, 28 Feb 2004 19:03:58 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1077987838.3259.21.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
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
To: Madwifi-users-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I get a failure of both alsa and ath_pci when I resume from an (ACPI 3)
suspend. After this I can still unload and reload the modules, but never
set up a wireless connection again, unless I reboot. If wireless modules
are not loaded, alsa does not display this resume failure.

When I use APM I can actively perform a wireless ping and play a mp3
when suspending - when I resume things are ok - the audio and ping will
resume. With acpi, both will fail almost immediately after resuming.
When I enable debugging I get:

Feb 28 18:04:01 localhost kernel: R (d21040dc 121040dc) 12104108
1e83f020 00000000 00000960 10000000 5e331911 !
Feb 28 18:04:01 localhost kernel: R (d2104108 12104108) 12104134
128b3020 00000000 00000960 1ff00000 70381911 !
Feb 28 18:04:01 localhost kernel: R (d2104134 12104134) 12104160
1cf42020 00000000 00000960 1ff00000 23471911 !

but bothing really descriptive.

I am using version ATH v0.8.5.2 from CVS on a Thinkpad R50P with IBM
802.11a/b/g built-in card. 

I am also using my own dsdt table - I have followed instructions to
correct 1 error and 2 warnings using iasl on dsdt.dsl. This fixed
/proc/acpi/events for me, but since I'm not an expert I'm scared I might
have broken something else...

-Niel

PS. Please include my e-mail address in your response as I am not a
subscriber.


Kernel options:
# ACPI (Advanced Configuration and Power Interface) Support
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
CONFIG_ACPI_TOSHIBA=m
CONFIG_ACPI_DEBUG=y
CONFIG_ACPI_BUS=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y





-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
