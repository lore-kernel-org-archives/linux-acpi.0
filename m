From: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Subject: Re: ASUS M3N (Centrino)
Date: Sat, 22 Nov 2003 14:40:33 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3FBF6751.80507@pca.it>
References: <3F9856B8.3080103@pca.it>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040805020908080806070201"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3F9856B8.3080103-wlebWZzHoyE@public.gmane.org>
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

This is a multi-part message in MIME format.
--------------040805020908080806070201
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

on 10/24/03 00:31, Luca Capello wrote:
| I downloaded the last kernel 2.6.0-test8 and the last ACPI patched for
| it. I successfully installed it and it works perfectly, just I get the
| same "osl / AE_TIME" error I get on kernel 2.4.21, where it was called
| "osl-8888" and not "osl-8892" (I attached the dmesg to see the exact
| error message). More, there's another error: "utmisc-0745" that IIRC
| I've never had on kernel 2.4.21.
this is an ancient problem never solved.

Now I passed to a new BIOS (version 0205A released 20031117) and to a
new kernel (2.4.23-rc2, even if I continue using 2.6.0-test9 with the
same ancient problem as from the attachment). Here the new problems IMHO
related to ACPI (I attached a part of my 'dmesg' with these errors):
| ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready
[0x1][0x700300]
| ALSA ../../../alsa-kernel/core/seq/oss/seq_oss_init.c:213: no device found
| osl-0898 [9488] os_wait_semaphore     : Failed to acquire
semaphore[c157b780|1|0], AE_TIME

Should I tweak my DSDT for these problems?

Thx, bye,
Gismo / Luca

PS to all M3N users: the new BIOS (0205A) solved the fan problems
Lindsey Simon experienced (I had some good news about it by another M3N
user), so please update to that one :-)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQE/v2dOVAp7Xm10JmkRAsr8AJ0eLQ/VE44OQUL0qHTWjA2L6mC2DwCeIxsn
VpQWtsfvLL31W5iRMevCisE=
=L9KM
-----END PGP SIGNATURE-----

--------------040805020908080806070201
Content-Type: text/plain;
 name="2.4.23-rc2_alsa-0.9.8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.23-rc2_alsa-0.9.8"

usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
hub.c: new USB device 00:1d.0-2, assigned address 2
usb.c: USB device 2 (vend/prod 0x4b4/0x2020) is not claimed by any active driver.
PCI: Enabling device 00:1f.5 (0005 -> 0007)
PCI: Setting latency timer of device 00:1f.5 to 64
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x700300]
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x700300]
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x700300]
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x700300]
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x700300]
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x700300]
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x700300]
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x700300]
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x700300]
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x700300]
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x700300]
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x700300]
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x700300]
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x700300]
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x700300]
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x700300]
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x700300]
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x700300]
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x700300]
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x700300]
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x700300]
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x700300]
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x700300]
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x700300]
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x700300]
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x700300]
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x700300]
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x700300]
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x700300]
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x700300]
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x700300]
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x700300]
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x700300]
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x700300]
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x700300]
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x700300]
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x700300]
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x700300]
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x700300]
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x700300]
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x700300]
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x700300]
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x700300]
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x700300]
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x700300]
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x700300]
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x700300]
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x700300]
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x700300]
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x700300]
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x700300]
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x700300]
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x700300]
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x700300]
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x700300]
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x700300]
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x700300]
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x700300]
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x700300]
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x700300]
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x700300]
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x700300]
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x700300]
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x700300]
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x700300]
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x700300]
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x700300]
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x700300]
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x700300]
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x700300]
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x700300]
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x700300]
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x700300]
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x700300]
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x700300]
intel8x0: clocking to 57314
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x700300]
ALSA intel8x0.c:583: codec_write 0: semaphore is not ready for register 0x2
usb.c: registered new driver hiddev
usb.c: registered new driver hid
mice: PS/2 mouse device common for all mice
usb-uhci.c: interrupt, status 2, frame# 1158
input: USB HID v1.00 Keyboard [PTC HID PS/2 Keyboard - PS/2 Mouse] on usb2:2.0
input: USB HID v1.00 Mouse [PTC HID PS/2 Keyboard - PS/2 Mouse] on usb2:2.1
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech-AlSwsSmVLrQ@public.gmane.org>
hid-core.c: USB HID support drivers
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x480-0x48f 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
memory : dc9fef00
memory : dc9fef80
memory : d921b100
mtrr: base(0xf0020000) is not aligned on a size(0x4b0000) boundary
memory : d921b200
memory : d921b280
memory : d921b300
memory : d921b380
memory : d921b400
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x700300]
ALSA intel8x0.c:599: codec_read 0: semaphore is not ready for register 0x2c
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x700300]
ALSA intel8x0.c:599: codec_read 0: semaphore is not ready for register 0x2c
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x700300]
ALSA intel8x0.c:599: codec_read 0: semaphore is not ready for register 0x32
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x700300]
ALSA intel8x0.c:599: codec_read 0: semaphore is not ready for register 0x2c
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x700300]
ALSA intel8x0.c:599: codec_read 0: semaphore is not ready for register 0x32
ALSA ../../../alsa-kernel/core/seq/oss/seq_oss_init.c:213: no device found
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x700300]
ALSA intel8x0.c:599: codec_read 0: semaphore is not ready for register 0x2c
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x700300]
ALSA intel8x0.c:599: codec_read 0: semaphore is not ready for register 0x32
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x700300]
ALSA intel8x0.c:599: codec_read 0: semaphore is not ready for register 0x2c
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x700300]
ALSA intel8x0.c:599: codec_read 0: semaphore is not ready for register 0x32
ALSA ../../../alsa-kernel/core/seq/oss/seq_oss_init.c:213: no device found
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x700300]
ALSA intel8x0.c:599: codec_read 0: semaphore is not ready for register 0x2c
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x700300]
ALSA intel8x0.c:599: codec_read 0: semaphore is not ready for register 0x32
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x700300]
ALSA intel8x0.c:599: codec_read 0: semaphore is not ready for register 0x2c
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x700300]
ALSA intel8x0.c:599: codec_read 0: semaphore is not ready for register 0x32
ALSA ../../../alsa-kernel/core/seq/oss/seq_oss_init.c:213: no device found
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x700300]
ALSA intel8x0.c:599: codec_read 0: semaphore is not ready for register 0x2c
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x700300]
ALSA intel8x0.c:599: codec_read 0: semaphore is not ready for register 0x32
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x700300]
ALSA intel8x0.c:599: codec_read 0: semaphore is not ready for register 0x2c
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x700300]
ALSA intel8x0.c:599: codec_read 0: semaphore is not ready for register 0x32
ALSA ../../../alsa-kernel/core/seq/oss/seq_oss_init.c:213: no device found
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x700300]
ALSA intel8x0.c:599: codec_read 0: semaphore is not ready for register 0x2c
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x700300]
ALSA intel8x0.c:599: codec_read 0: semaphore is not ready for register 0x2c
ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x700300]
ALSA intel8x0.c:599: codec_read 0: semaphore is not ready for register 0x32
ALSA ../../../alsa-kernel/core/seq/oss/seq_oss_init.c:213: no device found
ALSA ../../../alsa-kernel/core/seq/oss/seq_oss_init.c:213: no device found
     osl-0898 [9488] os_wait_semaphore     : Failed to acquire semaphore[c157b780|1|0], AE_TIME
     osl-0898 [9492] os_wait_semaphore     : Failed to acquire semaphore[c157b780|1|0], AE_TIME
     osl-0898 [9492] os_wait_semaphore     : Failed to acquire semaphore[c157b780|1|0], AE_TIME
ALSA ../../../alsa-kernel/core/seq/oss/seq_oss_init.c:213: no device found
     osl-0898 [10281] os_wait_semaphore     : Failed to acquire semaphore[c157b780|1|0], AE_TIME
     osl-0898 [10285] os_wait_semaphore     : Failed to acquire semaphore[c157b780|1|0], AE_TIME


--------------040805020908080806070201
Content-Type: text/plain;
 name="2.6.0-test9"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.6.0-test9"

uhci_hcd 0000:00:1d.2: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: irq 4, io base 0000d880
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
PCI: Enabling device 0000:00:1f.5 (0005 -> 0007)
PCI: Setting latency timer of device 0000:00:1f.5 to 64
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x0][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x0][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_semaphore: semaphore is not ready [0x1][0x700300]
intel8x0: clocking to 48000
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_write 0: semaphore is not ready for register 0x2
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x480-0x48f 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
mtrr: base(0xf0020000) is not aligned on a size(0x180000) boundary
     osl-0892 [1202] os_wait_semaphore     : Failed to acquire semaphore[df73e5a0|1|0], AE_TIME
     osl-0892 [1206] os_wait_semaphore     : Failed to acquire semaphore[df73e5a0|1|0], AE_TIME
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_read 0: semaphore is not ready for register 0x2c
     osl-0892 [1448] os_wait_semaphore     : Failed to acquire semaphore[df73e5a0|1|0], AE_TIME
     osl-0892 [1452] os_wait_semaphore     : Failed to acquire semaphore[df73e5a0|1|0], AE_TIME
     osl-0892 [1456] os_wait_semaphore     : Failed to acquire semaphore[df73e5a0|1|0], AE_TIME
     osl-0892 [1460] os_wait_semaphore     : Failed to acquire semaphore[df73e5a0|1|0], AE_TIME
     osl-0892 [1464] os_wait_semaphore     : Failed to acquire semaphore[df73e5a0|1|0], AE_TIME
     osl-0892 [2551] os_wait_semaphore     : Failed to acquire semaphore[df73e5a0|1|0], AE_TIME
     osl-0892 [2555] os_wait_semaphore     : Failed to acquire semaphore[df73e5a0|1|0], AE_TIME
     osl-0892 [2555] os_wait_semaphore     : Failed to acquire semaphore[df73e5a0|1|0], AE_TIME
     osl-0892 [2555] os_wait_semaphore     : Failed to acquire semaphore[df73e5a0|1|0], AE_TIME
     osl-0892 [2564] os_wait_semaphore     : Failed to acquire semaphore[df73e5a0|1|0], AE_TIME
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_read 0: semaphore is not ready for register 0x2c
     osl-0892 [4632] os_wait_semaphore     : Failed to acquire semaphore[df73e5a0|1|0], AE_TIME
     osl-0892 [4636] os_wait_semaphore     : Failed to acquire semaphore[df73e5a0|1|0], AE_TIME
     osl-0892 [4640] os_wait_semaphore     : Failed to acquire semaphore[df73e5a0|1|0], AE_TIME
     osl-0892 [4641] os_wait_semaphore     : Failed to acquire semaphore[df73e860|1|0], AE_TIME
     osl-0892 [4644] os_wait_semaphore     : Failed to acquire semaphore[df73e5a0|1|0], AE_TIME
     osl-0892 [4650] os_wait_semaphore     : Failed to acquire semaphore[df73e5a0|1|0], AE_TIME
     osl-0892 [4654] os_wait_semaphore     : Failed to acquire semaphore[df73e5a0|1|0], AE_TIME
     osl-0892 [4658] os_wait_semaphore     : Failed to acquire semaphore[df73e5a0|1|0], AE_TIME
     osl-0892 [4662] os_wait_semaphore     : Failed to acquire semaphore[df73e5a0|1|0], AE_TIME
Universal TUN/TAP device driver 1.5 (C)1999-2002 Maxim Krasnyansky

--------------040805020908080806070201--



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
