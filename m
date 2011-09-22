From: Jim Green <student.northwestern@gmail.com>
Subject: Re: bug report: ACPI Error: [RAMB] Namespace lookup failure,
 AE_NOT_FOUND (20110112/psargs-359)
Date: Thu, 22 Sep 2011 20:45:17 +0000
Message-ID: <CACAe89xfgSearTkRsva8yszDWJJg0H3zy_2buoewEdOz_Qi5NQ@mail.gmail.com>
References: <CACAe89zvHM7Dz4X1_aTjFt6JpLSJOTWn6HdhyUHCM81+=0Uv=w@mail.gmail.com>
	<CAF1ivSa45AFa5bVWx32qCVNUCfAoEk4ZNSjmy3B1E47kE9VvWQ@mail.gmail.com>
	<CACAe89zS5zckGc-2CMcO+QW5tZyXpDq4mvUHNUc8T4WZYMPF6A@mail.gmail.com>
	<1316415840.3634.13.camel@minggr>
	<CAF1ivSY2bMjz0Jb9PzktV_8Qry+MYFo13gHwvuWcTUPEm7eVrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-gw0-f42.google.com ([74.125.83.42]:59914 "EHLO
	mail-gw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753823Ab1IVUpT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 22 Sep 2011 16:45:19 -0400
Received: by gwj16 with SMTP id 16so2137974gwj.1
        for <linux-acpi@vger.kernel.org>; Thu, 22 Sep 2011 13:45:18 -0700 (PDT)
In-Reply-To: <CAF1ivSY2bMjz0Jb9PzktV_8Qry+MYFo13gHwvuWcTUPEm7eVrw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Moore, Robert" <robert.moore@intel.com>

On 22 September 2011 07:51, Lin Ming <ming.m.lin@intel.com> wrote:
> On Mon, Sep 19, 2011 at 3:04 PM, Lin Ming <ming.m.lin@intel.com> wrot=
e:
>> On Mon, 2011-09-19 at 10:12 +0800, Jim Green wrote:
>>> On 19 September 2011 00:23, Lin Ming <ming.m.lin@intel.com> wrote:
>>> > On Mon, Sep 19, 2011 at 1:18 AM, Jim Green
>>> > <student.northwestern@gmail.com> wrote:
>>> >> Hello:
>>> >>
>>> >> I am running 2.6.38.8-4 kernel on p8p67 deluxe motherboard(bios
>>> >> version 1702, latest stable)
>>> >>
>>> >> 2357 Sep 18 13:05:07 localhost kernel: [ =A0 =A01.045727] ACPI: =
EC: Look
>>> >> up EC in DSDT
>>> >> 2358 Sep 18 13:05:07 localhost kernel: [ =A0 =A01.046535] ACPI: =
Executed 1
>>> >> blocks of module-level executable AML code
>>> >> 2359 Sep 18 13:05:07 localhost kernel: [ =A0 =A01.049876] ACPI E=
rror:
>>> >> [RAMB] Namespace lookup failure, AE_NOT_FOUND (20110112/psargs-3=
59)
>>> >> 2360 Sep 18 13:05:07 localhost kernel: [ =A0 =A01.049880] ACPI E=
xception:
>>> >> AE_NOT_FOUND, Could not execute arguments for [RAMW] (Region)
>>> >> (20110112/ =A0 =A0 =A0 =A0 nsinit-349)
>>> >> 2361 Sep 18 13:05:07 localhost kernel: [ =A0 =A01.050347] ACPI: =
SSDT
>>> >> 00000000df5d4818 0079C (v01 =A0 =A0AMI =A0 =A0 =A0IST 00000001 M=
SFT 03000001)
>>> >> 2362 Sep 18 13:05:07 localhost kernel: [ =A0 =A01.050805] ACPI: =
Dynamic
>>> >> OEM Table Load:
>>> >> 2363 Sep 18 13:05:07 localhost kernel: [ =A0 =A01.050807] ACPI: =
SSDT
>>> >> =A0 =A0(null) 0079C (v01 =A0 =A0AMI =A0 =A0 =A0IST 00000001 MSFT=
 03000001)
>>> >> 2364 Sep 18 13:05:07 localhost kernel: [ =A0 =A01.050883] ACPI: =
SSDT
>>> >> 00000000df5dba18 0021C (v01 =A0 =A0AMI =A0 =A0 =A0CST 00000001 M=
SFT 03000001)
>>> >> 2365 Sep 18 13:05:07 localhost kernel: [ =A0 =A01.051168] ACPI: =
Dynamic
>>> >> OEM Table Load:
>>> >> 2366 Sep 18 13:05:07 localhost kernel: [ =A0 =A01.051169] ACPI: =
SSDT
>>> >> =A0 =A0(null) 0021C (v01 =A0 =A0AMI =A0 =A0 =A0CST 00000001 MSFT=
 03000001)
>>> >> 2367 Sep 18 13:05:07 localhost kernel: [ =A0 =A01.052510] ACPI: =
Interpreter enabled
>>> >> 2368 Sep 18 13:05:07 localhost kernel: [ =A0 =A01.052512] ACPI: =
(supports
>>> >> S0 S1 S3 S4 S5)
>>> >> 2369 Sep 18 13:05:07 localhost kernel: [ =A0 =A01.052530] ACPI: =
Using
>>> >> IOAPIC for interrupt routing
>>> >>
>>> >> Could anyone help how to fix this error?.. is this bug fixed in =
some
>>> >> later kernel versions?
>>> >
>>> > Could you attach the acpidump output?
>>>
>>> Hi!
>>>
>>> Pls see attached, THanks!
>>
>> Hi, please try below patch on 2.6.38.* kernel.
>
> Hi, Jim
>
> Did you get a chance to test below patch?

Hi, Lin
the bug was fixed. will this be in released to some new kernels or it i=
s
just a patch for 2.8.38.8?

Thanks.

Jim
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
