From: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Subject: Fw: Re: Problems with connect/disconnect cycles
Date: Sat, 20 Aug 2005 18:41:24 -0700
Message-ID: <20050820184124.217cba84.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


A few ACPI problems here with Len's latest.

Begin forwarded message:

Date: Sun, 21 Aug 2005 03:32:57 +0200
From: Norbert Preining <preining-DX+603jRYB8@public.gmane.org>
To: linux-usb-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Subject: Re: Problems with connect/disconnect cycles


Hi USB developers, hi Andrew!

On Mon, 21 M=E4r 2005, preining wrote:
> Dear usb developers, dear Andrew!
>=20
> I found that my builtin sd card reader connected via USB port
> experiences several connect/reconnect cycles every time I boot.
>=20
> I am using 2.6.11-mm4.

Same now with 2.6.13-rc6-mm1. This time it got really bad:

Aug 20 14:00:19 gandalf vmunix: usb 2-2: USB disconnect, address 2
Aug 20 14:00:19 gandalf kernel: usb 2-2: new full speed USB device using uh=
ci_hcd and address 3
Aug 20 14:00:19 gandalf kernel: scsi1 : SCSI emulation for USB Mass Storage=
 devices
Aug 20 14:00:19 gandalf kernel: usb-storage: device found at 3
Aug 20 14:00:19 gandalf kernel: usb-storage: waiting for device to settle b=
efore scanning
Aug 20 14:00:21 gandalf usb.agent[6109]:      usb-storage: already loaded
Aug 20 14:00:24 gandalf vmunix:   Vendor: Generic   Model: Flash R/W       =
  Rev: 2002
Aug 20 14:00:24 gandalf vmunix:   Type:   Direct-Access                    =
  ANSI SCSI revision: 02
Aug 20 14:00:24 gandalf vmunix: Attached scsi removable disk sda at scsi1, =
channel 0, id 0, lun 0
Aug 20 14:00:24 gandalf kernel: usb-storage: device scan complete
Aug 20 14:00:26 gandalf scsi.agent[6154]:      sd_mod: loaded successfully =
(for disk)

....

Aug 21 01:55:44 gandalf vmunix: usb 2-2: USB disconnect, address 32
Aug 21 01:55:44 gandalf kernel: usb 2-2: new full speed USB device using uh=
ci_hcd and address 33
Aug 21 01:55:44 gandalf kernel: scsi32 : SCSI emulation for USB Mass Storag=
e devices
Aug 21 01:55:44 gandalf kernel: usb-storage: device found at 33
Aug 21 01:55:44 gandalf kernel: usb-storage: waiting for device to settle b=
efore scanning
Aug 21 01:55:47 gandalf usb.agent[17503]:      usb-storage: already loaded
Aug 21 01:55:49 gandalf vmunix:   Vendor: Generic   Model: Flash R/W       =
  Rev: 2002
Aug 21 01:55:49 gandalf vmunix:   Type:   Direct-Access                    =
  ANSI SCSI revision: 02
Aug 21 01:55:49 gandalf kernel: Attached scsi removable disk sda at scsi32,=
 channel 0, id 0, lun 0
Aug 21 01:55:49 gandalf vmunix: usb-storage: device scan complete
Aug 21 01:55:50 gandalf scsi.agent[17544]:      sd_mod: loaded successfully=
 (for disk)


uuu, now many of these

Aug 21 02:09:18 gandalf vmunix:     ACPI-0131: *** Error: Invalid owner_id:=
 00


and many many more of these:

Aug 21 03:07:19 gandalf vmunix:     ACPI-0096: *** Error: Could not allocat=
e new owner_id (32 max), AE_OWNER_ID_LIMIT



Unfortunately I cannot in any way track down this problem to specific
kernels, or specific work situations. It sometimes happens, sometimes
not.=20

If anyone has any idea how to debug such a stupid problem, I would be
glad.=20

Best wishes

Norbert

---------------------------------------------------------------------------=
----
Dr. Norbert Preining <preining AT logic DOT at>             Universit=E0 di=
 Siena
sip:preining-5G14tY4QmKiDqU6vP1vexV6hYfS7NtTn@public.gmane.org                             +43 (0) 59966-69=
0018
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 =
B094
---------------------------------------------------------------------------=
----
HUCKNALL (vb.)
To crouch upwards: as in the movement of a seated person's feet and
legs made in order to allow a cleaner's hoover to pass beneath them.
			--- Douglas Adams, The Meaning of Liff


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
