From: Anish Mistry <mistry.7@osu.edu>
Subject: ASRock K7Upgrade-880 with S3
Date: Wed, 7 Jun 2006 00:20:32 -0400
Message-ID: <200606070020.54592.mistry.7@osu.edu>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4006687.YqoGv0ZTcX";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from am-productions.biz ([69.61.164.22]:16610 "EHLO
	mail.united-ware.com") by vger.kernel.org with ESMTP
	id S1750824AbWFGEUc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 7 Jun 2006 00:20:32 -0400
Received: from [192.168.1.100] (am-productions.biz [69.61.164.22])
	(authenticated bits=0)
	by mail.united-ware.com (8.13.4/8.13.6) with ESMTP id k574NRJw054069
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-acpi@vger.kernel.org>; Wed, 7 Jun 2006 00:23:33 -0400 (EDT)
	(envelope-from mistry.7@osu.edu)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

--nextPart4006687.YqoGv0ZTcX
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

	I'm prefacing my question with email to the FreeBSD ACPI list as this=20
problem is to ultimately debug an ACPI problem in FreeBSD.

=2D- START FreeBSD Email --
I'm trying to get my desktop to STR (S3) and can't even get S3 to=20
semi-powered down state. 6.1-RELEASE-p1

I've updated the BIOS to the latest version.  When I do an acpiconf -s=20
3 the suspend get all the way into the AcpiEnterSleepState function=20
and begins to write registers.  The last  line I see (with full ACPI=20
debugging enabled):
heregs-0708 HwRegisterWrite : ----Entry

Then the power light on the case starts to blink seeming to indicate=20
that it is in suspend, except I can still see output on the monitor=20
and the fans and harddrives are still  running.  Then when I press=20
the power button to try to bring the system back up it then displays:
heregs-0708 HwRegisterWrite : ----Exit
and then continues with a few more HwRegisterWrite and then exits the=20
AcpiEnterSleepState function and then does nothing.  The system shows=20
no life of coming back.  I then need to perform a cold boot, because=20
if I just hit the reset button the system doesn't restart to the=20
point where it gets to the BIOS screen.

My acpidump output is at:
http://am-productions.biz/docs/bigguy.asl
I've fixed the errors in the asl and tried using that, but it showed=20
the same problem.
http://am-productions.biz/docs/bigguy-fix.asl
dmesg:
http://am-productions.biz/docs/bigguy.dmesg

When I do an "acpidump -dt" I see the following message displayed:
acpidump: RSDT entry 2 (sig OEMB) is corrupt

Windows isn't installed on this system so I can't compare it with=20
that.  I tried suspending with Knoppix (2006-06-01) and that worked a=20
bit better.  It successfully shuts off the disks on suspend, but the=20
case fans and video card/monitor were still on.  When you press the=20
power button again in knoppix it successfully brought the system back=20
to life.  Getting it to the point of Knoppix would be a good start.

S1 in FreeBSD does work, but it doesn't shut anything down, so it's=20
not really useful.

hw.acpi.supported_sleep_state: S1 S3 S4 S5
hw.acpi.power_button_state: S5
hw.acpi.sleep_button_state: S1
hw.acpi.lid_switch_state: S3
hw.acpi.standby_state: S1
hw.acpi.suspend_state: S3
hw.acpi.sleep_delay: 5
hw.acpi.s4bios: 0
hw.acpi.verbose: 1
hw.acpi.reset_video: 0
hw.acpi.cpu.cx_supported: C1/0
hw.acpi.cpu.cx_lowest: C1
hw.acpi.cpu.cx_usage: 100.00%
debug.acpi.acpi_ca_version: 0x20041119
I've also tried CURRENT with ACPI-CA 20051021 with the same results.
=2D- END FreeBSD Email --

Now for the Linux part.  Since Linux (Knoppix with kernel 2.6.17)=20
seems to get at least some of the suspend/resume right I'm trying to=20
figure out how to get it to display the full debug information to=20
compare with FreeBSD.  I'm looking for how to do the following in=20
Linux:
http://www.freebsd.org/doc/en_US.ISO8859-1/books/handbook/acpi-debug.html
Specifically the ACPI layer and level debugging mention at the end of=20
the page.

Thanks,

=2D-=20
Anish Mistry

--nextPart4006687.YqoGv0ZTcX
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (FreeBSD)

iD8DBQBEhlQmxqA5ziudZT0RAkugAKCxL7nRt4IU7PjZNRnNAA2XUxxpmwCeNzTG
F5bg+BlcLN0r7u+KBbXYG9w=
=CwE3
-----END PGP SIGNATURE-----

--nextPart4006687.YqoGv0ZTcX--
