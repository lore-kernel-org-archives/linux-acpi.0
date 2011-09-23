From: Lin Ming <ming.m.lin@intel.com>
Subject: Re: bug report: ACPI Error: [RAMB] Namespace lookup failure,
 AE_NOT_FOUND (20110112/psargs-359)
Date: Fri, 23 Sep 2011 13:07:01 +0800
Message-ID: <CAF1ivSZsR2cqp2HdQHQ3GJwbU5r1ovD_-rYJB=hOsE92r1RSbw@mail.gmail.com>
References: <CACAe89zvHM7Dz4X1_aTjFt6JpLSJOTWn6HdhyUHCM81+=0Uv=w@mail.gmail.com>
	<CAF1ivSa45AFa5bVWx32qCVNUCfAoEk4ZNSjmy3B1E47kE9VvWQ@mail.gmail.com>
	<CACAe89zS5zckGc-2CMcO+QW5tZyXpDq4mvUHNUc8T4WZYMPF6A@mail.gmail.com>
	<1316415840.3634.13.camel@minggr>
	<CAF1ivSY2bMjz0Jb9PzktV_8Qry+MYFo13gHwvuWcTUPEm7eVrw@mail.gmail.com>
	<CACAe89xfgSearTkRsva8yszDWJJg0H3zy_2buoewEdOz_Qi5NQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:34572 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750802Ab1IWFHD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 23 Sep 2011 01:07:03 -0400
Received: by qyk30 with SMTP id 30so6801633qyk.19
        for <linux-acpi@vger.kernel.org>; Thu, 22 Sep 2011 22:07:02 -0700 (PDT)
In-Reply-To: <CACAe89xfgSearTkRsva8yszDWJJg0H3zy_2buoewEdOz_Qi5NQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jim Green <student.northwestern@gmail.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Moore, Robert" <robert.moore@intel.com>

On Fri, Sep 23, 2011 at 4:45 AM, Jim Green
<student.northwestern@gmail.com> wrote:
> On 22 September 2011 07:51, Lin Ming <ming.m.lin@intel.com> wrote:
>> On Mon, Sep 19, 2011 at 3:04 PM, Lin Ming <ming.m.lin@intel.com> wro=
te:
>>> On Mon, 2011-09-19 at 10:12 +0800, Jim Green wrote:
>>>> On 19 September 2011 00:23, Lin Ming <ming.m.lin@intel.com> wrote:
>>>> > On Mon, Sep 19, 2011 at 1:18 AM, Jim Green
>>>> > <student.northwestern@gmail.com> wrote:
>>>> >> Hello:
>>>> >>
>>>> >> I am running 2.6.38.8-4 kernel on p8p67 deluxe motherboard(bios
>>>> >> version 1702, latest stable)
>>>> >>
>>>> >> 2357 Sep 18 13:05:07 localhost kernel: [ =A0 =A01.045727] ACPI:=
 EC: Look
>>>> >> up EC in DSDT
>>>> >> 2358 Sep 18 13:05:07 localhost kernel: [ =A0 =A01.046535] ACPI:=
 Executed 1
>>>> >> blocks of module-level executable AML code
>>>> >> 2359 Sep 18 13:05:07 localhost kernel: [ =A0 =A01.049876] ACPI =
Error:
>>>> >> [RAMB] Namespace lookup failure, AE_NOT_FOUND (20110112/psargs-=
359)
>>>> >> 2360 Sep 18 13:05:07 localhost kernel: [ =A0 =A01.049880] ACPI =
Exception:
>>>> >> AE_NOT_FOUND, Could not execute arguments for [RAMW] (Region)
>>>> >> (20110112/ =A0 =A0 =A0 =A0 nsinit-349)
>>>> >> 2361 Sep 18 13:05:07 localhost kernel: [ =A0 =A01.050347] ACPI:=
 SSDT
>>>> >> 00000000df5d4818 0079C (v01 =A0 =A0AMI =A0 =A0 =A0IST 00000001 =
MSFT 03000001)
>>>> >> 2362 Sep 18 13:05:07 localhost kernel: [ =A0 =A01.050805] ACPI:=
 Dynamic
>>>> >> OEM Table Load:
>>>> >> 2363 Sep 18 13:05:07 localhost kernel: [ =A0 =A01.050807] ACPI:=
 SSDT
>>>> >> =A0 =A0(null) 0079C (v01 =A0 =A0AMI =A0 =A0 =A0IST 00000001 MSF=
T 03000001)
>>>> >> 2364 Sep 18 13:05:07 localhost kernel: [ =A0 =A01.050883] ACPI:=
 SSDT
>>>> >> 00000000df5dba18 0021C (v01 =A0 =A0AMI =A0 =A0 =A0CST 00000001 =
MSFT 03000001)
>>>> >> 2365 Sep 18 13:05:07 localhost kernel: [ =A0 =A01.051168] ACPI:=
 Dynamic
>>>> >> OEM Table Load:
>>>> >> 2366 Sep 18 13:05:07 localhost kernel: [ =A0 =A01.051169] ACPI:=
 SSDT
>>>> >> =A0 =A0(null) 0021C (v01 =A0 =A0AMI =A0 =A0 =A0CST 00000001 MSF=
T 03000001)
>>>> >> 2367 Sep 18 13:05:07 localhost kernel: [ =A0 =A01.052510] ACPI:=
 Interpreter enabled
>>>> >> 2368 Sep 18 13:05:07 localhost kernel: [ =A0 =A01.052512] ACPI:=
 (supports
>>>> >> S0 S1 S3 S4 S5)
>>>> >> 2369 Sep 18 13:05:07 localhost kernel: [ =A0 =A01.052530] ACPI:=
 Using
>>>> >> IOAPIC for interrupt routing
>>>> >>
>>>> >> Could anyone help how to fix this error?.. is this bug fixed in=
 some
>>>> >> later kernel versions?
>>>> >
>>>> > Could you attach the acpidump output?
>>>>
>>>> Hi!
>>>>
>>>> Pls see attached, THanks!
>>>
>>> Hi, please try below patch on 2.6.38.* kernel.
>>
>> Hi, Jim
>>
>> Did you get a chance to test below patch?
>
> Hi, Lin
> the bug was fixed. will this be in released to some new kernels or it=
 is
> just a patch for 2.8.38.8?

It will be in new kernel and also back-ported to old stable kernels.

Thanks for test.
Lin Ming
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
