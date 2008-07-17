From: "Renato S. Yamane" <yamane@diamondcut.com.br>
Subject: Re: Toshiba - Documentation for Linux Developers
Date: Thu, 17 Jul 2008 08:57:27 -0300
Message-ID: <487F33A7.4040809@diamondcut.com.br>
References: <4855971D.90004@diamondcut.com.br> <20080616221443.GA760@kroah.com>	 <b170af450807130654m2f800b10ybcba4b2c5c7cf329@mail.gmail.com>	 <487A1534.3000307@diamondcut.com.br>	 <b170af450807150017u248d4255i3800c10cb11df319@mail.gmail.com>	 <487C865C.5060303@diamondcut.com.br> <b170af450807150446l555e9bbfx3f388d3ebe9cb11f@mail.gmail.com> <487E5130.9040208@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-01.mandic.com.br ([200.225.81.132]:36246 "EHLO
	smtp-01.mandic.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752531AbYGQL5r (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Jul 2008 07:57:47 -0400
In-Reply-To: <487E5130.9040208@gmx.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Robert M. Albrecht" <romal@gmx.de>
Cc: linux-acpi@vger.kernel.org, pavel@suse.cz, linux-kernel@vger.kernel.org, gregkh@suse.de

[cc'ed Greg KH]

Only to remember: Toshiba website to Linux Developers is:
<http://linux.toshiba-dme.co.jp/linux/eng/develop.htm>

Best regards,
Renato S. Yamane


Robert M. Albrecht wrote:
> Hi,
>=20
> both Toshiba types (original and compal-oem machines) are basically
> unsupported for Linux.
>=20
> The omnibook-module for compal-systems was maintained outside the ker=
nel
> and stalled for some time now.
>=20
> The toshiba_acpi included in the kernel is outdated (there is a newer
> release, that fixes some bugs). Toshiba_acpi does only work on 32 bit
> systems, it breaks on 64 bit systems.
>=20
> If anyone is interested in some hacking I can provide shell-access to
> both types of machines.
>=20
> For some Tecra machines, Toshiba has provided some Vista-compatible
> BIOSes, they seem to enhance acpi-stuff for Linux too. So you might l=
ook
> for a bios-update.
>=20
> cu romal
>=20
> www.romal.de
> blog.romal.de
>=20
> Rafa=C5=82 Mi=C5=82ecki schrieb:
>> 2008/7/15, Renato S. Yamane <yamane@diamondcut.com.br>:
>>> Rafa=C5=82 Mi=C5=82ecki wrote:
>>>  > The newest version is packed for openSUSE fortunately. But it do=
esn't
>>>  > for my notebook
>>>
>>> Try compile SVN version as commented in my last e-mail
>>
>> OK, I tried version from SVN. Nothing changed :|
>>
>>
>>>  > dmesg is:
>>>  > omnibook: Driver version 2.20070211-trunk.
>>>  > omnibook: Unknown model.
>>>
>>>
>>> Try force recognize with ectype parameter.
>>>  #modprobe omnibook ectype=3Dx
>>
>> Sure, I tried every ectype between 1 and 15 before (omnibook from
>> package) and now (version from SVN) again. I checked two files (when
>> existed): lcd and temperature. Temperature (if file existed for forc=
ed
>> ectype) was always 0 and lcd always had some random values. Insertin=
g
>> other values (1, 7) didn't change anything.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
