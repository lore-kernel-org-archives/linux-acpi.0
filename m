From: Stefan Seyfried <seife@suse.de>
Subject: Re: Call for help: list of machines with working S3
Date: Tue, 15 Feb 2005 17:05:04 +0100
Message-ID: <42121DB0.8080602@suse.de>
References: <20050214211105.GA12808@elf.ucw.cz> <200502150605.11683.s0348365@sms.ed.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261767AbVBOQF0@vger.kernel.org>
In-Reply-To: <200502150605.11683.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: Pavel Machek <pavel@suse.cz>, ACPI mailing list <acpi-devel@lists.sourceforge.net>, kernel list <linux-kernel@vger.kernel.org>, rjw@sisk.pl
List-Id: linux-acpi@vger.kernel.org

Alistair John Strachan wrote:
> On Monday 14 Feb 2005 21:11, Pavel Machek wrote:
> [snip]
>>Table of known working systems:
>>
>>Model                           hack (or "how to do it")
>>---------------------------------------------------------------------=
------
>>--- IBM TP R32 / Type 2658-MMG      none (1)
>>Athlon HP Omnibook XE3		none (1)
>>Compaq Armada E500 - P3-700     none (1) (S1 also works OK)
>>IBM t41p			none (1)
>>Athlon64 desktop prototype	s3_bios (2)
>>HP NC6000			s3_bios (2)
>=20
> The above report is incorrect. On 2.6.11-rc4, even with the s3_bios o=
ption,=20
> the NC6000 (which I own) still does not wake up from S3 sleep. The wi=
ki=20
> linked somewhere else in this thread also identifies these machines a=
s not=20
> working.

I just retried it with a nc6000, it worked with "vga=3Dnormal
acpi_sleep=3Ds3_bios rw init=3D/bin/bash".
It did not work from a full blown system including X etc, but this is
probably a driver problem, the machine was sitting in a docking station
which connects everything via USB. Sorry, right now i cannot debug this
further, but it basically works and should not be too hard to get going=
=2E

Also, it does not work with vesafb (I have not tried radeonfb)
--=20
Stefan Seyfried, QA / R&D Team Mobile Devices, SUSE LINUX N=FCrnberg.

"Any ideas, John?"
"Well, surrounding them's out."
