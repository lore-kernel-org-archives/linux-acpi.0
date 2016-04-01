From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [Update][PATCH v7 7/7] cpufreq: schedutil: New governor based on
 scheduler utilization data
Date: Fri, 1 Apr 2016 12:23:07 -0700
Message-ID: <56FECA9B.20902@linaro.org>
References: <7262976.zPkLj56ATU@vostro.rjw.lan>
 <6666532.7ULg06hQ7e@vostro.rjw.lan> <145931680.Kk1xSBT0Ro@vostro.rjw.lan>
 <56FEB4BA.4080403@linaro.org>
 <CAJZ5v0gHbTUGvShyxT3FwWYS58PCdw1pMPrDR8C5mhbSdERi8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:34233 "EHLO
	mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752116AbcDATXK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 1 Apr 2016 15:23:10 -0400
Received: by mail-pf0-f172.google.com with SMTP id x3so97473997pfb.1
        for <linux-acpi@vger.kernel.org>; Fri, 01 Apr 2016 12:23:09 -0700 (PDT)
In-Reply-To: <CAJZ5v0gHbTUGvShyxT3FwWYS58PCdw1pMPrDR8C5mhbSdERi8g@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@kernel.org>

On 04/01/2016 12:14 PM, Rafael J. Wysocki wrote:
> On Fri, Apr 1, 2016 at 7:49 PM, Steve Muckle <steve.muckle@linaro.org> wrote:
>> On 03/29/2016 07:00 PM, Rafael J. Wysocki wrote:
>> ...
>>> +config CPU_FREQ_GOV_SCHEDUTIL
>>> +     tristate "'schedutil' cpufreq policy governor"
>>> +     depends on CPU_FREQ
>>> +     select CPU_FREQ_GOV_ATTR_SET
>>> +     select IRQ_WORK
>>> +     help
>>> +       This governor makes decisions based on the utilization data provided
>>> +       by the scheduler.  It sets the CPU frequency to be proportional to
>>> +       the utilization/capacity ratio coming from the scheduler.  If the
>>> +       utilization is frequency-invariant, the new frequency is also
>>> +       proportional to the maximum available frequency.  If that is not the
>>> +       case, it is proportional to the current frequency of the CPU with the
>>> +       tipping point at utilization/capacity equal to 80%.
>>
>> This help text implies that the tipping point of 80% applies only to
>> non-frequency invariant configurations, rather than both. Possible to
>> rephrase?
> 
> Sure.
> 
> What about:
> 
> "If that is not the case, it is proportional to the current frequency
> of the CPU.  The frequency tipping point is at utilization/capacity
> equal to 80% in both cases."

LGTM

thanks,
Steve
