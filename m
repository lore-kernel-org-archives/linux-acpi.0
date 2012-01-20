From: joeyli <jlee@suse.com>
Subject: Re: Fwd: Brightness on HP EliteBook 8460p
Date: Fri, 20 Jan 2012 11:12:18 +0800
Message-ID: <1327029139.15960.80.camel@linux-s257.site>
References: <3123346.jTQFjj4kVk@pali-elitebook>
	 <1324440344.10394.444.camel@linux-s257.site>
	 <9136713.SR1vWBOW6T@pali-elitebook>  <2185391.v0fsgiUWSx@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <2185391.v0fsgiUWSx@pali>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi Pali,=20

Sorry for I am late reply you.

=E6=96=BC =E4=BA=8C=EF=BC=8C2012-01-17 =E6=96=BC 19:10 +0100=EF=BC=8CPa=
li Roh=C3=A1r =E6=8F=90=E5=88=B0=EF=BC=9A
> On Wednesday 21 December 2011 12:45:07 Pali Roh=C3=A1r wrote:
> > Hello,
> >=20
> > I tried to boot with all 3 strings in acpi_os_name, but nothing was=
 changed.
> > I'm attaching dmesg outputs, one from BIOS mode, one from UEFI mode=
=2E Both
> > are with "Microsoft Windows NT".
>=20
> Did you looked at my logs?
>=20
> --=20
> Pali Roh=C3=A1r
> pali.rohar@gmail.com

I checked your dmesg log, found the acpi_os_name kernel parameter is :

[    0.000000] Command line: BOOT_IMAGE=3D/vmlinuz-3.2.0-4-generic
root=3DUUID=3D4ec6272a-8551-40f3-a1b1-3e10984f3e69 ro pcie_aspm=3Dforce
acpi.debug_level=3D0x2 acpi.debug_layer=3D0xFFFFFFFF "acpi_os_name=3DMi=
crosoft
Windows NT" splash vt.handoff=3D7

We still need by-pass the os name check in DSDT when test function key,
please help to feed:
	acpi_os_name=3D"Windows 2009"

And,
looks like the acpi debug level not enough, please kindly change acpi
debug parameter to:
	acpi.debug_level=3D0xF acpi.debug_layer=3D0xFFFFFFFF log_buf_len=3D5M

summary:
	acpi.debug_level=3D0xF acpi.debug_layer=3D0xFFFFFFFF log_buf_len=3D5M =
acpi_os_name=3D"Windows 2009"


Thanks a lot!
Joey Lee
