From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v2 0/4] ACPI 2.0: Enable TermList interpretion for table
 loading
Date: Fri, 10 Jun 2016 03:05:14 +0200
Message-ID: <76932cf4-c292-d711-d390-f451b66c3f9c@intel.com>
References: <cover.1463109824.git.lv.zheng@intel.com>
 <1AE640813FDE7649BE1B193DEA596E883BBA2A9A@SHSMSX101.ccr.corp.intel.com>
 <CAJZ5v0gYBKC0GxBpFH-jOca7ide-pGc9R1bfi9PCSZgiB1hSAg@mail.gmail.com>
 <1AE640813FDE7649BE1B193DEA596E883BBA4649@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:18991 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750819AbcFJBFU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 9 Jun 2016 21:05:20 -0400
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E883BBA4649@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On 5/20/2016 2:57 AM, Zheng, Lv wrote:
> Hi, Rafael
>
>> From: rjwysocki@gmail.com [mailto:rjwysocki@gmail.com] On Behalf Of
>> Rafael J. Wysocki
>> Subject: Re: [PATCH v2 0/4] ACPI 2.0: Enable TermList interpretion for table
>> loading
>>
>> On Tue, May 17, 2016 at 2:29 AM, Zheng, Lv <lv.zheng@intel.com> wrote:
>>> Hi, Rafael
>>>
>>> Can we queue this up in linux-next?
>>> ASLTS recursive tests are done in ACPICA upstream and no regressions can be
>> seen.
>>> We need more tests around this experimental change from the real users to
>> have the chances to learn the unknown cases.
>>> If they reported regressions, we could stop the regressions by reverting
>> [PATCH 4/4].
>>> So it should be safe to do such experiments in the Linux upstream.
>>> Thanks in advance.
>> There is a rule that during a merge window linux-next should only
>> contain material for that merge window.  That is, currently linux-next
>> should only contain material targeted at v4.7.
>>
>> For this reason, I can't put the series into linux-next right now, but
>> I'll do that as soon as 4.7-rc1 is released.
> [Lv Zheng]
> Great!
> Thanks for the information.

Unfortunately, it is reported that the series actually causes problems 
to happen.

I sent you a CC of my response to the report in question earlier today.

Thanks,
Rafael

