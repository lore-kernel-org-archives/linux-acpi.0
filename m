From: "Georg C. F. Greve" <greve-mXXj517/zsQ@public.gmane.org>
Subject: Re: [Fwd: Re: [PROBLEM] 2.6.3-rc1: still no suspend/resume
 on Centrino notebook (contains agp, lapic, swsusp)]
Date: Wed, 11 Feb 2004 15:48:05 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <m3k72ty8nu.fsf@reason.gnu-hamburg>
References: <3ACA40606221794F80A5670F0AF15F8401CBB68A@PDSMSX403.ccr.corp.intel.com>
	<20040211105531.GA30647@hell.org.pl>
	<20040211110154.GJ12634@redhat.com>
	<20040211112505.GE30647@hell.org.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040211112505.GE30647-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org> (Karol Kozimor's message
 of "Wed, 11 Feb 2004 12:25:05 +0100")
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org, acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

--==-=-=
Content-Type: multipart/mixed; boundary="=-=-="

--=-=-=

 || On Wed, 11 Feb 2004 12:25:05 +0100
 || Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org> wrote: 

 kk> That's especially strange as Nigel's swsusp2 survives the
 kk> suspend. Here's how it looks currently on my system [1]:

 kk> 				pmdisk	swsusp	swsusp2
 kk> intel-agp not loaded		OK	OK	OK
 kk> intel-agp loaded, not in use	(?)	reboot	OK
 kk> intel-agp in use		reboot	reboot	OK

That is interesting. Did you have X running while doing that?

I just ran a similar series with a Kernel 2.6.2 + ACPI 20040116 + the
ACPI/LAPIC patch + swsusp2 on my machine [1]. LAPIC compiled in --
otherwise it won't link, see other mail -- but always booted with
"nolapic" to disable "instant crash" button FN+F8.

Results:

agpgart   intel-agp   i830(DRI)   X11            Result of suspend
                                                 to disk and resume

  -           -          -       without DRI           OK

  *           -          -       without DRI           OK

  *           *          -       without DRI           OK

  *           *          *       without DRI           OK

  *           *          *         with DRI       hung upon resume


So the mere presence of the AGP and DRM/DRI structures doesn't seem to
create the conditions for things to fail. 

Only running an X Server that makes use of DRM/DRI does.


But the intel-agp module is not without fault, either. Because when I
load the i830 DRM/DRI, run the X server on it, turn X off, unload i830
DRM/DRI, the intel_agp still claims to be used by 1.

Also, I tried S3 (suspend to ram) for the hell of it while running X11
without DRM/DRI but with agpgart module loaded.

It showed the typical behaviour (suspends well, resumes very much
successfully with many lines complaining about codec_semaphore (syslog
attached), but very much functional (I can type on the keyboard to
bring up the network and log in remotely). 

Unfortunately, the screen is entirely dead.

I can toggle the /proc/acpi/asus/{brn,lcd} switches as much as I want
without any change. (Un)loading agpgart doesn't change anything
either.

But when doing "modprobe intel-agp" now, the command just simply
hangs. No reaction on that console... no output in dmesg, either.

Trying a shutdown -r, the machine seems to be hanging somewhere, but
since network is dead by then and the screen is dead, it is hard to
tell where.

Having the intel-agp module already loaded while trying S3 doesn't
change the behaviour.


Hope this helps someone to get a clearer idea what might be broken or
missing,

Regards,
Georg



[1] ASUS M2N Intel 855GM Centrio, more details at
    http://bugzilla.kernel.org/show_bug.cgi?id=1774


--=-=-=
Content-Disposition: attachment

Feb 11 15:31:33 myhost kernel: Back to C!
Feb 11 15:31:33 myhost kernel: atkbd.c: Unknown key pressed (translated set 2, code 0x61 on isa0060/serio0).
Feb 11 15:31:33 myhost kernel: atkbd.c: Use 'setkeycodes 61 <keycode>' to make it known.
Feb 11 15:31:33 myhost kernel: PM: Finishing up.
Feb 11 15:31:33 myhost kernel: PCI: Enabling device 0000:00:1f.5 (0005 -> 0007)
Feb 11 15:31:33 myhost kernel: PCI: Setting latency timer of device 0000:00:1f.5 to 64
Feb 11 15:31:33 myhost kernel: AC'97 warm reset still in progress? [0xffffffff]
Feb 11 15:31:33 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 11 15:31:33 myhost kernel: codec_write 0: semaphore is not ready for register 0x26
Feb 11 15:31:33 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 11 15:31:33 myhost kernel: codec_write 0: semaphore is not ready for register 0x0
Feb 11 15:31:33 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 11 15:31:33 myhost kernel: codec_write 0: semaphore is not ready for register 0x26
Feb 11 15:31:33 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 11 15:31:33 myhost kernel: codec_write 0: semaphore is not ready for register 0x20
Feb 11 15:31:33 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 11 15:31:33 myhost kernel: codec_write 0: semaphore is not ready for register 0x26
Feb 11 15:31:33 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 11 15:31:33 myhost kernel: codec_write 0: semaphore is not ready for register 0x2
Feb 11 15:31:33 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 11 15:31:33 myhost kernel: codec_read 0: semaphore is not ready for register 0x2
Feb 11 15:31:33 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 11 15:31:33 myhost kernel: codec_read 0: semaphore is not ready for register 0x2
Feb 11 15:31:33 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 11 15:31:33 myhost kernel: codec_read 0: semaphore is not ready for register 0x2
Feb 11 15:31:33 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 11 15:31:33 myhost kernel: codec_read 0: semaphore is not ready for register 0x2
Feb 11 15:31:33 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 11 15:31:33 myhost kernel: codec_read 0: semaphore is not ready for register 0x2
Feb 11 15:31:33 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 11 15:31:33 myhost kernel: codec_read 0: semaphore is not ready for register 0x2
Feb 11 15:31:33 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 11 15:31:33 myhost kernel: codec_read 0: semaphore is not ready for register 0x2
Feb 11 15:31:33 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 11 15:31:33 myhost kernel: codec_read 0: semaphore is not ready for register 0x2
Feb 11 15:31:33 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 11 15:31:33 myhost kernel: codec_read 0: semaphore is not ready for register 0x2
Feb 11 15:31:33 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 11 15:31:33 myhost kernel: codec_read 0: semaphore is not ready for register 0x2
Feb 11 15:31:33 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 11 15:31:33 myhost kernel: codec_write 0: semaphore is not ready for register 0x2
Feb 11 15:31:33 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 11 15:31:33 myhost kernel: codec_read 0: semaphore is not ready for register 0x2
Feb 11 15:31:33 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 11 15:31:33 myhost kernel: codec_write 0: semaphore is not ready for register 0x4
Feb 11 15:31:33 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 11 15:31:33 myhost kernel: codec_read 0: semaphore is not ready for register 0x4
Feb 11 15:31:33 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 11 15:31:33 myhost kernel: codec_write 0: semaphore is not ready for register 0x6
Feb 11 15:31:33 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 11 15:31:33 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 11 15:31:33 myhost kernel: codec_write 0: semaphore is not ready for register 0xa
Feb 11 15:31:33 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 11 15:31:33 myhost kernel: codec_read 0: semaphore is not ready for register 0xa
Feb 11 15:31:33 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 11 15:31:33 myhost kernel: codec_write 0: semaphore is not ready for register 0xc
Feb 11 15:31:33 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 11 15:31:33 myhost kernel: codec_read 0: semaphore is not ready for register 0xc
Feb 11 15:31:33 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 11 15:31:33 myhost kernel: codec_write 0: semaphore is not ready for register 0xe
Feb 11 15:31:33 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 11 15:31:33 myhost kernel: codec_read 0: semaphore is not ready for register 0xe
Feb 11 15:31:33 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 11 15:31:33 myhost kernel: codec_write 0: semaphore is not ready for register 0x10
Feb 11 15:31:33 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 11 15:31:33 myhost kernel: codec_read 0: semaphore is not ready for register 0x10
Feb 11 15:31:33 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 11 15:31:33 myhost kernel: codec_write 0: semaphore is not ready for register 0x12
Feb 11 15:31:33 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 11 15:31:33 myhost kernel: codec_read 0: semaphore is not ready for register 0x12
Feb 11 15:31:33 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 11 15:31:33 myhost kernel: codec_write 0: semaphore is not ready for register 0x14
Feb 11 15:31:33 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 11 15:31:33 myhost kernel: codec_read 0: semaphore is not ready for register 0x14
Feb 11 15:31:33 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 11 15:31:33 myhost kernel: codec_write 0: semaphore is not ready for register 0x16
Feb 11 15:31:33 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 11 15:31:33 myhost kernel: codec_read 0: semaphore is not ready for register 0x16
Feb 11 15:31:33 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 11 15:31:33 myhost kernel: codec_write 0: semaphore is not ready for register 0x18
Feb 11 15:31:33 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 11 15:31:33 myhost kernel: codec_read 0: semaphore is not ready for register 0x18
Feb 11 15:31:33 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 11 15:31:33 myhost kernel: codec_write 0: semaphore is not ready for register 0x1a
Feb 11 15:31:33 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 11 15:31:33 myhost kernel: codec_read 0: semaphore is not ready for register 0x1a
Feb 11 15:31:33 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 11 15:31:33 myhost kernel: codec_write 0: semaphore is not ready for register 0x1c
Feb 11 15:31:33 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 11 15:31:33 myhost kernel: codec_read 0: semaphore is not ready for register 0x1c
Feb 11 15:31:33 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 11 15:31:33 myhost kernel: codec_write 0: semaphore is not ready for register 0x20
Feb 11 15:31:33 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 11 15:31:33 myhost kernel: codec_read 0: semaphore is not ready for register 0x20
Feb 11 15:31:33 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 11 15:31:33 myhost kernel: codec_write 0: semaphore is not ready for register 0x22
Feb 11 15:31:33 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 11 15:31:33 myhost kernel: codec_read 0: semaphore is not ready for register 0x22
Feb 11 15:31:33 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 11 15:31:33 myhost kernel: codec_write 0: semaphore is not ready for register 0x2a
Feb 11 15:31:33 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 11 15:31:33 myhost kernel: codec_read 0: semaphore is not ready for register 0x2a
Feb 11 15:31:33 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 11 15:31:33 myhost kernel: codec_write 0: semaphore is not ready for register 0x2c
Feb 11 15:31:33 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 11 15:31:33 myhost kernel: codec_read 0: semaphore is not ready for register 0x2c
Feb 11 15:31:33 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 11 15:31:33 myhost kernel: codec_write 0: semaphore is not ready for register 0x32
Feb 11 15:31:33 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 11 15:31:33 myhost kernel: codec_read 0: semaphore is not ready for register 0x32
Feb 11 15:31:33 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 11 15:31:33 myhost kernel: codec_write 0: semaphore is not ready for register 0x3a
Feb 11 15:31:33 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 11 15:31:33 myhost kernel: codec_read 0: semaphore is not ready for register 0x3a
Feb 11 15:31:33 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 11 15:31:33 myhost kernel: codec_write 0: semaphore is not ready for register 0x2a
Feb 11 15:31:33 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 11 15:31:33 myhost kernel: codec_write 0: semaphore is not ready for register 0x2a
Feb 11 15:31:33 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 11 15:31:33 myhost kernel: codec_write 0: semaphore is not ready for register 0x3a
Feb 11 15:31:33 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 11 15:31:33 myhost kernel: codec_write 0: semaphore is not ready for register 0x2a
Feb 11 15:31:33 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 11 15:31:33 myhost kernel: codec_write 1: semaphore is not ready for register 0x26
Feb 11 15:31:33 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 11 15:31:33 myhost kernel: codec_write 1: semaphore is not ready for register 0x0
Feb 11 15:31:33 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 11 15:31:33 myhost kernel: codec_write 1: semaphore is not ready for register 0x26
Feb 11 15:31:33 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 11 15:31:33 myhost kernel: codec_write 1: semaphore is not ready for register 0x20
Feb 11 15:31:33 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 11 15:31:33 myhost kernel: codec_write 1: semaphore is not ready for register 0x26
Feb 11 15:31:33 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 11 15:31:33 myhost kernel: codec_write 1: semaphore is not ready for register 0x2
Feb 11 15:31:33 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 11 15:31:33 myhost kernel: codec_read 1: semaphore is not ready for register 0x2
Feb 11 15:31:33 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 11 15:31:33 myhost kernel: codec_read 1: semaphore is not ready for register 0x2
Feb 11 15:31:33 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 11 15:31:33 myhost kernel: codec_read 1: semaphore is not ready for register 0x2
Feb 11 15:31:33 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 11 15:31:33 myhost kernel: codec_read 1: semaphore is not ready for register 0x2
Feb 11 15:31:33 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 11 15:31:33 myhost kernel: codec_read 1: semaphore is not ready for register 0x2
Feb 11 15:31:33 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 11 15:31:33 myhost kernel: codec_read 1: semaphore is not ready for register 0x2
Feb 11 15:31:33 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 11 15:31:33 myhost kernel: codec_read 1: semaphore is not ready for register 0x2
Feb 11 15:31:33 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 11 15:31:33 myhost kernel: codec_read 1: semaphore is not ready for register 0x2
Feb 11 15:31:33 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 11 15:31:33 myhost kernel: codec_read 1: semaphore is not ready for register 0x2
Feb 11 15:31:33 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 11 15:31:33 myhost kernel: codec_read 1: semaphore is not ready for register 0x2
Feb 11 15:31:33 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 11 15:31:33 myhost kernel: codec_write 1: semaphore is not ready for register 0x1c
Feb 11 15:31:33 myhost kernel: codec_semaphore: semaphore is not ready [0xff][0xffffffff]
Feb 11 15:31:33 myhost kernel: codec_read 1: semaphore is not ready for register 0x1c
Feb 11 15:31:33 myhost kernel: hda: Wakeup request inited, waiting for !BSY...
Feb 11 15:31:33 myhost kernel: hda: start_power_step(step: 1000)
Feb 11 15:31:33 myhost kernel: blk: queue df4f3400, I/O limit 4095Mb (mask 0xffffffff)
Feb 11 15:31:33 myhost kernel: hda: completing PM request, resume
Feb 11 15:31:33 myhost kernel: hdc: Wakeup request inited, waiting for !BSY...
Feb 11 15:31:33 myhost kernel: hdc: start_power_step(step: 1000)
Feb 11 15:31:33 myhost kernel: hdc: completing PM request, resume

--=-=-=
Content-Disposition: inline


-- 
Georg C. F. Greve                                       <greve-mXXj517/zsQ@public.gmane.org>
Free Software Foundation Europe	                 (http://fsfeurope.org)
Brave GNU World	                           (http://brave-gnu-world.org)

--=-=-=--

--==-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP MESSAGE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.8 <http://mailcrypt.sourceforge.net/>

iD8DBQFAKkClbvivwoZXSsoRAkToAJ47CaXBgJDwyhwroUclOFF+jZGH4ACeN+T6
7/PT9aZJfMnCF8Zsxg9FZvA=
=GU4+
-----END PGP MESSAGE-----
--==-=-=--


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
