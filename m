From: Al Stone <ahs3@redhat.com>
Subject: Re: question on possible functionality...
Date: Wed, 16 Dec 2015 13:47:44 -0700
Message-ID: <5671CDF0.7070100@redhat.com>
References: <5670AE46.1000107@redhat.com> <2082437.3D9tUlxHqv@vostro.rjw.lan>
 <94F2FBAB4432B54E8AACC7DFDE6C92E37DA71480@ORSMSX112.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33406 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753762AbbLPUrp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 Dec 2015 15:47:45 -0500
In-Reply-To: <94F2FBAB4432B54E8AACC7DFDE6C92E37DA71480@ORSMSX112.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, David Box <david.e.box@linux.intel.com>, "Zheng, Lv" <lv.zheng@intel.com>

On 12/16/2015 08:34 AM, Moore, Robert wrote:
> Yes, this is supported. Change the FADT version number to 5, and remove the version 6 field (Hypervisor Identity) from the source.
> 
> [0004]                          Signature : "FACP"    [Fixed ACPI Description Table (FADT)]
> [0004]                       Table Length : 00000114
> [0001]                           Revision : 05

Ooops.  My bad.  I thought I had sent this to the ACPICA devel
list.  Sorry about the noise...

Thanks, Bob.  I hadn't thought about doing it that way, but it's
pretty obvious now that you mention it.  I guess I was thinking
about this from the other way around -- I would tell iasl what
spec release, and it would tell me that Revision X was required
for that table for that version of the spec, and then tell me
if I missed (or added) fields inappropriate to that version.

>> -----Original Message-----
>> From: Rafael J. Wysocki [mailto:rjw@rjwysocki.net]
>> Sent: Tuesday, December 15, 2015 7:19 PM
>> To: Al Stone
>> Cc: ACPI Devel Mailing List; David Box; Moore, Robert; Zheng, Lv
>> Subject: Re: question on possible functionality...
>>
>> On Tuesday, December 15, 2015 05:20:22 PM Al Stone wrote:
>>> Howdy.
>>>
>>> I have run into a couple of cases now where is would like to do
>>> something like the following:
>>>
>>>    $ iasl --acpi-version=5.1 apic.asl
>>>
>>> to build a 5.1-compliant FADT, as compared to:
>>>
>>>    $ iasl apic.asl
>>>
>>> which always expects a very recent definition of the tables being
>> defined.
>>>
>>> Is anyone working on such a thing?  Or has it been contemplated in the
>>> past and discarded for some reason?
>>
>> CCing the ACPICA maintainers.
>>
>> Thanks,
>> Rafael
> 


-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3@redhat.com
-----------------------------------
