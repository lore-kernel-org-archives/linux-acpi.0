From: Sedat Dilek <sedat.dilek@googlemail.com>
Subject: Re: Warning: pnp 00:0b: can't evaluate _CRS: 12311
Date: Thu, 26 Apr 2012 00:06:39 +0200
Message-ID: <CA+icZUVHO-7SXq3+qz1Gh3yrWtT+R15iiRG0DCLbcKn2PchVHA@mail.gmail.com>
References: <CA+icZUWVwUr19xL0Dn5mHnZjQaVjj6VYD3BMMktEWO0vgoZEXw@mail.gmail.com>
	<CA+icZUUGFaz0c-tHa9EGUxZaxPj_M=zrE+kE0dv5UMoA6GyN3w@mail.gmail.com>
	<CAErSpo5vZSf_EZr6-XnAA8N2Luv6rA92YtZsidWZCZ8rarkPUQ@mail.gmail.com>
	<CA+icZUU+asnLWAevwqKBgnvrmKNitL8-0+8ijDii4pt9VsjspA@mail.gmail.com>
	<94F2FBAB4432B54E8AACC7DFDE6C92E346A77806@ORSMSX101.amr.corp.intel.com>
	<CAErSpo5E3E=A+EEAZjmkYc8x3B==9ZtYufNaG4t8xQegtOfxfA@mail.gmail.com>
	<94F2FBAB4432B54E8AACC7DFDE6C92E346A77908@ORSMSX101.amr.corp.intel.com>
	<CAErSpo7Yj6_QZCSeNKXksiYayV53gkUubVBTnRRu8z1pyWeMQQ@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:61173 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757501Ab2DYWGj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Apr 2012 18:06:39 -0400
In-Reply-To: <CAErSpo7Yj6_QZCSeNKXksiYayV53gkUubVBTnRRu8z1pyWeMQQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Moore, Robert" <robert.moore@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Lin, Ming M" <ming.m.lin@intel.com>

On Wed, Apr 25, 2012 at 11:57 PM, Bjorn Helgaas <bhelgaas@google.com> w=
rote:
> On Wed, Apr 25, 2012 at 3:39 PM, Moore, Robert <robert.moore@intel.co=
m> wrote:
>> This disassembly might make more sense. From the looks of the ASL, s=
everal of the address base and length fields are being updated dynamica=
lly. =C2=A0I don't see anything that would corrupt a resource descripto=
r, however.
>>
>>
>> Are we certain that the ACPI Error and pnp messages are directly rel=
ated to the PNP0C02 device ID?
>>
>> [ =C2=A0 =C2=A00.293699] system 00:0a: Plug and Play ACPI device, ID=
s PNP0c02 (active)
>> [ =C2=A0 =C2=A00.294032] ACPI Error: Invalid/unsupported resource de=
scriptor: Type 0x00 (20120320/utresrc-650)
>> [ =C2=A0 =C2=A00.294037] pnp 00:0b: can't evaluate _CRS: 12311
>
> Oh, I'm sorry, I just wasted your time. =C2=A0I didn't notice the 0a/=
0b
> mismatch. =C2=A0You're right, the _CRS error is on 00:0b, and we don'=
t know
> what the path is or the PNP ID for 00:0b.
>
> Sedat, can you run "grep . /sys/bus/pnp/devices/*/id" please? =C2=A0T=
hat
> will at least show us the PNP ID of device 00:0b.
>
> Bjorn

Here we go:

$ sudo grep . /sys/bus/pnp/devices/*/id
/sys/bus/pnp/devices/00:00/id:PNP0a08
/sys/bus/pnp/devices/00:00/id:PNP0a03
/sys/bus/pnp/devices/00:01/id:PNP0200
/sys/bus/pnp/devices/00:02/id:INT0800
/sys/bus/pnp/devices/00:03/id:PNP0103
/sys/bus/pnp/devices/00:04/id:PNP0c04
/sys/bus/pnp/devices/00:05/id:PNP0c02
/sys/bus/pnp/devices/00:06/id:PNP0b00
/sys/bus/pnp/devices/00:07/id:INT3f0d
/sys/bus/pnp/devices/00:07/id:PNP0c02
/sys/bus/pnp/devices/00:08/id:PNP0303
/sys/bus/pnp/devices/00:09/id:ETD0b00
/sys/bus/pnp/devices/00:09/id:SYN0002
/sys/bus/pnp/devices/00:09/id:PNP0f13
/sys/bus/pnp/devices/00:0a/id:PNP0c02
/sys/bus/pnp/devices/00:0b/id:PNP0c01

- Sedat -
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
