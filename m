From: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Subject: Re: ASUS M6800N: shutdown doesn't power off the machine
Date: Sun, 07 Mar 2004 19:47:56 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <404B6E5C.1000409@pca.it>
References: <40321902.90403@pca.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <40321902.90403-wlebWZzHoyE@public.gmane.org>
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

this mail is the same as I posted on the thread called 'Can't poweroff anymore'
and dated 20040304, as I thought the problem was similar to that thread, but in
fact is completely different.

on 02/17/04 14:37, Luca Capello wrote:
> I've a simple problem: when I call 'shutdown -h now' or I press the
> power button, a clear shutdown is started, but the machine isn't power
> off. Here the messages on the console:
> =====
> Synchronizing SCSI cahce for disk sda:
> Power down.
> acpi_power_off called
>   hwsleep-0265 [36] acpi_enter_sleep_state: Entering sleep state [S5]
> =====
as I was running with 'preempt' and 'APIC/IO-APIC' and with my last ASUS
Centrino M3N 'APIC/IO-APIC' had cause some problems, I tried 3 new configurations:
- - no preempt and no APIC > shutdown works ok
- - preempt and no APIC > shutdown works again
- - preempt and APIC > shutdown doesn't work

Should I post as kernel bug?

Thx, bye,
Gismo / Luca
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQFAS25bVAp7Xm10JmkRAsOKAJ9QQAAFCS2y4A1YmXKIyswZ1jsT4gCbBiMZ
6/4dlLMpLi84DPFFYDRFPvI=
=hRuy
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
