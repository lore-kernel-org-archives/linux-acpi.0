From: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Subject: ASUS M6800N: sleep states
Date: Sun, 21 Mar 2004 21:01:19 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <405DF48F.30001@pca.it>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080209000501080603000700"
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

This is a multi-part message in MIME format.
--------------080209000501080603000700
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

I just start playing around with sleep states on my new laptop :-)

ATM I tried only S1 and with no 'radeonfb' inclued in the kernel, but compiled
as module (even not loaded, as I got an error I haven't solved yet). In this
condition (so no framebuffer), the suspend is always ok, but the screen is never
blanked and it shows
	 hwsleep-0300 [1297] acpi_enter_sleep_state: Entering sleep state [S1]

Here the results for the resume part:

- - with ALSA ('intel8x0', 'intel8x0m' and OSS) it stops at
	Resuming type 'pit':
	 pit0

- - with ACPI (all the modules and 'asus_acpi') it stops at
	hdc: Wakeup request inited, waiting for !BSY...
  as my DVD-RW/CD-RW support 'Hot Swap Function' (I can change it with
  a 2nd battery or HD - not included, obviously), I tried to remove it
  and if it's not present (so no hdc), the resume is ok. I don't know
  which module causes the problem (anyway, in a complete resume even with
  no ACPI modules I've some ACPI error messages as in the attached log)

- - with USB/'ehci_hcd', it stops after trying to resume 'ehci_hcd' (but I repeat
  that the suspend process is ok, so it's a step forward)

- - with USB/'uhci_hcd', I got one complete resume, but I can't reproduce it
  again, now it freezes at a message like
	uhci_hcd: wake-up

- - with 'agpgart'/'ati_agp'/'radeon', all is ok, even from X with the 'radeon' X
  driver and 'r200' DRI driver (which doesn't let 3D support for my ATI Radeon
  Mobility NP M10/9600)

So, I can confirm a positive and complete S1 suspend/resume via X with no ALSA,
no ACPI, no USB and for different S1 cycles (suspend > resume > suspend >
resume, attached the syslog). Just 2 minor problems: 'reboot' doesn't work (it
freezes on the message "Rebooting...") and 'shutdown -h now' acts as 'reboot'.

ASAP I'll try S3 and S4.

Thx, bye,
Gismo / Luca
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQFAXfSPVAp7Xm10JmkRAlmUAJ96VP0a/JzoiQ+XSV8qKH/s91q9qACcDo1f
EB/+SvKb4oJaayT5pYx3j4M=
=gNZq
-----END PGP SIGNATURE-----

--------------080209000501080603000700
Content-Type: application/x-gzip;
 name="2xS1_2.6.5-rc1.syslog.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="2xS1_2.6.5-rc1.syslog.gz"

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
--------------080209000501080603000700--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
