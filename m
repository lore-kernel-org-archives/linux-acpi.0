From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [RFC 00/15] ACPI graph support
Date: Tue, 11 Oct 2016 09:57:07 +0100
Message-ID: <b4f0bedf-2473-b629-7dbb-90709c74226a@arm.com>
References: <1475621148-21427-1-git-send-email-sakari.ailus@linux.intel.com>
 <20161005092215.GA20248@red-moon> <20161005114129.GI1765@lahna.fi.intel.com>
 <788f4bcd-605f-2694-5df5-ec7ef1bde233@arm.com>
 <CAJZ5v0iYPbLry-ZKeFqvm4Jeg24J7E6vQzV56jCh2N5fU6AQsw@mail.gmail.com>
 <0e56c5b2-0042-28e5-7445-6fe8422c728e@arm.com>
 <CAJZ5v0hy8V_WUuzOtT4oPt_hPRDUMHR5UYxVD0X3bVQe5AJf9Q@mail.gmail.com>
 <8999b937-4c06-6d82-aef5-6b7700a2a10c@arm.com>
 <CAJZ5v0g3MCBXXOn_txBE4E1-rjjwyXDu=wq=oD7xgXy=rhpm0w@mail.gmail.com>
 <957adfe3-5a17-47d5-f48c-2d47f727c387@arm.com>
 <CAJZ5v0hKnXiKTuQ5Ds57gnVQU3cEFj_YCaZn-he4x7tO8YdDrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:57758 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752078AbcJKI5M (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 11 Oct 2016 04:57:12 -0400
In-Reply-To: <CAJZ5v0hKnXiKTuQ5Ds57gnVQU3cEFj_YCaZn-he4x7tO8YdDrg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Al Stone <ahs3@redhat.com>



On 11/10/16 01:05, Rafael J. Wysocki wrote:
> On Thu, Oct 6, 2016 at 7:20 PM, Sudeep Holla <sudeep.holla@arm.com>
> wrote:

[...]

>>> Well, maybe they should have talked to the upstream before
>>> shipping the product with that table?  Failing to do so is like
>>> jumping to a pool from a tower without checking how much water is
>>> there in it in the first place ...
>>>
>>
>> Really ? I admit that I like this response and your stance here and
>> I definitely support it but I have seen quite a few cases which
>> tells me otherwise.
>
> Was I involved in any of those?
>

No I wasn't referring to any particular case here. What I meant is we
have quite a few hacks/workarounds even on x86 for various reasons like:
other OS works, the product is shipped and firmware can't be fixed, and
so on. We might encounter similar situations even with DSD in future and
hence my worries.

-- 
Regards,
Sudeep
