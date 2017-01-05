From: "Prakash, Prashanth" <pprakash@codeaurora.org>
Subject: Re: [PATCH 0/2] additional sysfs entries for CPPC
Date: Thu, 5 Jan 2017 10:59:11 -0700
Message-ID: <502822f6-9983-506e-df9d-34aca752382f@codeaurora.org>
References: <1481763994-28146-1-git-send-email-pprakash@codeaurora.org>
 <b147a3c2-5435-84b2-f3ff-6fb96e764fd5@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:49570 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1763129AbdAER7O (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 5 Jan 2017 12:59:14 -0500
In-Reply-To: <b147a3c2-5435-84b2-f3ff-6fb96e764fd5@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ahs3@redhat.com, linux-acpi@vger.kernel.org
Cc: rjw@rjwysocki.net, alexey.klimov@arm.com, hotran@apm.com, cov@codeaurora.org


On 1/3/2017 11:37 AM, Al Stone wrote:
> On 12/14/2016 06:06 PM, Prashanth Prakash wrote:
>> This patch-set adds few additional sysfs entries to expose the
>> performance capabilities of each CPU. The performance capabilities
>> include highest perf, lowest perf, nominal perf and lowest 
>> non-linear perf. See 8.4.7.1 for ACPI 6.1 spec for details on
>> these capabilities.
>>
>> cppc_cpufreq driver operates in KHz scale whereas the delivered
>> performance computed in userspace will be in abstract CPPC scale, so
>> exposing perf capabilities should allow userspace to figure out the
>> conversion factor from CPPC scale to KHz.
>>
>> Prashanth Prakash (2):
>>   ACPI / CPPC: read all perf caps in a single cppc read command
>>   ACPI / CPPC: add sysfs entries for CPPC perf capabilities
>>
>>  drivers/acpi/cppc_acpi.c | 164 ++++++++++++++++++++++++++++++-----------------
>>  include/acpi/cppc_acpi.h |   3 +-
>>  2 files changed, 107 insertions(+), 60 deletions(-)
>>
> Nice addition, Prashanth.  I had thought about doing this, but got distracted.
> Thanks for following through :).  I have not had a chance to test these yet, but
> will do so as soon as I can; my initial review is pretty positive, though.
>
Thanks Al! I look forward for your test results.

Thanks,
Prashanth
