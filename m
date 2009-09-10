From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [2.6.29-rc5 ACPI] truncated dsobject list...
Date: Thu, 10 Sep 2009 04:34:48 -0700
Message-ID: <4911F71203A09E4D9981D27F9D830858375A1677@orsmsx503.amr.corp.intel.com>
References: <6278d2220902170831n3801a935x578b5dff64d00c62@mail.gmail.com>
	 <4911F71203A09E4D9981D27F9D830858149BBB4F@orsmsx503.amr.corp.intel.com>
 <6278d2220909100317y1266021bla5e9f24e13a64f1b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:34926 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752396AbZIJLeq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Sep 2009 07:34:46 -0400
In-Reply-To: <6278d2220909100317y1266021bla5e9f24e13a64f1b@mail.gmail.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel J Blueman <daniel.blueman@gmail.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>

What this message means is that the number of elements within the packa=
ge was found to be more than the declared package element count (An AML=
 Package object contains the number of elements, then the elements. How=
ever, there is an overall length of the Package operator, so we can det=
ect if there is a mismatch between the declared number of elements and =
the actual number of elements.)

This can only happen if the BIOS modifies the AML on the fly. A compile=
r would never let this happen.

What ACPICA does is to use the package element count as the "actual" el=
ement count, and ignores the extra elements in the package. This is wha=
t the BIOS expects the OS to do, and it conforms to the ACPI spec (yes,=
 this condition is mentioned somewhere as I recall.)

So, the message can be safely ignored.

I'm open to suggestions as to different wording for the message, since =
it seems to be causing at least a bit of confusion.

Related:

We recently found a possible memory leak during this "truncation", the =
extra package elements were not always deleted, just dropped on the flo=
or. This has been fixed in version 20090903.

Bob



-----Original Message-----
=46rom: Daniel J Blueman [mailto:daniel.blueman@gmail.com]=20
Sent: Thursday, September 10, 2009 3:17 AM
To: Moore, Robert
Cc: linux-acpi@vger.kernel.org; Linux Kernel
Subject: Re: [2.6.29-rc5 ACPI] truncated dsobject list...

On Tue, Feb 17, 2009 at 7:48 PM, Moore, Robert <robert.moore@intel.com>=
 wrote:
>>ACPI Warning (dsobject-0502): Package List length (6) larger than
>>NumElements count (4), truncated
>
> This simply means that in one of the ACPI tables, a Package object wa=
s found that was declared to have 6 items. However, when parsing the pa=
ckage, the interpreter only found 4 items.
>
> It's a BIOS issue, but probably not serious unless there really is su=
pposed to be 6 items.

I see this with stock 2.6.31 [1] on Intel S5400SF hardware. I'll send
you the acpidump offline.

Thanks,
  Daniel

--- [1]

$ dmesg
ACPI: RSDP 00000000000f03f0 00024 (v02 INTEL )

ACPI: XSDT 000000007fb39120 0008C (v01 INTEL  S5400SF  00000000 INTL 01=
000013)

ACPI: DMAR 000000007fb37000 00112 (v01 INTEL  S5400SF  00000001 INTL 01=
000013)

ACPI: FACP 000000007fb35000 000F4 (v03 INTEL  S5400SF  00000000 INTL 01=
000013)

ACPI: DSDT 000000007fb2e000 05664 (v02 INTEL  S5400SF  00000008 INTL 01=
000013)

ACPI: FACS 000000007fabf000 00040

ACPI: APIC 000000007fb34000 000C8 (v01 INTEL  S5400SF  00000000 INTL 01=
000013)

ACPI: SPCR 000000007fb2d000 00050 (v01 INTEL  S5400SF  00000000 INTL 01=
000013)

ACPI: HPET 000000007fb2c000 00038 (v01 INTEL  S5400SF  00000001 INTL 01=
000013)

ACPI: MCFG 000000007fb2b000 0003C (v01 INTEL  S5400SF  00000001 INTL 01=
000013)

ACPI: SSDT 000000007fb2a000 00A14 (v02 INTEL  EIST     00004000 INTL 01=
000013)

ACPI: SSDT 000000007fb29000 00193 (v02 INTEL  IPMI     00004000 INTL 01=
000013)

ACPI: SSDT 000000007fb28000 002D4 (v02 INTEL  CST      00004000 INTL 01=
000013)

ACPI: HEST 000000007fb27000 000A8 (v01 INTEL  S5400SF  00000001 INTL 00=
000001)

ACPI: BERT 000000007fb26000 00030 (v01 INTEL  S5400SF  00000001 INTL 00=
000001)

ACPI: ERST 000000007fb25000 00230 (v01 INTEL  S5400SF  00000001 INTL 00=
000001)

ACPI: EINJ 000000007fb24000 00130 (v01 INTEL  S5400SF  00000001 INTL 00=
000001)

<snip>
ACPI: EC: Look up EC in DSDT

ACPI Warning: Package List length (6) larger than NumElements count
(2), truncated

 20090521 dsobject-502

ACPI Warning: Package List length (6) larger than NumElements count
(2), truncated

 20090521 dsobject-502

ACPI Warning: Package List length (6) larger than NumElements count
(2), truncated

 20090521 dsobject-502

ACPI Warning: Package List length (6) larger than NumElements count
(2), truncated

 20090521 dsobject-502

ACPI Warning: Package List length (6) larger than NumElements count
(2), truncated

 20090521 dsobject-502

ACPI Warning: Package List length (6) larger than NumElements count
(2), truncated

 20090521 dsobject-502

ACPI Warning: Package List length (6) larger than NumElements count
(2), truncated

 20090521 dsobject-502

ACPI Warning: Package List length (6) larger than NumElements count
(2), truncated

 20090521 dsobject-502


>>-----Original Message-----
>>From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
>>owner@vger.kernel.org] On Behalf Of Daniel J Blueman
>>Sent: Tuesday, February 17, 2009 8:32 AM
>>To: linux-acpi@vger.kernel.org; Linux Kernel
>>Subject: [2.6.29-rc5 ACPI] truncated dsobject list...
>>
>>With 2.6.29-rc5 on an Intel S5000PAL server (BIOS
>>S5000.86B.10.60.0091.100920081631), we see ACPI object list truncatio=
n
>>[1]. Does it make sense to increase the default element allocation?
>>
>>Many thanks,
>> =A0Daniel
>>
>>--- [1]
>>
>>ACPI: EC: Look up EC in DSDT
>>ACPI Warning (dsobject-0502): Package List length (6) larger than
>>NumElements count (4), truncated
>>[20081204]
--=20
Daniel J Blueman
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
