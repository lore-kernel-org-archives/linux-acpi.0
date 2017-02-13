From: "Prakash, Prashanth" <pprakash@codeaurora.org>
Subject: Re: [PATCH 0/2] additional sysfs entries for CPPC
Date: Mon, 13 Feb 2017 09:38:17 -0700
Message-ID: <f09519cd-4399-5253-8e8d-30611a85b228@codeaurora.org>
References: <1481763994-28146-1-git-send-email-pprakash@codeaurora.org>
 <b147a3c2-5435-84b2-f3ff-6fb96e764fd5@redhat.com>
 <72d699cd-06fb-7896-1325-5fc74c4f9888@redhat.com>
 <CAJZ5v0jKDF7fys_ZHM0FvOw+xtQv5hKBBHxeZs80NRiRx=e=AA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:43038 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751834AbdBMQiV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 13 Feb 2017 11:38:21 -0500
In-Reply-To: <CAJZ5v0jKDF7fys_ZHM0FvOw+xtQv5hKBBHxeZs80NRiRx=e=AA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>, Al Stone <ahs3@redhat.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Alexey Klimov <alexey.klimov@arm.com>, Hoan Tran <hotran@apm.com>, Christopher Covington <cov@codeaurora.org>

Hi Rafael,

On 2/8/2017 5:44 PM, Rafael J. Wysocki wrote:
> On Wed, Feb 8, 2017 at 11:10 PM, Al Stone <ahs3@redhat.com> wrote:
>> On 01/03/2017 11:37 AM, Al Stone wrote:
>>> On 12/14/2016 06:06 PM, Prashanth Prakash wrote:
>>>> This patch-set adds few additional sysfs entries to expose the
>>>> performance capabilities of each CPU. The performance capabilities
>>>> include highest perf, lowest perf, nominal perf and lowest
>>>> non-linear perf. See 8.4.7.1 for ACPI 6.1 spec for details on
>>>> these capabilities.
>>>>
>>>> cppc_cpufreq driver operates in KHz scale whereas the delivered
>>>> performance computed in userspace will be in abstract CPPC scale, so
>>>> exposing perf capabilities should allow userspace to figure out the
>>>> conversion factor from CPPC scale to KHz.
>>>>
>>>> Prashanth Prakash (2):
>>>>   ACPI / CPPC: read all perf caps in a single cppc read command
>>>>   ACPI / CPPC: add sysfs entries for CPPC perf capabilities
>>>>
>>>>  drivers/acpi/cppc_acpi.c | 164 ++++++++++++++++++++++++++++++-----------------
>>>>  include/acpi/cppc_acpi.h |   3 +-
>>>>  2 files changed, 107 insertions(+), 60 deletions(-)
>>>>
>>> Nice addition, Prashanth.  I had thought about doing this, but got distracted.
>>> Thanks for following through :).  I have not had a chance to test these yet, but
>>> will do so as soon as I can; my initial review is pretty positive, though.
>>>
>> Sorry for the delays :(.  These work for me, on an APM Mustang:
>>
>> # ls
>> feedback_ctrs  lowest_non_linear_perf  nominal_perf    wraparound_time
>> highest_perf   lowest_perf             reference_perf
>> # for ii in *; do echo $ii `cat $ii`; done
>> feedback_ctrs ref:195829033861120 del:1261303045816320
>> highest_perf 1000
>> lowest_non_linear_perf 250
>> lowest_perf 250
>> nominal_perf 1000
>> reference_perf 1000
>> wraparound_time 18446744073709551615
>>
>>
>> Tested-by: Al Stone <ahs3@redhat.com>
> I'm not actually sure about the assumption this series is based on.
>
> I don't see anything in the spec to guarantee that it will always be
> safe to evaluate _CPC only once and cache its output.
Among the Performance capabilities registers(section 8.4.7.1.1), the only
register that can change dynamically is Guaranteed performance register.
We are not supporting/using Guaranteed performance at the moment.

Guaranteed performance Register has an associated Notify event which will be
invoked when it changes. No such events are associated with other capabilities
register. Similar distinction is made in the beginning of section 8.4.7.1.1:
"Figure 8-47 outlines the static performance thresholds of the platform
 and the dynamic guaranteed performance threshold."

I agree spec isn't very clear about marking these registers as static except
that one sentence I quoted above, but there is enough in spec to guarantee
that the capabilities we are using will not change dynamically.

--
Thanks,
Prashanth

