From: "Robert M. Albrecht" <romal@gmx.de>
Subject: Re: Toshiba - Documentation for Linux Developers
Date: Wed, 16 Jul 2008 21:51:12 +0200
Message-ID: <487E5130.9040208@gmx.de>
References: <4855971D.90004@diamondcut.com.br> <20080616221443.GA760@kroah.com>	 <b170af450807130654m2f800b10ybcba4b2c5c7cf329@mail.gmail.com>	 <487A1534.3000307@diamondcut.com.br>	 <b170af450807150017u248d4255i3800c10cb11df319@mail.gmail.com>	 <487C865C.5060303@diamondcut.com.br> <b170af450807150446l555e9bbfx3f388d3ebe9cb11f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759251AbYGPTvv@vger.kernel.org>
In-Reply-To: <b170af450807150446l555e9bbfx3f388d3ebe9cb11f@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: pavel@suse.cz, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi,

both Toshiba types (original and compal-oem machines) are basically=20
unsupported for Linux.

The omnibook-module for compal-systems was maintained outside the kerne=
l=20
and stalled for some time now.

The toshiba_acpi included in the kernel is outdated (there is a newer=20
release, that fixes some bugs). Toshiba_acpi does only work on 32 bit=20
systems, it breaks on 64 bit systems.

If anyone is interested in some hacking I can provide shell-access to=20
both types of machines.

=46or some Tecra machines, Toshiba has provided some Vista-compatible=20
BIOSes, they seem to enhance acpi-stuff for Linux too. So you might loo=
k=20
for a bios-update.

cu romal

www.romal.de
blog.romal.de

Rafa=C5=82 Mi=C5=82ecki schrieb:
> 2008/7/15, Renato S. Yamane <yamane@diamondcut.com.br>:
>> Rafa=C5=82 Mi=C5=82ecki wrote:
>>  > The newest version is packed for openSUSE fortunately. But it doe=
sn't
>>  > for my notebook
>>
>> Try compile SVN version as commented in my last e-mail
>=20
> OK, I tried version from SVN. Nothing changed :|
>=20
>=20
>>  > dmesg is:
>>  > omnibook: Driver version 2.20070211-trunk.
>>  > omnibook: Unknown model.
>>
>>
>> Try force recognize with ectype parameter.
>>  #modprobe omnibook ectype=3Dx
>=20
> Sure, I tried every ectype between 1 and 15 before (omnibook from
> package) and now (version from SVN) again. I checked two files (when
> existed): lcd and temperature. Temperature (if file existed for force=
d
> ectype) was always 0 and lcd always had some random values. Inserting
> other values (1, 7) didn't change anything.
>=20
