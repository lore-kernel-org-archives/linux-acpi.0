From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 0/3] cpuidle: Rework the handling of the poll state
Date: Tue, 29 Aug 2017 09:13:20 +0200
Message-ID: <335d33b3-832a-1588-c007-16110dbef33e@linaro.org>
References: <21794463.WNaOdcSnfv@aspire.rjw.lan>
 <1350530b-bed8-ab45-d5d2-dcaf4178320d@arm.com>
 <8432156.DIvYQkV4Qe@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wr0-f177.google.com ([209.85.128.177]:37279 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751209AbdH2HNX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Aug 2017 03:13:23 -0400
Received: by mail-wr0-f177.google.com with SMTP id n37so7288635wrf.4
        for <linux-acpi@vger.kernel.org>; Tue, 29 Aug 2017 00:13:22 -0700 (PDT)
In-Reply-To: <8432156.DIvYQkV4Qe@aspire.rjw.lan>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>, Linux ACPI <linux-acpi@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Jacob Pan <jacob.jun.pan@linux.intel.com>

On 28/08/2017 23:17, Rafael J. Wysocki wrote:
> On Thursday, August 24, 2017 11:48:19 AM CEST Sudeep Holla wrote:
>>
>> On 23/08/17 22:18, Rafael J. Wysocki wrote:
>>> Hi,
>>>
>>> On x86 the fist idle state is a polling one, but the way it is set up is far
>>> from straightforward and then it is avoided by governors in rather somewhat
>>> convoluted fashion.
>>>
>>> Make this more clear by explicitly flagging that state as "polling" and
>>> checking its flag where it needs to be avoided instead of using
>>> arch-dependent numbering of idle states (patch [1/3]), move the
>>> polling state code from driver.c to a separate C file (patch [2/3]) and
>>> move the initialization of it from the core to the relevant cpuidle drivers -
>>> ACPI and intel_idle (patch [3/3]).
>>>
>>
>> Tested this on ARM64 platform(both DT and ACPI/LPI) and everything
>> continues to work fine.
>> Tested-by: Sudeep Holla <sudeep.holla@arm.com>
> 
> Thanks Sudeep!
> 
> I haven't seen any more comments on this which I'm taking as a green light for
> it, so I'm going to queue it up for 4.14.

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

