From: Prarit Bhargava <prarit@redhat.com>
Subject: Re: "Error parsing PCC subspaces from PCCT" due to invalid PCCT?
Date: Sun, 14 Jan 2018 12:57:25 -0500
Message-ID: <0b7726a1-0b1f-500b-67a8-5fd4097f2bb5@redhat.com>
References: <7a0817b6-dd67-4b85-0ef2-3b8f190d5f46@redhat.com>
 <1571097.iXCS0Bl1Qo@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36352 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751726AbeANR51 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 14 Jan 2018 12:57:27 -0500
In-Reply-To: <1571097.iXCS0Bl1Qo@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Moore, Robert" <robert.moore@intel.com>



On 01/12/2018 08:30 PM, Rafael J. Wysocki wrote:
> On Friday, January 12, 2018 3:50:10 PM CET Prarit Bhargava wrote:
>> Just looking for some advice on this problem.
>>
>> https://bugzilla.redhat.com/show_bug.cgi?id=1435837 are many reports against
>> Dell, HP, Lenovo hardware that get a
>>
>> Error parsing PCC subspaces from PCCT
>>
>> during boot.
>>
>> AFAICT this occurs because a PCCT header is defined without any actual PCC
>> subspaces.  e.g) from one of the systems:
>>
>> [000h 0000   4]                    Signature : "PCCT"    [Platform
>> Communications Channel Table]
>> [004h 0004   4]                 Table Length : 00000030
>> [008h 0008   1]                     Revision : 01
>> [009h 0009   1]                     Checksum : 89
>> [00Ah 0010   6]                       Oem ID : "HP    "
>> [010h 0016   8]                 Oem Table ID : "ProLiant"
>> [018h 0024   4]                 Oem Revision : 00000001
>> [01Ch 0028   4]              Asl Compiler ID : "HP  "
>> [020h 0032   4]        Asl Compiler Revision : 00000001
>>
>> [024h 0036   4]        Flags (decoded below) : 00000001
>>                                     Doorbell : 1
>> [028h 0040   8]                     Reserved : 0000000000000000
>>
>> Raw Table Data: Length 48 (0x30)
>>
>>   0000: 50 43 43 54 30 00 00 00 01 89 48 50 20 20 20 20  // PCCT0.....HP
>>   0010: 50 72 6F 4C 69 61 6E 74 01 00 00 00 48 50 20 20  // ProLiant....HP
>>   0020: 01 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00  // ................
>>
>>
>> I don't see anything in the ACPI 6.2 Spec 5.2.28 that implies a PCC subspace
>> MUST be defined so I guess technically the above is okay to do.
>>
>> OR :)  Is this really a bug in these Intel systems' BIOSes?
> 
> On x86 Linux does not use PCC at all, so this is all irrelevant.

True.  Then kernel is outputting a bogus error.  And that's a bad end user
experience.  I'll patch shortly.

P.

> 
> Thanks,
> Rafael
> 
