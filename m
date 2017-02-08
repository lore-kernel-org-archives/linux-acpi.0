From: Al Stone <ahs3@redhat.com>
Subject: Re: [PATCH 0/2] additional sysfs entries for CPPC
Date: Wed, 8 Feb 2017 15:10:31 -0700
Message-ID: <72d699cd-06fb-7896-1325-5fc74c4f9888@redhat.com>
References: <1481763994-28146-1-git-send-email-pprakash@codeaurora.org>
 <b147a3c2-5435-84b2-f3ff-6fb96e764fd5@redhat.com>
Reply-To: ahs3@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qt0-f182.google.com ([209.85.216.182]:33025 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751301AbdBHWMq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Feb 2017 17:12:46 -0500
Received: by mail-qt0-f182.google.com with SMTP id v23so179863923qtb.0
        for <linux-acpi@vger.kernel.org>; Wed, 08 Feb 2017 14:12:46 -0800 (PST)
In-Reply-To: <b147a3c2-5435-84b2-f3ff-6fb96e764fd5@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Prashanth Prakash <pprakash@codeaurora.org>, linux-acpi@vger.kernel.org
Cc: rjw@rjwysocki.net, alexey.klimov@arm.com, hotran@apm.com, cov@codeaurora.org

On 01/03/2017 11:37 AM, Al Stone wrote:
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
> 
> Nice addition, Prashanth.  I had thought about doing this, but got distracted.
> Thanks for following through :).  I have not had a chance to test these yet, but
> will do so as soon as I can; my initial review is pretty positive, though.
> 

Sorry for the delays :(.  These work for me, on an APM Mustang:

# ls
feedback_ctrs  lowest_non_linear_perf  nominal_perf    wraparound_time
highest_perf   lowest_perf	       reference_perf
# for ii in *; do echo $ii `cat $ii`; done
feedback_ctrs ref:195829033861120 del:1261303045816320
highest_perf 1000
lowest_non_linear_perf 250
lowest_perf 250
nominal_perf 1000
reference_perf 1000
wraparound_time 18446744073709551615


Tested-by: Al Stone <ahs3@redhat.com>


-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3@redhat.com
-----------------------------------
