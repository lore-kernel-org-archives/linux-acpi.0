From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: Warning: pnp 00:0b: can't evaluate _CRS: 12311
Date: Thu, 26 Apr 2012 00:14:50 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E346A779ED@ORSMSX101.amr.corp.intel.com>
References: <CA+icZUWVwUr19xL0Dn5mHnZjQaVjj6VYD3BMMktEWO0vgoZEXw@mail.gmail.com>
 <CA+icZUUGFaz0c-tHa9EGUxZaxPj_M=zrE+kE0dv5UMoA6GyN3w@mail.gmail.com>
 <CAErSpo5vZSf_EZr6-XnAA8N2Luv6rA92YtZsidWZCZ8rarkPUQ@mail.gmail.com>
 <CA+icZUU+asnLWAevwqKBgnvrmKNitL8-0+8ijDii4pt9VsjspA@mail.gmail.com>
 <94F2FBAB4432B54E8AACC7DFDE6C92E346A77806@ORSMSX101.amr.corp.intel.com>
 <CAErSpo5E3E=A+EEAZjmkYc8x3B==9ZtYufNaG4t8xQegtOfxfA@mail.gmail.com>
 <94F2FBAB4432B54E8AACC7DFDE6C92E346A77908@ORSMSX101.amr.corp.intel.com>
 <CAErSpo7Yj6_QZCSeNKXksiYayV53gkUubVBTnRRu8z1pyWeMQQ@mail.gmail.com>
 <CA+icZUVHO-7SXq3+qz1Gh3yrWtT+R15iiRG0DCLbcKn2PchVHA@mail.gmail.com>
 <CAErSpo4Jsx5C2JG6qtU=qnA6RFNH+H4mDajEuKgAFkAodakF3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:47388 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932453Ab2DZAOw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Apr 2012 20:14:52 -0400
In-Reply-To: <CAErSpo4Jsx5C2JG6qtU=qnA6RFNH+H4mDajEuKgAFkAodakF3Q@mail.gmail.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>, "sedat.dilek@gmail.com" <sedat.dilek@gmail.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Lin, Ming M" <ming.m.lin@intel.com>

>                Method (_CRS, 0, NotSerialized)
>                {
>                    If (IGDS)
>                    {
>                        Return (CRS)
>                    }
>                }
>            }
>
>I don't know whether this is legal or not.  If "(!IGDS)", _CRS
>apparently don't return anything at all, and I don't know what happens
>then.


Yes, it is illegal to return nothing from _CRS.

Newer versions of ACPICA (and iASL) will squawk at this, but we current=
ly do not attempt to actually perform a runtime "repair".

The driver is probably getting an Integer object of value zero, which m=
ight explain the behavior seen.

Bob







>-----Original Message-----
>From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
>owner@vger.kernel.org] On Behalf Of Bjorn Helgaas
>Sent: Wednesday, April 25, 2012 3:49 PM
>To: sedat.dilek@gmail.com
>Cc: Moore, Robert; linux-acpi@vger.kernel.org; Len Brown; linux-
>kernel@vger.kernel.org; Lin, Ming M
>Subject: Re: Warning: pnp 00:0b: can't evaluate _CRS: 12311
>
>On Wed, Apr 25, 2012 at 4:06 PM, Sedat Dilek <sedat.dilek@googlemail.c=
om>
>wrote:
>> On Wed, Apr 25, 2012 at 11:57 PM, Bjorn Helgaas <bhelgaas@google.com=
>
>wrote:
>>> On Wed, Apr 25, 2012 at 3:39 PM, Moore, Robert <robert.moore@intel.=
com>
>wrote:
>>>> This disassembly might make more sense. From the looks of the ASL,
>several of the address base and length fields are being updated
>dynamically. =A0I don't see anything that would corrupt a resource
>descriptor, however.
>>>>
>>>>
>>>> Are we certain that the ACPI Error and pnp messages are directly
>related to the PNP0C02 device ID?
>>>>
>>>> [ =A0 =A00.293699] system 00:0a: Plug and Play ACPI device, IDs PN=
P0c02
>(active)
>>>> [ =A0 =A00.294032] ACPI Error: Invalid/unsupported resource descri=
ptor:
>Type 0x00 (20120320/utresrc-650)
>>>> [ =A0 =A00.294037] pnp 00:0b: can't evaluate _CRS: 12311
>>>
>>> Oh, I'm sorry, I just wasted your time. =A0I didn't notice the 0a/0=
b
>>> mismatch. =A0You're right, the _CRS error is on 00:0b, and we don't=
 know
>>> what the path is or the PNP ID for 00:0b.
>>>
>>> Sedat, can you run "grep . /sys/bus/pnp/devices/*/id" please? =A0Th=
at
>>> will at least show us the PNP ID of device 00:0b.
>>>
>>> Bjorn
>>
>> Here we go:
>> ...
>> /sys/bus/pnp/devices/00:0b/id:PNP0c01
>
>There's only one PNP0C01 device:
>
>            Device (^^MEM2)
>            {
>                Name (_HID, EisaId ("PNP0C01"))
>                Name (_UID, 0x02)
>                Name (CRS, ResourceTemplate ()
>                {
>                    Memory32Fixed (ReadWrite,
>                        0x20000000,         // Address Base
>                        0x00200000,         // Address Length
>                        )
>                    Memory32Fixed (ReadWrite,
>                        0x40000000,         // Address Base
>                        0x00200000,         // Address Length
>                        )
>                })
>                Method (_CRS, 0, NotSerialized)
>                {
>                    If (IGDS)
>                    {
>                        Return (CRS)
>                    }
>                }
>            }
>
>I don't know whether this is legal or not.  If "(!IGDS)", _CRS
>apparently don't return anything at all, and I don't know what happens
>then.
>--
>To unsubscribe from this list: send the line "unsubscribe linux-acpi" =
in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
