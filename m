From: Daniel J Blueman <daniel.blueman@gmail.com>
Subject: Re: [2.6.29-rc5 ACPI] truncated dsobject list...
Date: Thu, 10 Sep 2009 11:17:01 +0100
Message-ID: <6278d2220909100317y1266021bla5e9f24e13a64f1b@mail.gmail.com>
References: <6278d2220902170831n3801a935x578b5dff64d00c62@mail.gmail.com>
	 <4911F71203A09E4D9981D27F9D830858149BBB4F@orsmsx503.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f206.google.com ([209.85.219.206]:61251 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755336AbZIJKQ7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Sep 2009 06:16:59 -0400
In-Reply-To: <4911F71203A09E4D9981D27F9D830858149BBB4F@orsmsx503.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>

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
