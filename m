From: "Georg C. F. Greve" <greve-mXXj517/zsQ@public.gmane.org>
Subject: Re: PROBLEM: LCD display dead after ACPI suspend to RAM (S3)
Date: Thu, 22 Jan 2004 16:05:17 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <m3hdyoja6q.fsf@reason.gnu-hamburg>
References: <E1AjfWl-0006f8-00@chiark.greenend.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <E1AjfWl-0006f8-00-QGMSyCZBOSwv4zxTlrOuLwNdhmdF6hFW@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: linux-kernel-2V+nj6dI/Rc/ohRxsw7f2g@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

--=-=-=

 || On 2004-01-22 14:09:47, Matthew Garrett wrote:

 > Try passing acpi_sleep=s3_bios or acpi_sleep=s3_mode to the kernel
 > on boot - also try while running X, switch away before suspend and
 > switch back afterwards. The problem is that the kernel doesn't know
 > how to wake the video hardware back up after S3 - the kernel
 > parameters are hacks that try to provoke it back into life, and X
 > is sometimes able to reinitialise stuff itself.

Here is the dmesg once with s3_bios and once with s3_mode.

--=-=-=
Content-Disposition: inline; filename=dmesg-s3_bios.txt

PM: Preparing system for suspend
Stopping tasks: ============================================|
hdc: start_power_step(step: 0)
hdc: completing PM request, suspend
hda: start_power_step(step: 0)
hda: start_power_step(step: 1)
hda: complete_power_step(step: 1, stat: 50, err: 0)
hda: completing PM request, suspend
PM: Entering state.
Back to C!
PM: Finishing up.
PCI: Enabling device 0000:00:1f.5 (0005 -> 0007)
PCI: Setting latency timer of device 0000:00:1f.5 to 64
AC'97 warm reset still in progress? [0xffffffff]
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_write 0: semaphore is not ready for register 0x26
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_write 0: semaphore is not ready for register 0x0
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_write 0: semaphore is not ready for register 0x26
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_write 0: semaphore is not ready for register 0x20
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_write 0: semaphore is not ready for register 0x26
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_write 0: semaphore is not ready for register 0x2
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 0: semaphore is not ready for register 0x2
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 0: semaphore is not ready for register 0x2
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 0: semaphore is not ready for register 0x2
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 0: semaphore is not ready for register 0x2
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 0: semaphore is not ready for register 0x2
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 0: semaphore is not ready for register 0x2
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 0: semaphore is not ready for register 0x2
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 0: semaphore is not ready for register 0x2
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 0: semaphore is not ready for register 0x2
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 0: semaphore is not ready for register 0x2
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_write 0: semaphore is not ready for register 0x2
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 0: semaphore is not ready for register 0x2
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_write 0: semaphore is not ready for register 0x4
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 0: semaphore is not ready for register 0x4
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_write 0: semaphore is not ready for register 0x6
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 0: semaphore is not ready for register 0x6
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_write 0: semaphore is not ready for register 0xa
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 0: semaphore is not ready for register 0xa
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_write 0: semaphore is not ready for register 0xc
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 0: semaphore is not ready for register 0xc
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_write 0: semaphore is not ready for register 0xe
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 0: semaphore is not ready for register 0xe
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_write 0: semaphore is not ready for register 0x10
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 0: semaphore is not ready for register 0x10
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_write 0: semaphore is not ready for register 0x12
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 0: semaphore is not ready for register 0x12
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_write 0: semaphore is not ready for register 0x14
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 0: semaphore is not ready for register 0x14
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_write 0: semaphore is not ready for register 0x16
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 0: semaphore is not ready for register 0x16
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_write 0: semaphore is not ready for register 0x18
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 0: semaphore is not ready for register 0x18
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_write 0: semaphore is not ready for register 0x1a
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 0: semaphore is not ready for register 0x1a
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_write 0: semaphore is not ready for register 0x1c
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 0: semaphore is not ready for register 0x1c
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_write 0: semaphore is not ready for register 0x20
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 0: semaphore is not ready for register 0x20
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_write 0: semaphore is not ready for register 0x22
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 0: semaphore is not ready for register 0x22
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_write 0: semaphore is not ready for register 0x2a
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 0: semaphore is not ready for register 0x2a
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_write 0: semaphore is not ready for register 0x2c
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 0: semaphore is not ready for register 0x2c
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_write 0: semaphore is not ready for register 0x32
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 0: semaphore is not ready for register 0x32
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_write 0: semaphore is not ready for register 0x3a
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 0: semaphore is not ready for register 0x3a
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_write 1: semaphore is not ready for register 0x26
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_write 1: semaphore is not ready for register 0x0
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_write 1: semaphore is not ready for register 0x26
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_write 1: semaphore is not ready for register 0x20
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_write 1: semaphore is not ready for register 0x26
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_write 1: semaphore is not ready for register 0x2
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 1: semaphore is not ready for register 0x2
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 1: semaphore is not ready for register 0x2
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 1: semaphore is not ready for register 0x2
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 1: semaphore is not ready for register 0x2
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 1: semaphore is not ready for register 0x2
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 1: semaphore is not ready for register 0x2
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 1: semaphore is not ready for register 0x2
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 1: semaphore is not ready for register 0x2
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 1: semaphore is not ready for register 0x2
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 1: semaphore is not ready for register 0x2
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_write 1: semaphore is not ready for register 0x1c
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 1: semaphore is not ready for register 0x1c
hda: Wakeup request inited, waiting for !BSY...
hda: start_power_step(step: 1000)
hda: completing PM request, resume
hdc: Wakeup request inited, waiting for !BSY...
hdc: start_power_step(step: 1000)
hdc: completing PM request, resume
Restarting tasks...<6>Synaptics Touchpad, model: 1
 Firmware: 4.6
 180 degree mounted touchpad
 Sensor: 18
 new absolute packet format
 Touchpad has extended capability bits
 -> four buttons
 -> multifinger detection
 -> palm detection
 done
input: SynPS/2 Synaptics TouchPad on isa0060/serio4
eth0: link up, 10Mbps, half-duplex, lpa 0x0000
eth0: link up, 10Mbps, half-duplex, lpa 0x0000
MCE: The hardware reports a non fatal, correctable incident occurred on CPU 0.
Bank 1: f200000000000175

--=-=-=
Content-Disposition: inline; filename=dmesg-s3_mode.txt

PM: Preparing system for suspend
Stopping tasks: =============================================|
hdc: start_power_step(step: 0)
hdc: completing PM request, suspend
hda: start_power_step(step: 0)
hda: start_power_step(step: 1)
hda: complete_power_step(step: 1, stat: 50, err: 0)
hda: completing PM request, suspend
PM: Entering state.
Back to C!
PM: Finishing up.
PCI: Enabling device 0000:00:1f.5 (0005 -> 0007)
PCI: Setting latency timer of device 0000:00:1f.5 to 64
AC'97 warm reset still in progress? [0xffffffff]
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_write 0: semaphore is not ready for register 0x26
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_write 0: semaphore is not ready for register 0x0
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_write 0: semaphore is not ready for register 0x26
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_write 0: semaphore is not ready for register 0x20
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_write 0: semaphore is not ready for register 0x26
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_write 0: semaphore is not ready for register 0x2
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 0: semaphore is not ready for register 0x2
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 0: semaphore is not ready for register 0x2
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 0: semaphore is not ready for register 0x2
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 0: semaphore is not ready for register 0x2
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 0: semaphore is not ready for register 0x2
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 0: semaphore is not ready for register 0x2
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 0: semaphore is not ready for register 0x2
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 0: semaphore is not ready for register 0x2
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 0: semaphore is not ready for register 0x2
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 0: semaphore is not ready for register 0x2
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_write 0: semaphore is not ready for register 0x2
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 0: semaphore is not ready for register 0x2
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_write 0: semaphore is not ready for register 0x4
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 0: semaphore is not ready for register 0x4
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_write 0: semaphore is not ready for register 0x6
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 0: semaphore is not ready for register 0x6
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_write 0: semaphore is not ready for register 0xa
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 0: semaphore is not ready for register 0xa
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_write 0: semaphore is not ready for register 0xc
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 0: semaphore is not ready for register 0xc
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_write 0: semaphore is not ready for register 0xe
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 0: semaphore is not ready for register 0xe
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_write 0: semaphore is not ready for register 0x10
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 0: semaphore is not ready for register 0x10
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_write 0: semaphore is not ready for register 0x12
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 0: semaphore is not ready for register 0x12
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_write 0: semaphore is not ready for register 0x14
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 0: semaphore is not ready for register 0x14
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_write 0: semaphore is not ready for register 0x16
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 0: semaphore is not ready for register 0x16
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_write 0: semaphore is not ready for register 0x18
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 0: semaphore is not ready for register 0x18
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_write 0: semaphore is not ready for register 0x1a
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 0: semaphore is not ready for register 0x1a
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_write 0: semaphore is not ready for register 0x1c
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 0: semaphore is not ready for register 0x1c
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_write 0: semaphore is not ready for register 0x20
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 0: semaphore is not ready for register 0x20
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_write 0: semaphore is not ready for register 0x22
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 0: semaphore is not ready for register 0x22
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_write 0: semaphore is not ready for register 0x2a
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 0: semaphore is not ready for register 0x2a
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_write 0: semaphore is not ready for register 0x2c
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 0: semaphore is not ready for register 0x2c
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_write 0: semaphore is not ready for register 0x32
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 0: semaphore is not ready for register 0x32
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_write 0: semaphore is not ready for register 0x3a
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 0: semaphore is not ready for register 0x3a
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_write 1: semaphore is not ready for register 0x26
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_write 1: semaphore is not ready for register 0x0
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_write 1: semaphore is not ready for register 0x26
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_write 1: semaphore is not ready for register 0x20
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_write 1: semaphore is not ready for register 0x26
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_write 1: semaphore is not ready for register 0x2
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 1: semaphore is not ready for register 0x2
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 1: semaphore is not ready for register 0x2
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 1: semaphore is not ready for register 0x2
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 1: semaphore is not ready for register 0x2
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 1: semaphore is not ready for register 0x2
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 1: semaphore is not ready for register 0x2
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 1: semaphore is not ready for register 0x2
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 1: semaphore is not ready for register 0x2
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 1: semaphore is not ready for register 0x2
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 1: semaphore is not ready for register 0x2
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_write 1: semaphore is not ready for register 0x1c
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 1: semaphore is not ready for register 0x1c
hda: Wakeup request inited, waiting for !BSY...
hda: start_power_step(step: 1000)
hda: completing PM request, resume
hdc: Wakeup request inited, waiting for !BSY...
hdc: start_power_step(step: 1000)
hdc: completing PM request, resume
Restarting tasks...<6>Synaptics Touchpad, model: 1
 Firmware: 4.6
 180 degree mounted touchpad
 Sensor: 18
 new absolute packet format
 Touchpad has extended capability bits
 -> four buttons
 -> multifinger detection
 -> palm detection
 done
input: SynPS/2 Synaptics TouchPad on isa0060/serio4
MCE: The hardware reports a non fatal, correctable incident occurred on CPU 0.
Bank 1: f200000000000175

--=-=-=


For both I still get

 Asus ACPI: Error reading LCD status
 Asus ACPI: Error switching LCD

The only difference is that for s3_bios, the backlight of the LCD is
one, but the screen only shows a pretty uninteresting pattern of three
or four lines.

Regards,
Georg

-- 
Georg C. F. Greve                                       <greve-mXXj517/zsQ@public.gmane.org>
Free Software Foundation Europe	                 (http://fsfeurope.org)
Brave GNU World	                           (http://brave-gnu-world.org)

--=-=-=--


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
